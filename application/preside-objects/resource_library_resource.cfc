/**
 * @searchEnabled true
 * @datamanagergridfields title,resource_type,access_restriction,datecreated,datemodified,region,category
 */
component extends="application.extensions.preside-ext-resource-library.preside-objects.resource_library_resource"{
	property name="publish_date" searchField="date"          required=true        searchEnabled=true;                                                                                           searchEnabled=true;             default=false;
	property name="category"     relationship="many-to-many" relatedTo="category" searchEnabled=true searchSearchable=false;
	property name="region"       relationship="many-to-many" relatedTo="region"   searchEnabled=true searchSearchable=false;
}