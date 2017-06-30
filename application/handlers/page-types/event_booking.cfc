component {

	property name="event_services"		 inject="event_services";
	property name="emailService"         inject="emailService";
	property name="notificationService"  inject="notificationService";
	property name="presideObjectService" inject="presideObjectService";
	property name="FormsService"		 inject="FormsService";

	private function index( event, rc, prc, args={} ) {
		if(!len(rc.id?:"")) relocate( event.buildLink(page="event_listing") );

		event_detail = presideObjectService.selectData(
			  objectName = "event_detail"
			, id         = rc.id
		);

		if(!isNull(event_detail.total_seats) && event_detail.total_seats GT 0 && event_detail.seats_booked GTE event_detail.total_seats){
			return renderView(
				  view          = 'page-types/event_booking/fullyBooked'
				, presideObject = 'event_booking'
				, id            = event.getCurrentPageId()
				, args          = args
			);
		}

		rc.savedData              = rc.savedData ?: {};
		rc.savedData.event_detail = rc.id;
		rc.eventDetail            = event_services.getEventDetail( id=rc.id );
		rc.savedData.price        = rc.eventDetail.price;

		//for javascript purpose
		event.include("js-booking").includeData( data = { id = rc.id, price=rc.savedData.price } );

		return renderView(
			  view          = 'page-types/event_booking/index'
			, presideObject = 'event_booking'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function bookEvent( event, rc, prc, args={} ) {

		var formName         = "event_booking.booking_detail";
		var formData         =event.getCollectionForForm( formName );
		stripHTMLFromFormInput( formData );

		var validationResult = validateForm( formName, formData );
		var persistStruct    = { };

		if(!validationResult.validated() ){
			id = formData.event_detail;
			persistStruct.savedData        = formData;
			persistStruct.validationResult = validationResult;
 			setNextEvent( url=event.buildLink(page="event_booking"), persistStruct=persistStruct )
		 } else {
		 	if(len(Trim(formData.special_request))){
		 		formData.special_request = "none";
		 	}

			booked = presideObjectService.insertData(
        		  objectName = "booking_detail"
        		, data       = {
        			  event_detail	  = formData.event_detail
        			, label			  = "Booking by #formData.firstname#"
        			, firstname		  = formData.firstname
        			, lastname		  = formData.lastname
        			, email 		  = formData.email
        			, number_of_seat  = LSParseNumber(formData.number_of_seat)
        			, total_amount	  = LSParseNumber(formData.total_amount)
        			, session		  = formData.event_session
        			, special_request = formData.special_request
        	}, insertManyToManyRecords=true );

			persistStruct.id	 = formData.event_detail;
   			persistStruct.booked = booked;

			//sends email to user
			EmailService.send(
                  template = "eventBookingConfirmation"
                , to       = [ formData.email ]
                , args     = formData
            );

			//sends notification to admin
   			notificationService.createNotification(
   				  topic = "newBooking"
   				, type  = "ALERT"
   				, data  = {id=booked}
   			);

			return renderView(
				  view          = 'page-types/event_booking/bookingSuccess'
				, presideObject = 'event_booking'
				, args          = persistStruct
			);
		}
	}
}