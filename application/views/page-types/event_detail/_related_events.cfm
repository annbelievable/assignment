<cfscript>
	related_events = args.related_events?:QueryNew("");
</cfscript>

<cfif related_events.recordcount>
	<h4>Related Events Nearby:</h4>
	<cfoutput query="related_events">
		<p><a href="#event.buildLink( page=related_events.id )#">#related_events.title#</a></p>
	</cfoutput>
</cfif>