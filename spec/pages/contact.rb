
require_relative '../sections/home/contact_card'

class Contact < SitePrism::Page
  element :txt_contact_name

  # element :contact_notes
  element :contact_crm, '.contact-card'
  element :message, 'div[class="noty_message"] > span'

  section :contact_card, Sections::ContactCard, '.contact-card'
  section :oppo_form, Sections::ContactOpportunityForm, '.modal-content'

  elements :contact_opportunity_list, '.crm__history > table > tbody > tr'

  def verify_contact(contact)
    wait_until_contact_card_visible
    true if contact_card.txt_contact_name.text.include?(contact[:name])
  end

  def access_crm_list
    find('div[class="ng-isolate-scope"] > ul > li[class^="crm-tab"]').click
  end

  def fill_opportunity_data(opportunity)
    wait_until_oppo_form_visible
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

  def validate_contact_opportunity_list(opportunity)
    puts 'validando...'
    wait_until_contact_opportunity_list_visible
    contact_card.contact_opportunity_list.each do |u|
      puts u.text
      if u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:price]) && u.text.include?(opportunity[:status])
        puts 'true'
        return true
      end
    end
    puts 'false'
    false
  end

  def select_opportunity(opportunity)
    puts 'procurando...'
    wait_until_contact_opportunity_list_visible
  
    contact_card.contact_opportunity_list.each do |u|
      puts u.text

      if u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:price]) && u.text.include?(opportunity[:status])
        u.click
        break
      end
    end
    
  end
end
