/**
 * @searchEnabled      true
 * @isSystemPageType   true
 */
component {
	property name="item_per_page"               type="numeric" dbtype="integer" default=10;
	property name="show_filter_region" 			type="boolean" dbtype="boolean" default=true;
	property name="show_filter_category"        type="boolean" dbtype="boolean" default=true;
	property name="show_filter_year"            type="boolean" dbtype="boolean" default=true;
}