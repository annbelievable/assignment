
<cf_presideparam name="args.parent_page"    field="page.parent_page"		editable="false" />
<cf_presideparam name="args.title"          field="page.title"        		editable="true" />
<cf_presideparam name="args.main_content"   field="page.main_content" 		editable="true" />
<cf_presideparam name="args.bottom_content" field="page.bottom_content" 	editable="true" />
<cf_presideparam name="args.regions" 	    field="GROUP_CONCAT(region.id)" editable="false" />
<cf_presideparam name="args.start_date"		field="event_detail.start_date"	editable="false" />
<cf_presideparam name="args.end_date"		field="event_detail.end_date"	editable="false" />
<cf_presideparam name="args.document"		field="event_detail.document"	editable="false" />
<cfscript>
	page_id = event.getCurrentPageId();
	page_link = event.buildLink( page=page_id );
	pdf_link = event.buildLink( assetId=args.document?:"" );
	pdf_image = event.buildLink( assetId=args.document?:"", derivative="pdf_thumbnail"  );
	disqus_shortname = getSystemSetting(
	          category = "disqus"
	        , setting  = "shortname"
	        , default  = ""
	    );
</cfscript>
<cfoutput>
	<h1>#args.title#</h1>
	<div class="row">
		#args.main_content#
	</div>
	<div class="row">
		#args.bottom_content#
	</div>
	<p>Start date:#args.start_date#</p>
	<p>End date:#args.end_date#</p>

	#renderViewlet(event="page-types.event_detail.get_regions", args={ page_id=page_id } )#

	#renderViewlet(event="page-types.event_detail.get_category", args={ page_id=page_id } )#

	<br>
	<hr>
	<br>

	#renderViewlet(event="page-types.event_detail.get_related_events", args={ regions=args.regions, page_id=page_id } )#

	<br>
	<hr>
	<br>

	<cfif args.end_date LT NOW() >
		<h4>Event Expired</h4>

		<div id="disqus_thread"></div>
		<script>
			var disqus_config = function () {
			this.page.url = '#page_link#';
			this.page.identifier = '#page_id#';
			};
			(function() { // DON'T EDIT BELOW THIS LINE
			var d = document, s = d.createElement('script');
			s.src = 'https://#disqus_shortname#/embed.js';
			s.setAttribute('data-timestamp', +new Date());
			(d.head || d.body).appendChild(s);
			})();
		</script>


		<cfif len(args.document)>
			<p>Download PDF document for #args.title#</p>
			<br>
			<cfset args.document = listFirst(args.document)>
			<a href="#pdf_link#">
				<img src="#pdf_image#"/>
			</a>
			<br>
		</cfif>

	<cfelse>
		<cfif event.isFullyBooked(eventID = page_id)>
			This event is fully booked
		<cfelse>
			<a href="#event.buildLink( page="event_booking", querystring="id=#page_id#" )#">Book Now</a>
		</cfif>
	</cfif>

	<br>
	<a href="#event.buildLink( page=args.parent_page )#">Back to Event Listings</a>
	<br>

</cfoutput>
