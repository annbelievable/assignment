component {

	property name="event_booking" inject="presidecms:object:event_booking";
	property name="FormsService" inject="FormsService";

	private function index( event, rc, prc, args={} ) {
		return renderView(
			  view          = 'page-types/event_booking/index'
			, presideObject = 'event_booking'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function book_event( event, rc, prc, args={} ) {
		return renderView(
			  view          = 'page-types/event_booking/index'
			, presideObject = 'event_booking'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

}
