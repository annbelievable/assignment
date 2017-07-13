
<cfoutput>
	<form name="booking" id="booking" action="#event.buildLink( linkTo="page-types.event_booking.savePersonalDetail")#" method="POST">
		#renderForm(
			  formName         = "event_booking.personalDetail"
			, context          = "website"
			, formId           = "booking-form"
			, validationResult = rc.validationResult ?: ""
			, savedData 	   = rc.savedData ?: {}
		)#
		<input type="submit" value="Next" />
	</form>
</cfoutput>