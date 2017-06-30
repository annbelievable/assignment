component {

    property name="event_services" inject="event_services";

	private string function emailSubject( event, rc, prc, args={} ) {
        var data   = deserializeJSON(args.data);
        var id     = data.id;
        return "Event detail ID: #id# seats finished.";
    }

	private string function emailHtml( event, rc, prc, args={} ) {
        var data   = deserializeJSON(args.data);
        var id     = data.id;
        return renderView(
              view = "/renderers/notifications/seatsFinished/emailHtml"
            , args = id
        );
    }

    private string function emailText( event, rc, prc, args={} ) {
        var data   = deserializeJSON(args.data);
        var id     = data.id;
        return renderView(
              view = "/renderers/notifications/seatsFinished/emailText"
            , args = id
        );
    }



    private string function full( event, rc, prc, args={} ) {
        var id     = args.id;
        return renderView(
              view = "/renderers/notifications/seatsFinished/full"
            , args = id
        );
    }

    private string function datatable( event, rc, prc, args={} ) {
        return "Event Detail ID: #args.id?:""#.";
    }

}
