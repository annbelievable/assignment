component {

  property name="event_services"     inject="event_services";

  private struct function prepareParameters() {
    sessionIds             = (arguments.event_session?:"");
    sessionQuery           = event_services.getSessionLabel( id=sessionIds );
    return {
            firstname      = (arguments.firstname?:"")
          , lastname       = (arguments.lastname?:"")
          , numberOfSeat   = (arguments.number_of_seat?:"")
          , totalAmount    = (arguments.total_amount?:"")
          , eventSession   = ValueList(sessionQuery.label)
          , specialRequest = (arguments.special_request?:"")
    };
  }

  private struct function getPreviewParameters() {
    return {
            firstname        = "David"
          , lastname         = "Bowie"
          , numberOfSeat     = 2
          , totalAmount      = 400
          , eventSession     = "night"
          , specialRequest   = "none"

    };
  }

  private string function defaultSubject() {
    return "Event Booking Successful.";
  }

/*
  private string function defaultHtmlBody() {
    return renderView( view="/email/template/memberRegistrationConfirmation/defaultHtmlBody" );
  }

  private string function defaultTextBody() {
    return renderView( view="/email/template/memberRegistrationConfirmation/defaultTextBody" );
  }
*/

}

