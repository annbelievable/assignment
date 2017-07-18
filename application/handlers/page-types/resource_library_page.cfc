component {

	property name="ResourceLibrarySearchEngine" inject="ResourceLibrarySearchEngine";
	property name="presideObjectService"        inject="PresideObjectService";

	private function index( event, rc, prc, args={} ) {
		//for the filter panel
		var showCategory   = event.getPageProperty( 'show_filter_category', true );
		var showRegion     = event.getPageProperty( 'show_filter_region'  , true );
		var showYear       = event.getPageProperty( 'show_filter_year'    , true );
		args.showFilter    = showCategory || showRegion || showYear;

		//to set the variables or get from input
		args.q        = rc.q        ?: "";
		args.category = rc.category ?: "";
		args.region   = rc.region   ?: "";
		args.year     = isNumeric( rc.year ?: "" ) ? rc.year : "";
		args.maxRows  = event.getPageProperty( 'item_per_page', '' );
		args.pageId   = event.getCurrentPageId();

		event.includeData( {
			  resultsContainer = "##result-content"
			, resultEndpoint   = event.buildLink( linkTo="page-types.resource_library_page.resultSection" )
			, maxRows          = args.maxRows
			, pageId           = args.pageId
		} );

		return renderView(
			  presideObject = "resource_library_page"
			, args          = args
			, id            = args.pageId
			, view          = "page-types/resource_library_page/index"
		);
	}

	public string function resultSection( event, rc, prc, args={} ) {

		prc.searchResults = _getSearchResult( argumentCollection = arguments );

		var pageSetting   = presideObjectService.selectData(
			  objectName   = "resource_library_page"
			, selectFields = [ "show_filter_category", "show_filter_region", "show_filter_year"  ]
			, id           = args.pageId
		);

		args.showCategory = pageSetting.show_filter_category;
		args.showRegion   = pageSetting.show_filter_region;
		args.showYear     = pageSetting.show_filter_year;

		return renderView(
			  view     = "page-types/resource_library_page/_resultSection"
			, args     = args
			, noLayout = true
		);
	}

	private function _getSearchResult( event, rc, prc, args={} ) {
		rc.q 			 = rc.q  			  ?: "";
		rc.pageId        = rc.pageId          ?: "";
		rc.maxRows       = rc.maxRows         ?: "";
		rc.region        = rc.region          ?: "";
		rc.category      = rc.category        ?: "";
		rc.year          = isNumeric( rc.year ?: "" ) ? rc.year : "";

		args.q           = args.q             ?: rc.q;
		args.maxRows     = args.maxRows       ?: rc.maxRows;
		args.pageId      = args.pageId        ?: rc.pageId;
		args.region      = args.region        ?: rc.region;
		args.category    = args.category      ?: rc.category;
		args.year        = args.year          ?: rc.year;

		var pageSize = isNumeric( args.maxRows  ) && args.maxRows <= 999999 ? args.maxRows : 10;
		var page     = isNumeric( rc.page ?: "" ) && rc.page      <= 999999 ? rc.page      : 1;

		if( isEmpty( args.region ) || isEmpty( args.category ) ){
			var defaultFilterValues = presideObjectService.selectData(
				  objectName   = "resource_library_page"
				, selectFields = [ "group_concat( distinct region.id ) as region", "category.id as category"  ]
				, id           = args.pageId
			)
			if( isEmpty( args.category ) ){
				args.category = defaultFilterValues.category;
			}
			if( isEmpty( args.region ) ){
				args.region   = defaultFilterValues.region;
			}
		}

		return ResourceLibrarySearchEngine.search(
			  q                = args.q
			, category         = getObjectDetailById( args={ objectName='category', id=args.category  } ).id
			, region           = getObjectDetailById( args={ objectName='region'  , id=args.region    } ).id
			, year             = args.year
			, page             = page
			, pageSize         = pageSize
		);

	}

	private struct function getObjectDetailById( event, rc, prc, args={} ) {

		if( isEmpty( args.id ?: "" ) || isEmpty( args.objectName ?: "" ) ){
			return {
				  id    = ""
				, label = ""
			};
		}

		var objectDetails = presideObjectService.selectData(
			  objectName   = args.objectName
			, filter       = { id = listToArray( args.id ) }
			, selectFields = [ "id", "label" ]
		);

		return {
			  id    = valueList( objectDetails.id )
			, label = valueList( objectDetails.label )
		};
	}

}