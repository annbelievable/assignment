component {

	property name="eventService"		 inject="eventService";
	property name="bookingService"		 inject="bookingService";
	property name="presideObjectService" inject="presideObjectService";
	property name="FormsService"		 inject="FormsService";

	private function index( event, rc, prc, args={} ) {

		if( ( rc.statusCode ?: "" )=="SUCCESS" ){
			return renderView(
				  presideObject = "event_booking"
				, args          = args
				, id            = event.getCurrentPageId()
				, view          = "page-types/event_booking/bookingSuccess"
			);
		}

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

		rc.savedData            = rc.savedData ?: {};
		var applicationProgress = bookingService.getApplicationProgress(eventId=rc.id);

		if( isEmpty( rc.savedData ) ){
			if( StructKeyExists(applicationProgress, "status") ){
				rc.savedData = applicationProgress.state["step#applicationProgress.status#Detail"] ?: {};
			}
		}
		rc.eventDetail            = eventService.getEventDetail( id=rc.id );
		rc.savedData.event_detail = rc.id;//stored into hidden input
		rc.savedData.price        = rc.eventDetail.price;

		//for javascript purpose
		event.include("js-booking").includeData( data = { id=rc.id, price=rc.savedData.price } );

		args.currentStep = isNumeric( applicationProgress.status ?: "" ) && applicationProgress.status <= 3 ? applicationProgress.status : 1;

		return renderView(
			  view          = 'page-types/event_booking/index'
			, presideObject = 'event_booking'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function savePersonalDetail( event, rc, prc, args={} ) {
		var formName         = 'event_booking.personalDetail';
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );
		if( validationResult.validated() ){
			bookingService.updateApplicationProgress(
				  eventId     = formData.event_detail
				, step        = 2
				, stateDetail = { step1Detail = formData }
			);
			setNextEvent( url=event.buildLink( page="event_booking", queryString="id=#( formData.event_detail ?: '' )#" )   );
		}

		setNextEvent(
			  url           = event.buildLink( page="event_booking" )
			, persistStruct = {
				  validationResult = validationResult
				, savedData        = formData
				, errorMessage     = translateResource( "cms:problem_with_form_submission" )
				, id               = formData.event_detail ?: ""
			}
		);
	}

	public function saveSessionDetail( event, rc, prc, args={} ) {
		var formName         = 'event_booking.sessionDetail';
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );

		if( validationResult.validated() ){
			bookingService.updateApplicationProgress(
				  eventId     = formData.event_detail
				, step        = 3
				, stateDetail = { step2Detail=formData }
			);
			setNextEvent( url=event.buildLink( page="event_booking", queryString="id=#( formData.event_detail ?: '' )#" ) );
		}

		setNextEvent(
			  url           = event.buildLink( page="event_booking", queryString="id=#( formData.event_detail ?: '' )#"  )
			, persistStruct = {
				 validationResult  = validationResult
				, savedData        = formData
				, errorMessage     = translateResource( "error:problem_with_form_submission" )
			}
		);
	}

	public function savePaymentInfo( event, rc, prc, args={} ) {
		var formName         = "event_booking.paymentInfo";
		var formData         = event.getCollectionForForm( formName );
		stripHTMLFromFormInput( formData );
		var validationResult = validateForm( formName, formData );
		var persistStruct    = {};

		if(!validationResult.validated() ){
			persistStruct.id               = formData.event_detail ?: "";
			persistStruct.savedData        = formData;
			persistStruct.validationResult = validationResult;
			setNextEvent( url=event.buildLink(page="event_booking" , queryString="id=#( formData.event_detail ?: '' )#"), persistStruct=persistStruct );
		 } else {
			bookingService.updateApplicationProgress(
				  eventId     = formData.event_detail
				, step        = 3
				, stateDetail = { step3Detail=formData }
			);
		}

		var result = bookingService.finalizeApplication( eventId=formData.event_detail );

		if( result.statusCode == "SUCCESS" ){
			setNextEvent(
				  url           = event.buildLink( page="event_booking", queryString="id=#( formData.event_detail ?: '' )#" )
				, persistStruct = {
					statusCode  = result.statusCode
				}
			);
		}

		errorMessage = result.statusCodeMessage;
		setNextEvent(
			  url           = event.buildLink( page="event_booking", queryString="id=#( formData.event_detail ?: '' )#" )
			, persistStruct = { errorMessage=errorMessage }
		);
	}

	public void function prevStep( event, rc, prc ) {
		rc.step = isNumeric( rc.step ?: "" ) && rc.step <= 3 ? rc.step : 1;
		rc.id   = rc.id ?: '';
		bookingService.updateApplicationProgress( step=rc.step, eventId=rc.id );
		setNextEvent( url = event.buildLink( page="event_booking", queryString="id=#rc.id#" ) );
	}

}














