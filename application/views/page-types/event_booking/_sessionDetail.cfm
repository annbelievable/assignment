
<cfoutput>
	<form name="booking" id="booking" action="#event.buildLink( linkTo="page-types.event_booking.saveSessionDetail")#" method="POST">
		#renderForm(
			  formName         = "event_booking.sessionDetail"
			, context          = "website"
			, formId           = "booking-form"
			, validationResult = rc.validationResult ?: ""
			, savedData 	   = rc.savedData ?: {}
		)#
		<input type="submit" value="Next" />
	 	<a href="#event.buildLink( linkTo='page-types.event_booking.prevStep', queryString="step=1&id=#( rc.id?:'' )#" )#" class="pull-left">Back</a>
	</form>
</cfoutput>