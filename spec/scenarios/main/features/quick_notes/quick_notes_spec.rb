require_relative '../../../../pages/login/login'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/main/contacts/contact'
require_relative '../../../../pages/main/features/quick_notes/quick_notes'
require_relative '../../../../sections/main/activities/activity'
require_relative '../../../../pages/main/activities/activity'
require_relative '../../../../pages/main/contacts/features/notes/contact_notes'
require_relative '../../../../sections/main/contacts/features/notes/contact_notes'

#miniapp_crm_geral :quick_notes_general
describe('Quick Notes', :master1  ) do
  before do
    Capybara.page.driver.browser.manage.window.maximize
    login_page.load
    login_page.do_login(get_admin())
    home.wait_until_home_features_visible
    home.wait_until_user_status_visible
    @contacts = get_contacts()
    @note = {
      text: 'Test Automatic Note' 
    }
  end
  describe('add notes', :add_notes) do
    it('add note and check in the note list', :add_note_and_check_list) do |e|
      e.step('when I access quick notes on home page') do
          puts '    when I access quick notes on home page'
          notes.home_features.notes.click
          expect(notes.note_list.title.text).to eql 'Notes'
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          notes.note_list.add_note.click
          notes.wait_for_add_note
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          notes.add_note.txt_note_text.set(@note[:text])
          notes.note_list.btn_save.click
          expect(notes.message.text).to eql 'Note Inserted'
          notes.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
          #expect(notes.check_note_in_list(@note2)).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
          notes.home_features.notes.click
      end
      e.step('and I have to see the insert note activity') do
          puts '  and I have to see the insert note activity'
          expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_insert')
      end
    end
    it('add note and check it in the contact card', :add_note_and_check_contact_card) do |e|
      puts '  add note and check it in the contact card'
      e.step('when I access quick notes on home page') do
        puts '    when I access quick notes on home page'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          notes.note_list.add_note.click
          notes.wait_for_add_note
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          notes.add_note.txt_note_text.set(@note[:text])
          notes.note_list.btn_save.click
          expect(notes.message.text).to eql 'Note Inserted'
          notes.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end
      e.step('and I have to see the insert note activity') do
          puts '  and I have to see the insert note activity'
          expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_insert')
      end
      e.step('and I check in contact card if it was inserted correctly') do
        puts '  and I check in contact card if it was inserted correctly'
        notes.select_contact(@contacts[0])
        contact.contact_feature_list.note_list.click
        expect(note_contact.note_list.title.text).to eql 'Notes'
        expect(page).to have_content(@note[:text])
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end

    end
    it('add note and send it to other user', :add_note_and_send_to_user) do |e|
      puts '  add note and send it to other user'
      e.step('when I access quick notes on home page') do
        puts '    when I access quick notes on home page'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
      end
      e.step('and I select to add a new note') do
        puts '  and I select to add a new note'
        notes.note_list.add_note.click
        notes.wait_for_add_note
      end
      e.step('and I set the note text and click on save button') do
        puts '  and I set the note text and click on save button'
        notes.add_note.txt_note_text.set(@note[:text])
        notes.add_note.btn_send_to.click
        notes.add_note.wait_for_send_users_list
        notes.send_to_user(get_user(1))
        notes.note_list.btn_save.click
        expect(notes.message.text).to eql 'Note Inserted'
        notes.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
        puts '  then I have to see the note inserted'
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[1][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
      end
      e.step('and I have to see the insert note activity') do
        puts '  and I have to see the insert note activity'
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_insert')
      end
      e.step('when I loggin with user that note was shared') do
        puts '  when I loggin with user that note was shared'
        notes.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared' 
        notes.home_features.notes.click
        notes.wait_for_note_list
        notes.note_list.wait_for_note_posted_by
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[1][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
        notes.home_features.notes.click
      end
    end
    it('add note and send it to department', :add_note_and_send_to_department) do |e|
      puts '  add note and send it to department'
      e.step('when I access quick notes on home page') do
        puts '    when I access quick notes on home page'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
      end
      e.step('and I select to add a new note') do
        puts '  and I select to add a new note'
        notes.note_list.add_note.click
        notes.wait_for_add_note
      end
      e.step('and I set the note text and click on save button') do
        puts '  and I set the note text and click on save button'
        notes.add_note.txt_note_text.set(@note[:text])
        notes.add_note.btn_send_to.click
        notes.add_note.wait_for_send_users_list
        notes.send_to_depto('Sales')
        notes.note_list.btn_save.click
        expect(notes.message.text).to eql 'Note Inserted'
        notes.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
        puts '  then I have to see the note inserted'
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, "Sales")).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end
      e.step('and I have to see the insert note activity') do
        puts '  and I have to see the insert note activity'
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_insert')
      end
      e.step('when I loggin with department\'s user that note was shared') do
        puts '  when I loggin with department\'s user that note was shared'
        notes.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared' 
        notes.home_features.notes.click
        notes.wait_for_note_list
        notes.note_list.wait_for_note_posted_by
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, "Sales")).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
      end
      e.step('when I loggin with other department\'s user that note was shared') do
        puts '  when I loggin with other department\'s user that note was shared'
        notes.logout
        login_page.do_login(get_user(2))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared' 
        notes.home_features.notes.click
        notes.wait_for_note_list
        notes.note_list.wait_for_note_posted_by
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, "Sales")).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[2][:full_name])).to eql true
      end
      e.step('when I loggin with other department\'s user that note was shared') do
        puts '  when I loggin with other department\'s user that note was shared'
        notes.logout
        login_page.do_login(get_user(3))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared' 
        notes.home_features.notes.click
        notes.wait_for_note_list
        notes.note_list.wait_for_note_posted_by
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, "Sales")).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[3][:full_name])).to eql true
        notes.home_features.notes.click
      end
    end
    after(:each) do
      notes.home_features.notes.click
      if notes.note_list.note_icon_delete_list.length > 0
        notes.delete_notes
      else
        notes.logout
        login_page.do_login(get_admin())
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
        notes.home_features.notes.click
        notes.wait_for_note_list
        expect(notes.note_list.title.text).to eql 'Notes'
        notes.delete_notes
      end
      notes.logout
    end
  end
  describe('mark note as read', :mark_as_read) do
    before(:all) do
      @note = {
        text: 'Test Automatic Note' 
      }
      @note2 = {
        text: 'Test Automatic Note 2' 
      }
    end
    it('add note share with other user and mark as read it', :mark_as_read_click) do |e|
      puts '  add note share with other user and mark as read it'
      e.step('when I access quick notes on home page') do
        puts '  when I access quick notes on home page'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
      end
      e.step('and I select to add a new note') do
        puts '  and I select to add a new note'
        notes.note_list.add_note.click
        notes.wait_for_add_note
      end
      e.step('and I set the note text and click on save button') do
        puts '  and I set the note text and click on save button'
        notes.add_note.txt_note_text.set(@note[:text])
        notes.add_note.btn_send_to.click
        notes.add_note.wait_for_send_users_list
        notes.send_to_user(get_user(1))
        notes.note_list.btn_save.click
        notes.wait_until_message_visible
        expect(notes.message.text).to eql 'Note Inserted'
        notes.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
        puts '  then I have to see the note inserted'
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[1][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
      end
      e.step('and I have to see the insert note activity') do
        puts '  and I have to see the insert note activity'
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_insert')
      end
      e.step('when I loggin with user that note was shared') do
        puts '  when I loggin with user that note was shared'
        notes.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared' 
        notes.home_features.notes.click
        notes.wait_for_note_list
        notes.note_list.wait_for_note_posted_by
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[1][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="1"]')
      end
      e.step('when I mark as read this note') do
        puts '  when I mark as read this note'
        notes.mark_as_read
      end
      e.step('then I have to see the note marked as read') do
        puts '  then I have to see the note marked as read'
        notes.wait_until_message_visible
        expect(notes.message.text).to eql 'Note marked as read'
        notes.wait_until_message_invisible
        expect(notes.note_list).to have_css('i.rbn-icon-common-was-read')
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="0"]')
      end
    end
    it('add note and check notes counter', :mark_as_read_counter) do |e|
      puts '  check notes counter'
      
      e.step('when I access quick notes on home page') do
        puts '  when I access quick notes on home page'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
        sleep 5
      end
      e.step('and I add and share notes') do
        puts '  and I add and share notes'
        notes.note_list.add_note.click
        notes.wait_for_add_note
        notes.add_note.txt_note_text.set(@note[:text])
        notes.add_note.btn_send_to.click
        notes.add_note.wait_for_send_users_list
        notes.send_to_user(get_user(1))
        notes.note_list.btn_save.click
        expect(notes.message.text).to eql 'Note Inserted'
        notes.wait_until_message_invisible
        notes.note_list.add_note.click
        notes.wait_for_add_note
        notes.add_note.txt_note_text.set(@note2[:text])
        notes.add_note.btn_send_to.click
        notes.add_note.wait_for_send_users_list
        notes.send_to_user(get_user(1))
        notes.note_list.btn_save.click
        expect(notes.message.text).to eql 'Note Inserted'
        notes.wait_until_message_invisible
      end
      e.step('then I have to see the notes inserted') do
        puts '  then I have to see the notes inserted'
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note2[:text])).to eql true
      end
      e.step('when I loggin with user that note was shared') do
        puts '  when I loggin with user that note was shared'
        notes.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the notes that were shared') do
        puts '  then I have to see the notes that were shared' 
        notes.home_features.notes.click
        notes.wait_for_note_list
        notes.note_list.wait_for_note_posted_by
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="2"]')
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note2[:text])).to eql true
      end
      e.step('when I mark one note as read this note') do
        puts '  when I mark one note as read this note'
        notes.mark_as_read
      end
      e.step('then I have to see the note marked as read and decrement one in counter') do
        puts '  then I have to see the note marked as read and decrement one in counter'
        notes.wait_until_message_visible
        expect(notes.message.text).to eql 'Note marked as read'
        notes.wait_until_message_invisible
        expect(notes.note_list).to have_css('i.rbn-icon-common-was-read')
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="1"]')
      end
      e.step('when I mark other note as read this note') do
        puts '  when I mark other note as read this note'
        notes.mark_as_read
      end
      e.step('then I have to see the note marked as read and decrement one in counter') do
        puts '  then I have to see the note marked as read and decrement one in counter'
        notes.wait_until_message_visible
        expect(notes.message.text).to eql 'Note marked as read'
        notes.wait_until_message_invisible
        expect(notes.note_list).to have_css('i.rbn-icon-common-was-read')
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="0"]')
      end
    end
    after(:each) do
      if notes.note_list.note_icon_delete_list.length > 0
        notes.delete_notes
      else
        notes.logout
        login_page.do_login(get_admin())
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
        notes.home_features.notes.click
        notes.note_list.wait_for_note_text_list
        expect(notes.note_list.title.text).to eql 'Notes'
        notes.delete_notes
      end
      notes.logout
    end
  end
  describe('share notes', :share_notes) do
    it('add note and share with other coworkers',:share_notes_with_coworker ) do |e|
      puts 'add note and share with other coworkers'
      e.step('when I access quick notes on home page') do
        puts '    when I access quick notes on home page'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          notes.note_list.add_note.click
          notes.wait_for_add_note
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          notes.add_note.txt_note_text.set(@note[:text])
          notes.note_list.btn_save.click
          expect(notes.message.text).to eql 'Note Inserted'
          notes.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end
      e.step('when I share with coworkers') do
        puts '  when I share with coworkers'
        notes.note_list.note_icon_share_list[0].click
        notes.wait_for_share_note
        expect(notes.share_note.title.text).to eql 'Share'
        notes.share_with(@contacts[1])
        notes.share_note.btn_save_share.click
      end
      e.step('then I have to see that not was shared') do
        puts '  then I have to see that not was shared'
        expect(notes.message.text).to eql 'Document shared successfully.'
        notes.wait_until_message_invisible
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
      end
      e.step('when I loggin with coworker that note was shared') do
        puts '  when I loggin with coworker that note was shared'
        notes.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared' 
        notes.home_features.notes.click
        notes.wait_for_note_list
        notes.note_list.wait_for_note_posted_by
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="1"]')
      end
    end
    it('add note and share through email', :share_notes_through_email) do |e|
      puts '  add note and share through email'
      e.step('when I access quick notes on home page') do
        puts '    when I access quick notes on home page'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          notes.note_list.add_note.click
          notes.wait_for_add_note
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          notes.add_note.txt_note_text.set(@note[:text])
          notes.note_list.btn_save.click
          expect(notes.message.text).to eql 'Note Inserted'
          notes.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end
      e.step('when I select to share this note') do 
        puts '  when I select to share this note'
        notes.note_list.note_icon_share_list[0].click
        notes.wait_for_share_note
        expect(notes.share_note.title.text).to eql 'Share'
        notes.share_note.share_email.set('test@automatic.com')
        notes.share_note.btn_save_share.click
      end
      e.step('then I have to see that note was shared') do 
        puts '  then I have to see that note was shared'
        expect(notes.message.text).to eql 'Document shared successfully.'
        notes.wait_until_message_invisible
        notes.note_list.note_icon_share_list[0].click
        expect(notes.share_note.title.text).to eql 'Share'
        expect(notes.share_note.shared_emails).to have_content('test@automatic.com')
        notes.share_note.btn_cancel_share.click
      end
      e.step('when I share note with more than one emails') do
        puts '  when I share note with more than one emails'
        notes.note_list.note_icon_share_list[0].click
        notes.wait_for_share_note
        expect(notes.share_note.title.text).to eql 'Share'
        notes.share_note.share_email.set('test-2@automatic.com')
        notes.share_note.btn_save_share.click
        notes.wait_until_message_invisible
        notes.note_list.note_icon_share_list[0].click
        notes.wait_for_share_note
        expect(notes.share_note.title.text).to eql 'Share'
        notes.share_note.share_email.set('test-3@automatic.com')
        notes.share_note.btn_save_share.click
        notes.wait_until_message_visible
      end
      e.step('then I have to see that note was shared') do 
        puts '  then I have to see that note was shared'
        notes.wait_until_message_invisible
        notes.note_list.note_icon_share_list[0].click
        expect(notes.share_note.title.text).to eql 'Share'
        expect(notes.share_note.shared_emails).to have_content('test@automatic.com')
        expect(notes.share_note.shared_emails).to have_content('test-2@automatic.com')
        expect(notes.share_note.shared_emails).to have_content('test-3@automatic.com')
        notes.share_note.btn_cancel_share.click
      end
    end
    after(:each) do
      if notes.note_list.note_icon_delete_list.length > 0
        notes.delete_notes
      else
        notes.logout
        login_page.do_login(get_admin())
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
        notes.home_features.notes.click
        notes.note_list.wait_for_note_text_list
        expect(notes.note_list.title.text).to eql 'Notes'
        notes.delete_notes
      end
      notes.logout
    end
  end
  describe('delete notes', :delete_notes) do
    before() do

      #notes.insert_notes(get_admin(), 1)
    end
    it('delete note that is not shared', :delete_note_not_shared) do |e|
      puts '  delete note that is not shared'
      e.step('when I access quick notes on home page') do
        puts '    when I access quick notes on home page'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          notes.note_list.add_note.click
          notes.wait_for_add_note
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          notes.add_note.txt_note_text.set(@note[:text])
          notes.note_list.btn_save.click
          expect(notes.message.text).to eql 'Note Inserted'
          notes.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end  
      e.step('when I delete the inserted note') do
        puts '  when I delete the inserted note'
        notes.delete_notes
        notes.wait_until_message_visible
        expect(notes.message.text).to eql 'Note deleted'
        notes.wait_until_message_invisible
      end
      e.step('then I have to see that note was deleted') do
        puts '  then I have to see that note was deleted'
        expect(notes.note_list.note_empty_list.text).to eql 'No records'
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_delete')
      end
    end
    it('delete note that was shared', :delete_shared_note) do |e|
      e.step('when I access quick notes on home page') do
        puts '    when I access quick notes on home page'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          notes.note_list.add_note.click
          notes.wait_for_add_note
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          notes.add_note.txt_note_text.set(@note[:text])
          notes.note_list.btn_save.click
          expect(notes.message.text).to eql 'Note Inserted'
          notes.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end
      e.step('when I share with coworkers') do
        puts '  when I share with coworkers'
        notes.note_list.note_icon_share_list[0].click
        notes.wait_for_share_note
        expect(notes.share_note.title.text).to eql 'Share'
        notes.share_with(@contacts[1])
        notes.share_note.btn_save_share.click
      end
      e.step('then I have to see that not was shared') do
        puts '  then I have to see that not was shared'
        expect(notes.message.text).to eql 'Document shared successfully.'
        notes.wait_until_message_invisible
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
      end
      e.step('when I loggin with coworker that note was shared') do
        puts '  when I loggin with coworker that note was shared'
        notes.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared' 
        notes.home_features.notes.click
        notes.wait_for_note_list
        notes.note_list.wait_for_note_posted_by
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="1"]')
      end
      e.step('when I delete this note') do
        puts '  when I delete this note'
        notes.logout
        login_page.do_login(get_admin())
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
        notes.home_features.notes.click
        expect(page).to have_content('Notes')
        notes.delete_notes
        notes.wait_until_message_visible
        expect(notes.message.text).to eql 'Note deleted'
        notes.wait_until_message_invisible
      end
      e.step('then I have to not see this notes anymore') do
        puts '  then I have to not see this notes anymore'
      expect(notes.note_list.note_empty_list.text).to eql 'No records'
      expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_delete')
      end
      e.step('when I loggin with coworker that note was shared') do
        puts '  when I loggin with coworker that note was shared'
        notes.logout
        login_page.do_login(get_user(3))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have not to see this note anymore') do
        puts '  then I have not to see this note anymore'
        notes.home_features.notes.click
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="0"]')
        expect(notes.note_list.note_empty_list.text).to eql 'No records'
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_delete')
      end
    end 
  end
  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end
end