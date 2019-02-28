module Sections

  class NotesFeture < SitePrism::Section
    element :title, 'div.f1'
    element :txt_note_text, 'textarea'
    element :note_send_to, '.custom-dropdown-grouped'
    elements :send_department_list, 'li[data-ng-repeat^="department"]'
    elements :send_users_list, 'li[data-ng-repeat^="setup"]'
    element :btn_save, '.btn-primary'
    element :btn_cancel, '.btn-warning'

  end

  class NoteList < NotesFeture
    element :title, '.tab-title'
    elements :note_text_list, '.custom-list-item p.f1'
    elements :note_sent_to, '.custom-list-item div[data-ng-if="note.responsible.name"]'
    elements :note_posted_by, '.custom-list-item .custom-list-posted'
    elements :note_shared_with, '.custom-list-item .custom-list-shared'
    elements :note_icon_mark_as_read_list, 'i.rbn-icon-common-read'
    elements :note_icon_delete_list, 'i.rbn-icon-common-trash'
    elements :note_icon_share_list, 'i.rbn-icon-common-share'
    element :note_empty_list, 'div.grey.custom-list'
  end

  class NoteSharePop < NotesFeture
    element :title, '.modal-header .modal-title'
    element :share_close_modal, '.modal-header button'
    elements :share_user_list, '.modal-body .modal-share-setup-list ul.list-unstyled li'
    element :share_email, '.modal-body .custom-form textarea'
    element :shared_emails, '.custom-form div[data-ng-if*="emails_sharing"]'
    element :btn_save_share, '.modal-footer .btn-primary'
    element :btn_cancel_share, '.modal-footer .btn-warning'
  end

end 