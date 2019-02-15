
module Sections
class UserDetails < SitePrism::Section
    # user information
    element :txt_first_name, 'input[placeholder="First Name"]'
    element :txt_last_name, 'input[placeholder="Last Name"]'
    element :txt_email, 'input[placeholder="E-mail"]'
    elements :txt_password, '.control input[placeholder="Password"]'
    element :txt_password_repeart, 'input[placeholder="Repeat"]'
    # extensions
    element :txt_extension, 'input[placeholder="Extension"]'
    element :txt_direct_number, 'div[class="control ng-binding"]:nth-of-type(2)'
    element :select_outbound_caller_id, 'select[data-ng-options$="outboundCallers"]'
    element :txt_caller_custom_number, 'input[data-ng-model*="caller_id.external.number"]'
    element :txt_caller_custom_name, 'input[data-ng-model*="caller_id.external.name"]'
    # devices
    element :link_add_device, 'a[data-ng-click*=addSoftphone]'
    elements :checkboxes_device, '.device'
    elements :link_devices_name, '.control > span > a[data-ng-click*="getDeviceSettings"]'
    elements :icon_delete_device, '.control > span > i.icon-fontello-trash-empty'
    # devices#landline
    element :link_add_cell_landline, 'a[data-ng-click*="addCellphone"]'
    elements :link_landline_items, '.control > span > a[data-ng-click*="editCellphone"]'
    # voice mail
    element :checkbox_voicemail, '.checkbox input[data-ng-model*="extras.is_voicemail_enabled"]'
    element :txt_voicemail_password, 'input[data-ng-model$="voicemail_pin"]'
    #greeting
    elements :checkboxes, '.checkbox'
    elements :radios, '.radio.radio-complete label'
    element :radio_auto_greeting, '.radio #radioGreetingAuto'
    element :radio_text_greeting, '#radioGreetingText'
    element :txt_text_greeting, 'input[data-ng-model$="greeting.text_to_speech"]'
    element :select_language, 'select[data-ng-model*="greeting.voice"]'
    element :radio_file_greeting, '#radioGreetingFile'
    element :select_file_greeting, 'select[data-ng-model$="greeting.file.id"]'
    element :link_upload_voicemail_file, '.fileinput-button input'
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
    #CRM feature options
    element :checkbox_crm, 'div.checkbox > input[data-ng-model="SetupUserDetailsController.record.crm.is_enabled"]'

    elements :icon_tooltips, 'i.icon-tooltip'
    #reset user
    element :btn_reset_user, '.control button[data-ng-click*="resetUser"]'


  end  
  class Messages < SitePrism::Section

    element :modal, '#modalContentId'
    element :btn_ok, '.swal2-confirm'
    # devices#modal
    element :modal_title, '.modal-dialog  .modal-content .modal-title'
    element :modal_message, '.modal-dialog  .modal-content div.modal-body'
    element :modal_button, '.modal-dialog  .modal-content .modal-footer button'
    element :modal_btn_save, '.modal-dialog  .modal-content .modal-footer button.button-save'
    element :modal_btn_cancel, '.modal-dialog  .modal-content .modal-footer button.button-cancel'
  end
  class ModalDevicesConfig <SitePrism::Section
    element :modal_title, '.modal .modal-content .modal-title'
    element :modal_body, '.modal .modal-content .modal-body'
    element :close, '.modal .modal-content .modal-header .modal-close'
  end
  class ModalLandLine < SitePrism::Section
    element :modal_title, '.modal-title'
    element :txt_landline_name, '.modal-body .row .form-group > div >  input[data-ng-model="device.name"]'
    element :txt_landline_number, '.modal-body .row .form-group > div >  input[data-ng-model="device.number"]'
    elements :tooltips, '.modal i.icon-tooltip'
    element :btn_cancel, '.modal .modal-content .modal-footer button.button-cancel'
    element :btn_save, '.modal .modal-content .modal-footer button.button-save'
  end
  class MassiveCallerId < SitePrism::Section
    element :title, '.details-title'
    elements :users_list, '.form .column .checkbox'
    elements :radios_options, '.control .radio'
    element :select_cId_number, '.control .select'
    element :txt_cId_custom_name, '.control input[data-ng-model*="custom.name"]'
    element :txt_cId_custom_number, '.control input[data-ng-model*="custom.number"]'
    element :btn_save, '.control button'
  end
  class MassivePassword < SitePrism::Section
    element :title, '.details-title'
    elements :users_list, '.form .column .checkbox'
    element :txt_massive_pass, '.control .input'
    element :btn_save, '.control button'
  end
end