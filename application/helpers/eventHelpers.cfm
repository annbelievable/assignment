
<cffunction name="stripHTMLFromFormInput" access="public" returntype="any" output="false">
	<cfargument name="formName" type="struct" required="true" />
	<cfloop collection="#formName#" item="key">
		<cfset formName[key] = REReplaceNoCase(formName[key], "<[^[:space:]][^>]*>", "", "ALL") />
	</cfloop>
	<cfreturn formName />
</cffunction>
