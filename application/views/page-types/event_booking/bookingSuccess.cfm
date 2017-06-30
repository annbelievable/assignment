<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#
	<h2>Booking Success</h2>
	<h4>Booking ID Below:#args.booked#</h4>
	an email containing the booking detail will be sent to you shortly.
</cfoutput>