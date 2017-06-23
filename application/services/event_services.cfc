
component output=false{
//CONSTRUCTOR
/**
*
*@event_listing.inject presidecms:object:event_listing
*@event_detail.inject presidecms:object:event_detail
*
*/



	public any function init(required any event_listing, required any event_detail){
		_setEvent_listing(arguments.event_listing);
		_setEvent_detail(arguments.event_detail);
		return this;
	}

	private function _setEvent_listing(required any event_listing){
		_event_listing = arguments.event_listing;
	}

	private function _getEvent_listing(  ){
		return _event_listing;
	}

	private function _setEvent_detail(required any event_detail){
		_event_detail = arguments.event_detail;
	}

	private function _getEvent_detail(  ){
		return _event_detail;
	}

	query function get_region( required string page_id="" ){
		var filter					= "page.id = :page.id";
		var filterParams["page.id"] = arguments.page_id;
		return _getEvent_listing().selectData(
			  selectFields = ["DISTINCT(region.id)", "region.label"]//, "page.id","page.title"
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function get_categories( required string page_id="" ){
		var filter					= "page.id = :page.id";
		var filterParams["page.id"] = arguments.page_id;
		return _getEvent_listing().selectData(
			  selectFields = ["DISTINCT(categories.id)", "categories.label"]
			, filter	   = filter
			, filterParams = filterParams
		);
	}





	query function getEventDetail( required string id ){
		var filter							= "event_detail.id = :event_detail.id";
		var filterParams["event_detail.id"]	= arguments.id;
		return _getEvent_detail().selectData(
			  filter	   = filter
			, filterParams = filterParams
		);
	}

	query function filter_region( string region="" ){
		var filter					  = "region.id = :region.id";
		var filterParams["region.id"] = arguments.region;
		return _getEvent_detail().selectData(
			  selectFields  = ["page.id","page.title"]//,"event_detail.start_date","event_detail.end_date"
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function get_latest_event_detail( string latest_event="" ){
		var filter = "event_detail.id in (:event_detail.id)";
		var filterParams["event_detail.id"] = listToArray(arguments.latest_event);
		filter &= "and event_detail.end_date > #NOW()#";
		//filterParams["today"] = Dateformat(NOW(),'DD/MM/YYYY');
		return _getEvent_detail().selectData(
				  selectFields = ["page.id","page.title","event_detail.start_date","event_detail.end_date"]
				, filter = filter
				, filterParams = filterParams
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
		return _getEvent_detail().selectData(
			 selectFields  = ["DISTINCT(page.id)","page.title"]//,"event_detail.start_date","event_detail.end_date"
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function get_child_event_detail( required string page_id="" ){
		var filter							 = "page.parent_page = :page.parent_page";
		var filterParams["page.parent_page"] = arguments.page_id;
		return _getEvent_detail().selectData(
			  selectFields = ["page.id","page.title","event_detail.start_date","event_detail.end_date"]
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function get_event_regions(  ){
		return _getEvent_detail().selectData(
			  selectFields = ["DISTINCT(regions.id)", "regions.label"]
		);
	}

	query function get_regions( required string page_id="" ){
		var filter 					= "page.id = :page.id";
		var filterParams["page.id"] = arguments.page_id;
		return _getEvent_detail().selectData(
			  selectFields = ["DISTINCT(regions.id)", "regions.label"]
			, filter	   = filter
			, filterParams = filterParams
		);
	}

	query function get_category( required string page_id="" ){
		var filter					= "page.id = :page.id";
		var filterParams["page.id"] = arguments.page_id;
		return _getEvent_detail().selectData(
			  selectFields = ["DISTINCT(category.id)", "category.label"]
			, filter	   = filter
			, filterParams = filterParams
		);
	}


}