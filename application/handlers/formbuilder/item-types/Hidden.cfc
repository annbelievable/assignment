component {

	private string function renderInput( event, rc, prc, args={} ) {
		var controlName = args.name ?: "";
		var hiddenValue = "mysecret";

		return renderFormControl(
			  argumentCollection = arguments
			, name               = controlName
			, type               = "hidden"
			, context            = "formbuilder"
			, id                 = args.id ?: controlName
			, layout             = ""
			, hiddenValue        = hiddenValue
		);
	}

	//the reason being is that the label is deleted in form so here the title in i18n is used
	private function getExportColumns( event, rc, prc, args={} ) {
		return [ translateResource( 'formbuilder.item-types.hidden:title' ) ];
	}
}