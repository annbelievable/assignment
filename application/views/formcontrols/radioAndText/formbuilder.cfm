
<cfscript>
	name            = args.name                   ?: "";
	radioInputId    = args.radio_id               ?: "";
	radio_yes_label = len( args.radio_yes_label ) ? args.radio_yes_label : "Yes";
	radio_no_label  = len( args.radio_no_label )  ? args.radio_no_label  : "No";
	textareainputId = args.textarea_id            ?: "";
	textareaLabels  = args.textarea_labels        ?: "";
	minlength       = args.textarea_minlength     ?: "";
	maxlength       = args.textarea_maxlength     ?: "";
	help            = args.textarea_help          ?: "";

	event.include( "/js/specific/radio-textarea/" );
</cfscript>

<cfoutput>
	<div class="radio-with-textarea-field">
		<div class="form-group radio-selection-field">
			<div class="form-field form-inline">
				<div class="radio">
					<input type="radio" id="rdb-yes_radio#name#" name="radio_#name#"  class="radio-selection radio-selection-1" value="1"<!--- <cfif IsBoolean( radioValues ) && radioValues> checked</cfif> --->>
					<label for="rdb-yes_radio#name#">#radio_yes_label#</label>
				</div>
				<div class="radio">
					<input type="radio" id="rdb-no_radio#name#" name="radio_#name#"  class="radio-selection radio-selection-2" value="0"<!--- <cfif IsBoolean( radioValues ) && !radioValues> checked</cfif> --->>
					<label for="rdb-no_radio#name#">#radio_no_label#</label>
				</div>
			</div>
		</div>

		<div class="form-group textarea-field">
			<label for="">#textareaLabels#</label>
			<textarea
			  id          = "#textareainputId#"
			  rows        = "8"
			  name        = "text_#name#"
			  <cfif !isEmpty( minlength ) && isNumeric( minlength )>  minlength = "#minlength#"</cfif>
			  <cfif !isEmpty( maxlength ) && isNumeric( maxlength )>  maxlength = "#maxlength#"</cfif>
			  tabindex    = "#getNextTabIndex()#"></textarea>
		</div>

		<cfif !isEmpty( help ) >
			#help#
		</cfif>
	</div>
</cfoutput>



