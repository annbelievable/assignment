<cfparam name="args.id"				 type="string" />
<cfparam name="args.event_detail"	 type="string" />
<cfparam name="args.firstname"		 type="string" />
<cfparam name="args.lastname"		 type="string" />
<cfparam name="args.email"			 type="string" />
<cfparam name="args.number_of_seat"	 type="numeric" />
<cfparam name="args.total_amount"	 type="numeric" />
<cfparam name="args.sessions"		 type="string" />
<cfparam name="args.special_request" type="string" />

<cfoutput>
	<div class="alert alert-info">
		<h2><i class="fa fa-exclamation"></i>Booking Detail ID: #args.id#</h2>
		<dl>
			<dt>Name:</dt>
			<dd><strong>#args.firstname# #args.lastname#</strong></dd>

			<dt>Email:</dt>
			<dd><a href="#args.email#">#args.email#</a></dd>

			<dt>Event ID:</dt>
			<dd>#args.event_detail#</dd>

			<dt>Number of Seats:</dt>
			<dd>#args.number_of_seat#</dd>

			<dt>Sessions:</dt>
			<dd>#args.sessions#</dd>

			<dt>Total Amount:</dt>
			<dd>#args.total_amount#</dd>

			<dt>Special Request:</dt>
			<dd>#args.special_request?:""#</dd>
		</dl>
	</div>
</cfoutput>