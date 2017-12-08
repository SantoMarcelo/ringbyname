

class UserDetails < Siteprism::Section
    # user information
    element :txt_first_name, 'input[placeholder="First Name"]'
    element :txt_last_name, 'input[placeholder="Last Name"]'
    element :txt_email, 'input[placeholder="E-mail"]'
    element :txt_password, 'input[placeholder="Password"]'
    element :txt_password_repeart, 'input[placeholder="Repeat"]'
    # extensions
    element :txt_extension, 'input[placeholder="Extension"]'
    element :txt_direct_number, 'div[class="control ng-binding"]:nth-of-type(2)'
    element :select_outbound_caller_id, 'select[data-ng-options$="outboundCallers"]'
    # devices
    element :link_add_device, 'a[data-ng-click*=addSoftphone]'
    element :checkbox_device, '.device'
    element :link_add_cell_landline, 'a[data-ng-click*="addCellphone"]'
    # voice mail
    element :checkbox_voicemail, '#checkboxVoicemailEnabled'
    element :txt_voicemail_password, 'input[data-ng-model$="voicemail_pin"]'
    element :radio_auto_greeting, '#radioGreetingAuto'
    element :radio_text_greeting, '#radioGreetingText'
    element :txt_text_greeting, 'input[data-ng-model$="greeting.text_to_speech"]'
    element :radio_file_greeting, '#radioGreetingFile'
    element :select_file_greeting, 'select[data-ng-model$="greeting.file.id"]'
    element :link_upload_voicemail_file, 'div[data-file-upload$="uploadOptions"]'
    # callback
    element :checkbox_callback_request, '#checkboxCallbackRequest'
    element :checkbox_require_key_press, '#checkboxRequireKeypress'
    # time out options
    element :txt_number_rings, 'input[data-ng-model$="ring_times"]'
    # call recording
    element :checkbox_inbound_call_recording, '#checkboxInboundCallRecordingEnabled'
    element :checkbox_outbound_call_recording, '#checkboxOutboundCallRecordingEnabled'
    # call pickup
    element :checkbox_call_pickup, '#checkboxRemoteCallPickup'
    # admin permission
    element :checkbox_admin_permission, '#checkboxPermissions'
    # Save button
    element :btn_save_user, 'button[type="submit"]:nth-child(1)'
    # reset button
    element :btn_reset_user, 'button[data-ng-click*="resetUser"]'
  end