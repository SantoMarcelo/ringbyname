require_relative '../../../pages/login/login'
require_relative '../../../pages/main/home'
require_relative '../../../pages/main/contacts/contact'
require_relative '../../../pages/main/activities/activity'

#:contact_card_genenral 
describe('Contact Card', :master) do
  before do
    Capybara.page.driver.browser.manage.window.maximize
    
    login_page.load
    admin = get_admin()
    login_page.do_login(get_admin())
    home.wait_until_home_features_visible
    home.wait_until_user_status_visible
    @contacts = get_contacts()
    admin_user = get_admin()
  end 
  describe('search contacts', :search_contacts) do
    it('search contact by name and by phone', :search_by_name_and_phone) do |e|
      e.step('when I on home page') do
        puts '  when I on home page'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
      end
      e.step('and I search a contact by name') do
        puts '  and I search a contact by name'
        home.contact.txt_search_contacts.set(@contacts[2][:full_name])
      end
      e.step('then I should see the list filtred') do
        puts '  then I should see the list filtred'
        expect(page).to have_css('.contacts')
        expect(home.validate_contact_list(@contacts[2])).to eql true
      end
      e.step('when I search a contact by phone') do
        puts '  when I search a contact by phone'
        home.contact.txt_search_contacts.set(@contacts[2][:phones][0]['phone_number'])
      end
      e.step('then I should see the filtred list') do
        puts '  then I should see the filtred list'
        expect(page).to have_css('.contacts')
        expect(home.validate_contact_list(@contacts[2])).to eql true
      end
      e.step('when I clear search field') do
        puts '  when I clear search field'
        home.contact.txt_search_contacts.set('')
      end
      e.step('then I should see unfiltred list') do
        puts '  then I should see unfiltred list'
        expect(page).to have_css('.contacts')
        expect(home.validate_contact_list(@contacts[0])).to eql true
        expect(home.validate_contact_list(@contacts[1])).to eql true
        expect(home.validate_contact_list(@contacts[2])).to eql true
        expect(home.validate_contact_list(@contacts[3])).to eql true
      end
      e.step('when I set group to contact') do
        puts "  when I set group to contact"
        home.select_contact(@contacts[0])
        contact.contact_group.wait_for_contact_group_list
        contact.remove_contact_group('Family')
        contact.contact_group.txt_name_group.set("Family")
        contact.contact_group.btn_add_group.click
        expect(home.message.text).to eql "Contact updated successfully."
        home.wait_until_message_invisible
        contact.contact_group.txt_name_group.set("")
      end
      e.step('then I should see the group added to contact') do
        puts '  then I should see the group added to contact'
        expect(contact.validate_contact_group_list('Family')).to eql true
      end
      e.step('when I filter contact list by Family group') do
        puts '  when I filter contact list by Family group'
        home.contact.btn_group_filters.click
        home.select_group_filter("Family")
        home.contact.btn_group_filters.click
        
      end
      e.step('then I should see the contact list filtred') do
        puts '  then I should see the contact list filtred'
        expect(page).to have_css('.contacts')
        expect(home.validate_contact_list(@contacts[0])).to eql true
        expect(contact.validate_selected_contact_group("Family")).to eql true
      end
      e.step('when I clear the selected filters') do
        puts '  when I clear the selected filters'
        contact.remove_selected_group_filter("Family")
      end
      e.step('then I should see the unfiltred list') do
        puts '  then I should see the unfiltred list'
        expect(home.validate_contact_list(@contacts[0])).to eql true
        expect(home.validate_contact_list(@contacts[1])).to eql true
        expect(home.validate_contact_list(@contacts[2])).to eql true
        expect(home.validate_contact_list(@contacts[3])).to eql true
      end
      e.step('and I revert changes') do
        puts '  and I revert changes'
        home.select_contact(@contacts[0])
        contact.contact_group.wait_for_contact_group_list
        contact.remove_contact_group('Family')
      end
    end
  end
  describe('add contacts', :add_contacts) do
    before do
      @contact = {
        company: 'Inphonex',
        first_name: 'Test',
        last_name: 'Auto Contact',
        full_name: 'Test Auto Contact',
        work_email: 'work_email@test.com',
        personal_email: 'personal_email@test.com',
        main_phone: '9876543210',
        main_extension: '1001',
        home_phone: '7410852963',
        mobile_phone: '8520147963',
        work_phone: '9632587410',
        work_extension: '1002',
        fax_phone: '9876543210',
        work_address: '7206 NW 31st ST, Miami, FL 33122 US',
        personal_address: '7998 NW 35st ST, Miami, FL 33122 US',
        work_weblink: 'work_weblink.com.br',
        facebook_weblink: 'Facebook_weblink.com.br',
        linkedin_weblink: 'LinkedIN_weblink.com.br',
        twitter_weblink: 'Twitter_weblink.com.br',
        personal_weblink: 'Personal_weblink.com.br',
        other_weblink: 'Other_weblink.com.br',

      }
    end
    it('check add contact validations', :add_contact_validations) do |e|
      puts 'check add contact validations'
      e.step('when I on home page') do
        puts '  when I on home page'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
      end
      e.step('and I select to add a new contact') do
        puts '  and I select to add a new contact'
        contact.contact.icon_add_contact.click
      end
      e.step('when I try to save without first name') do
        puts '  then I try to save without first name'
        scroll_to(contact.contact_form.icon_contact_add_email)
        scroll_to(contact.contact_form.icon_contact_add_address)
        contact.contact_form.btn_save.click
      end
      e.step('then I have to see the validation message') do
        puts '  then I have to see the validation message'
        expect(home.message.text).to eql "Please enter a valid First Name."
        home.wait_until_message_invisible
      end
    end
    
    it('add contact and check if was inserted correctly', :add_contact_only) do |e|
      puts 'add contact and check if was inserted correctly'
      e.step('when I on home page') do
        puts '  when I on home page'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
      end
      e.step('and I select to add a new contact') do
        puts '  and I select to add a new contact'
        contact.contact.icon_add_contact.click
      end
      e.step('and I fill contact information') do
        puts '  and I fill contact information'
        contact.contact_form.txt_contact_company.set(@contact[:company])
        contact.contact_form.txt_contact_first_name.set(@contact[:first_name])
        contact.contact_form.txt_contact_last_name.set(@contact[:last_name])
        contact.fill_contact_email(0, @contact[:work_email])
        contact.contact_form.icon_contact_add_email.click
        contact.wait_for_contact_card
        contact.fill_contact_email(1, @contact[:personal_email], "Personal")
        contact.contact_form.icon_contact_add_phone.click
        contact.contact_form.icon_contact_add_phone.click
        contact.contact_form.icon_contact_add_phone.click
        contact.contact_form.icon_contact_add_phone.click
        contact.fill_contact_phones(0, @contact[:main_phone], @contact[:main_extension])
        contact.fill_contact_phones(1, @contact[:fax_phone], nil, "Fax")
        contact.fill_contact_phones(2, @contact[:home_phone], nil, "Home")
        contact.fill_contact_phones(3, @contact[:mobile_phone], nil, "Mobile")
        contact.fill_contact_phones(4, @contact[:work_phone], @contact[:work_extension], "Work")
        contact.contact_form.txt_contact_phone_extension[1].send_keys :tab
        contact.contact_form.icon_contact_add_address.click
        contact.fill_contact_address(0, @contact[:work_address])
        contact.fill_contact_address(1, @contact[:personal_address], "Personal")
        contact.contact_form.txt_contact_address[1].send_keys :tab
        #scroll_to(contact.contact_form.icon_contact_add_weblink)
        contact.contact_form.icon_contact_add_weblink.click
        contact.contact_form.icon_contact_add_weblink.click
        contact.contact_form.icon_contact_add_weblink.click
        contact.contact_form.icon_contact_add_weblink.click
        contact.contact_form.icon_contact_add_weblink.click
        #scroll_to(contact.contact_form.icon_contact_add_weblink)
        contact.contact_form.txt_contact_weblink[0].send_keys :tab
        contact.fill_contact_weblinks(0, @contact[:work_weblink])
        contact.contact_form.txt_contact_weblink[0].send_keys :tab
        contact.fill_contact_weblinks(1, @contact[:facebook_weblink], "Facebook")
        contact.contact_form.txt_contact_weblink[1].send_keys :tab
        contact.fill_contact_weblinks(2, @contact[:linkedin_weblink], "Linkedin")
        contact.contact_form.txt_contact_weblink[2].send_keys :tab
        contact.fill_contact_weblinks(3, @contact[:twitter_weblink], "Twitter")
        contact.contact_form.txt_contact_weblink[3].send_keys :tab
        contact.fill_contact_weblinks(4, @contact[:personal_weblink], "Personal")
        contact.contact_form.txt_contact_weblink[4].send_keys :tab
        contact.fill_contact_weblinks(5, @contact[:other_weblink], "Other")
        contact.contact_form.txt_contact_weblink[5].send_keys :tab
        
        contact.contact_form.btn_save.click
      end
      e.step('then I check if contact was inserted correctly') do
        puts '  then I check if contact was inserted correctly'
        home.wait_until_message_visible
        expect(home.message.text).to eql 'Contact inserted'
        home.wait_until_message_invisible
        expect(contact.contact_info.contact_name.text.include?(@contact[:first_name]))
        expect(contact.contact_info.contact_name.text.include?(@contact[:last_name]))
        expect(contact.validate_contact_info(@contact[:company])).to eql true
        expect(contact.validate_contact_info(@contact[:work_email])).to eql true
        expect(contact.validate_contact_info(@contact[:personal_email])).to eql true
        expect(contact.validate_contact_info(@contact[:main_phone])).to eql true
        #expect(contact.validate_contact_info(@contact[:main_extension])).to eql true
        expect(contact.validate_contact_info(@contact[:home_phone])).to eql true
        expect(contact.validate_contact_info(@contact[:work_phone])).to eql true
        #expect(contact.validate_contact_info(@contact[:work_extension])).to eql true
        expect(contact.validate_contact_info(@contact[:fax_phone])).to eql true
        expect(contact.validate_contact_info(@contact[:work_address])).to eql true
        expect(contact.validate_contact_info(@contact[:personal_address])).to eql true
        expect(contact.validate_contact_info(@contact[:work_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:facebook_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:linkedin_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:twitter_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:personal_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:other_weblink])).to eql true
      end
      e.step('and I check if the contact is displayed in contact list') do
        puts '  and I check if the contact is displayed in contact list'
        expect(contact.validate_contact_in_contact_list(@contact)).to eql true
      end
      e.step('and the insert activity should be displayed in the activity list') do
        puts '  and the insert activity should be displayed in the activity list'
        expect(contact.validate_contact_activity(@contact)).to eql true
      end
      e.step('and I remove this contact') do
        contact.select_contact(@contact)
        sleep 2
        contact.contact_info.wait_for_contact_name
        contact.contact_card.edit_icon.click
        contact.contact_form.wait_until_txt_contact_first_name_visible
        sleep 2
        scroll_to(contact.contact_form.icon_contact_add_email)
        scroll_to(contact.contact_form.icon_contact_add_phone)
        scroll_to(contact.contact_form.icon_contact_add_weblink)
        contact.contact_form.btn_remove.click
        contact.contact_modal.btn_ok.click
        expect(home.message.text).to eql 'Contact deleted'
      end
    end
    after() do
      Capybara.current_session.driver.quit
    end
  end
  describe('edit contact', :edit_contacts) do
    before(:all) do
      contact.insert_contact(get_admin())
      @contact = {
        company: 'Inphonex',
        first_name: 'Test',
        last_name: 'Auto contact',
        full_name: 'Test Auto Contact',
        work_email: 'work_email@test.com',
        personal_email: 'personal_email@test.com',
        main_phone: '9876543210',
        main_extension: '1001',
        home_phone: '7410852963',
        mobile_phone: '8520147963',
        work_phone: '9632587410',
        work_extension: '1002',
        fax_phone: '9876543211',
        work_address: '7206 NW 31st ST, Miami, FL 33122 US',
        personal_address: '7998 NW 35st ST, Miami, FL 33122 US',
        work_weblink: 'work_weblink.com.br',
        facebook_weblink: 'Facebook_weblink.com.br',
        linkedin_weblink: 'LinkedIN_weblink.com.br',
        twitter_weblink: 'Twitter_weblink.com.br',
        personal_weblink: 'Personal_weblink.com.br',
        other_weblink: 'Other_weblink.com.br',
      }
      @contact_edit = {
        company: 'Inphonex Edited',
        first_name: 'Test Edited',
        last_name: 'Auto Contact Edited',
        full_name: 'Test Edited Auto Contact Edited',
        work_email: 'work_email_Edited@test.com',
        personal_email: 'personal_email_Edited@test.com',
        main_phone: '9876543999',
        main_extension: '1009',
        home_phone: '7410852888',
        mobile_phone: '8520147777',
        work_phone: '9632587666',
        work_extension: '1006',
        fax_phone: '9876543555',
        work_address: '9999 NW 31st ST, Miami, FL 33122 US',
        personal_address: '8888 NW 35st ST, Miami, FL 33122 US',
        work_weblink: 'work_weblink_Edited.com.br',
        facebook_weblink: 'Facebook_weblink_Edited.com.br',
        linkedin_weblink: 'LinkedIN_weblink_Edited.com.br',
        twitter_weblink: 'Twitter_weblink_Edited.com.br',
        personal_weblink: 'Personal_weblink_Edited.com.br',
        other_weblink: 'Other_weblink_Edited.com.br',
      }
    end
    it('edit contact and check if was edited corretly', :edit_contacts_and_check) do |e|
      puts 'edit contact and check if was edited corretly'
      e.step('when I on home page') do
        puts '  when I on home page'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
      end
      e.step('and I select a contact to edit') do
        puts '  and I select a contact to edit'
        contact.select_contact(@contact)
        sleep 1
        contact.contact_info.wait_for_contact_name
        contact.contact_card.edit_icon.click
        expect(contact.contact_info.contact_name.text.include?(@contact[:full_name]))
      end
      e.step('and I set eddited data to contact') do
        puts '  and I set eddited data to contact'
        contact.wait_for_contact_card
        contact.contact_group.txt_name_group.set("Clients")
        contact.contact_group.btn_add_group.click
        contact.contact_form.txt_contact_company.set(@contact_edit[:company])
        contact.contact_form.txt_contact_first_name.set(@contact_edit[:first_name])
        contact.contact_form.txt_contact_last_name.set(@contact_edit[:last_name])
        contact.fill_contact_email(0, @contact_edit[:work_email])
        contact.fill_contact_email(1, @contact_edit[:personal_email], "Personal")
        contact.fill_contact_phones(0, @contact_edit[:main_phone], @contact_edit[:main_extension])
        contact.contact_form.txt_contact_phone_extension[0].send_keys :tab
        contact.fill_contact_phones(1, @contact_edit[:fax_phone], nil, "Fax")
        contact.contact_form.txt_contact_phones[1].send_keys :tab
        contact.fill_contact_phones(2, @contact_edit[:home_phone], nil, "Home")
        contact.contact_form.txt_contact_phones[2].send_keys :tab
        contact.fill_contact_phones(3, @contact_edit[:mobile_phone], nil, "Mobile")
        contact.contact_form.txt_contact_phones[3].send_keys :tab
        contact.fill_contact_phones(4, @contact_edit[:work_phone], @contact_edit[:work_extension], "Work")
        contact.contact_form.txt_contact_phone_extension[1].send_keys :tab
        contact.fill_contact_address(0, @contact_edit[:work_address])
        contact.fill_contact_address(1, @contact_edit[:personal_address], "Personal")
        contact.contact_form.txt_contact_address[1].send_keys :tab
        contact.fill_contact_weblinks(0, @contact_edit[:work_weblink])
        contact.contact_form.txt_contact_weblink[0].send_keys :tab
        contact.fill_contact_weblinks(1, @contact_edit[:facebook_weblink], "Facebook")
        contact.contact_form.txt_contact_weblink[1].send_keys :tab
        contact.fill_contact_weblinks(2, @contact_edit[:linkedin_weblink], "Linkedin")
        contact.contact_form.txt_contact_weblink[1].send_keys :tab
        contact.fill_contact_weblinks(3, @contact_edit[:twitter_weblink], "Twitter")
        contact.contact_form.txt_contact_weblink[3].send_keys :tab
        contact.fill_contact_weblinks(4, @contact_edit[:personal_weblink], "Personal")
        contact.contact_form.txt_contact_weblink[4].send_keys :tab
        contact.fill_contact_weblinks(5, @contact_edit[:other_weblink], "Other")
        contact.contact_form.txt_contact_weblink[5].send_keys :tab
        contact.contact_form.btn_save.click
      end
      e.step('then I check if contact was updated correctly') do
        puts '  then I check if contact was updated correctly'
        expect(home.message.text).to eql 'Contact updated successfully.'
        home.wait_until_message_invisible
        expect(contact.contact_info.contact_name.text.include?(@contact_edit[:first_name]))
        expect(contact.contact_info.contact_name.text.include?(@contact_edit[:last_name]))
        expect(contact.validate_contact_info(@contact_edit[:company])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:work_email])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:personal_email])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:main_phone])).to eql true
        #expect(contact.validate_contact_info(@contact_edit[:main_extension])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:home_phone])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:work_phone])).to eql true
        #expect(contact.validate_contact_info(@contact_edit[:work_extension])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:fax_phone])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:work_address])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:personal_address])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:work_weblink])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:facebook_weblink])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:linkedin_weblink])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:twitter_weblink])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:personal_weblink])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:other_weblink])).to eql true
      end
      e.step('and I check if the contact is displayed in contact list') do
        puts '  and I check if the contact is displayed in contact list'
        expect(contact.validate_contact_in_contact_list(@contact_edit)).to eql true
      end
      e.step('and I search a contact by name') do
        puts '  and I search a contact by name'
        home.contact.txt_search_contacts.set(@contact_edit[:full_name])
        sleep 2
      end
      e.step('then I should see the list filtred') do
        puts '  then I should see the list filtred'
        expect(home.validate_contact_list(@contact_edit)).to eql true
        home.contact.txt_search_contacts.set('')
      end
      e.step('when I filter contact list by Family group') do
        puts '  when I filter contact list by Family group'
        home.contact.btn_group_filters.click
        home.select_group_filter("Clients")
        home.contact.btn_group_filters.click
      end
      e.step('then I should see the contact list filtred') do
        puts '  then I should see the contact list filtred'
        expect(home.validate_contact_list(@contact_edit)).to eql true
        expect(contact.validate_selected_contact_group("Clients")).to eql true
      end
      e.step('when I clear the selected filters') do
        puts '  when I clear the selected filters'
        contact.remove_selected_group_filter("Clients")
      end
      e.step('and the insert activity should be displayed in the activity list') do
        puts '  and the insert activity should be displayed in the activity list'
        expect(contact.validate_contact_activity(@contact_edit)).to eql true
      end
      e.step('when I select contact to edit') do
        puts '  when I select contact to edit'
        contact.select_contact(@contact_edit)
        sleep 2
        puts contact.contact_info.contact_name.text
        puts @contact_edit[:full_name]
        expect(contact.contact_info.contact_name.text.include?(@contact_edit[:full_name])).to eql true
        contact.contact_info.wait_until_contact_name_visible
        contact.contact_card.edit_icon.click
        sleep 1
      end
      e.step('and I edit contact removing extras information') do
        puts '  and I edit contact removing extras information'
        contact.remove_extra_emails
        contact.remove_extra_phones
        contact.remove_extra_phones
        contact.remove_extra_phones
        contact.contact_form.txt_contact_phone_extension[0].send_keys :tab
        contact.remove_extra_address
        contact.contact_form.txt_contact_address[0].send_keys :tab
        contact.contact_form.txt_contact_weblink[0].send_keys :tab
        contact.remove_extra_weblink
        contact.remove_extra_weblink
        contact.contact_form.btn_save.click
      end
      e.step('then I check if this change was saved correctly') do
        puts '  then I check if this change was saved correctly'
        expect(home.message.text).to eql 'Contact updated successfully.'
        home.wait_until_message_invisible
        expect(contact.contact_info.contact_name.text.include?(@contact_edit[:first_name]))
        expect(contact.contact_info.contact_name.text.include?(@contact_edit[:last_name]))
        expect(contact.validate_contact_info(@contact_edit[:company])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:work_email])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:main_phone])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:work_address])).to eql true
        expect(contact.validate_contact_info(@contact_edit[:work_weblink])).to eql true
      end
    end

    it('edit contact and check form validations', :edit_contacts_check_validations) do |e|
      puts 'edit contact and check form validations'
      e.step('when I on home page') do
        puts '  when I on home page'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
      end
      e.step('and I select a contact to edit') do
        puts '  and I select a contact to edit'
        contact.select_contact(@contact_edit)
        contact.contact_info.wait_for_contact_name
        sleep 1
        contact.contact_card.edit_icon.click
        expect(contact.contact_info.contact_name.text.include?(@contact_edit[:full_name]))
      end
      e.step('when I try to save without first name') do
        puts '  then I try to save without first name'
        contact.contact_form.wait_for_txt_contact_first_name
        contact.contact_form.txt_contact_first_name.set("")
        contact.contact_form.txt_contact_email[0].send_keys :tab
        contact.contact_form.txt_contact_phones[0].send_keys :tab
        contact.contact_form.txt_contact_phone_extension[0].send_keys :tab
        contact.contact_form.txt_contact_address[0].send_keys :tab

        contact.contact_form.btn_save.click
      end
      e.step('then I have to see the validation message') do
        puts '  then I have to see the validation message'
        expect(home.message.text).to eql "Please enter a valid First Name."
        home.wait_until_message_invisible
        #contact.contact_form.txt_contact_phones[0].send_keys [:shift, :tab]
        #contact.contact_form.select_contact_phone_label[0].send_keys [:shift, :tab]
        contact.contact_form.txt_contact_first_name.set(@contact_edit[:first_name])
        contact.contact_form.txt_contact_last_name.set(@contact_edit[:last_name])
        e.attach_file('screenshot', get_screenshot)
        contact.contact_form.btn_save.click

      end
    end
    after(:all) do
      @contact_edit = {
        company: 'Inphonex Edited',
        first_name: 'Test Edited',
        last_name: 'Auto Contact Edited',
        full_name: 'Test Edited Auto Contact Edited',
        work_email: 'work_email_Edited@test.com',
        personal_email: 'personal_email_Edited@test.com',
        main_phone: '9876543999',
        main_extension: '1009',
        home_phone: '7410852888',
        mobile_phone: '8520147777',
        work_phone: '9632587666',
        work_extension: '1006',
        fax_phone: '9876543555',
        work_address: '9999 NW 31st ST, Miami, FL 33122 US',
        personal_address: '8888 NW 35st ST, Miami, FL 33122 US',
        work_weblink: 'work_weblink_Edited.com.br',
        facebook_weblink: 'Facebook_weblink_Edited.com.br',
        linkedin_weblink: 'LinkedIN_weblink_Edited.com.br',
        twitter_weblink: 'Twitter_weblink_Edited.com.br',
        personal_weblink: 'Personal_weblink_Edited.com.br',
        other_weblink: 'Other_weblink_Edited.com.br',
      }
      login_page.load
      login_page.do_login(get_admin())
      home.wait_until_home_features_visible
      home.wait_until_user_status_visible
      contact.select_contact(@contact_edit)
      sleep 2
      contact.contact_info.wait_for_contact_name
      contact.contact_card.edit_icon.click
      contact.contact_form.wait_until_txt_contact_first_name_visible
      sleep 2
      scroll_to(contact.contact_form.icon_contact_add_email)
      scroll_to(contact.contact_form.icon_contact_add_phone)
      scroll_to(contact.contact_form.icon_contact_add_weblink)
      contact.contact_form.btn_remove.click
      contact.contact_modal.btn_ok.click
      expect(home.message.text).to eql 'Contact deleted'
      Capybara.current_session.driver.quit
    end
  end
  describe('delete contact', :delete_contact) do
    before do
      contact.insert_contact(get_admin())
      @contact = {
        company: 'Inphonex',
        first_name: 'Test',
        last_name: 'Auto contact',
        full_name: 'Test Auto Contact',
        work_email: 'work_email@test.com',
        personal_email: 'personal_email@test.com',
        main_phone: '9876543210',
        main_extension: '1001',
        home_phone: '7410852963',
        mobile_phone: '8520147963',
        work_phone: '9632587410',
        work_extension: '1002',
        fax_phone: '9876543210',
        work_address: '7206 NW 31st ST, Miami, FL 33122 US',
        personal_address: '7998 NW 35st ST, Miami, FL 33122 US',
        work_weblink: 'work_weblink.com.br',
        facebook_weblink: 'Facebook_weblink.com.br',
        linkedin_weblink: 'LinkedIN_weblink.com.br',
        twitter_weblink: 'Twitter_weblink.com.br',
        personal_weblink: 'Personal_weblink.com.br',
        other_weblink: 'Other_weblink.com.br',
      }
    end
    it('delete contact and check if was deleted correctly') do |e|
      e.step('when I on home page') do
        puts '  when I on home page'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
      end
      e.step('and I select a contact to delete') do
        puts '  and I select a contact to delete'
        contact.select_contact(@contact)
        contact.contact_info.wait_for_contact_name
        contact.contact_card.edit_icon.click
        expect(contact.contact_info.contact_name.text.include?(@contact[:full_name]))
      end
      e.step('and I delete a contact') do
        puts '  and I delete a contact'
        #scroll_to(contact.contact_form.icon_contact_add_email)
        #scroll_to(contact.contact_form.icon_contact_add_address)
        contact.contact_form.txt_contact_first_name.set("")
        contact.contact_form.txt_contact_email[1].send_keys :tab
        contact.contact_form.txt_contact_phones[1].send_keys :tab
        contact.contact_form.txt_contact_phones[2].send_keys :tab
        contact.contact_form.txt_contact_phones[3].send_keys :tab
        contact.contact_form.txt_contact_phones[4].send_keys :tab
        contact.contact_form.txt_contact_phone_extension[1].send_keys :tab
        contact.contact_form.txt_contact_address[0].send_keys :tab
        contact.contact_form.txt_contact_address[1].send_keys :tab
        contact.contact_form.txt_contact_weblink[0].send_keys :tab
        contact.contact_form.txt_contact_weblink[1].send_keys :tab
        contact.contact_form.txt_contact_weblink[2].send_keys :tab
        contact.contact_form.txt_contact_weblink[3].send_keys :tab
        contact.contact_form.txt_contact_weblink[4].send_keys :tab
        contact.contact_form.txt_contact_weblink[5].send_keys :tab
        contact.contact_form.btn_remove.click
        puts contact.contact_modal.content.text
        contact.contact_modal.btn_ok.click
      end
      e.step('then I have to see the contact deleted') do
        puts '  then I have to see the contact deleted'
        expect(home.message.text).to eql 'Contact deleted'
        contact.wait_until_message_invisible
        home.contact.txt_search_contacts.set(@contact[:full_name])
        expect(home.validate_contact_list(@contact)).to eql false
      end
    end
  end

  describe('contact owner', :owner_contact) do
    before do
      @contact = {
        company: 'Inphonex',
        first_name: 'Test',
        last_name: 'Auto Contact',
        full_name: 'Test Auto Contact',
        work_email: 'work_email@test.com',
        personal_email: 'personal_email@test.com',
        main_phone: '9876543210',
        main_extension: '1001',
        home_phone: '7410852963',
        mobile_phone: '8520147963',
        work_phone: '9632587410',
        work_extension: '1002',
        fax_phone: '9876543210',
        work_address: '7206 NW 31st ST, Miami, FL 33122 US',
        personal_address: '7998 NW 35st ST, Miami, FL 33122 US',
        work_weblink: 'work_weblink.com.br',
        facebook_weblink: 'Facebook_weblink.com.br',
        linkedin_weblink: 'LinkedIN_weblink.com.br',
        twitter_weblink: 'Twitter_weblink.com.br',
        personal_weblink: 'Personal_weblink.com.br',
        other_weblink: 'Other_weblink.com.br',

      }
    end
    it('insert a contact and check if other users can edit them') do |e|
      e.step('when I on home page') do
        puts '  when I on home page'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
      end
      e.step('and I select to add a new contact') do
        puts '  and I select to add a new contact'
        contact.contact.icon_add_contact.click
      end
      e.step('and I fill contact information') do
        puts '  and I fill contact information'
        contact.contact_form.txt_contact_company.set(@contact[:company])
        contact.contact_form.txt_contact_first_name.set(@contact[:first_name])
        contact.contact_form.txt_contact_last_name.set(@contact[:last_name])
        contact.fill_contact_email(0, @contact[:work_email])
        contact.contact_form.icon_contact_add_email.click
        contact.wait_for_contact_card
        contact.fill_contact_email(1, @contact[:personal_email], "Personal")
        contact.contact_form.icon_contact_add_phone.click
        contact.contact_form.icon_contact_add_phone.click
        contact.contact_form.icon_contact_add_phone.click
        contact.contact_form.icon_contact_add_phone.click
        contact.fill_contact_phones(0, @contact[:main_phone], @contact[:main_extension])
        contact.fill_contact_phones(1, @contact[:fax_phone], nil, "Fax")
        contact.fill_contact_phones(2, @contact[:home_phone], nil, "Home")
        contact.fill_contact_phones(3, @contact[:mobile_phone], nil, "Mobile")
        contact.fill_contact_phones(4, @contact[:work_phone], @contact[:work_extension], "Work")
        contact.contact_form.txt_contact_phone_extension[1].send_keys :tab
        contact.contact_form.icon_contact_add_address.click
        contact.fill_contact_address(0, @contact[:work_address])
        contact.fill_contact_address(1, @contact[:personal_address], "Personal")
        contact.contact_form.txt_contact_address[1].send_keys :tab
        #scroll_to(contact.contact_form.icon_contact_add_weblink)
        contact.contact_form.icon_contact_add_weblink.click
        contact.contact_form.icon_contact_add_weblink.click
        contact.contact_form.icon_contact_add_weblink.click
        contact.contact_form.icon_contact_add_weblink.click
        contact.contact_form.icon_contact_add_weblink.click
        #scroll_to(contact.contact_form.icon_contact_add_weblink)
        contact.contact_form.txt_contact_weblink[0].send_keys :tab
        contact.fill_contact_weblinks(0, @contact[:work_weblink])
        contact.contact_form.txt_contact_weblink[0].send_keys :tab
        contact.fill_contact_weblinks(1, @contact[:facebook_weblink], "Facebook")
        contact.contact_form.txt_contact_weblink[1].send_keys :tab
        contact.fill_contact_weblinks(2, @contact[:linkedin_weblink], "Linkedin")
        contact.contact_form.txt_contact_weblink[2].send_keys :tab
        contact.fill_contact_weblinks(3, @contact[:twitter_weblink], "Twitter")
        contact.contact_form.txt_contact_weblink[3].send_keys :tab
        contact.fill_contact_weblinks(4, @contact[:personal_weblink], "Personal")
        contact.contact_form.txt_contact_weblink[4].send_keys :tab
        contact.fill_contact_weblinks(5, @contact[:other_weblink], "Other")
        contact.contact_form.txt_contact_weblink[5].send_keys :tab

        contact.contact_form.btn_save.click
      end
      e.step('then I check if contact was inserted correctly') do
        puts '  then I check if contact was inserted correctly'
        expect(home.message.text).to eql 'Contact inserted'
        home.wait_until_message_invisible
        expect(contact.contact_info.contact_name.text.include?(@contact[:first_name]))
        expect(contact.contact_info.contact_name.text.include?(@contact[:last_name]))
        expect(contact.validate_contact_info(@contact[:company])).to eql true
        expect(contact.validate_contact_info(@contact[:work_email])).to eql true
        expect(contact.validate_contact_info(@contact[:personal_email])).to eql true
        expect(contact.validate_contact_info(@contact[:main_phone])).to eql true
        #expect(contact.validate_contact_info(@contact[:main_extension])).to eql true
        expect(contact.validate_contact_info(@contact[:home_phone])).to eql true
        expect(contact.validate_contact_info(@contact[:work_phone])).to eql true
        #expect(contact.validate_contact_info(@contact[:work_extension])).to eql true
        expect(contact.validate_contact_info(@contact[:fax_phone])).to eql true
        expect(contact.validate_contact_info(@contact[:work_address])).to eql true
        expect(contact.validate_contact_info(@contact[:personal_address])).to eql true
        expect(contact.validate_contact_info(@contact[:work_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:facebook_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:linkedin_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:twitter_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:personal_weblink])).to eql true
        expect(contact.validate_contact_info(@contact[:other_weblink])).to eql true
      end
      e.step('when I logon with other user') do
        home.logout
        login_page.do_login(get_user(1))
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
        sleep 1
      end
      e.step('and I try to edit a inserted contact') do
        puts '  and I try to edit a inserted contact'
        contact.select_contact(@contact)
        sleep 1
        contact.contact_info.wait_for_contact_name
        expect(contact.contact_info.contact_name.text.include?(@contact[:full_name]))
      end
      e.step('then this user does have not permission to edit this contact') do
        puts '  then this user does have not permission to edit this contact'
        element_visible = page.has_css?('.rbn-icon-common-contact-card-edit')
        expect(element_visible).to eql false
      end
    end
    after(:all) do
      @contact = {
        company: 'Inphonex',
        first_name: 'Test',
        last_name: 'Auto Contact',
        full_name: 'Test Auto Contact',
        work_email: 'work_email@test.com',
        personal_email: 'personal_email@test.com',
        main_phone: '9876543210',
        main_extension: '1001',
        home_phone: '7410852963',
        mobile_phone: '8520147963',
        work_phone: '9632587410',
        work_extension: '1002',
        fax_phone: '9876543210',
        work_address: '7206 NW 31st ST, Miami, FL 33122 US',
        personal_address: '7998 NW 35st ST, Miami, FL 33122 US',
        work_weblink: 'work_weblink.com.br',
        facebook_weblink: 'Facebook_weblink.com.br',
        linkedin_weblink: 'LinkedIN_weblink.com.br',
        twitter_weblink: 'Twitter_weblink.com.br',
        personal_weblink: 'Personal_weblink.com.br',
        other_weblink: 'Other_weblink.com.br',

      }
      login_page.load
      login_page.do_login(get_admin())
      home.wait_until_home_features_visible
      home.wait_until_user_status_visible
      contact.select_contact(@contact)
      sleep 2
      contact.contact_info.wait_for_contact_name
      contact.contact_card.edit_icon.click
      contact.contact_form.wait_until_txt_contact_first_name_visible
      sleep 2
      scroll_to(contact.contact_form.icon_contact_add_email)
      scroll_to(contact.contact_form.icon_contact_add_phone)
      scroll_to(contact.contact_form.icon_contact_add_weblink)
      contact.contact_form.btn_remove.click
      contact.contact_modal.btn_ok.click
      expect(home.message.text).to eql 'Contact deleted'
      Capybara.current_session.driver.quit
    end
  end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end
end