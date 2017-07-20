component {

	private string function renderInput( event, rc, prc, args={} ) {
		return renderFormControl(
			  argumentCollection = arguments
			, name               = args.name
			, type               = "radioAndText"
			, context            = "formbuilder"
			, radio_id           = args.radio_id ?: ""
			, layout             = ""
			, required           = IsTrue( args.mandatory ?: "" )
			, textarea_id        = args.textarea_id        ?: ""
			, radio_yes_label    = args.radio_yes_label    ?: "Yes"
			, radio_no_label     = args.radio_no_label     ?: "No"
			, textarea_labels    = args.textarea_label     ?: ""
			, textarea_help      = args.textarea_help      ?: ""
			, textarea_minlength = args.textarea_minlength ?: ""
			, textarea_maxlength = args.textarea_maxlength ?: ""
			, defaultValue       = 0
		);
	}

	private string function getItemDataFromRequest( event, rc, prc, args={} ) {
		var inputName   = args.inputName         ?: "";
		var itemConfig  = args.itemConfiguration ?: {};
		var requestData = args.requestData       ?: {};
		var radioName   = "radio_#inputName#";
		var textName    = "text_#inputName#";
		var radioValue  = requestData[radioName] == 1 ? "Yes" : "No";
		var textValue   = requestData[textName];

		var data        = {
			  '#radioName#'= radioValue
			, '#textName#' = textValue
		};

		return serializeJSON( data );
	}

	private string function renderResponse( event, rc, prc, args={} ) {
		args.response = IsJson( args.response ?: "" ) ? DeserializeJson( args.response ) : args.response;
		return renderView( view="/formbuilder/item-types/radioAndText/renderResponse", args=args );
	}

	public array function getExportColumns( event, rc, prc, args={} ) {
		var name      = args.name ?: "";
		var radioName = "#name# Radio";
		var textName  = "#name# Text";
		return [ radioName, textName ];
	}

	public array function renderResponseForExport( event, rc, prc, args={} ) {
		var response = IsJson( args.response ?: "" ) ? deserializeJSON( args.response ) : {};
		var itemData = [];
		for ( var obj in response ) {
			ArrayAppend( itemData, response[obj] );
		}
		return itemData;
	}

}