<cfscript>
	filter_region = args.filter_region?:QueryNew("");

</cfscript>

<cfif filter_region.recordcount>
	<div class ="row">
		<h4>Events At #args.region#:</h4>
		<cfoutput query="filter_region">
			<p><a href="#event.buildLink( page=filter_region.id )#">#filter_region.title#</a></p>
		</cfoutput>
	</div>
</cfif>