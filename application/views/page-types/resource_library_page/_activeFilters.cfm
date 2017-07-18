<cfscript>
	rc.category             = rc.category        ?: "";
	rc.region               = rc.region          ?: "";
	rc.year                 = rc.year            ?: "";
	args.showCategory       = args.showCategory  ?: true;
	args.showRegion         = args.showRegion    ?: true;
	args.showYear           = args.showYear      ?: true;

	aggregations                = prc.searchResults.getAggregations() ?: structNew();
	aggregationsCategory        = valueList( arrayOfStructsToQuery( columnList="id", arrayOfStructs=aggregations.category ).id );
	aggregationsRegion          = valueList( arrayOfStructsToQuery( columnList="id", arrayOfStructs=aggregations.region ).id );
	aggregationsYear            = valueList( arrayOfStructsToQuery( columnList="key", arrayOfStructs=aggregations.year ).key );
</cfscript>

<cfoutput>
	<cfif !isEmpty( rc.category & rc.region & rc.year ) >

		<cfif args.showCategory == 1>
			<cfloop list="#rc.category#" item="category">
				<cfif listFindNoCase( aggregationsCategory, category ) >

					<span class="text">
						 <cfset filterProperties = renderViewlet( event="page-types.resource_library_page.getObjectDetailById", args={ objectName="category", id=category } )>
						#filterProperties.label#
					</span>

				</cfif>
			</cfloop>
		</cfif>

		<cfif args.showRegion == 1>
			<cfloop list="#rc.region#" item="region">
				<cfif listFindNoCase( aggregationsRegion, region ) >

					<span class="text">
						<cfset filterProperties = renderViewlet( event="page-types.resource_library_page.getObjectDetailById", args={ objectName="region", id=region } )>
						#filterProperties.label#
					</span>

				</cfif>
			</cfloop>
		</cfif>

		<cfif args.showYear == 1>
			<cfloop list="#rc.year#" item="year">

				<cfif listFindNoCase( aggregationsYear, year ) >
					<span class="text">#year#</span>
				</cfif>

			</cfloop>
		</cfif>

	</cfif>
</cfoutput>

