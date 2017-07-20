component extends="coldbox.system.Interceptor"{

	property name="notificationService"  inject="delayedInjector:notificationService";
	property name="presideObjectService" inject="delayedInjector:presideObjectService";
	property name="SitetreeService"      inject="delayedInjector:SitetreeService";

	public void function postInsertObjectData( event, interceptData ){

		if( interceptData.objectName == 'booking_detail' ){
			var bookingId   = interceptData.data.event_detail;
			var eventDetail = presideObjectService.selectData(
				  objectName = "event_detail"
				, id         = bookingId
			);

			SitetreeService.editPage(
				  id         = bookingId
				, seats_booked = eventDetail.seats_booked + interceptData.data.number_of_seat
			);

			if( eventDetail.seats_booked GTE eventDetail.total_seats ){
				notificationService.createNotification(
	   				  topic = "seatsFinished"
	   				, type  = "ALERT"
	   				, data  = {id = bookingId}
	   			);
			}
		}
	}
}