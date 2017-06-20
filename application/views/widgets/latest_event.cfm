
<cfparam name="args.latest_event" default="" />

<cfoutput>
	#renderViewlet( event="page-types.event_detail.get_latest_event_detail", args={ latest_event = args.latest_event } )#
</cfoutput>




<!---
<cfset today="#Dateformat(NOW(),'DD/MM/YYYY')#"/> --->

<!---
<cfoutput>
	<ul>
		<cfloop list="#args.latest_event#" index="latest_event">
			<cfdump var="#latest_event#">
		</cfloop>
	</ul>
</cfoutput> --->

<!--- events = presideObjectService.selectData(
          objectName   = "event"
        , filter       = { category = rc.category }
        , selectFields = [ "event.name", "category.label as categoryName", "event.category" ]
        , orderby      = "event.name"
);

		var filter					  = "region.id in (:region.id)";
		var filterParams["region.id"] = listToArray(arguments.regions);
		if(len(arguments.excluded_event_id)){
			filter				   &= " and page.id != :page.id";
			filterParams["page.id"] = arguments.excluded_event_id;
		} --->



