
component  {
	property name="event_detail" relationship="many-to-many" relatedTo="event_detail" required=false;
	property name="region"       relationship="many-to-one"  relatedTo="region"       required=false;
	property name="categories"   relationship="many-to-many" relatedTo="category"     required=false;
}