component extends="preside.system.config.Config" {

	public void function configure() {
		super.configure();

		settings.preside_admin_path  = "assignment";
		settings.system_users        = "sysadmin";
		settings.default_locale      = "en";

		settings.default_log_name    = "assignment";
		settings.default_log_level   = "information";
		settings.sql_log_name        = "assignment";
		settings.sql_log_level       = "information";

		settings.ckeditor.defaults.stylesheets.append( "css-bootstrap" );
		settings.ckeditor.defaults.stylesheets.append( "css-layout" );

		settings.features.websiteUsers.enabled = true;

		settings.notificationTopics.append("newBooking");
		settings.notificationTopics.append("seatsFinished");

		interceptors.append( { class="app.interceptors.EventBookingInterceptor", properties={} });
		coldbox.requestcontextDecorator = "app.decorators.RequestContextDecorator";

		_setupDerivatives();
		_setupEmailSettings();
	}

	private function _setupDerivatives(){
		settings.assetmanager.derivatives.pdf_thumbnail = {
		      permissions     = "inherit"
		    , inEditor        = false
		    , transformations = [
		          { method="pdfPreview" , args={ page=1 }, inputfiletype="pdf", outputfiletype="jpg" }
		        , { method="shrinkToFit", args={ width=300, height=300 } }
		      ]
		};
	}

	private void function _setupEmailSettings() {
    	settings.email.templates.eventBookingConfirmation = {
	          feature       = "cms"
	        , recipientType = "anonymous"
	        , parameters    = [
	                    { id = "firstname"      , required=false }
	                  , { id = "lastname"       , required=false }
	                  , { id = "numberOfSeat"   , required=false }
	                  , { id = "totalAmount"    , required=false }
	                  , { id = "eventSession"   , required=false }
	                  , { id = "specialRequest" , required=false }
	        ]
	    };
    }
}
