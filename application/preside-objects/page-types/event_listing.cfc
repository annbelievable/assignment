/*
 * This preside object has been scaffolded by the Preside dev tools scaffolder
 *
 * For speed of scaffolding, we have just created all your properties with the default
 * settings. You will almost certainly want to define your properties in more detail
 * here. Some examples:
 *
 * property name="myTextField" type="string" dbtype="varchar" maxLength=200 required=true uniqueindexes="myUX|2";
 * property name="myFlag" type="boolean" dbtype="boolean" required=false default=false;
 * property name="somecategory" relationship="many-to-one" relatedto="some_category_object" required=true uniqueindexes="myUX|1;
 *
 * You should remove this comment once you are done with it.
 */

component  {
	property name="event_detail" relationship="many-to-many" relatedTo="event_detail" required=false;
	property name="region"	    relationship="many-to-one"   relatedTo="region"		  required=false;
	property name="categories"  relationship="many-to-many"  relatedTo="category"	  required=false;
}