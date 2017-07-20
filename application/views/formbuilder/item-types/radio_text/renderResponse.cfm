<cfparam name="args.response"          type="string" default="" />
<!--- <cfparam name="args.itemConfiguration" type="struct" default="#structNew()#" /> --->

<!--- <cfscript>
	labelName = args.itemConfiguration.name;
	RadioValue    = Len( args.response[ "radio_#labelName#" ] )    ? args.response[ "radio_#labelName#" ]    : '<em class="grey">No response</em>';
	TextareaValue = Len( args.response[ "text_#labelName#" ] )     ? args.response[ "text_#labelName#" ]     : '<em class="grey">No response</em>';

	switch(RadioValue) {
		case 1 :
			RadioValue = args.itemConfiguration.radio_yes_label;
			break;
		case 2 :
			RadioValue = args.itemConfiguration.radio_no_label;
			break;
	}

	var radioLabel = args.itemConfiguration.radio_yes_label ?: args.itemConfiguration.radio_no_label;
	var textLabel  = args.itemConfiguration.textarea_label ?: "";
</cfscript> --->

<cfoutput>
<!--- 	<cfif len(radioLabel)>
		<strong>#radioLabel#:</strong>
	</cfif>
	#RadioValue#
	<br>
	<cfif len(textLabel)>
		<strong>#textLabel#:</strong>
	</cfif>
	#TextareaValue# --->
	#args.response#
</cfoutput>