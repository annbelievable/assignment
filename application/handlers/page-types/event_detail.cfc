component output=false{

	property name="event_detail"   inject="presidecms:object:event_detail";
	property name="eventService" inject="eventService";

	private function index( event, rc, prc, args={} ) {
		return renderView(
			  view          = 'page-types/event_detail/index'
			, presideObject = 'event_detail'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function get_regions( event, rc, prc, args={} ){
		args.event_detail_regions = eventService.get_regions( page_id = args.page_id );
		return renderView(
			  view			= 'page-types/event_detail/_region'
			, args			= args

		);
	}

	public function get_category( event, rc, prc, args={} ){
		args.event_detail_category = eventService.get_category( page_id = args.page_id );
		return renderView(
			  view			= 'page-types/event_detail/_category'
			, args			= args
		);
	}

	public function get_related_events( event, rc, prc, args={} ){
		args.related_events = eventService.get_related_events( regions=args.regions, excluded_event_id=args.page_id );
		return renderView(
			  view			= 'page-types/event_detail/_related_events'
			, args			= args
		);
	}

	public function getLatestEventDetail( event, rc, prc, args={} ){
		args.latestEventDetail = eventService.getLatestEventDetail( );
		return renderView(
			  view			= 'widgets/_latest_event'
			, args			= args
		);
	}

}
