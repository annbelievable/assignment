component {

	private function index( event, rc, prc, args={} ) {
		return renderView(
			  view          = 'page-types/homepage/index'
			, presideObject = 'homepage'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}
}
