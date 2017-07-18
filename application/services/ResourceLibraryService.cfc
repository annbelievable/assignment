component extends="application.extensions.preside-ext-resource-library.services.ResourceLibraryService"{

	public query function getResourceByFilters(
		  string category         = ""
		, string categoryExclude  = ""
		, string region           = ""
		, string maxRows          = 3
		, string excludeID        = ""
	) {
		var filter = "1=1";

		if( !isEmpty( arguments.category ) ){
			filter &= " and category in ( :category )";
		}

		if( !isEmpty( arguments.categoryExclude ) ){
			filter &= " and category not in ( :category_exclude )";
		}

		if( !isEmpty( arguments.region ) ){
			filter &= " and region.id in ( :region.id )";
		}

		if( !isEmpty( arguments.excludeID ) ){
			filter &= " and resource_library_resource.id != :resource_library_resource.id"
		}
		return $getPresideObjectService().selectData(
			  objectName   = "resource_library_resource"
			, selectFields = [ "resource_library_resource.title", "resource_library_resource.slug", "resource_library_resource.id", "category.label as categoryLabel", "category.id as categoryId", "publish_date", "featuredImage", "access_restriction", "teaser" ]
			, filter       = filter
			, filterParams = {
				  category                       = listToArray( arguments.category )
				, category_exclude               = { type="varchar", value=arguments.categoryExclude, list=true }
				, "region.id"                    = listToArray( arguments.region )
				, "resource_library_resource.id" = arguments.excludeID
			}
			, maxRows      = arguments.maxRows
			, orderBy      = "publish_date desc"
			, groupBy      = "resource_library_resource.id"
		);
	}

}