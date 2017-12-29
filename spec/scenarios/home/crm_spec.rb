require_relative '../../pages/login'
require_relative '../../pages/home/home'
require_relative '../../pages/reset_password'
require_relative '../../pages/contact'

describe('CRM - Opportunity') do
  before(:all) do
    login_page.load
    login_page.do_login($marcelo_admin_user)
    home.wait_until_home_menu_visible
    home.wait_until_user_status_visible

    @contato1 = {
      name: 'Dev Marcelo 1 User'
    }
    @opportunity = {
      name: 'Big Opportunity',
      source: 'Website',
      status: 'Qualified',
      probability: '50',
      product: 'Test Product',
      price: '999999',
      action: 'Phone Call',
      follow_up: '01-02-2018',
      comment: 'Test Comment'

    }
  end

  describe('add opportunity', :add_opo) do
    it('access contact card and add a opportunity') do |e|
      e.step('when I on home page and access contact card') do
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
        home.wait_until_contact_visible
        sleep(5)
        home.select_contact(@contato1)
        contact.wait_until_contact_card_visible
        expect(contact.verify_contact(@contato1)) == true
      end
      e.step('and I select CRM menu and click to add') do
        contact.access_crm_list
      end
      e.step('then I filled opportunity information') do
        contact.add_opportunity(@opportunity)
      end
      e.step('Then I see the inserted message') do
        expect(contact.message.text).to eql 'Opportunity inserted.'
      end
      e.step('and I check if the opportunity is in grid') do
        expect(contact.validate_oppo_in_grid(@opportunity)) == true
        # contact.validate_oppo_in_grid(@opportunity)
        contact.select_opportunity(@opportunity)
        sleep(10)
      end
    end
    # it('access CRM and verify opportunities') do |e|

    # end
  end

  describe('validate opportunity grid', :crm_list) do
    it('access the oportunity list') do |e|
      e.step('When I on home page') do
        home.access_crm
      end
      e.step('ivalidate grid data') do
        expect(home.current_url).to end_with '/#!/app/crm'
        sleep(5)
      end
    end
  end
end
