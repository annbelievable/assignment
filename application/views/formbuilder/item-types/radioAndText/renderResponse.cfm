<cfparam name="args.response" type="struct" default="" />
<cfoutput>
	<cfloop collection="#args.response#" item="responseItem">
		#args.response['#responseItem#']#
		<br>
	</cfloop>
</cfoutput>