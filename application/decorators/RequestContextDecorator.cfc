component extends="preside.system.coldboxModifications.RequestContextDecorator" output=false{

	public boolean function isFullyBooked( required string eventID){
		var eventDetail = getModel("presideObjectService").selectData(
			  objectName   = "event_detail"
			, id           = arguments.eventID
			, selectFields = ["total_seats","seats_booked"]
		);

		if(eventDetail.total_seats EQ 0){
			return false;
		}else if(eventDetail.total_seats NEQ 0 AND eventDetail.seats_booked EQ 0 ){
			return false;
		}else if(eventDetail.total_seats NEQ 0 AND eventDetail.total_seats GT eventDetail.seats_booked ){
			return false;
		}else{
			return true;
		}
	}

}