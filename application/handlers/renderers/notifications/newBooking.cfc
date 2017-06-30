component output=false{

    property name="event_services" inject="event_services";

	private string function emailSubject( event, rc, prc, args={} ) {
        var data = deserializeJSON(args.data);
        var id   = data.id;
        return "New Booking, booking detail ID: #id#.";
    }

	private string function emailHtml( event, rc, prc, args={} ) {
        var data   = deserializeJSON(args.data);
        var id     = data.id;
        var booked = event_services.getBookingDetail(
                      id           = id
                    , selectFields = [
                          "id"
                        , "event_detail"
                        , "firstname"
                        , "lastname"
                        , "email"
                        , "number_of_seat"
                        , "total_amount"
                        , "special_request"
                        , "group_concat( session.label) AS sessions"] );
        return renderView(
              view = "/renderers/notifications/newBooking/emailHtml"
            , args = booked
        );
    }

    private string function emailText( event, rc, prc, args={} ) {
        var data   = deserializeJSON(args.data);
        var id     = data.id;
        var booked = event_services.getBookingDetail(
                      id           = id
                    , selectFields = [
                          "id"
                        , "event_detail"
                        , "firstname"
                        , "lastname"
                        , "email"
                        , "number_of_seat"
                        , "total_amount"
                        , "special_request"
                        , "group_concat( session.label) AS sessions"] );
        return renderView(
              view = "/renderers/notifications/newBooking/emailText"
            , args = booked
        );
    }

    private string function full( event, rc, prc, args={} ) {
        var booked = event_services.getBookingDetail(
                      id           = args.id
                    , selectFields = [
                          "id"
                        , "event_detail"
                        , "firstname"
                        , "lastname"
                        , "email"
                        , "number_of_seat"
                        , "total_amount"
                        , "special_request"
                        , "group_concat( session.label) AS sessions"] );
        return renderView(
              view = "/renderers/notifications/newBooking/full"
            , args = booked
        );
    }

    private string function datatable( event, rc, prc, args={} ) {
        return "Booking Detail ID: #args.id#.";
    }

}