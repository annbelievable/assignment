component {
	property name="siteTreeService"          inject="siteTreeService";
	property name="NewsService"              inject="NewsService";

	public function index( event, rc, prc, args={} ) {
		args.newsDetails = NewsService.getNewsDetails();
		return renderView(
			  view          = 'page-types/news_listing/index'
			, presideObject = 'news_listing'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public string function detail( event, prc, rc, args={} ){
		prc.eventSlug    = prc.eventSlug  ?: "";
		prc.news         = NewsService.getNewsDetailBySlug( slug=prc.eventSlug );
		prc.newsListing  = siteTreeService.getPage( systemPage = "news_listing" );

		event.setEditPageLink( event.buildAdminLink( linkTo='datamanager.editRecord', queryString='object=news_detail&id=#prc.news
            .id#' ) );
		event.initializeDummyPresideSiteTreePage(
			  id         = prc.news.id
			, title      = prc.news.label
			, slug       = prc.eventSlug
			, parentPage = prc.newsListing
		);
	}
}
