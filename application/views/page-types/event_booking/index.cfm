
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfoutput>
    <cfif Len( Trim( rc.errorMessage ?: "" ) )>
        <div class="alert alert-danger">
            #renderContent( "richeditor", rc.errorMessage )#
        </div>
    </cfif>

    <cfswitch expression="#args.currentStep#">
        <cfcase value="2">
            #renderView( view='page-types/event_booking/_sessionDetail', args=args )#
        </cfcase>
        <cfcase value="3">
            #renderView( view='page-types/event_booking/_paymentInfo', args=args )#
        </cfcase>
        <cfdefaultcase>
            #renderView( view='page-types/event_booking/_personalDetail', args=args )#
        </cfdefaultcase>
    </cfswitch>
</cfoutput>