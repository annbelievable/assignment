
component output=false{
//CONSTRUCTOR
/**
*
*@event_listing.inject presidecms:object:event_listing
*@event_detail.inject presidecms:object:event_detail
*@booking_detail.inject presidecms:object:booking_detail
*@session.inject presidecms:object:session
*/



	public any function init(required any event_listing, required any event_detail, required any booking_detail, required any session){
		_setEventListing(arguments.event_listing);
		_setEventDetail(arguments.event_detail);
		_setBookingDetail(arguments.booking_detail);
		_setSession(arguments.session);
		return this;
	}

	private function _setEventListing(required any event_listing){
		_event_listing = arguments.event_listing;
	}

	private function _getEventListing(  ){
		return _event_listing;
	}

	private function _setEventDetail(required any event_detail){
		_event_detail = arguments.event_detail;
	}

	private function _getEventDetail(  ){
		return _event_detail;
	}

	private function _setBookingDetail(required any booking_detail){
		_booking_detail = arguments.booking_detail;
	}

	private function _getBookingDetail(  ){
		return _booking_detail;
	}

	private function _setSession(required any session){
		_session = arguments.session;
	}

	private function _getSession(  ){
		return _session;
	}



	query function getRegion( required string page_id="" ){
		var filter					= "page.id = :page.id";
		var filterParams["page.id"] = arguments.page_id;
		return _getEventListing().selectData(
			  selectFields = ["DISTINCT(region.id)", "region.label"]//, "page.id","page.title"
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function getCategories( required string page_id="" ){
		var filter					= "page.id = :page.id";
		var filterParams["page.id"] = arguments.page_id;
		return _getEventListing().selectData(
			  selectFields = ["DISTINCT(categories.id)", "categories.label"]
			, filter	   = filter
			, filterParams = filterParams
		);
	}





	query function getEventDetail( required string id, array selectFields=[] ){
		var filter							= "event_detail.id = :event_detail.id";
		var filterParams["event_detail.id"]	= arguments.id;
		if(len(arguments.selectFields)){
			selectFields = arguments.selectFields;
		}else{
			selectFields = [];
		}
		return _getEventDetail().selectData(
			  selectFields = selectFields
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function filter_region( string region="" ){
		var filter					  = "region.id = :region.id";
		var filterParams["region.id"] = arguments.region;
		return _getEventDetail().selectData(
			  selectFields  = ["page.id","page.title"]//,"event_detail.start_date","event_detail.end_date"
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function getLatestEventDetail( ){
		// var filter = "event_detail.id in (:event_detail.id)";
		// var filterParams["event_detail.id"] = listToArray(arguments.latest_event);
		// filter &= "and event_detail.end_date > #NOW()#";
		//filterParams["today"] = Dateformat(NOW(),'DD/MM/YYYY');
		return _getEventDetail().selectData(
				  selectFields = ["page.id","page.title","event_detail.start_date","event_detail.end_date"]
				, filter = "event_detail.end_date > #NOW()#"
				// , filterParams = filterParams
				, orderby = "event_detail.end_date"
		);
	}

	query function get_related_events( required string regions, string excluded_event_id="" ){
		var filter					  = "region.id in (:region.id)";
		var filterParams["region.id"] = listToArray(arguments.regions);
		if(len(arguments.excluded_event_id)){
			filter				   &= " and page.id != :page.id";
			filterParams["page.id"] = arguments.excluded_event_id;
		}
		return _getEventDetail().selectData(
			 selectFields  = ["DISTINCT(page.id)","page.title"]//,"event_detail.start_date","event_detail.end_date"
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function get_child_event_detail( required string page_id="" ){
		var filter							 = "page.parent_page = :page.parent_page";
		var filterParams["page.parent_page"] = arguments.page_id;
		return _getEventDetail().selectData(
			  selectFields = ["page.id","page.title","event_detail.start_date","event_detail.end_date"]
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function get_event_regions(  ){
		return _getEventDetail().selectData(
			  selectFields = ["DISTINCT(regions.id)", "regions.label"]
		);
	}

	query function get_regions( required string page_id="" ){
		var filter 					= "page.id = :page.id";
		var filterParams["page.id"] = arguments.page_id;
		return _getEventDetail().selectData(
			  selectFields = ["DISTINCT(regions.id)", "regions.label"]
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function get_category( required string page_id="" ){
		var filter					= "page.id = :page.id";
		var filterParams["page.id"] = arguments.page_id;
		return _getEventDetail().selectData(
			  selectFields = ["DISTINCT(category.id)", "category.label"]
			, filter	   = filter
			, filterParams = filterParams
		);
	}





	query function getBookingDetail( required string id, array selectFields=[] ){
		var filter							  = "booking_detail.id = :booking_detail.id";
		var filterParams["booking_detail.id"] = arguments.id;
		if(len(arguments.selectFields)){
			selectFields = arguments.selectFields;
		}else{
			selectFields = [];
		}
		return _getBookingDetail().selectData(
			  selectFields = selectFields
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function getSessionLabel( required string id ){
		var filter					   = "session.id in (:session.id)";
		var filterParams["session.id"] = listToArray(arguments.id);
		return _getSession().selectData(
			  selectFields = ["session.label"]
			, filter	   = filter
			, filterParams = filterParams
		);
	}



}