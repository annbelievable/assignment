<cfscript>
	searchResults = prc.searchResults.getResults();
	parentPage    = args.pageId ?: event.getCurrentPageId();
</cfscript>
<cfoutput>
	<cfloop query="searchResults">
		<!--- comment: the link below needs to be fixed, this requires to build a dummy page for it --->
		<!--- <cfset resourceLink = event.buildLink( resourceId=searchResults.id )> --->
		<h3 class="title">
			<!--- <a href="#resourceLink#"> --->
				#searchResults.title#
			<!--- </a> --->
		</h3>
		<span class="date">#dateFormat( searchResults.date, "mmmm d, yyyy" )#</span> <p>#searchResults.teaser#</p>

		<!--- 					#renderViewlet( event="page-types.resource_library_page.renderResourceTypeLinkByResourceId", args={ resourceId=searchResults.id, parentPage=parentPage  } )# --->
	</cfloop>
</cfoutput>