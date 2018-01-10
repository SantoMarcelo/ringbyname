require_relative '../../pages/login'
require_relative '../../pages/home/home'
require_relative '../../pages/home/crm_mini_app'
require_relative '../../pages/reset_password'
require_relative '../../pages/contact'
require_relative '../../pages/admin/dashboard'

describe('CRM - Opportunity', :general_crm) do
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
      follow_up: '01-02-2018',
      close_date: '05-01-2015',
      comment: 'Test Comment'
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
      close_date: '10-01-2015',
      comment: 'Test Comment EDITED'

    }
  end

  describe('add opportunity', :add_contact_opo) do
    it('access contact card and add a opportunity') do |e|
      puts 'access contact card and add a opportunity'
      e.step('Given when I has CRM license allowed') do
        puts 'Given when I has CRM license allowed'
        # access admin page
        home.goto_admin
        admin_dashboard.wait_until_btn_continue_visible
        admin_dashboard.btn_continue.click
        admin_dashboard.options.admin_setup.click
        # select user and allow CRM feature
        users.select_user_in_grid($user1)
        users.crm_feature_enable
        users.wait_until_message_visible
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
        contact.access_crm_list
        find('.crm-tab__add-button').click
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
      e.step('access CRM and verify opportunities') do
        puts 'access CRM and verify opportunities'
        home.access_crm
        home.wait_until_opportunity_list_visible
        expect(home.current_url).to end_with '/#!/app/crm'
        expect(home.validate_opportunity_list(@opportunity)).to eql true
      end
    end
  end

  describe('edit opportunity', :edit_oppo) do
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
        contact.fill_opportunity_data(@edited_opportunity)
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
        contact.wait_until_oppo_form_visible
        expect(contact.oppo_form.txt_oppo_name.text.include?(@edited_opportunity[:name]))
        expect(contact.oppo_form.select_oppo_source.text.include?(@edited_opportunity[:source]))
        expect(contact.oppo_form.select_oppo_status.text.include?(@edited_opportunity[:status]))
        expect(contact.oppo_form.select_oppo_prob.text.include?(@edited_opportunity[:probability]))
        expect(contact.oppo_form.txt_oppo_product.text.include?(@edited_opportunity[:product]))
        expect(contact.oppo_form.txt_oppo_price.text.include?(@edited_opportunity[:price]))
        expect(contact.oppo_form.select_oppo_next_action.text.include?(@edited_opportunity[:action]))
        expect(contact.oppo_form.date_oppo_follow_up.text.include?(@edited_opportunity[:follow_up]))
        expect(contact.oppo_form.date_close_date.text.include?(@edited_opportunity[:close_date]))
        expect(contact.oppo_form.txt_oppo_comment.text.include?(@edited_opportunity[:comment]))

        contact.oppo_form.btn_oppo_cancel.click
      end
    end
    it('edit opportunity by CRM mini app', :edit_oppo_miniapp) do |e|
      puts 'edit opportunity by CRM mini app'
      e.step('Given when I on home page and access CRM mini app') do
        puts 'Given when I on home page and access CRM mini app'
        home.access_crm
        # home.wait_until_opportunity_list_visible
        expect(home.current_url).to end_with '/#!/app/crm'
      end
      e.step('and I select a oportunity to edit') do
        puts 'and I select a oportunity to edit'
        crm.select_opportunity(@edited_opportunity)
      end
      e.step('when I edit an opportunity') do
        puts 'when I edit an opportunity'
        crm.fill_opportunity_data(@opportunity)
      end
      e.step('then I check if was updated correctly ') do
        puts 'then I check if was updated correctly '
        expect(home.message.text).to eql 'Opportunity updated.'
        crm.wait_until_opportunity_list_visible
        puts 'validate list'
        sleep(2)
        crm.validate_opportunity_list(@opportunity)
        puts 'select opportunity'
        crm.select_opportunity(@opportunity)
        puts 'validate form data...'
        crm.wait_until_oppo_form_visible
        expect(crm.oppo_form.txt_oppo_name.text.include?(@opportunity[:name]))
        expect(crm.oppo_form.select_oppo_source.text.include?(@opportunity[:source]))
        expect(crm.oppo_form.select_oppo_status.text.include?(@opportunity[:status]))
        expect(crm.oppo_form.select_oppo_prob.text.include?(@opportunity[:probability]))
        expect(crm.oppo_form.txt_oppo_product.text.include?(@opportunity[:product]))
        expect(crm.oppo_form.txt_oppo_price.text.include?(@opportunity[:price]))
        expect(crm.oppo_form.select_oppo_next_action.text.include?(@opportunity[:action]))
        expect(crm.oppo_form.date_oppo_follow_up.text.include?(@opportunity[:follow_up]))
        expect(crm.oppo_form.date_close_date.text.include?(@opportunity[:close_date]))
        expect(crm.oppo_form.txt_oppo_comment.text.include?(@opportunity[:comment]))

        crm.oppo_form.btn_oppo_cancel.click
      end
    end
  end
  # describe('search opportunit in mini app', :search_oppo) do
  #   it('seacrch by opportunity name') do |e|
  #     puts 'seacrch by opportunity name'
  #     e.step('given I have five different opportunities') do
  #       @opportunity1 = {
  #         name: 'Big Opportunity 1',
  #         source: 'Social Media Site',
  #         status: 'Qualified',
  #         probability: '50%',
  #         product: 'Test Product',
  #         price: '$9,999.99',
  #         action: 'Phone Call',
  #         follow_up: '01-02-2018',
  #         close_date: '05-01-2015',
  #         comment: 'Test Comment'
  #       }
  #       @opportunity2 = {
  #         name: 'Small Oppo 2',
  #         source: 'Website',
  #         status: 'Attempted',
  #         probability: '25%',
  #         product: 'Test Product',
  #         price: '$9,999.99',
  #         action: 'Phone Call',
  #         follow_up: '01-02-2018',
  #         close_date: '05-01-2015',
  #         comment: 'Test Comment'
  #       }
  #       @opportunity3 = {
  #         name: 'Old opport 3',
  #         source: 'Word of Mouth',
  #         status: 'Qualified',
  #         probability: '75%',
  #         product: 'Test Product',
  #         price: '$9,999.99',
  #         action: 'Phone Call',
  #         follow_up: '01-02-2018',
  #         close_date: '05-01-2015',
  #         comment: 'Test Comment'
  #       }
  #       @opportunity4 = {
  #         name: 'New Opportunity 4',
  #         source: 'Referral',
  #         status: 'Qualified',
  #         probability: '100%',
  #         product: 'Test Product',
  #         price: '$9,999.99',
  #         action: 'Phone Call',
  #         follow_up: '01-02-2018',
  #         close_date: '05-01-2015',
  #         comment: 'Test Comment'
  #       }
  #       @opportunity5 = {
  #         name: 'Gold Opportunity 5',
  #         source: 'Advertisement',
  #         status: 'Qualified',
  #         probability: '100%',
  #         product: 'Test Product',
  #         price: '$9,999.99',
  #         action: 'Phone Call',
  #         follow_up: '01-02-2018',
  #         close_date: '05-01-2015',
  #         comment: 'Test Comment'
  #       }
  #       #generate opportunity
  #       crm.create_opportunity(@opportunity1)
  #     end
  #     # e.step('when I search by name') do

  #     # end
  #     # e.step('then I can see only the searched opportunity') do

  #     # end
  #   end
  #   # it('search opportunity by status') do |_e|
  #   #   puts 'search opportunity by status'
  #   # end
  #end

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end
end
