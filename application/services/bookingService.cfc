/**
*
* @presideService
*
*/

component output=false{
// CONSTRUCTOR
    /**
     * @workflowService.inject      workflowService
     * @emailService.inject         emailService
     * @notificationService.inject  notificationService
     *
     */

    public any function init(
          required any workflowService
        , required any emailService
        , required any notificationService

    ) {
        _setWorkflowService( arguments.workflowService );
        _setEmailService( arguments.emailService );
        _setNotificationService( arguments.notificationService );
        return this;
    }

    public struct function getApplicationProgress(required string eventId ) {
        var workflowArgs = {
              workflow  = "booking"
            , reference = arguments.eventId
        }
        return _getWorkflowService().getState( argumentCollection=workflowArgs );
    }

    public void function updateApplicationProgress(
          required string step
        , required string eventId
        ,          struct stateDetail = {}
    ) {
        var workflowArgs = {
              workflow  = "booking"
            , reference = arguments.eventId
            , state     = arguments.stateDetail
            , status    = arguments.step
            , expires   = _getApplicationWorkflowExpiry()
        };
        _getWorkflowService().appendToState( argumentCollection=workFlowArgs );
    }

    private date function _getApplicationWorkflowExpiry() {
        return DateAdd( "d", 1, Now() );
    }

    public struct function finalizeApplication( required string eventId ) {
        var result              = { statusCode="SUCCESS" };
        var userDetails         = $getWebsiteLoggedInUserDetails();
        var applicationProgress = getApplicationProgress( eventId = arguments.eventId );
        var applicationState    = applicationProgress.state ?: {};
        var bookingData = {
              id                = applicationProgress.id                                       ?: ""
            , label             = 'Booking successful'
            , event_detail      = applicationState.step1Detail.event_detail                    ?: ""
            , firstname         = applicationState.step1Detail.firstname                       ?: ""
            , lastname          = applicationState.step1Detail.lastname                        ?: ""
            , email             = applicationState.step1Detail.email                           ?: ""
            , number_of_seat    = LSParseNumber(applicationState.step2Detail.number_of_seat)   ?: ""
            , total_amount      = LSParseNumber(applicationState.step2Detail.total_amount)     ?: ""
            , session           = applicationState.step2Detail.event_session                   ?: ""
            , special_request   = applicationState.step2Detail.special_request                 ?: ""
            , purchase_number   = applicationState.step3Detail.purchaseNumber                  ?: ""
            , creditcard_number = applicationState.step3Detail.creditCardNumber                ?: ""
            , expired_date      = applicationState.step3Detail.expiredDate                     ?: ""
        }

        if(!len(trim(bookingData.special_request))){
            bookingData.special_request = "none";
        }

        try {
            var booked = $getPresideObjectService().insertData(
                  objectName = "booking_detail"
                , data       = bookingData
                , insertManyToManyRecords=true
            );

            _getWorkflowService().complete( id=applicationProgress.id );
        }
        catch( e ) {
            $raiseError(e);
            result.statusCode        = "FAILED";
            result.statusCodeMessage = "Failed to save the data. Please contact our web administrator";
        }

        if(result.statusCode == "SUCCESS"){
            // sends email to user
            $sendEmail(
                  template = "eventBookingConfirmation"
                , to       = [ bookingData.email ]
                , args     = bookingData
            );
            // sends notification to admin
            $createNotification(
                   topic = "newBooking"
                 , type  = "ALERT"
                 , data  = {id=booked}
             );
        }

        return result;
    }

    private function _setWorkflowService( required any workflowService ){
        _workflowService = arguments.workflowService;
    }

    private function _getWorkflowService(  ){
        return _workflowService;
    }

    private function _setEmailService( required any emailService ){
        _emailService = arguments.emailService;
    }

    private function _getEmailService(  ){
        return _emailService;
    }

    private function _setNotificationService( required any notificationService ){
        _notificationService = arguments.notificationService;
    }

    private function _getNotificationService(  ){
        return _notificationService;
    }
}