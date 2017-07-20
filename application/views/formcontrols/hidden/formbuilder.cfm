<cfscript>
	inputName    = args.name         ?: "";
	inputId      = args.id           ?: "";
	inputClass   = args.class        ?: "";
	defaultValue = args.defaultValue ?: "";
	hiddenValue  = args.hiddenValue  ?: "";

	value  = event.getValue( name=inputName, defaultValue=defaultValue );
	if ( not IsSimpleValue( value ) ) {
		value = "";
	}
</cfscript>

<cfoutput>
	<p>HIDDEN</p>
	<input type="hidden" class="#inputClass#" id="#inputId#" name="#inputName#" value="#hiddenValue#">
</cfoutput>

<!--- <cfoutput>#renderView( view='formcontrols/hidden/index', args=args )#</cfoutput> --->