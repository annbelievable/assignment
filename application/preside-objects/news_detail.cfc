
component  dataManagerGroup="event"{
	/**
	 * @searchEnabled                true
	 */

	property name="slug" default="method:createSlug" control="autoslug"  basedOn="label" searchEnabled=true searchSearchable=false;

	public string function createSlug( required struct data ) {
		var slug      = LCase( ReReplace( arguments.data.label, "\W", "-", "all" ) );
		var increment = 0;

		while( this.dataExists( filter={ slug = slug } ) ) {
			slug = ReReplace( slug, "\-[0-9]+$", "" ) & "-" & ++increment;
		}

		return slug;
	}
}