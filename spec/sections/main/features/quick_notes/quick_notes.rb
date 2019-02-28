module Sections 
    
  class Notes < SitePrism::Section
    element :title, 'p.f1.red2'
    element :close, '.rbn-dropdown-close'
    element :add_note, '.rbn-icon-common-note-add'
    element :txt_note_text, 'textarea'
    element :btn_send_to, '.rbn-dropdown .btn-trigger'
    elements :send_department_list, '.rbn-dropdown-content ul.list-unstyled li[data-ng-repeat^="department"]'
    elements :send_users_list, '.rbn-dropdown-content ul.list-unstyled li[data-ng-repeat^="setup"]'
    element :btn_save, '.btn.btn-primary'
    element :btn_cancel, '.btn.btn-warning'
    elements :note_sent_to, '.list-unstyled.custom-top-list li div[data-ng-if="note.responsible.name"]'
    elements :note_shared_with, '.list-unstyled.custom-top-list li .custom-list-shared'
    elements :note_posted_by, '.list-unstyled.custom-top-list li .custom-list-posted'
    elements :note_text_list, '.list-unstyled.custom-top-list li > p'
    elements :note_icon_mark_as_read_list, 'i.rbn-icon-common-read'
    elements :note_icon_delete_list, 'i.rbn-icon-common-trash'
    elements :note_icon_share_list, 'i.rbn-icon-common-share'
    element :note_empty_list, '.list-unstyled.custom-top-list li'
  end

  class NoteShare < SitePrism::Section
    element :title, '.modal-header .modal-title'
    element :share_close_modal, '.modal-header button'
    elements :share_user_list, '.modal-body .modal-share-setup-list ul.list-unstyled li'
    element :share_email, '.modal-body .custom-form textarea'
    element :shared_emails, '.custom-form div[data-ng-if*="emails_sharing"]'
    element :btn_save_share, '.modal-footer .btn-primary'
    element :btn_cancel_share, '.modal-footer .btn-warning'
  end

  


end