<cfscript>
	rc.q                = rc.q              ?: "";
	rc.category         = rc.category       ?: "";
	rc.region           = rc.region         ?: "";
	rc.year             = rc.year           ?: "";
	args.showCategory   = args.showCategory ?: true;
	args.showRegion     = args.showRegion   ?: true;
	args.showYear       = args.showYear     ?: true;
	aggregations        = prc.searchResults.getAggregations() ?: structNew();
	category            = arrayOfStructsSort( aggregations.category, 'label', 'asc' , 'textnocase' ) ?: [];
	region              = arrayOfStructsSort( aggregations.region  , 'label', 'asc' , 'textnocase' ) ?: [];
	year                = arrayOfStructsSort( aggregations.year    , 'key'  , 'desc', 'numeric'    ) ?: [];
</cfscript>
<cfoutput>

	<form name="search" id="search" action="#event.buildLink( page="resource_library_page")#" method="POST">
		<input type="text" name="q" value="#rc.q#" placeholder="Search" >

		<cfif arrayLen( category ) && args.showCategory == 1>
			<h4 class="collapsible-item-header"><a>Category</a></h4>

			<div class="widget-filter-checkbox">
				<cfloop from="1" to="#arrayLen( category )#" index="i">
					<div class="checkbox">
						<input
							type       = "checkbox"
							name       = "category"
							class      = "filter-checkbox"
							id         = "cb-#category[i].key#"
							value      = "#category[i].id#"
							data-label = "#category[i].label#"
							<cfif listContains( rc.category, category[i].id )> checked </cfif>
						>
						<label for="cb-#category[i].key#">#category[i].label# (#category[i].doc_count#)</label>
					</div>
				</cfloop>
			</div>
		</cfif>

		<cfif arrayLen( region ) && args.showRegion == 1>
			<h4 class="collapsible-item-header"><a>Region</a></h4>

			<div class="widget-filter-checkbox">
				<cfloop from="1" to="#arrayLen( region )#" index="i">
					<div class="checkbox">
						<input
							type       = "checkbox"
							name       = "region"
							class      = "filter-checkbox"
							id         = "cb-#region[i].key#"
							value      = "#region[i].id#"
							data-label = "#region[i].label#"
							<cfif listContains( rc.region, region[i].id )> checked </cfif>
						>
						<label for="cb-#region[i].key#">#region[i].label# (#region[i].doc_count#)</label>
					</div>
				</cfloop>
			</div>
		</cfif>

		<cfif arrayLen( year ) && args.showYear == 1>
			<h4 class="collapsible-item-header"><a>Year</a></h4>

			<div class="widget-filter-checkbox">
				<cfloop from="1" to="#arrayLen( year )#" index="i">
					<div class="checkbox">
						<input
							type       = "checkbox"
							name       = "year"
							class      = "filter-checkbox"
							id         = "cb-#year[i].key#"
							value      = "#year[i].key#"
							data-label = "#year[i].key#"
							<cfif listContains( rc.year, year[i].key )> checked </cfif>
						>
						<label for="cb-#year[i].key#">#year[i].key# (#year[i].doc_count#)</label>
					</div>
				</cfloop>
			</div>
		</cfif>

		<input type="submit" value="Filter" />
	</form>

</cfoutput>