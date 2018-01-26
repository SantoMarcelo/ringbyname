require_relative '../../../pages/login/login'
require_relative '../../../pages/main/home'
require_relative '../../../pages/main/crm/crm_mini_app'
require_relative '../../../pages/login/reset_password'
require_relative '../../../pages/contact'
require_relative '../../../pages/admin/dashboard/dashboard'

describe('CRM - Opportunity', :cc_general_crm) do
  before do
    Capybara.page.driver.browser.manage.window.maximize
    login_page.load
    login_page.do_login($admin_user)
    home.wait_until_home_menu_visible
    home.wait_until_user_status_visible

    @opportunity = {
      name: 'Big Opportunity',
      source: 'Website',
      status: 'Qualified',
      probability: '50%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '12-01-2018',
      close_date: '05-01-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }

    @edited_opportunity = {
      name: 'Big OpportunityEDITED',
      source: 'Social Media Site',
      status: 'Dead',
      probability: '100%',
      product: 'Test ProductEDITED',
      price: '$8,888.88',
      action: 'Email',
      follow_up: '10-02-2018',
      close_date: '10-01-2018',
      comment: 'Test Comment EDITED',
      contact_owner: 'Dev Marcelo 1 User'

    }

    @opportunity1 = {
      name: 'Big Opportunity 1',
      source: 'Social Media Site',
      status: 'Attempted',
      probability: '50%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-01-2018',
      close_date: '05-01-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity2 = {
      name: 'Small Oppo 2',
      source: 'Website',
      status: 'Contacted',
      probability: '25%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-02-2018',
      close_date: '05-02-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity3 = {
      name: 'Old opport 3',
      source: 'Word of Mouth',
      status: 'Qualified',
      probability: '75%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-03-2018',
      close_date: '05-03-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity4 = {
      name: 'New Opportunity 4',
      source: 'Referral',
      status: 'Unqualified',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-04-2018',
      close_date: '05-04-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity5 = {
      name: 'Gold Opportunity 5',
      source: 'Advertisement',
      status: 'Dead',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-05-2018',
      close_date: '05-05-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity6 = {
      name: 'china business 6',
      source: 'Advertisement',
      status: 'Quoted',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-06-2018',
      close_date: '05-06-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity7 = {
      name: 'Gold Opportunity 7',
      source: 'Advertisement',
      status: 'Negotiating',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-07-2018',
      close_date: '05-07-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity8 = {
      name: 'Gold Opportunity 8',
      source: 'Advertisement',
      status: 'Closed Won',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-08-2018',
      close_date: '05-08-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity9 = {
      name: 'Gold Opportunity 9',
      source: 'Advertisement',
      status: 'Closed Lost',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-09-2018',
      close_date: '05-09-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity10 = {
      name: 'Gold Opportunity 10',
      source: 'Advertisement',
      status: 'Negotiating',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-10-2018',
      close_date: '05-10-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity11 = {
      name: 'Gold Opportunity 11',
      source: 'Advertisement',
      status: 'Negotiating',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-11-2018',
      close_date: '05-11-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity12 = {
      name: 'Gold Opportunity 12',
      source: 'Advertisement',
      status: 'Negotiating',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-12-2018',
      close_date: '05-12-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity13 = {
      name: 'Gold Opportunity 13',
      source: 'Advertisement',
      status: 'Negotiating',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-13-2018',
      close_date: '05-13-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity14 = {
      name: 'Gold Opportunity 14',
      source: 'Advertisement',
      status: 'Negotiating',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '06-14-2018',
      close_date: '05-14-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
    @opportunity15 = {
      name: 'Gold Opportunity 15',
      source: 'Advertisement',
      status: 'Negotiating',
      probability: '100%',
      product: 'Test Product',
      price: '$9,999.99',
      action: 'Phone Call',
      follow_up: '01-02-2018',
      close_date: '05-15-2018',
      comment: 'Test Comment',
      contact_owner: 'Dev Marcelo 1 User'
    }
  end

  describe('add opportunity', :cc_add_contact_opo) do
    it('access contact card and add a opportunity') do |e|
      puts 'access contact card and add a opportunity'
      e.step('Given when I has CRM license allowed') do
        puts 'Given when I has CRM license allowed'
        # access admin page
        users.user_allow_crm_feature($user1)
        # validate if was allowed correctly
        expect(users.message.modal.text).to eql 'User updated successfully.'
        users.message.btn_ok.click
        users.wait_until_grid_rows_visible
        expect(users.grid_rows.include?(users.grid_icon_crm))
        users.select_user_in_grid($user1)
        expect(users.details.checkbox_crm).to be_checked
        # return to home page
        admin_dashboard.goto_home
      end
      e.step('when I on home page and access contact card') do
        puts 'when I on home page and access contact card'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
        home.select_contact($contact1)
        contact.wait_until_contact_card_visible
        expect(contact.verify_contact($contact1)) == true
      end
      e.step('and I select CRM menu and click to add') do
        puts 'and I select CRM menu and click to add'
        contact.access_crm
        # find('.crm-tab__add-button').click
      end
      e.step('then I filled opportunity information') do
        puts 'then I filled opportunity information'
        contact.fill_opportunity_data(@opportunity)
      end
      e.step('Then I see the inserted message') do
        puts 'Then I see the inserted message'
        expect(contact.message.text).to eql 'Opportunity inserted.'
      end
      e.step('and I check if the opportunity is in grid') do
        puts 'and I check if the opportunity is in grid'
        expect(contact.validate_contact_opportunity_list(@opportunity)).to eql true
      end
      e.step('and access CRM and verify opportunities') do
        puts 'and access CRM and verify opportunities'
        puts 'acessando crm'
        home.access_crm
        crm.wait_until_opportunity_list_visible
        expect(home.current_url).to end_with '/#!/app/crm'
        expect(crm.validate_opportunity_list(@opportunity)).to eql true
      end
    end
    # it('verify validations when insert opportunity') do |e|
    #   e.step('given when I on contactr card page') do
    #     home.wait_until_contact_visible
    #     sleep(2)
    #     home.select_contact($contact1)
    #     contact.wait_until_contact_card_visible
    #   end
    #   e.step('and I add a oportunity') do
    #     contact.access_crm
    #   end
    #   e.step('when I try to inser opportunity without name') do
    #    puts 'when I try to inser opportunity without name'
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab

    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #     expect(contact.message.text).to eql 'Please provide the opportunity name.'
    #   end
    #   e.step('when I try to inser opportunity without source') do
    #     puts 'when I try to inser opportunity without source'
    #     sleep(5)
    #     contact.oppo_form.txt_oppo_name.set 'Oportunity Validations'
       
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab
       
    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #     expect(contact.message.text).to eql 'Invalid opportunity source.'
    #   end
    #   e.step('when I try to inser opportunity without status') do
    #     puts 'when I try to inser opportunity without status'
    #     sleep(5)
    #     contact.oppo_form.select_oppo_source.find('option', text: 'Website').select_option
       
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab
       
    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #         expect(contact.message.text).to eql 'Please provide a valid status.'
    #   end
    #   e.step('when I try to inser opportunity without probability') do
    #     puts 'when I try to inser opportunity without probability'
    #     sleep(5)
    #     contact.oppo_form.select_oppo_status.find('option', text: 'Qualified').select_option
       
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab
       
    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #     expect(contact.message.text).to eql 'Please provide a valid probability.'
    #   end
    #   e.step('when I try to inser opportunity without next action') do
    #     puts 'when I try to inser opportunity without next action'
    #     sleep(5)
    #     contact.oppo_form.select_oppo_prob.find('option', text: '50%').select_option
       
    #     contact.oppo_form.select_oppo_next_action.send_keys :tab
    #     contact.oppo_form.date_oppo_follow_up.send_keys :tab
    #     contact.oppo_form.date_close_date.send_keys :tab
    #     contact.oppo_form.txt_oppo_comment.send_keys :tab
       
    #     contact.oppo_form.btn_oppo_save.click
    #   end
    #   e.step('then I see a validation message') do
    #     expect(contact.message.text).to eql 'Please provide a valid next action.'
    #   end
    # end
  end

  describe('edit opportunity', :cc_edit_oppo) do
    it('edit opportunity by contact card') do |e|
      puts 'edit opportunity by contact card'
      e.step('Given I on home page and access contact card') do
        puts 'Given I on home page and access contact card'
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(2)
        home.select_contact($contact1)
        contact.wait_until_contact_card_visible
        expect(contact.verify_contact($contact1)) == true
      end
      e.step('and I access CRM menu') do
        puts 'and I access CRM menu'
        contact.access_crm_list
      end
      e.step('when I select a opportunity to edit') do
        puts 'when I select a opportunity to edit'
        contact.select_opportunity(@opportunity)
      end
      e.step('and I edit a opportunity') do
        puts 'and I edit a opportunity'
        sleep(3)
        contact.edit_fill_opportunity_data(@edited_opportunity)
      end
      e.step('then I see the success message') do
        puts 'then I see the success message'
        expect(contact.message.text).to eql 'Opportunity updated.'
      end
      e.step('and I check if was updated correctly') do
        puts 'and I check if was updated correctly'
        contact.wait_until_contact_opportunity_list_visible
        sleep(2)
        contact.select_opportunity(@edited_opportunity)
        contact.wait_until_edit_oppo_form_visible
        expect(contact.edit_oppo_form.txt_oppo_name.text.include?(@edited_opportunity[:name]))
        expect(contact.edit_oppo_form.select_oppo_source.text.include?(@edited_opportunity[:source]))
        expect(contact.edit_oppo_form.select_oppo_status.text.include?(@edited_opportunity[:status]))
        expect(contact.edit_oppo_form.select_oppo_prob.text.include?(@edited_opportunity[:probability]))
        expect(contact.edit_oppo_form.txt_oppo_product.text.include?(@edited_opportunity[:product]))
        expect(contact.edit_oppo_form.txt_oppo_price.text.include?(@edited_opportunity[:price]))
        expect(contact.edit_oppo_form.select_oppo_next_action.text.include?(@edited_opportunity[:action]))
        expect(contact.edit_oppo_form.date_oppo_follow_up.text.include?(@edited_opportunity[:follow_up]))
        expect(contact.edit_oppo_form.date_close_date.text.include?(@edited_opportunity[:close_date]))
        expect(contact.edit_oppo_form.txt_oppo_comment.text.include?(@edited_opportunity[:comment]))

        contact.edit_oppo_form.btn_oppo_cancel.click
      end
    end
  end

  describe('opportunity pagination', :cc_crm_pagination) do
    it('validate contact card opportunity pagination', :cc_contact_card_pagination) do |e|
      e.step('given when I on contact card') do
        home.wait_until_contact_visible
        sleep(2)
        home.select_contact($contact1)
        contact.wait_until_contact_card_visible
      end
      e.step('and I access oportunity list') do
        contact.access_crm_list
        contact.wait_until_contact_opportunity_list_visible
        contact.icon_opportunity_list.send_keys :tab
      end
      e.step('when I change the opportunity page') do
        contact.wait_until_pagination_visible
        crm.goto_page(2)
        sleep(2)
      end
      e.step('then I can see the most older opportunity') do
        contact.wait_until_contact_opportunity_list_visible
        expect(contact.validate_contact_opportunity_list(@opportunity10)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity11)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity12)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity13)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity14)).to eql true
        expect(contact.validate_contact_opportunity_list(@opportunity15)).to eql true
      end
    end
  end

  # describe('upload attachments', :cc_upload_attachment) do
  #   it('attache file when create a opportunity') do |e|
  #     e.step('attach file') do
  #       home.wait_until_contact_visible
  #       sleep(2)
  #       home.select_contact($contact1)
  #       contact.wait_until_contact_card_visible
  #       contact.access_crm_list
  #       contact.select_opportunity(@opportunity1)
  #       # contact.edit_oppo_form.link_upload_attach.click
  #       # contact.find('.fileinput-button > .icon-fontello-upload').click

  #       puts 'attach file'
  #       page.attach_file('.fileinput-button > .icon-fontello-upload', 'C:\Projects\automated-tests\R-app\rapp\spec\test_attach.docx')
  #     end
  #   end
  # end

  # describe('opportunity owner', :cc_oppo_owner)do
  
  #   it('display only opportunity what logged user is an owner') do |e|
  #     puts 'WARNING: Need to has 2 CRM licenses provisioned on account'
  #     e.step('given when I allow CRM license to other user')do
  #     home.goto_admin
  #     admin_dashboard.wait_until_btn_continue_visible
  #     admin_dashboard.btn_continue.click
  #     admin_dashboard.options.admin_setup.click
  #     # select user and allow CRM feature
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
    Capybara.current_session.driver.quit
  end
end
