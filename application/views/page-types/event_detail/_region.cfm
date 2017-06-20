<cfscript>
	event_detail_regions = args.event_detail_regions?:QueryNew("");
</cfscript>

<cfif event_detail_regions.recordcount>
	<h4>Regions Available:</h4>
	<cfoutput query="event_detail_regions">
		<p>#event_detail_regions.label#</p>
	</cfoutput>
</cfif>