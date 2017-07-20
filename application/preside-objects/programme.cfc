
component dataManagerGroup="event" {
	property name="label"        type="string" dbtype="varchar" maxLength="200" required=false;
	property name="start_time"   type="date"   dbtype="datetime"                required=false;
	property name="event_detail" relationship="many-to-one" relatedTo="event_detail";
}