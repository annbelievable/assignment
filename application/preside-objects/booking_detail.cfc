
component   dataManagerGroup="event"{
	property name="event_detail" relationship="many-to-one"  relatedTo="event_detail";
	property name="session"      relationship="many-to-many" relatedTo="session" required=true;
	property name="firstname"         type="string"  dbtype="varchar" maxLength="200" required=true;
	property name="lastname"          type="string"  dbtype="varchar" maxLength="200" required=true;
	property name="email"             type="string"  dbtype="varchar" maxLength="200" required=true;
	property name="number_of_seat"    type="numeric" dbtype="int" required=true;
	property name="total_amount"      type="numeric" dbtype="int" required=false;
	property name="special_request"   type="string"  dbtype="longtext" default="none";
	property name="purchase_number"   type="string"  dbtype="varchar" maxLength="200" required=true;
	property name="creditcard_number" type="string"  dbtype="varchar" maxLength="200" required=true;
	property name="expired_date"      type="string"  dbtype="varchar" maxLength="200" required=true;
}