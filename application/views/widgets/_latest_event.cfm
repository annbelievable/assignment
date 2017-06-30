
<cfscript>
	latestEventDetail = args.latestEventDetail?:QueryNew("");
</cfscript>

<cfif latestEventDetail.recordcount>
	<h2>Latest Events:</h2>
	<ul>
		<cfoutput query = "latestEventDetail">
			<a href="#event.buildLink( page=latestEventDetail.id )#"><h3>#latestEventDetail.title#</h3></a>
		</cfoutput>
	</ul>
</cfif>
