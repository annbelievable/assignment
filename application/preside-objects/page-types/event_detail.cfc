/**
 *
 * @datamanagergridfields start_date,end_date,total_seats,price
 */
component  {
	property name="start_date"   type="date"    dbtype="datetime" required=false;
	property name="end_date"     type="date"    dbtype="datetime" required=false;
	property name="bookable"     type="boolean" dbtype="boolean"  required=false;
	property name="price"        type="numeric" dbtype="int"      required=false;
	property name="total_seats"  type="numeric" dbtype="int"      default=0;
	property name="seats_booked" type="numeric" dbtype="int"      default=0;

	property name="regions"    relationship="many-to-many" relatedTo="region"    required=false searchEnabled=true searchSearchable=false;
	property name="category"   relationship="many-to-one"  relatedTo="category"                 searchEnabled=true searchSearchable=false;
	property name="programmes" relationship="one-to-many"  relatedTo="programme" relationshipKey="event_detail";
	property name="session"    relationship="one-to-many"  relatedTo="session"   relationshipKey="event_detail";
	property name="document" control="assetPicker" ;//playing around with relationship="one-to-one" relatedTo="asset"

}
