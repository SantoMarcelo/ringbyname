require_relative '../home'
module Sections

    class ContactCard < Contact
      element :txt_contact_name, '.contact-card > .row > div> h1'
      element :contact_crm_icon, 'div[class="ng-isolate-scope"] > ul > li[class^="crm-tab"]'
      elements :contact_opportunity_list, '.crm__history > table > tbody > tr'
      elements :opportunity_list_item, '.crm__history > table > tbody > tr .column-name'
      element :scroll, '.ps__scrollbar-y'
      element :edit_icon, '.rbn-icon-common-contact-card-edit'

    end 
    class ContactModal < ContactCard
      element :content, '.modal-body .bootbox-body'
      element :btn_ok, '.modal-footer .btn.btn-primary'
      element :btn_cancel, '.btn.btn-default'
      element :btn_close, '.modal-body .close'
    end
 
    class ContactForm < ContactCard
      element :txt_contact_company, 'input[data-ng-model="contact.company"]'
      element :txt_contact_first_name, 'input[data-ng-model="contact.name.first_name"]'
      element :txt_contact_last_name, 'input[data-ng-model="contact.name.last_name"]'
      #emails section
      element :icon_contact_add_email, '.rbn-mobicon-35-add[data-ng-click="addField(\'emails\')"]'
      elements :txt_contact_email, '.form-group input.form-control[data-ng-model^="contact.emails"]'
      elements :select_contact_email_label, 'select[data-ng-model^="contact.emails"]'
      elements :icon_remove_contact_email, '.form-group i[data-ng-click="removeField(email, \'emails\')"]'
      #phones section
      element :icon_contact_add_phone, '.form-group i[data-ng-click="addField(\'phones\')"]'
      elements :txt_contact_phones, '.form-group input.form-control[placeholder="Phone"]'
      elements :select_contact_phone_label, '.form-group select[data-ng-model^="contact.phones"]'
      elements :txt_contact_phone_extension, '.form-group input[data-ng-model$="extension"]'
      elements :icon_remove_contact_phone, '.form-group i[data-ng-click="removeField(phones, \'phones\')"]'
      #addresses section
      element :icon_contact_add_address, '.form-group i[data-ng-click="addField(\'addresses\')"]'
      elements :txt_contact_address, '.form-group input.form-control[data-ng-model^="contact.addresses"]'
      elements :select_contact_adddress_label, '.form-group select[data-ng-model^="contact.addresses"]'
      elements :icon_remove_contact_address, '.form-group i[data-ng-click="removeField(address, \'addresses\')"]'
      #weblinks
      element :icon_contact_add_weblink, '.form-group i[data-ng-click="addField(\'weblinks\')"]'
      elements :txt_contact_weblink, '.form-group input.form-control[data-ng-model^="contact.weblinks"]'
      elements :select_contact_weblink_label, '.form-group select[data-ng-model^="contact.weblinks"]'
      elements :icon_remove_contact_weblink, '.form-group i[data-ng-click="removeField(weblink, \'weblinks\')"]'
      
      element :btn_save, '.btn-group .btn-primary'
      element :btn_cancel, '.btn-group .btn-warning'
      element :btn_remove, '.btn-danger'
    end

    class ContactInfo < ContactCard
      element :contact_name, 'h1.f1'
      element :contact_picture, '.contact-info .contact-picture'
      elements :contact_info_list, '.contact-info ul>li'
    end

    class ContactGroups < ContactCard
      element :txt_name_group, '.input-group input'
      element :btn_add_group, '.input-group button'
      elements :contact_group_list, '.group-list-filter-filters li'
      elements :remove_contact_group, '.group-list-filter-filters .each-filter .glyphicon-remove'
    end

    class ContactFeature < ContactCard
      element :feature_title, '.tab-title'
      element :note_feature, '.rbn-icon-common-note-add'
      element :event_feature, '.rbn-icon-common-event-add'
      element :fax_feature, '.rbn-icon-common-fax-add'
      element :sms_feature, '.rbn-icon-common-sms-add'
      element :crm_feature, '.rbn-icon-common-crm-add'
    end

    class ContactFeatureList < ContactCard
      element :note_list, '.rbn-icon-common-contact-card-tab-notes'
      element :fax_list, '.rbn-icon-common-contact-card-tab-fax'
      element :call_history_list, '.rbn-icon-common-contact-card-tab-history'
      element :sms_list, '.icon-fontello-sms'
      element :crm_list, '.icon-fontello-crm'
    end


    class ContactOpportunityForm < SitePrism::Section
      element :txt_oppo_name, 'input[data-ng-model="crmContactCard.opportunity.name"]'
      element :select_oppo_source, 'select[data-ng-model="crmContactCard.opportunity.source.id"]'
      element :select_oppo_status, 'select[data-ng-model="crmContactCard.opportunity.status.id"]'
      element :select_oppo_prob, 'select[data-ng-model="crmContactCard.opportunity.probability.id"]'
      element :txt_oppo_product, 'input[data-ng-model="crmContactCard.opportunity.product"]'
      element :txt_oppo_price, 'input[data-ng-model="crmContactCard.opportunity.cost"]'
      element :select_oppo_next_action, 'select[data-ng-model="crmContactCard.opportunity.action.id"]'
      element :date_oppo_follow_up, '.input.opportunity_date_follow_up' 
      element :date_close_date, '.input.opportunity_date_close'
      element :txt_oppo_comment, 'textarea[data-ng-model="crmContactCard.opportunity.comments"]'
      element :link_upload_attach, '.fileinput-button > .icon-fontello-upload'
      element :btn_oppo_save, 'button[data-ng-click="crmContactCard.submit()"]'
      element :btn_oppo_cancel, 'button[data-ng-click="smsCompose.cancelForm()"]'
    end

    class EditContactOpportunityForm < SitePrism::Section
      element :btn_edit_oppo, '.opportunity-edit-button'
      element :btn_print_oppo, '.opportunity-print-button'
      element :txt_oppo_name, 'input[data-ng-model="crmEdit.record.name"]'
      element :select_oppo_source, 'select[data-ng-model="crmEdit.record.source.id"]'
      element :select_oppo_status, 'select[data-ng-model="crmEdit.record.status.id"]'
      element :select_oppo_prob, 'select[data-ng-model="crmEdit.record.probability.id"]'
      element :txt_oppo_product, 'input[data-ng-model="crmEdit.record.product"]'
      element :txt_oppo_price, 'input[data-ng-model="crmEdit.record.cost"]'
      element :select_oppo_next_action, 'select[data-ng-model="crmEdit.record.action.id"]'
      element :date_oppo_follow_up, 'div > input.opportunity_date_follow_up'
      element :date_close_date, 'div > input.opportunity_date_close'
      element :txt_oppo_comment, 'textarea[data-ng-model="crmEdit.record.comments"]'
      element :link_upload_attach, '.fileinput-button > input[data-fileupload-model="attachment.selected"]:nth-child(2)'
      element :last_updated_info, '.last-edited'
      element :btn_oppo_save, 'button[data-ng-click="crmEdit.submit()"]'
      element :btn_oppo_cancel, 'button[data-ng-click="crmEdit.cancel()"]'
    end

    class OpportunityDetails <SitePrism::Section
        element :title, '.crm-card-container__header h2'
        element :opportunity_name, '.item.opportunity-name .oppt-value'
        element :opportunity_status, '.item.opportunity-status .oppt-value'
        element :opportunity_close_date, '.item.opportunity-close-date .oppt-value'
        element :opportunity_source, '.item.opportunity-source .oppt-value'
        element :opportunity_probality, '.item.opportunity-probability .oppt-value'
        element :opportunity_product, '.item.opportunity-product-service .oppt-value'
        element :opportunity_price, '.item.opportunity-price-cost .oppt-value'
        element :opportunity_action, '.item.opportunity-action .oppt-value'
        element :opportunity_followup_date, '.item.opportunity-follow-up-date .oppt-value'
        element :opportunity_comments, '.item.opportunity-comments .oppt-value'
        element :opportunity_last_edit, '.crm-card-container__opportunity--edited'
        
    end

end