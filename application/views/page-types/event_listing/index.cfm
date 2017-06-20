
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cf_presideparam name="args.bottom_content"  field="page.bottom_content" editable="true" />
<cf_presideparam name="args.parent_page"   field="page.parent_page"	 editable="false" />

<cfscript>
	//this script is meant for region
	filter = {"page.parent_page" = event.getCurrentPageId() };

	regions = args.regions?:queryNew("");

	rc.region = rc.region?:"";

	if(len(rc.region)){
		filter["region.id"] = rc.region;
	}

</cfscript>

<cfoutput>
	<h1>#args.title#</h1>
	<div class="row">
		#args.main_content#
	</div>
	<div class="row">
		#args.bottom_content#
	</div>

	#renderViewlet( event="page-types.event_listing.get_region", args={ page_id=event.getCurrentPageId() } )#

	#renderViewlet( event="page-types.event_listing.get_categories", args={ page_id=event.getCurrentPageId() } )#

	<br>
	<hr>
	<br>

	#renderViewlet( event="page-types.event_listing.get_child_event_detail", args={ page_id = event.getCurrentPageId()} )#

	<form name="filter" action="#event.buildLink()#" method="POST">
		<fieldset>
			<label for="region">Region</label>
			<select id="region" name="region">
				<option value="">All</option>
				<cfloop query="regions">
					<option value="#id#" #(rc.region eq id)?'selected="selected"':''#>#label#</option>
				</cfloop>
			</select>
			<input type="submit" value="Filter" />
		</fieldset>
	</form>

	#renderViewlet( event="page-types.event_listing.filter_region", args={ region = rc.region })#

	<br>

	<a href="#event.buildLink( page=args.parent_page )#">Home</a>

</cfoutput>
