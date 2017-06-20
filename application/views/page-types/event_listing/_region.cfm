<cfscript>
	event_listing_region = args.event_listing_region?:QueryNew("");
</cfscript>

<cfif event_listing_region.recordcount>
	<div class ="row">
		<h4>Region Available:</h4>
		<cfoutput query="event_listing_region">
			<p>#event_listing_region.label#</p>
		</cfoutput>
	</div>
</cfif>