component extends="coldbox.system.Interceptor" {

	property name="memberService"    inject="provider:MemberService";

// PUBLIC
	public void function configure() {}

	public void function postElasticSearchGetIndexSettings( event, interceptData ) {
		var mappings = interceptData.settings.mappings;

		if ( !mappings.isEmpty() ) {
			for( var doctype in mappings ){
				mappings[ doctype ].properties.date = { type="date", ignore_malformed=true, format="dateOptionalTime" }
				mappings[ doctype ].properties.year = { type="integer" };
			}
		}
	}

	public void function postElasticSearchGetObjectDataForIndexing( event, interceptData ) {

		var records = arguments.interceptData.records ?: [];

		var _getDate   = function( doc ) {
			if ( IsDate( doc.date           ?: "" ) ) { return doc.date;           }
			if ( IsDate( doc.date_published ?: "" ) ) { return doc.date_published; }
			if ( IsDate( doc.publish_date   ?: "" ) ) { return doc.publish_date;   }

			return doc.datecreated ?: "";
		};

		for( var record in records ) {
			var date = _getDate( record );
			if ( IsDate( date ?: "" ) ) {
				record.date = DateFormat( date, "yyyy-mm-dd" ) & "T" & TimeFormat( date, "HH:mm:ss" );
				record.year = Year( record.date );
			}
		}
	}

}