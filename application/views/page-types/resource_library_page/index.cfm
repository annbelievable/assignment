
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.teaser"       field="page.teaser"       editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfoutput>
	<h1>#args.title#</h1>
	#args.teaser#
	#args.main_content#

	<div class="container-fluid">
		#renderViewlet( event="page-types.resource_library_page.resultSection", args=args )#
	</div>

</cfoutput>