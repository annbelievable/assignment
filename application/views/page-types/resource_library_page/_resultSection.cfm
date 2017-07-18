<cfscript>
	totalResults    = prc.searchResults.getTotalResults();
	args.category   = args.category   ?: rc.category  ?: "";
	args.region     = args.region     ?: rc.region    ?: "";
	args.year       = args.year       ?: rc.year      ?: "";
	args.maxRows    = args.maxRows    ?: rc.maxRows   ?: 10;
	args.showFilter = args.showFilter ?: true;
</cfscript>
<cfoutput>

	<div class="row">
		#renderView( view="/page-types/resource_library_page/_activeFilters", args=args  )#
	</div>

	<div class="row">
		<div class="col-xs-12 col-md-8">
			<h3>#totalResults# item<cfif totalResults GT 1>s</cfif></h3>
			#renderView( view="/page-types/resource_library_page/_resultItems", args=args )#
		</div>

		<div class="col-xs-12 col-md-4 sidebar">
			#renderView( view="/page-types/resource_library_page/_filterPanel", args=args )#
		</div>
	</div>

</cfoutput>
