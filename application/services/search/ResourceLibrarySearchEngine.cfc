/**
 * @singleton
 * @presideService
 */
component {

// CONSTRUCTOR
	/**
	 * @elasticSearchEngine.inject     ElasticSearchEngine
	 * @elasticSearchApiWrapper.inject ElasticSearchApiWrapper
	 */

	public any function init(
		  required any elasticSearchEngine
		, required any elasticSearchApiWrapper
	) {
		_setElasticSearchEngine( arguments.elasticSearchEngine     );
		_setElasticSearchApi(    arguments.elasticSearchApiWrapper );

		return this;
	}

// PUBLIC METHODS
	public any function search(
		  string  q                          = "*"
		, numeric page                       = 1
		, numeric pageSize                   = 10
		, string  region                     = ""
		, string  category                   = ""
		, string  year                       = ""
		, string  fieldList                  = "id,title,slug,date,teaser,description,featuredImage,region,category"
	) {

		var args             = Duplicate( arguments );
		args.objects         = [ "resource_library_resource" ];
		args.sortOrder       = "_score";
		args.defaultOperator = "AND";
		args.pageSize        = arguments.pageSize;

		if ( !Len( Trim( args.q ) ) ) {
			args.q = "*";
		}

		args.fullDsl        = _getElasticSearchApi().generateSearchDsl( argumentCollection=args );
		args.fullDsl.filter = _getFilterDsl(
			  region        = arguments.region
			, category      = arguments.category
			, year          = arguments.year
		);
		args.fullDsl.query  = _getQueryStringConfig( q=args.q );

		_addAggregationsDsl( args.fullDsl  );

		var results = _getElasticSearchEngine().search( argumentCollection=args );

		_translateAggregation( results.getAggregations() );

		return results;
	}

// PRIVATE HELPERS
	private struct function _getFilterDsl(
		  string   region            = ""
		, string   category          = ""
		, string   year              = ""
	) {
		var filter              = {};
			filter.bool         = {};
			filter.bool.should  = [];
			filter.bool.must    = [];


		if ( arguments.region.len() ) {
			filter.bool.must.append( {  terms  = { region  =  listToArray('#arguments.region#', ",") } } );
		}

		if ( arguments.category.len() ) {
			filter.bool.must.append( {  terms  = { category =  listToArray('#arguments.category#', ",") } } );
		}

		if ( arguments.year.len() ) {
			filter.bool.must.append( {  terms  = { year =  listToArray('#arguments.year#') } } );
		}

		if( !arrayLen( filter.bool.must ) && !arrayLen( filter.bool.should ) ){
			filter = {};
		}

		return filter;
	}

	private void function _addAggregationsDsl( required struct dsl ) {
		var aggs = {
			  region           = { terms={ field="region"       , order={ _term="asc"  }, size=50 } }
			, category         = { terms={ field="category"     , order={ _term="asc"  }, size=50 } }
			, year             = { terms={ field="year"         , order={ _term="desc" }, size=50 } }
		};

		if ( ( dsl.filter ?: {} ).count() ) {
			dsl.aggs = {
				filtered = {
					  filter = dsl.filter
					, aggs   = aggs
				}
			}
		} else {
			dsl.aggs = aggs;
		}
	}

	private void function _translateAggregation( required struct aggregations ) {
		var filtered = aggregations.filtered ?: aggregations;

		for( var key in filtered ) {
			aggregations[ key ] = filtered[ key ].buckets ?: [];

			if ( aggregations[ key ].len() ) {

				var objectName = "";

				switch( key ) {
					case "region"               : objectName="region"   ; break;
					case "category"    			: objectName="category" ; break;
				}

				if( !isEmpty( objectName ) ){
					for( var i=1; i <= aggregations[ key ].len(); i++ ) {

						aggregations[ key ][i].delete( "doc_count_error_upper_bound" );
						aggregations[ key ][i].delete( "sum_other_doc_count" );

						var record = $getPresideObject( '#objectName#' ).selectData(
							  selectFields = [ "label", "id" ]
							, id           = aggregations[ key ][i].key
						);

						aggregations[ key ][i].label = record.label ?: "";
						aggregations[ key ][i].id    = record.id  ?: "";

					}
				}
			}
		}
	}

	private struct function _getQueryStringConfig( string q, string searchBy ){
		var config = {};

		config.query_string = {
			  query            =  lcase( arguments.q )
			, fields           = [ "title^10", "teaser^3", "description" ]
			, default_operator = "OR"
		};

		return config;
	}


// GETTERS AND SETTERS
	private any function _getElasticSearchEngine() {
		return _elasticSearchEngine;
	}
	private void function _setElasticSearchEngine( required any elasticSearchEngine ) {
		_elasticSearchEngine = arguments.elasticSearchEngine;
	}

	private any function _getElasticSearchApi() {
		return _elasticSearchApi;
	}
	private void function _setElasticSearchApi( required any elasticSearchApiWrapper ) {
		_elasticSearchApi = arguments.elasticSearchApiWrapper;
	}

}