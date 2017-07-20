
<cfscript>
  name                   = args.name                     ?: "";
  radioInputId           = args.radio_id                 ?: "";
  radio_yes_label        = len( args.radio_yes_label )   ? args.radio_yes_label : "Yes";
  radio_no_label         = len( args.radio_no_label )    ? args.radio_no_label  : "No";
  textareainputId        = args.textarea_id              ?: "";
  textareaLabels         = args.textarea_labels          ?: "";

  // radioInputClass        = args.radio_class              ?: "";
  // radioExtraClasses      = args.radio_extraClasses       ?: "";
  // radioDefaultValue      = args.radio_defaultValue       ?: "";
  // radioValues            = event.getValue( name="radio_#name#", defaultValue=radioDefaultValue );
  // if ( not IsSimpleValue( radioValues ) ) {
  //   radioValues = "";
  // }
  // textareaInputClass     = args.textarea_class           ?: "";
  // textareaExtraClasses   = args.textarea_extraClasses    ?: "";
  // textMaxlength          = args.textarea_maxlength       ?: "";
  // textareaHelps          = args.textarea_help            ?: "";
  // textareaValues         = args.textarea_values          ?: "";
  // textareaDefaultValue   = args.textarea_defaultValue    ?: "";
  // textareaValues         = event.getValue( name="text_#name#", defaultValue=textareaDefaultValue );
  // if ( not IsSimpleValue( textareaValues ) ) {
  //     textareaValues = "";
  // }
  // textareaValues         = HtmlEditFormat( textareaValues );
  // event.include("/js/radio_text/");
  event.include("/js/specific/radio-textarea/");
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
<!---       class       = "#textareaInputClass# form-control autosize-transition<cfif textMaxlength.len()> limited</cfif>" --->
      <!--- <cfif textMaxlength.len()> data-maxlength="#textMaxlength#"</cfif> --->
      tabindex    = "#getNextTabIndex()#"></textarea>
  </div>
</div>
</cfoutput>



