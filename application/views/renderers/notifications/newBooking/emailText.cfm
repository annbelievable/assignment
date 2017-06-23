
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
	Booking Detail ID : #args.id#

	Name  : #args.firstname# #args.lastname#
	Email : #args.email#

	Event ID		: #args.event_detail#
	Number of Seats : #args.number_of_seat#
	Sessions		: #args.sessions#
	Total Amount	: #args.total_amount#

	Special Request : #args.special_request#

</cfoutput>