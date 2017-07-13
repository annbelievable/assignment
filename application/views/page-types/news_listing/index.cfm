
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cfscript>
	var newsDetails = args.newsDetails ?: queryNew("");
</cfscript>

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#

	<cfloop query="newsDetails">
		<a href="#event.buildLink( eventSlug='#slug#' )#">#label#</a>
	</cfloop>
</cfoutput>