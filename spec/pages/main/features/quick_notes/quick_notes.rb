require_relative '../../../../sections/main/features/quick_notes/quick_notes'
require_relative '../../../../sections/main/activities/activity'

class QuickNote < Home
  
    section :note_list, Sections::Notes, '.quick-launcher-option .rbn-dropdown-menu.bottom'
    section :add_note, Sections::Notes, '.rbn-dropdown-menu.right'
    section :send_to, Sections::Notes, '.rbn-dropdown-menu.event-drop'
    section :share_note, Sections::NoteShare, '.modal-dialog'
    element :checkbox, '.modal-body .custom-form .modal-share-setup-list ul.list-unstyled li'
   

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
      add_note.send_users_list.each do |item|
        if item.text.include?(user[:full_name])
            item.click
        end
      end
    end
    def send_to_depto(depto) 
      add_note.send_department_list.each do |item|
        if item.text.include?(depto)
            item.click
        end
      end
    end
    def delete_notes
      wait_for_note_list
      note_list.note_icon_delete_list.each do |item|
        item.click
        wait_until_modal_confirmation_text_visible
        btn_modal_confirmation_ok.click
        wait_until_message_invisible
      end
    end
    def mark_as_read
      note_list.note_icon_mark_as_read_list.each do |item|
        item.click
        break
      end
    end
    def insert_notes(admin_user, quantity)
      puts "Fazendo login"
      user = { 'data' => {
        'username' => admin_user[:username],
        'password' => admin_user[:password],
        'stay_sign_in' => 0,
        'timezone' => 'America/Sao_Paulo'
      } }
      headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2'
      }
  
      @response = HTTParty.post(
        "http://api.#{$environment}-php56.dev.ringbyname.com/auth?",
        body: user.to_json,
        headers: headers
      )
      user_id = @response.parsed_response['data']['setup']['id']
      session_id = @response.parsed_response['data']['session_id']
      puts "setup id:  #{user_id}"

      headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2',
        'X-Session-Id' => session_id        
      }
      i = 1
      quantity.times do
        puts "dentro do times"
        body = {
         
            'content' => "Test Auto Note #{i}",
            'contact_id' => nil,
            'responsible' => {
              'type' => 'setup',
              'id' => user_id}
       
          
        }
        puts body        
        insert_note = HTTParty.post(
          "http://api.#{$environment}-php56.dev.ringbyname.com/note?",
          body: body,
          headers: headers
        )
        puts insert_note
      i +=1
      puts i
      end
  
    end
    def share_with(contact)
      share_note.share_user_list.each do |item|
        if item.text.include?(contact[:full_name])
          item.click
        end
      end
    end
end