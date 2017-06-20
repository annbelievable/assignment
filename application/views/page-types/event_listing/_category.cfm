<cfscript>
	event_listing_categories = args.event_listing_categories?:QueryNew("");
</cfscript>

<cfif event_listing_categories.recordcount>
	<div class ="row">
		<h4>Event Categories:</h4>
		<cfoutput query="event_listing_categories">
			<p>#event_listing_categories.label#</p>
		</cfoutput>
	</div>
</cfif>