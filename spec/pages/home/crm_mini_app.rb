
require_relative '../../sections/home/menu'
require_relative '../../sections/home/home'
require_relative '../../sections/home/contact_card'
require_relative '../../pages/login'
require_relative '../../pages/contact'
require_relative '../../pages/home/home'
require_relative '../../pages/admin/dashboard'

class CrmMiniApp < SitePrism::Page
  section :home_menu, Sections::MainMenu, '.nav-middle-top'
  section :contact, Sections::Contact, '#contact-list'
  section :oppo_form, Sections::MiniAppOpportunityForm, '.modal-content'
  section :crm, Sections::CRM, '.crm-card-search-bar'

  elements :opportunity_list, '.crm-card-list > div > table > tbody > tr'
  element :label_current_filter, 'div > p > strong.ng-binding'

  element :message, 'div[class="noty_message"] > span'

  def access_crm
    home_menu.crm.click
  end

  def select_contact(contact)
    wait_until_contact_visible
    sleep(3)
    self.contact.contact_list.each do |u|
      if u.text.include?(contact[:name])
        u.click
        break
      end
    end
  end

  def validate_opportunity_list(opportunity)
    puts opportunity[:contact_owner]
    puts opportunity[:name]
    puts opportunity[:status]
    puts opportunity[:price]
    puts opportunity[:probability]

    wait_until_opportunity_list_visible
    opportunity_list.each do |u|
      puts u.text
      if u.text.include?(opportunity[:contact_owner]) && u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:status]) && u.text.include?(opportunity[:price]) && u.text.include?(opportunity[:probability])
        puts 'true'
        return true
      end
    end
    puts 'false'
    false
  end

  def fill_opportunity_data(opportunity)
    # wait_until_oppo_form_visible
    sleep(1)

    oppo_form.date_close_date.set(opportunity[:close_date])
    oppo_form.txt_oppo_name.set(opportunity[:name])
    oppo_form.date_oppo_follow_up.set(opportunity[:follow_up])

    oppo_form.select_oppo_source.find('option', text: (opportunity[:source])).select_option
    oppo_form.select_oppo_status.find('option', text: (opportunity[:status])).select_option
    oppo_form.select_oppo_prob.find('option', text: (opportunity[:probability])).select_option

    oppo_form.txt_oppo_product.set(opportunity[:product])
    oppo_form.txt_oppo_price.set(opportunity[:price])

    oppo_form.select_oppo_next_action.find('option', text: (opportunity[:action])).select_option
    oppo_form.txt_oppo_comment.set(opportunity[:comment])

    oppo_form.btn_oppo_save.click
  end

  def select_opportunity(opportunity)
    puts 'procurando...'
    wait_until_opportunity_list_visible

    opportunity_list.each do |u|
      puts u.text

      if u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:price]) && u.text.include?(opportunity[:status])
        u.click
        break
      end
    end
  end

  def create_opportunity(opportunity)
    contact = Contact.new
    sleep(1)
    contact.add_opportunity.click
    contact.fill_opportunity_data(opportunity)
  end
end
