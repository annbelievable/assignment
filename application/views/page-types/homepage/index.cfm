<cfparam name="args.title"        type="string" field="page.title"        editable="true" />
<cfparam name="args.main_content" type="string" field="page.main_content" editable="true" />

<cfscript>
	// keyword = rc.q ?: "";
</cfscript>

<cfoutput>
	<div class="jumbotron"><h1>#args.title#</h1></div>
	#args.main_content#


<!--- 	<form action="#event.buildLink( page='homepage' )#" method="get">
		<div class="form-field">
			<input type="text" name="q" class="form-control widget-search-input" value="#keyword#" placeholder="Keyword" >
		</div>
		<button type="submit">Search</button>
	</form>


	<div>
		#renderViewlet( event="page-types.homepage.result", args=args )#
	</div> --->

</cfoutput>