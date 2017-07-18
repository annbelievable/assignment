( function($){
	if( typeof cfrequest.id === "undefined" ) return;
	$( document ).ready(function() {
		var price = cfrequest.price;

		function total(value){
			$('#total_amount').val(value);
		}

        $("#number_of_seat").on("change", function(){
        	var new_value = this.value * price;
        	total(new_value);
        });

        $("#number_of_seat").change();

	});
})( jQuery );