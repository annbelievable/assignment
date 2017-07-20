component output=false{

	property name="presideObjectService" inject="presideObjectService";

	public string function index( event, rc, prc, args={} ){
		var objectName = args.objectName ?: "";
		args.records   = presideObjectService.selectData( objectName=objectName, selectFields=["id","label"], orderby="label");
		args.values    = ValueArray( args.records.id );
		args.labels    = ValueArray( args.records.label );

		return renderView( view="formcontrols/checkboxlist/index", args = args );
	}
}
