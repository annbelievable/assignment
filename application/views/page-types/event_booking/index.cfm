
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#
	<form name="event_booking" id="event_booking" action="#event.buildLink( linkTo="page-types.event_booking.bookEvent")#" method="POST">

		#renderForm(
			  formName		   = "event_booking.booking_detail"
			, context		   = "website"
			, formId		   = "event_booking"
			, validationResult = rc.validationResult ?: ""
			, savedData 	   = rc.savedData ?: {}
		)#

		<input type="submit" value="Book" />
	</form>
</cfoutput>