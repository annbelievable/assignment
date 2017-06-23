component {

	property name="FormsService"		 inject="FormsService";
	property name="event_services"		 inject="event_services";
	property name="presideObjectService" inject="presideObjectService";
	property name="notificationService" inject="notificationService";

	private function index( event, rc, prc, args={} ) {
		if(!len(rc.id?:"")) relocate( event.buildLink(page="event_listing") );

		rc.savedData = rc.savedData ?: {};
		rc.savedData.event_detail = rc.id;
		rc.eventDetail = event_services.getEventDetail( id=rc.id );
		rc.savedData.price = rc.eventDetail.price;

		event.include("js-booking").includeData( data = { id = rc.id, price=rc.savedData.price } );

		return renderView(
			  view          = 'page-types/event_booking/index'
			, presideObject = 'event_booking'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function bookEvent( event, rc, prc, args={} ) {
		var formName = "event_booking.booking_detail";
		var formData = event.getCollectionForForm( formName );
		var validationResult=validateForm( formName, formData );
		var persistStruct = { };

		if(!validationResult.validated() ){
			persistStruct.savedData = formData;
			persistStruct.validationResult = validationResult;
 			setNextEvent( url=event.buildLink(page="event_booking"), persistStruct=persistStruct )
		 } else {
		 	if(len(formData.special_request) EQ 0){
		 		formData.special_request="none";
		 	}

			booked = presideObjectService.insertData(
        		  objectName = "booking_detail"
        		, data       = {
        			  event_detail	  = formData.event_detail
        			, label			  = "Booking by #formData.firstname#"
        			, firstname		  = formData.firstname
        			, lastname		  = formData.lastname
        			, event_detail	  = formData.event_detail
        			, email 		  = formData.email
        			, number_of_seat  = LSParseNumber(formData.number_of_seat)
        			, total_amount	  = LSParseNumber(formData.total_amount)
        			, session		  = formData.event_session
        			, special_request = formData.special_request
        	}, insertManyToManyRecords=true );

			persistStruct.id	 = formData.event_detail;
   			persistStruct.booked = booked;

   			notificationService.createNotification(
   				  topic = "newBooking"
   				, type  = "ALERT"
   				, data  = {id=booked}
   			);

			setNextEvent( url=event.buildLink(page="event_booking"), persistStruct=persistStruct )
		}
	}

}