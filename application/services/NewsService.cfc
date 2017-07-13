component output=false{
//CONSTRUCTOR
/**
*@news_detail.inject presidecms:object:news_detail
*/
	public any function init( required any news_detail ) {
		_setNewsDetail( arguments.news_detail );
		return this;
	}

	query function getNewsDetails() {
		return _getNewsDetail().selectData( selectFields=["id","label","slug"] );
	}

	public query function getNewsDetailBySlug( required string slug ){
		var filter               = "slug = :slug";
		var filterParams["slug"] = arguments.slug;
		return _getNewsDetail().selectData(
			  filter       = filter
			, filterParams = filterParams
			, selectFields = ["id","label"]
		);
	}

	private function _setNewsDetail( required any news_detail ) {
		_newsDetail = arguments.news_detail;
	}

	private function _getNewsDetail() {
		return _newsDetail;
	}

}