component {

	property name="presideObjectService" inject="presideObjectService";

	private void function onSubmit( event, rc, prc, args={} ) {
		var data = {
			  email    = rc.email    ?: "no one"
			, feedback = rc.feedback ?: "nothing"
			, label    = "feedback"
		}
		presideObjectService.insertData(
             objectName = "feedback"
            , data       = data
		);
	}

}