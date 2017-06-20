
component  {
	property name="start_date" type="date"	  dbtype="datetime" required=false;
	property name="end_date"   type="date"	  dbtype="datetime" required=false;

	property name="bookable"   type="boolean" dbtype="boolean" required=false;
	property name="price"	   type="numeric" dbtype="int"	   required=false;

	property name="regions"	   relationship="many-to-many" relatedTo="region"	 required=false;
	property name="category"   relationship="many-to-one"  relatedTo="category"	 relationshipKey="event_detail";
	property name="programmes" relationship="one-to-many"  relatedTo="programme" relationshipKey="event_detail";
	property name="document" control="assetPicker" ;//relationship="one-to-one" relatedTo="asset"

}