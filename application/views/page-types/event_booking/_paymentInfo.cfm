
<cfoutput>
	<form name="booking" id="booking" action="#event.buildLink( linkTo="page-types.event_booking.savePaymentInfo")#" method="POST">
		#renderForm(
			  formName         = "event_booking.paymentInfo"
			, context          = "website"
			, formId           = "booking-form"
			, validationResult = rc.validationResult ?: ""
			, savedData 	   = rc.savedData ?: {}
		)#
		<input type="submit" value="Complete Booking" />
		<a href="#event.buildLink( linkTo='page-types.event_booking.prevStep', queryString="step=2&id=#( rc.id?:'' )#" )#" class="pull-left">Back</a>
	</form>
</cfoutput>