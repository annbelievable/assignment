
<cffunction name="stripHTMLFromFormInput" access="public" returntype="any" output="false">
	<cfargument name="formName" type="struct" required="true" />
	<cfloop collection="#formName#" item="key">
		<cfset formName[key] = REReplaceNoCase(formName[key], "<[^[:space:]][^>]*>", "", "ALL") />
	</cfloop>
	<cfreturn formName />
</cffunction>

<cffunction name="arrayOfStructsSort" access="public" returntype="array">
	<cfargument name="sourceArray" type="array"  required="true"                       />
	<cfargument name="key"         type="string" required="false"                      />
	<cfargument name="sortOrder"   type="string" required="false" default="asc"        />
	<cfargument name="sortType"    type="string" required="false" default="textnocase" />
	<cfargument name="delimiter"   type="string" required="false" default="." />

	<cfscript>
		var sortArray   = [];
		var returnArray = [];
		var count       = arrayLen( arguments.sourceArray );

		for( var i = 1; i lte count; i = i + 1 ){
			var arrayValue = arguments.sourceArray[i][key] & arguments.delimiter & i;
			if( arguments.sortType=="numeric" ){
				arrayValue = reReplaceNoCase( arguments.sourceArray[i][key], "[^0-9]", "", "all" ) & arguments.delimiter & i;
			}
			sortArray[i] = arrayValue;
		}

		arraySort( sortArray, arguments.sortType, arguments.sortOrder );

		for( var i = 1; i lte count; i = i + 1 ){
			returnArray[i] = arguments.sourceArray[ listLast( sortArray[i], arguments.delimiter ) ];
		}

		return returnArray;
	</cfscript>
</cffunction>
