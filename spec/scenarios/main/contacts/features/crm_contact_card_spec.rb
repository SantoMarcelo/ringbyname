require_relative '../../../../pages/login/login'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/main/features/crm/crm_mini_app'
require_relative '../../../../pages/login/reset_password'
require_relative '../../../../pages/main/contacts/contact'
require_relative '../../../../pages/admin/dashboard/dashboard'
#opportunity_general
#cc_general_opportunity - :opportunity_general 
describe('Contact Card - CRM Opportunity', :master) do
  before do
    system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
    Capybara.page.driver.browser.manage.window.maximize
    #set_user_data(get_admin())
    
    login_page.load
    login_page.do_login(get_admin())
    home.wait_until_home_features_visible
    home.wait_until_user_status_visible
    followup = Date.today
    close_date = followup +1
    
    @contacts = get_contacts()
    @admin_user = get_admin()
   
    
    @opportunity1 = {
      name: 'Test Opportunity 1',
      source: 'Social Media Site',
      status: 'Attempted',
      probability: '25%',
      product: 'Test Product 1',
      price: '$199.99',
      action: 'Phone Call',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity2 = {
      name: 'Test Opportunity 2',
      source: 'Website',
      status: 'Contacted',
      probability: '50%',
      product: 'Test Product 2',
      price: '$299.99',
      action: 'Email',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity3 = {
      name: 'Test Opportunity 3',
      source: 'Word of Mouth',
      status: 'Qualified',
      probability: '75%',
      product: 'Test Product 3',
      price: '$399.99',
      action: 'Prepare Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity4 = {
      name: 'Test Opportunity 4',
      source: 'Referral',
      status: 'Unqualified',
      probability: '100%',
      product: 'Test Product 4',
      price: '$499.99',
      action: 'Follow-up on Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity5 = {
      name: 'Test Opportunity 5',
      source: 'Trade Show',
      status: 'Dead',
      probability: '25%',
      product: 'Test Product 5',
      price: '$599.99',
      action: 'Negotiate',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity6 = {
      name: 'Test Opportunity 6',
      source: 'Advertisement',
      status: 'Quoted',
      probability: '25%',
      product: 'Test Product 6',
      price: '$699.99',
      action: 'Phone Call',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity7 = {
      name: 'Test Opportunity 7',
      source: 'Online Search',
      status: 'Negotiating',
      probability: '50%',
      product: 'Test Product 7',
      price: '$799.99',
      action: 'Email',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity8 = {
      name: 'Test Opportunity 8',
      source: 'Self Generated',
      status: 'Closed Won',
      probability: '75%',
      product: 'Test Product 8',
      price: '$899.99',
      action: 'Prepare Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity9 = {
      name: 'Test Opportunity 9',
      source: 'Movie',
      status: 'Closed Lost',
      probability: '100%',
      product: 'Test Product 9',
      price: '$999.99',
      action: 'Follow-up on Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity10 = {
      name: 'Test Opportunity 10',
      source: 'Social Media Site',
      status: 'Attempted',
      probability: '50%',
      product: 'Test Product 10',
      price: '$1,099.99',
      action: 'Follow-up on Quote',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity11 = {
      name: 'Test Opportunity 11',
      source: 'Website',
      status: 'Contacted',
      probability: '75%',
      product: 'Test Product 11',
      price: '$1,199.99',
      action: 'Negotiate',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity12 = {
      name: 'Test Opportunity 12',
      source: 'Word of Mouth',
      status: 'Qualified',
      probability: '100%',
      product: 'Test Product 12',
      price: '$1,299.99',
      action: 'Negotiate',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity13 = {
      name: 'Test Opportunity 13',
      source: 'Referral',
      status: 'Unqualified',
      probability: '25%',
      product: 'Test Product 13',
      price: '$1,399.99',
      action: 'Send Agreement',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity14 = {
      name: 'Test Opportunity 14',
      source: 'Trade Show',
      status: 'Dead',
      probability: '50%',
      product: 'Test Product 14',
      price: '$1,499.99',
      action: 'Close',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
    @opportunity15 = {
      name: 'Test Opportunity 15',
      source: 'Advertisement',
      status: 'Quoted',
      probability: '75%',
      product: 'Test Product 15',
      price: '$1,599.99',
      action: 'Phone Call',
      follow_up:  followup.strftime("%m-%d-%Y"),
      close_date: close_date.strftime("%m-%d-%Y"),
      comment: 'test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste',
      contact_owner: @admin_user[:full_name]
    }
  end

  describe('add opportunity', :cc_add_contact_opportunity) do
    it('access contact card and add a opportunity', :cc_add_opportunity_only) do |e|
      puts 'access contact card and add a opportunity'
      e.step('when I on home page and access contact card') do
        puts '  when I on home page and access contact card'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
        home.select_contact(@contacts[0])
        contact.wait_until_contact_card_visible
        expect(contact.verify_contact(@contacts[0])) == true
      end
      e.step('and I select CRM menu and click to add') do
        puts '  and I select CRM menu and click to add'
        contact.access_crm
        # find('.crm-tab__add-button').click
      end
      e.step('then I filled opportunity information') do
        puts '  then I filled opportunity information'
        sleep(1)
        contact.oppo_form.txt_oppo_name.set(@opportunity1[:name])
        contact.oppo_form.select_oppo_source.find('option', text: (@opportunity1[:source])).select_option
        contact.oppo_form.select_oppo_status.find('option', text: (@opportunity1[:status])).select_option
        contact.oppo_form.select_oppo_prob.find('option', text: (@opportunity1[:probability])).select_option
        contact.oppo_form.select_oppo_prob.send_keys :tab
        contact.oppo_form.txt_oppo_product.set(@opportunity1[:product])
        contact.oppo_form.txt_oppo_product.send_keys :tab
        contact.oppo_form.txt_oppo_price.set(@opportunity1[:price])
        scroll_to(contact.oppo_form.txt_oppo_price)
        contact.oppo_form.select_oppo_next_action.find('option', text: (@opportunity1[:action])).select_option
        contact.oppo_form.select_oppo_next_action.send_keys :tab
        set_date(contact.oppo_form.date_oppo_follow_up['class'].gsub(" ", "."), @opportunity1[:follow_up] )
        contact.oppo_form.date_oppo_follow_up.click
        contact.oppo_form.select_oppo_next_action.click
        set_date(contact.oppo_form.date_close_date['class'].gsub(" ", "."), @opportunity1[:close_date] )
        contact.oppo_form.select_oppo_next_action.click
        contact.oppo_form.txt_oppo_comment.set(@opportunity1[:comment])
        contact.oppo_form.txt_oppo_comment.send_keys :tab
        
        contact.oppo_form.btn_oppo_save.click
      end
      e.step('Then I see the inserted message') do
        puts '  Then I see the inserted message'
        contact.wait_until_message_visible
        expect(contact.message.text).to eql 'Opportunity inserted.'
        e.attach_file('screenshot', get_screenshot)
        contact.wait_until_message_invisible
      end
      e.step('and I check if the opportunity is in grid') do
        puts '  and I check if the opportunity is in grid'
        contact.wait_for_icon_opportunity_list
        contact.access_crm_list
        contact.contact_card.wait_for_opportunity_list_item
        expect(contact.validate_contact_opportunity_list(@opportunity1)).to eql true
        e.attach_file('screenshot', get_screenshot)
      end
      e.step('and access CRM and verify opportunities') do
        puts '  and access CRM and verify opportunities'
        home.access_crm
        crm_mini_app.crm_container.wait_for_opportunity_list
        crm_mini_app.crm_container.wait_for_opportunity_list_column
        expect(crm_mini_app.crm_container.title.text).to eql 'CRM'
        expect(crm_mini_app.validate_opportunity_list(@opportunity1)).to eql true
        e.attach_file('screenshot', get_screenshot)
      end

    end
    it('verify validations when insert opportunity', :cc_add_opportunity_validations) do |e|
      puts 'verify validations when insert opportunity'
      e.step('given when I on contactr card page') do
        puts '  given when I on contactr card page'
        home.wait_until_contact_visible
        sleep(2)
        home.select_contact(@contacts[0])
        contact.wait_until_contact_card_visible
      end
      e.step('and I add a oportunity') do
        puts '  and I add a oportunity'
        contact.access_crm
      end
      
      e.step('when I try to inser opportunity without source') do
        puts '  when I try to inser opportunity without source'
        contact.wait_until_message_invisible

        contact.oppo_form.select_oppo_prob.send_keys :tab
        contact.oppo_form.txt_oppo_product.send_keys :tab
        contact.oppo_form.txt_oppo_price.send_keys :tab
        contact.oppo_form.select_oppo_next_action.send_keys :tab
        contact.oppo_form.date_oppo_follow_up.send_keys :tab
        contact.oppo_form.date_close_date.send_keys :tab
        contact.oppo_form.txt_oppo_comment.send_keys :tab

        contact.oppo_form.btn_oppo_save.click
      end
      e.step('then I see a validation message') do
        puts '  then I see a validation message'
        contact.wait_until_message_visible
        expect(home.message.text).to eql 'Invalid opportunity source.'
      end
      e.step('when I try to inser opportunity without status') do
        puts '  when I try to inser opportunity without status'
        contact.wait_until_message_invisible
        contact.oppo_form.select_oppo_next_action.send_keys [:shift, :tab]
        contact.oppo_form.txt_oppo_price.send_keys [:shift, :tab]
        contact.oppo_form.txt_oppo_product.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_prob.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_status.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_source.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_source.find('option', text: 'Website').select_option
        scroll_to(contact.oppo_form.select_oppo_source)
        contact.oppo_form.select_oppo_next_action.send_keys :tab
        contact.oppo_form.date_oppo_follow_up.send_keys :tab
        contact.oppo_form.date_close_date.send_keys :tab
        contact.oppo_form.txt_oppo_comment.send_keys :tab
       
        contact.oppo_form.btn_oppo_save.click
      end
      e.step('then I see a validation message') do
        puts '  then I see a validation message'
        contact.wait_until_message_visible
        expect(home.message.text).to eql 'Please provide a valid status.'
      end
      e.step('when I try to inser opportunity without probability') do
        puts '  when I try to inser opportunity without probability'
        contact.wait_until_message_invisible
        contact.oppo_form.select_oppo_next_action.send_keys [:shift, :tab]
        contact.oppo_form.txt_oppo_price.send_keys [:shift, :tab]
        contact.oppo_form.txt_oppo_product.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_prob.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_status.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_source.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_status.find('option', text: 'Qualified').select_option
        scroll_to(contact.oppo_form.select_oppo_source)
        contact.oppo_form.select_oppo_next_action.send_keys :tab
        contact.oppo_form.date_oppo_follow_up.send_keys :tab
        contact.oppo_form.date_close_date.send_keys :tab
        contact.oppo_form.txt_oppo_comment.send_keys :tab
       
        contact.oppo_form.btn_oppo_save.click
      end
      e.step('then I see a validation message') do
        ' then I see a validation message'
        contact.wait_until_message_visible
        expect(contact.message.text).to eql 'Please provide a valid probability.'
       end
      e.step('when I try to inser opportunity without next action') do
        puts '  when I try to inser opportunity without next action'
        contact.wait_until_message_invisible
        contact.oppo_form.select_oppo_next_action.send_keys [:shift, :tab]
        contact.oppo_form.txt_oppo_price.send_keys [:shift, :tab]
        contact.oppo_form.txt_oppo_product.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_prob.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_status.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_source.send_keys [:shift, :tab]
        contact.oppo_form.select_oppo_prob.find('option', text: '50%').select_option
        scroll_to(contact.oppo_form.select_oppo_source)
        contact.oppo_form.select_oppo_next_action.send_keys :tab
        contact.oppo_form.date_oppo_follow_up.send_keys :tab
        contact.oppo_form.date_close_date.send_keys :tab
        contact.oppo_form.txt_oppo_comment.send_keys :tab
       
        contact.oppo_form.btn_oppo_save.click
      end
      e.step('then I see a validation message') do
        puts '  then I see a validation message'
        contact.wait_until_message_visible
        expect(contact.message.text).to eql 'Please provide a valid next action.'
      end
      e.step('when I try to inser opportunity without name') do
        puts ' when I try to inser opportunity without name'
        contact.wait_until_message_invisible
        contact.oppo_form.select_oppo_next_action.find('option', text: 'Phone Call').select_option
 
         contact.oppo_form.btn_oppo_save.click
       end
       e.step('then I see a validation message') do
         ' then I see a validation message'
         contact.wait_until_message_visible
         expect(home.message.text).to eql 'Please provide the opportunity name.'
       end
    end
    after() do
      system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
      Capybara.reset_sessions!
     end
  end

  describe('edit opportunity', :cc_edit_opportunity) do
    before do
      admin_user = get_admin()
      crm_mini_app.insert_opportunity(admin_user, 3)
      followup = Date.today
      close_date = followup +1
      @opportunity_edited = {
          name: 'Test Opportunity Edited',
          source: 'Advertisement',
          status: 'Negotiating',
          probability: '75%',
          product: 'Test Product Edited',
          price: '$111.11',
          action: 'Close',
          follow_up: followup.strftime("%m-%d-%Y"), 
          close_date: close_date.strftime("%m-%d-%Y"),
          comment: 'Edited',
          contact_owner: 'Dev Marcelo 1 User'
        }
    end
    it('edit opportunity through contact card', :edit) do |e|
      puts 'edit opportunity through contact card'
      e.step('Given I on home page and access contact card') do
        puts 'Given I on home page and access contact card'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
        home.select_contact(@contacts[0])
        contact.wait_until_contact_card_visible
        expect(contact.verify_contact(@contacts[0]))
      end
      e.step('and I access CRM menu') do
        puts 'and I access CRM menu'
        contact.wait_for_icon_opportunity_list
        contact.access_crm_list
        sleep 3
      end
      e.step('when I select a opportunity to edit') do
        puts 'when I select a opportunity to edit'
        contact.contact_card.wait_until_opportunity_list_item_visible
        contact.select_opportunity(@opportunity1)
        sleep 2
        contact.edit_opportunity.btn_edit_oppo.click
      end
      e.step('and I edit a opportunity') do
        puts 'and I edit a opportunity'
        contact.edit_opportunity.wait_until_txt_oppo_name_visible
        sleep 1
        scroll_to(contact.edit_opportunity.txt_oppo_name)
        contact.edit_opportunity.txt_oppo_name.set(@opportunity_edited[:name])
        contact.edit_opportunity.select_oppo_source.find('option', text: (@opportunity_edited[:source])).select_option
        contact.edit_opportunity.select_oppo_status.find('option', text: (@opportunity_edited[:status])).select_option
        contact.edit_opportunity.select_oppo_prob.find('option', text: (@opportunity_edited[:probability])).select_option
        contact.edit_opportunity.txt_oppo_product.set(@opportunity_edited[:product])
        contact.edit_opportunity.txt_oppo_price.set(@opportunity_edited[:price])
        contact.edit_opportunity.select_oppo_next_action.find('option', text: (@opportunity_edited[:action])).select_option
        contact.edit_opportunity.select_oppo_next_action.send_keys :tab
        set_date(contact.edit_opportunity.date_oppo_follow_up['class'].gsub(" ", "."), @opportunity_edited[:follow_up] )
        set_date(contact.edit_opportunity.date_close_date['class'].gsub(" ", "."), @opportunity_edited[:close_date] )
        contact.edit_opportunity.txt_oppo_comment.set(@opportunity_edited[:comment])
        contact.edit_opportunity.txt_oppo_comment.send_keys :tab
        #scroll_to(contact.edit_opportunity.txt_oppo_comment)
        contact.edit_opportunity.btn_oppo_save.click
      end
      e.step('then I see the success message') do
        puts 'then I see the success message'
        contact.wait_until_message_visible
        expect(contact.message.text).to eql 'Opportunity updated.'
        contact.wait_until_message_invisible
      end
      e.step('and I check if was updated correctly') do
        puts 'and I check if was updated correctly'
        expect(contact.opportunity_details.opportunity_name.text.include?(@opportunity_edited[:name]))
        expect(contact.opportunity_details.opportunity_source.text.include?(@opportunity_edited[:source]))
        expect(contact.opportunity_details.opportunity_status.text.include?(@opportunity_edited[:status]))
        expect(contact.opportunity_details.opportunity_probality.text.include?(@opportunity_edited[:probability]))
        expect(contact.opportunity_details.opportunity_product.text.include?(@opportunity_edited[:product]))
        expect(contact.opportunity_details.opportunity_price.text.include?(@opportunity_edited[:price]))
        expect(contact.opportunity_details.opportunity_action.text.include?(@opportunity_edited[:action]))
        expect(contact.opportunity_details.opportunity_followup_date.text.include?(@opportunity_edited[:follow_up]))
        expect(contact.opportunity_details.opportunity_close_date.text.include?(@opportunity_edited[:close_date]))
        expect(contact.opportunity_details.opportunity_comments.text.include?(@opportunity_edited[:comment]))
        expect(contact.opportunity_details.opportunity_last_edit.text.include?('Last edited by Dev Marcelo 1 User on'))
        #validate update in list
        home.select_contact(@contacts[0])
        contact.wait_until_contact_card_visible
        contact.wait_for_icon_opportunity_list
        contact.access_crm_list
        contact.contact_card.wait_until_opportunity_list_item_visible
        expect(contact.validate_contact_opportunity_list(@opportunity_edited)).to eql true
      end
    end
    after() do
      system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
      Capybara.reset_sessions!
     end
  end

  describe('opportunity details', :cc_opportunity_details) do
    before do
      admin_user = get_admin()
      crm_mini_app.insert_opportunity(admin_user, 1)
    end
    it('validate opportunity details') do |e|
      puts 'validate opportunity details'
      e.step('Given I on home page and access contact card') do
        puts 'Given I on home page and access contact card'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
        home.select_contact(@contacts[0])
        contact.wait_until_contact_card_visible
        expect(contact.verify_contact(@contacts[0])) == true
      end
      e.step('and I access CRM menu') do
        puts 'and I access CRM menu'
        contact.wait_for_icon_opportunity_list
        contact.access_crm_list
        sleep 3
      end
      e.step('when I select a opportunity to view details') do
        puts 'when I select a opportunity to view details'
        contact.wait_until_contact_opportunity_list_visible
        scroll_to(contact.icon_opportunity_list)
        contact.select_opportunity(@opportunity1)

      end
      e.step('then I should see the opportunity details')do
        puts 'then I should see the opportunity details'
        contact.opportunity_details.wait_for_opportunity_name
        scroll_to(contact.opportunity_details.title visible: false)
        expect(contact.opportunity_details.title).to have_content(@opportunity1[:name])
        expect(contact.opportunity_details.opportunity_name.text.include?(@opportunity1[:name]))
        expect(contact.opportunity_details.opportunity_source.text.include?(@opportunity1[:source]))
        expect(contact.opportunity_details.opportunity_status.text.include?(@opportunity1[:status]))
        expect(contact.opportunity_details.opportunity_probality.text.include?(@opportunity1[:probability]))
        expect(contact.opportunity_details.opportunity_product.text.include?(@opportunity1[:product]))
        expect(contact.opportunity_details.opportunity_price.text.include?(@opportunity1[:price]))
        expect(contact.opportunity_details.opportunity_action.text.include?(@opportunity1[:action]))
        expect(contact.opportunity_details.opportunity_followup_date.text.include?(@opportunity1[:follow_up]))
        expect(contact.opportunity_details.opportunity_close_date.text.include?(@opportunity1[:close_date]))
        expect(contact.opportunity_details.opportunity_comments.text.include?(@opportunity1[:comment]))
        expect(contact.opportunity_details.opportunity_last_edit.text.include?('Last edited by Dev Marcelo 1 User on'))
      end
    end
    after() do
      system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
      Capybara.reset_sessions!
     end
  end

  describe('opportunity pagination', :cc_crm_pagination) do
    before do
      admin_user = get_admin()
      crm_mini_app.insert_opportunity(admin_user, 15)
    end
    it('validate contact card opportunity pagination', :cc_contact_card_pagination) do |e|
      e.step('given when I on contact card') do
        puts '  given when I on contact card'
        home.wait_until_contact_visible
        sleep 2
        home.select_contact(@contacts[0])
        contact.wait_until_contact_card_visible
      end
      e.step('when I access oportunity list') do
        puts '  when I access oportunity list'
        contact.wait_for_icon_opportunity_list
        contact.access_crm_list
        sleep 2
        #contact.contact_card.wait_until_contact_opportunity_list_visible
        scroll_to(contact.icon_opportunity_list)
        e.attach_file('screenshot', get_screenshot)
        #contact.icon_opportunity_list.send_keys :tab
      end
      e.step('then I should see the first page of opportunity list') do
        puts '  then I should see the first page of opportunity list'
        contact.contact_card.wait_until_opportunity_list_item_visible
        e.attach_file('screenshot', get_screenshot)
        expect(contact.validate_contact_opportunity_list(@opportunity1)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity2)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity3)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity4)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity6)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity7)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity8)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity9)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity10)).to eql true
        e.attach_file('screenshot', get_screenshot)
      end
      e.step('when I change the opportunity page') do
        puts '  when I change the opportunity page'
        contact.wait_until_pagination_visible
        contact.goto_page(2)
        sleep(2)
      end
      e.step('then I can see the most older opportunity') do
        puts '  then I can see the most older opportunity'
        contact.contact_card.wait_until_opportunity_list_item_visible
        e.attach_file('screenshot', get_screenshot)
        #expect(contact.validate_contact_opportunity_list(@opportunity10)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity11)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity12)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity13)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity14)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity15)).to eql true
      end
    end
    after() do
      system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
      Capybara.reset_sessions!
     end
  end


  # describe('upload attachments', :cc_upload_attachment) do
  #   it('attache file when create a opportunity') do |e|
  #     e.step('attach file') do
  #       home.wait_until_contact_visible
  #       sleep(2)
  #       home.select_contact(@contacts[0])
  #       contact.wait_until_contact_card_visible
  #       contact.access_crm_list
  #       contact.select_opportunity(@opportunity1)
  #       # contact.edit_opportunity.link_upload_attach.click
  #       # contact.find('.fileinput-button > .icon-fontello-upload').click

  #       puts 'attach file'
  #       page.attach_file('.fileinput-button > .icon-fontello-upload', 'C:\Projects\automated-tests\R-app\rapp\spec\test_attach.docx')
  #     end
  #   end
  # end

  # describe('opportunity owner', :cc_oppo_owner)do
  
  #   it('display only opportunity what logged setup is an owner') do |e|
  #     puts 'WARNING: Need to has 2 CRM licenses provisioned on account'
  #     e.step('given when I allow CRM license to other setup')do
  #     home.goto_admin
  #     admin_dashboard.wait_until_btn_continue_visible
  #     admin_dashboard.btn_continue.click
  #     admin_dashboard.options.admin_setup.click
  #     # select setup and allow CRM feature
  #     users.select_user_in_grid($user2)
  #     users.crm_feature_enable
  #     sleep(5)
  #     users.wait_until_message_visible
  #     # validate if was allowed correctly
  #     expect(users.message.modal.text).to eql 'User updated successfully.'
  #     users.message.btn_ok.click
  #     users.wait_until_grid_rows_visible
  #     expect(users.grid_check_user_info($user2)).to eql true
  #     users.select_user_in_grid($user2)
  #     expect(users.details.checkbox_crm).to be_checked
  #     # return to home page
  #     admin_dashboard.goto_home
  #     end

  #   end
  # end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/delete_opportunity.sql")
    Capybara.current_session.driver.quit
  end
end
