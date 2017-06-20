<cfscript>
	child_event_detail = args.child_event_detail?:QueryNew("");
</cfscript>

<cfif child_event_detail.recordcount>
	<div class ="row">
		<h3>Event Details:</h3>
		<cfoutput query="child_event_detail">
			<h5><a href="#event.buildLink( page=child_event_detail.id )#">#child_event_detail.title#</a></h5>
			<p>Start Date #DateFormat(child_event_detail.start_date,"dd/mm/yy")# | End Date #DateFormat(child_event_detail.end_date,"dd/mm/yy")# </p>
		</cfoutput>
	</div>
</cfif>