require_relative '../../../../pages/login/login'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/main/features/crm/crm_mini_app'
require_relative '../../../../pages/login/reset_password'
require_relative '../../../../pages/main/contacts/contact'
require_relative '../../../../pages/admin/dashboard/dashboard'
#opportunity_general
#cc_general_opportunity:quick_notes_general 
describe('Contact Card - Notes', :master) do
  before do
    Capybara.page.driver.browser.manage.window.maximize
    
    login_page.load
    login_page.do_login(get_admin())
    home.wait_until_home_features_visible
    home.wait_until_user_status_visible
    @contacts = get_contacts()
    @admin_user = get_admin()
    @note = {
      text: 'Test Automatic Note' 
    }
    notes.home_features.notes.click
    expect(notes.note_list.title.text).to eql 'Notes'
    notes.delete_notes
    notes.wait_until_message_invisible
    puts "passei before"
  end
  describe('add notes thought contact card', :cc_add_notes) do
    it('add note and check in the note list', :cc_add_note_and_check_list) do |e|
      e.step('when I access contact card on home page') do
          puts '  when I access contact card on home page'
          home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          contact.contact_feature_list.note_list.click
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          note_contact.feature_notes.txt_note_text.set(@note[:text])
          note_contact.feature_notes.btn_save.click
          
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          note_contact.wait_until_message_visible
          expect(note_contact.message.text).to eql 'Note Inserted'
          e.attach_file('screenshot', get_screenshot)
          note_contact.wait_until_message_invisible
          contact.contact_feature_list.note_list.click
          expect(note_contact.note_list.title.text).to eql 'Notes'
          #Expect Note text#
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
          #expect Note Send To#
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          #expect Note Posted By#
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
          #expect Note Shared with#
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
          e.attach_file('screenshot', get_screenshot)
      end
      e.step('and I have to see the insert note activity') do
          puts '  and I have to see the insert note activity'
          expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_insert')
          e.attach_file('screenshot', get_screenshot)
      end
    end
    it('add note and check it in the quick notes', :cc_add_note_and_check_quick_notes) do |e|
      puts '  add note and check it in the quick notes'
      e.step('when I access contact card on home page') do
        puts '  when I access contact card on home page'
        home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
        puts '  and I select to add a new note'
        contact.contact_feature_list.note_list.click
      end
      e.step('and I set the note text and click on save button') do
        puts '  and I set the note text and click on save button'
        note_contact.feature_notes.txt_note_text.set(@note[:text])
        note_contact.feature_notes.btn_save.click
      end
      e.step('then I have to see the note inserted') do
        puts '  then I have to see the note inserted'
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Note Inserted'
        e.attach_file('screenshot', get_screenshot)
        note_contact.wait_until_message_invisible
        contact.contact_feature_list.note_list.click
        expect(note_contact.note_list.title.text).to eql 'Notes'
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_insert')
        e.attach_file('screenshot', get_screenshot)
      end
      e.step('and I check in quick notes if it was inserted correctly') do
        puts '  and I check in quick notes if it was inserted correctly'
        notes.home_features.notes.click
        expect(notes.note_list.title.text).to eql 'Notes'
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
        e.attach_file('screenshot', get_screenshot)
        notes.home_features.notes.click
      end
    end
    it('add note and send it to other user', :cc_add_note_and_send_to_user) do |e|
      puts '  add note and send it to other user'
      e.step('when I access contact card on home page') do
        puts '  when I access contact card on home page'
        home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          contact.contact_feature_list.note_list.click
      end
      e.step('and I set the note text and click on save button') do
        puts '  and I set the note text and click on save button'
        note_contact.feature_notes.txt_note_text.set(@note[:text])
        note_contact.feature_notes.note_send_to.click
        note_contact.feature_notes.wait_for_send_department_list
        note_contact.send_to_user(get_user(1))
        note_contact.feature_notes.btn_save.click
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Note Inserted'
        e.attach_file('screenshot', get_screenshot)
        note_contact.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
        puts '  then I have to see the note inserted'
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[1][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
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
        e.attach_file('screenshot', get_screenshot)
        notes.home_features.notes.click
      end
    end
    it('add note and send it to department', :cc_add_note_and_send_to_department) do |e|
      puts '  add note and send it to department'
      e.step('when I access contact card on home page') do
        puts '  when I access contact card on home page'
        home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
        puts '  and I select to add a new note'
        contact.contact_feature_list.note_list.click
      end
      e.step('and I set the note text and click on save button') do
        puts '  and I set the note text and click on save button'
        note_contact.feature_notes.txt_note_text.set(@note[:text])
        note_contact.feature_notes.note_send_to.click
        note_contact.feature_notes.wait_for_send_department_list
        note_contact.send_to_depto('Sales')
        note_contact.feature_notes.btn_save.click
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Note Inserted'
        e.attach_file('screenshot', get_screenshot)
        note_contact.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
        puts '  then I have to see the note inserted'
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, "Sales")).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_insert')
        e.attach_file('screenshot', get_screenshot)
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
        e.attach_file('screenshot', get_screenshot)
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
        e.attach_file('screenshot', get_screenshot)
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
        e.attach_file('screenshot', get_screenshot)
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
        sleep 2
        notes.wait_for_note_list
        expect(notes.note_list.title.text).to eql 'Notes'
        notes.delete_notes
      end
      notes.logout
    end
  end
  describe('mark note as read thought contact card', :cc_mark_as_read) do
    before(:all) do
      @note = {
        text: 'Test Automatic Note' 
      }
      @note2 = {
        text: 'Test Automatic Note 2' 
      }
    end
    it('add note share with other user and mark as read it', :cc_mark_as_read_click) do |e|
      puts '  add note share with other user and mark as read it'
      e.step('when I access contact card on home page') do
        puts '    when I access contact card on home page'
        home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          contact.contact_feature_list.note_list.click
      end
      e.step('and I set the note text and click on save button') do
        puts '  and I set the note text and click on save button'
        note_contact.feature_notes.txt_note_text.set(@note[:text])
        note_contact.feature_notes.note_send_to.click
        note_contact.feature_notes.wait_for_send_department_list
        note_contact.send_to_user(get_user(1))
        note_contact.feature_notes.btn_save.click
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Note Inserted'
        e.attach_file('screenshot', get_screenshot)
        note_contact.wait_until_message_invisible
      end
      e.step('then I have to see the note inserted') do
        puts '  then I have to see the note inserted'
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[1][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_insert')
      end
      e.step('when I loggin with user that note was shared') do
        puts '  when I loggin with user that note was shared'
        notes.logout
        expect(page).to have_content('Sign in')
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
        expect(page).to have_content('Available')
        
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared'
        expect(page).to have_css('#contact-list')
        puts "COntact List"
        expect(page).to have_content(@contacts[3][:full_name])
        e.attach_file('screenshot', get_screenshot)
        home.select_contact(@contacts[0])
        e.attach_file('screenshot', get_screenshot)
        note_contact.note_list.wait_for_note_text_list
        contact.contact_feature_list.note_list.click
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[1][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_posted_by,@contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
      end
      e.step('when I mark as read this note') do
        puts '  when I mark as read this note'
        note_contact.mark_as_read
        sleep 2
      end
      e.step('then I have to see the note marked as read') do
        puts '  then I have to see the note marked as read'
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Note marked as read'
        note_contact.wait_until_message_invisible
        e.attach_file('screenshot', get_screenshot)
        expect(note_contact.note_list).to have_css('i.rbn-icon-common-was-read')
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="0"]')
      end
    end
    it('add note and check notes counter', :cc_mark_as_read_counter) do |e|
      puts '  check notes counter'
      
      e.step('when I access contact card on home page') do
        puts '  when I access contact card on home page'
        home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          contact.contact_feature_list.note_list.click
      end
      e.step('and I add and share notes') do
        puts '  and I add and share notes'
        note_contact.feature_notes.txt_note_text.set(@note[:text])
        note_contact.feature_notes.note_send_to.click
        note_contact.feature_notes.wait_for_send_department_list
        note_contact.send_to_user(get_user(1))
        note_contact.feature_notes.btn_save.click
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Note Inserted'
        note_contact.wait_until_message_invisible
        note_contact.feature_notes.txt_note_text.set(@note2[:text])
        note_contact.feature_notes.note_send_to.click
        note_contact.feature_notes.wait_for_send_department_list
        note_contact.send_to_user(get_user(1))
        note_contact.feature_notes.btn_save.click
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Note Inserted'
        note_contact.wait_until_message_invisible
      end
      e.step('then I have to see the notes inserted') do
        puts '  then I have to see the notes inserted'
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note2[:text])).to eql true
      end
      e.step('when I loggin with user that note was shared') do
        puts '  when I loggin with user that note was shared'
        notes.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the noteS that were shared') do
        puts '  then I have to see the noteS that were shared' 
        expect(page).to have_css('#contact-list')
        expect(page).to have_content(@contacts[3][:full_name])
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="2"]')
        home.select_contact(@contacts[0])
        note_contact.note_list.wait_for_title
        contact.contact_feature_list.note_list.click
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note2[:text])).to eql true
      end
      e.step('when I mark one note as read this note') do
        puts '  when I mark one note as read this note'
        e.attach_file('screenshot', get_screenshot)
        note_contact.mark_as_read

      end
      e.step('then I have to see the note marked as read and decrement one in counter') do
        puts '  then I have to see the note marked as read and decrement one in counter'
        note_contact.wait_until_message_visible
        e.attach_file('screenshot', get_screenshot)
        expect(note_contact.message.text).to eql 'Note marked as read'
        note_contact.wait_until_message_invisible
        e.attach_file('screenshot', get_screenshot)
        expect(note_contact.note_list).to have_css('i.rbn-icon-common-was-read')
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="1"]')
      end
      e.step('when I mark other note as read this note') do
        puts '  when I mark other note as read this note'
        note_contact.mark_as_read
      end
      e.step('then I have to see the note marked as read and decrement one in counter') do
        puts '  then I have to see the note marked as read and decrement one in counter'
        note_contact.wait_until_message_visible
        e.attach_file('screenshot', get_screenshot)
        expect(note_contact.message.text).to eql 'Note marked as read'
        note_contact.wait_until_message_invisible
        e.attach_file('screenshot', get_screenshot)
        expect(note_contact.note_list).to have_css('i.rbn-icon-common-was-read')
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="0"]')
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
        notes.note_list.wait_for_note_text_list
        expect(notes.note_list.title.text).to eql 'Notes'
        notes.delete_notes
      end
      notes.logout
    end
  end

  describe('share notes', :cc_share_notes) do
    it('add note and share with other coworkers',:cc_share_notes_with_coworker ) do |e|
      puts 'add note and share with other coworkers'
      e.step('when I access contact card on home page') do
        puts '  when I access contact card on home page'
        home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          contact.contact_feature_list.note_list.click
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          note_contact.feature_notes.txt_note_text.set(@note[:text])
          note_contact.feature_notes.btn_save.click
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          note_contact.wait_until_message_visible
          expect(note_contact.message.text).to eql 'Note Inserted'
          e.attach_file('screenshot', get_screenshot)
          note_contact.wait_until_message_invisible
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end
      e.step('when I share with coworkers') do
        puts '  when I share with coworkers'
        note_contact.note_list.note_icon_share_list[0].click
        note_contact.wait_for_note_share
        expect(note_contact.note_share.title.text).to eql 'Share'
        note_contact.share_with(@contacts[1])
        note_contact.note_share.btn_save_share.click
      end
      e.step('then I have to see that not was shared') do
        puts '  then I have to see that not was shared'
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Document shared successfully.'
        note_contact.wait_until_message_invisible
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
      end
      e.step('when I loggin with coworker that note was shared') do
        puts '  when I loggin with coworker that note was shared'
        note_contact.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared' 
        note_contact.home_features.notes.click
        notes.wait_for_note_list
        notes.note_list.wait_for_note_posted_by
        expect(notes.validate_data_on_screen(notes.note_list.note_text_list, @note[:text])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_posted_by,@contacts[0][:full_name])).to eql true
        expect(notes.validate_data_on_screen(notes.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
        expect(page).to have_css('.rbn-icon-common-quick-notes[data-notifications-before="1"]')
      end
    end
    it('add note and share through email', :cc_share_notes_through_email) do |e|
      puts '  add note and share through email'
      e.step('when I access contact card on home page') do
        puts '  when I access contact card on home page'
        home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          contact.contact_feature_list.note_list.click
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          note_contact.feature_notes.txt_note_text.set(@note[:text])
          note_contact.feature_notes.btn_save.click
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          note_contact.wait_until_message_visible
          expect(note_contact.message.text).to eql 'Note Inserted'
          e.attach_file('screenshot', get_screenshot)
          note_contact.wait_until_message_invisible
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end
      e.step('when I select to share this note') do 
        puts '  when I select to share this note'
        note_contact.note_list.note_icon_share_list[0].click
        note_contact.wait_for_note_share
        expect(note_contact.note_share.title.text).to eql 'Share'
        note_contact.note_share.share_email.set('test@automatic.com')
        note_contact.note_share.btn_save_share.click
      end
      e.step('then I have to see that note was shared') do 
        puts '  then I have to see that note was shared'
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Document shared successfully.'
        note_contact.wait_until_message_invisible
        note_contact.note_list.note_icon_share_list[0].click
        expect(note_contact.note_share.title.text).to eql 'Share'
        expect(note_contact.note_share.shared_emails).to have_content('test@automatic.com')
        note_contact.note_share.btn_cancel_share.click
      end
      e.step('when I share note with more than one emails') do
        puts '  when I share note with more than one emails'
        note_contact.note_list.note_icon_share_list[0].click
        note_contact.wait_for_note_share
        expect(note_contact.note_share.title.text).to eql 'Share'
        note_contact.note_share.share_email.set('test-2@automatic.com')
        note_contact.note_share.btn_save_share.click
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Document shared successfully.'
        note_contact.wait_until_message_invisible
        note_contact.note_list.note_icon_share_list[0].click
        note_contact.wait_for_note_share
        expect(note_contact.note_share.title.text).to eql 'Share'
        note_contact.note_share.share_email.set('test-3@automatic.com')
        note_contact.note_share.btn_save_share.click
        note_contact.wait_until_message_visible
      end
      e.step('then I have to see that note was shared') do 
        puts '  then I have to see that note was shared'
        note_contact.wait_until_message_invisible
        note_contact.note_list.note_icon_share_list[0].click
        expect(note_contact.note_share.title.text).to eql 'Share'
        expect(note_contact.note_share.shared_emails).to have_content('test@automatic.com')
        expect(note_contact.note_share.shared_emails).to have_content('test-2@automatic.com')
        expect(note_contact.note_share.shared_emails).to have_content('test-3@automatic.com')
        note_contact.note_share.btn_cancel_share.click
      end
    end
    after(:each) do
      home.select_contact(@contacts[0])
      if note_contact.note_list.note_icon_delete_list.length > 0
        note_contact.delete_notes
      else
        notes.logout
        login_page.do_login(get_admin())
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
        home.select_contact(@contacts[0])
        contact.contact_feature_list.note_list.click
        expect(note_contact.note_list.title.text).to eql 'Notes'
        note_contact.delete_notes
      end
      home.logout
    end
  end
  describe('delete notes', :cc_delete_notes) do
    before() do
      home.select_contact(@contacts[0])
      contact.contact_feature_list.note_list.click
      puts "contact list"
      puts note_contact.note_list.note_icon_delete_list.length
      if note_contact.note_list.note_icon_delete_list.length > 0
        note_contact.delete_notes
      end
    end
    it('delete note that is not shared', :cc_delete_note) do |e|
      puts '  delete note that is not shared'
      e.step('when I access contact card on home page') do
        puts '  when I access contact card on home page'
        home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          contact.contact_feature_list.note_list.click
      end
      e.step('and I set the note text and click on save button') do
          puts '  and I set the note text and click on save button'
          note_contact.feature_notes.txt_note_text.set(@note[:text])
          note_contact.feature_notes.btn_save.click
          
      end
      e.step('then I have to see the note inserted') do
          puts '  then I have to see the note inserted'
          note_contact.wait_until_message_visible
          expect(note_contact.message.text).to eql 'Note Inserted'
          e.attach_file('screenshot', get_screenshot)
          note_contact.wait_until_message_invisible
          contact.contact_feature_list.note_list.click
          expect(note_contact.note_list.title.text).to eql 'Notes'
          #Expect Note text#
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
          #expect Note Send To#
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
          #expect Note Posted By#
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_posted_by, @contacts[0][:full_name])).to eql true
          #expect Note Shared with#
          expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
          e.attach_file('screenshot', get_screenshot)
      end
      e.step('when I delete the inserted note') do
        puts '  when I delete the inserted note'
        note_contact.delete_notes
      end
      e.step('then I have to see that note was deleted') do
        puts '  then I have to see that note was deleted'
        expect(note_contact.note_list.note_empty_list.text).to eql 'No records found'
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_delete')
      end
    end
    it('delete note that was shared', :cc_delete_shared_note) do |e|
      e.step('when I access contact card on home page') do
        puts '  when I access contact card on home page'
        puts "selecionando as pressas"
        home.select_contact(@contacts[0])
      end
      e.step('and I select to add a new note') do
          puts '  and I select to add a new note'
          contact.contact_feature_list.note_list.click
      end
      e.step('and I set the note text and click on save button') do
        puts '  and I set the note text and click on save button'
        note_contact.feature_notes.txt_note_text.set(@note[:text])
        note_contact.feature_notes.btn_save.click
      end
      e.step('then I have to see the note inserted') do
        puts '  then I have to see the note inserted'
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Note Inserted'
        e.attach_file('screenshot', get_screenshot)
        note_contact.wait_until_message_invisible
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_text_list, @note[:text])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_sent_to, @contacts[0][:full_name])).to eql true
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[0][:full_name])).to eql true
      end
      e.step('when I share with coworkers') do
        puts '  when I share with coworkers'
        note_contact.note_list.note_icon_share_list[0].click
        note_contact.wait_for_note_share
        expect(note_contact.note_share.title.text).to eql 'Share'
        note_contact.share_with(@contacts[1])
        note_contact.note_share.btn_save_share.click
      end
      e.step('then I have to see that not was shared') do
        puts '  then I have to see that not was shared'
        note_contact.wait_until_message_visible
        expect(note_contact.message.text).to eql 'Document shared successfully.'
        note_contact.wait_until_message_invisible
        expect(note_contact.validate_data_on_screen(note_contact.note_list.note_shared_with, @contacts[1][:full_name])).to eql true
      end
      e.step('when I loggin with coworker that note was shared') do
        puts '  when I loggin with coworker that note was shared'
        note_contact.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
      end
      e.step('then I have to see the note that was shared') do
        puts '  then I have to see the note that was shared' 
        note_contact.home_features.notes.click
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
        home.select_contact(@contacts[0])
        sleep 2
        e.attach_file('screenshot', get_screenshot)
        note_contact.note_list.wait_for_note_text_list
        note_contact.delete_notes
        note_contact.wait_until_message_invisible
      end
      e.step('then I have to not see this notes anymore') do
        puts '  then I have to not see this notes anymore'
        expect(note_contact.note_list.note_empty_list.text).to eql 'No records found'
        expect(activity.my_activity).to have_css('i.rbn-icon-activity-note_delete')
      end
      e.step('when I loggin with coworker that note was shared') do
        puts '  when I loggin with coworker that note was shared'
        notes.logout
        login_page.do_login(get_user(1))
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
