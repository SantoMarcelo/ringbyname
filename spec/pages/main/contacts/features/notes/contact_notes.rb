
require_relative '../../../../../sections/main/contacts/contact_card'
require_relative '../../../../../sections/main/contacts/features/notes/contact_notes'
require_relative '../../../../../helpers'
require_relative '../../../../../pages/main/activities/activity'

class ContactNotes < Contact
  section :feature_notes, Sections::NotesFeture, '#contact-card-tab-note'  
  section :note_list, Sections::NoteList, 'div.tab-content:nth-child(2)'
  section :note_share, Sections::NoteSharePop, '.modal-dialog'

  element :modal_confirmation_text, '.modal-dialog .modal-body div.bootbox-body'
  element :btn_modal_confirmation_ok, '.modal-dialog .modal-footer .btn-primary'
  element :btn_modal_confirmation_cancel, '.modal-dialog .modal-footer .btn-default'


  def validate_data_on_screen(list, data)
    list.each do |item|
      if item.text.include?(data)
        return true
      end
    end
    return false
  end
  def send_to_user(user) 
    feature_notes.send_users_list.each do |item|
      if item.text.include?(user[:full_name])
          item.click
      end
    end
  end
  def send_to_depto(depto) 
    feature_notes.send_department_list.each do |item|
      if item.text.include?(depto)
          item.click
      end
    end
  end
  def delete_notes
    note_list.note_icon_delete_list.each do |item|
      item.click
      wait_until_modal_confirmation_text_visible
      btn_modal_confirmation_ok.click
      wait_until_modal_confirmation_text_invisible
      wait_until_message_visible
      wait_until_message_invisible
    end
  end
  def mark_as_read
    note_list.note_icon_mark_as_read_list.each do |item|
      item.click
      break
    end
  end
  def share_with(contact)
    note_share.share_user_list.each do |item|
      if item.text.include?(contact[:full_name])
        item.click
      end
    end
  end


end 
