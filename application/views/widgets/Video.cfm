<!---
	This view file has been automatically created by the preside dev tools
	scaffolder. Please fill with meaningful content and remove this comment
--->

<cfparam name="args.video_link" default="" />
<cfparam name="args.width" default="560" />
<cfparam name="args.height" default="315" />


<cfif len(args.video_link)>
	<cfoutput>
		<iframe width="#args.width#" height="#args.height#" src="#args.video_link#" frameborder="0" allowfullscreen></iframe>
	</cfoutput>
</cfif>