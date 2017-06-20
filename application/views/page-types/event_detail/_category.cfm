<cfscript>
	event_detail_category = args.event_detail_category?:QueryNew("");
</cfscript>

<cfif event_detail_category.recordcount>
	<h4>Event Category:</h4>
	<cfoutput query="event_detail_category">
		<p>#event_detail_category.label#</p>
	</cfoutput>
</cfif>