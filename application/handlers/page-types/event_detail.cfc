component output=false{

	property name="event_detail" inject="presidecms:object:event_detail";
	property name="event_services" inject="event_services";

	private function index( event, rc, prc, args={} ) {
		// TODO: create your handler logic here
		return renderView(
			  view          = 'page-types/event_detail/index'
			, presideObject = 'event_detail'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function get_regions( event, rc, prc, args={} ){
		args.event_detail_regions = event_services.get_regions( page_id = args.page_id );
		return renderView(
			  view			= 'page-types/event_detail/_region'
			, args			= args

		);
	}

	public function get_category( event, rc, prc, args={} ){
		args.event_detail_category = event_services.get_category( page_id = args.page_id );
		return renderView(
			  view			= 'page-types/event_detail/_category'
			, args			= args
		);
	}

	public function get_related_events( event, rc, prc, args={} ){
		args.related_events = event_services.get_related_events( regions=args.regions, excluded_event_id=args.page_id );
		return renderView(
			  view			= 'page-types/event_detail/_related_events'
			, args			= args
		);
	}

	public function get_latest_event_detail( event, rc, prc, args={} ){
		args.latest_event_detail = event_services.get_latest_event_detail( latest_event=args.latest_event );
		return renderView(
			  view			= 'widgets/_latest_event'
			, args			= args
		);
	}

}
