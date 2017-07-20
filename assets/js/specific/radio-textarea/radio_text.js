(function($) {

	$('.radio-selection-field .radio-selection').on('change', function(){
		var thisRadio = $(this);
		var textareaField = thisRadio.closest('.radio-with-textarea-field').find('.textarea-field');

		if ( thisRadio.val() == 1 ){
			textareaField.slideDown();
		} else {
			textareaField.slideUp();
		}
	});

	$(document).ready(function() {
		$('.radio-selection-field .radio-selection-1').each(function() {

			var textareaField = $(this).closest('.radio-with-textarea-field').find('.textarea-field');

			if ( $(this).prop("checked") == true ){
				textareaField.slideDown();
			} else {
			textareaField.slideUp();
		}

		});
	});

})(jQuery);