component implements="preside.system.services.routeHandlers.iRouteHandler" singleton=true {

// constructor
	public any function init() output=false {
		return this;
	}

// route handler methods
	public boolean function match( required string path, required any event ) output=false {
		return ReFindNoCase( "^/news-listing/.*?\.html", arguments.path );
	}

	public void function translate( required string path, required any event ) output=false {
		var rc  = event.getCollection();
		var prc = event.getCollection( private=true );

		prc.eventSlug = ReReplace( arguments.path, "^/news-listing/(.*?)\.html$", "\1" );

		rc.event = "page-types.news_listing.detail";
	}

	public boolean function reverseMatch( required struct buildArgs, required any event ) output=false {
		return Len( Trim( buildArgs.eventSlug ?: "" ) );
	}

	public string function build( required struct buildArgs, required any event ) output=false {
		return _getRootPath() & "/news-listing/#buildArgs.eventSlug#.html";
	}

// private helpers
	private string function _getRootPath() output=false {
		var protocol = ( cgi.server_protocol.startsWith( "HTTPS" ) ? "https" : "http" ) & "://";
		var domain   = cgi.server_name;
		var port     = cgi.server_port == 80 ? "" : ":#cgi.server_port#";

		return protocol & domain & port;
	}

}