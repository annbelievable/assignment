component output=false{

	property name="event_listing" inject="presidecms:object:event_listing";
	property name="eventService" inject="eventService";

	private function index( event, rc, prc, args={} ){
		args.regions = eventService.get_event_regions();
		// TODO: create your handler logic here
		return renderView(
			  view          = 'page-types/event_listing/index'
			, presideObject = 'event_listing'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function filter_region( event, rc, prc, args={} ){
		args.filter_region = eventService.filter_region( region = args.region );
		return renderView(
			  view			= 'page-types/event_listing/_filter_region'
			, args			= args
		);
	}

	public function get_child_event_detail( event, rc, prc, args={} ){
		args.child_event_detail = eventService.get_child_event_detail( page_id = args.page_id );
		return renderView(
			  view			= 'page-types/event_listing/_child_event_detail'
			, args			= args
		);
	}

	public function getRegion( event, rc, prc, args={} ){
		args.event_listing_region = eventService.getRegion( page_id = args.page_id );
		return renderView(
			  view			= 'page-types/event_listing/_region'
			, args			= args

		);
	}

	public function getCategories( event, rc, prc, args={} ){
		args.event_listing_categories = eventService.getCategories( page_id = args.page_id );
		return renderView(
			  view			= 'page-types/event_listing/_category'
			, args			= args
		);
	}

}
