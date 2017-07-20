component {

	private string function renderInput( event, rc, prc, args={} ) {

		return renderFormControl(
			  argumentCollection = arguments
			, name               = args.name
			, type               = "radio_text"
			, context            = "formbuilder"
			, radio_id           = args.radio_id                ?: ""
			, layout             = ""
			, required           = IsTrue( args.mandatory ?: "" )

			, textarea_id        = args.textarea_id             ?: ""
			, radio_yes_label    = args.radio_yes_label         ?: "Yes"
			, radio_no_label     = args.radio_no_label          ?: "No"
			, textarea_labels    = args.textarea_label          ?: ""
			, textarea_help      = args.textarea_help           ?: ""
			, defaultValue       = 0
		);
	}

	private any function getItemDataFromRequest( event, rc, prc, args={} ) {
		var inputName   = args.inputName         ?: "";
		var itemConfig  = args.itemConfiguration ?: {};
		var requestData = args.requestData       ?: {};
		var radioName   = "radio_#inputName#";
		var textName    = "text_#inputName#";
		var radioValue  = requestData[radioName];
		var textValue   = requestData[textName];
		var data        = {};

		if(radioValue == "1"){
			return data[inputName]  = textValue;
		}else{
			return data[inputName]  = radioValue;
		}
	}

	private string function renderResponse( event, rc, prc, args={} ) {
		args.response   = IsJson( args.response ?: "" ) ? DeserializeJson( args.response ) : args.response;
		return renderView( view="/formbuilder/item-types/radio_text/renderResponse", args=args );
	}

}