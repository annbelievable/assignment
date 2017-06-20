
<cfscript>
	latest_event_detail = args.latest_event_detail?:QueryNew("");
</cfscript>

<cfif latest_event_detail.recordcount>
	<h2>Latest Events:</h2>
	<ul>
		<cfoutput query = "latest_event_detail">
			<a href="#event.buildLink( page=latest_event_detail.id )#"><h3>#latest_event_detail.title#</h3></a>
		</cfoutput>
	</ul>
</cfif>
