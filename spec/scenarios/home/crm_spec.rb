require_relative '../../pages/login'
require_relative '../../pages/home/home'
require_relative '../../pages/reset_password'
require_relative '../../pages/contact'
require_relative '../../pages/admin/dashboard'

describe('CRM - Opportunity', :general_crm) do
  before do
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
      probability: '50%',
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
      Capybara.current_session.driver.quit
    end
    it('access CRM and verify opportunities') do |e|
      puts 'access CRM and verify opportunities'
      e.step('When I on home page') do
        puts 'When I on home page'
        home.access_crm
        home.wait_until_opportunity_list_visible
      end
      e.step('I validate grid data') do
        puts 'I validate grid data'
        expect(home.current_url).to end_with '/#!/app/crm'
        expect(home.validate_oppo_list(@opportunity)).to eql true
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
        contact.wait_until_contact_opportunity_list_visible
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
  end
end
