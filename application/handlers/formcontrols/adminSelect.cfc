component {

	property name="presideObjectService" inject="presideObjectService";

	public string function index( event, rc, prc, args={} ){
		var objectName = args.objectName ?: "";
		var id         = args.savedData.event_detail;
		eventDetail    = presideObjectService.selectData( objectName=objectName, id=id, selectFields=["total_seats","seats_booked"]);

		if(eventDetail.total_seats == 0){
			numSeats = 1000;
		}else{
			numSeats = eventDetail.total_seats - eventDetail.seats_booked;
		}

		args.labels    = [];
		args.values    = [];
		seats          = ArrayNew(1);

		for (i=1;i<=numSeats;i++) {
			seats[i] = i;
			ArrayAppend(args.labels, i);
			ArrayAppend(args.values, i);
		}

		return renderView( view="formcontrols/select/website", args = args );
	}
}