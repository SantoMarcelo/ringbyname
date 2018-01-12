
require_relative '../sections/home/contact_card'

class Contact < SitePrism::Page
  element :txt_contact_name

  # element :contact_notes
  element :contact_crm, '.contact-card'
  element :message, 'div[class="noty_message"] > span'
  element :add_opportunity, 'div[class="icons-base"] > div > div > a[data-target="#contact-card-tab-crm"] > i:last-child'
  element :icon_opportunity_list, 'li.crm-tab'

  section :contact_card, Sections::ContactCard, '.contact-card'
  section :oppo_form, Sections::ContactOpportunityForm, '#contact-card-tab-crm'
  section :edit_oppo_form, Sections::EditContactOpportunityForm, '.modal-content'
  
  elements :contact_opportunity_list, '.crm__history > table > tbody > tr'

  def verify_contact(contact)
    wait_until_contact_card_visible
    true if contact_card.txt_contact_name.text.include?(contact[:name])
  end

  def access_crm
    self.add_opportunity.click
  end

  def access_crm_list
    self.icon_opportunity_list.click
  end

  def fill_opportunity_data(opportunity)
    wait_until_oppo_form_visible
    sleep(1)

    oppo_form.txt_oppo_name.set(opportunity[:name])
    oppo_form.select_oppo_source.find('option', text: (opportunity[:source])).select_option
    oppo_form.select_oppo_status.find('option', text: (opportunity[:status])).select_option
    oppo_form.select_oppo_prob.find('option', text: (opportunity[:probability])).select_option
    oppo_form.txt_oppo_product.set(opportunity[:product])
    oppo_form.txt_oppo_price.set(opportunity[:price])
    oppo_form.txt_oppo_price.send_keys :tab
    oppo_form.select_oppo_next_action.find('option', text: (opportunity[:action])).select_option
    oppo_form.select_oppo_next_action.send_keys :tab
    oppo_form.date_oppo_follow_up.set(opportunity[:follow_up])
    oppo_form.date_oppo_follow_up.send_keys :tab
    oppo_form.date_close_date.set(opportunity[:close_date])
    oppo_form.date_close_date.send_keys :tab
    oppo_form.txt_oppo_comment.set(opportunity[:comment])
    oppo_form.txt_oppo_comment.send_keys :tab
    
    oppo_form.btn_oppo_save.click
    
  end

  def edit_fill_opportunity_data(opportunity)
    wait_until_edit_oppo_form_visible
    sleep(1)

    edit_oppo_form.txt_oppo_name.set(opportunity[:name])
    edit_oppo_form.select_oppo_source.find('option', text: (opportunity[:source])).select_option
     edit_oppo_form.select_oppo_status.find('option', text: (opportunity[:status])).select_option
     edit_oppo_form.select_oppo_prob.find('option', text: (opportunity[:probability])).select_option
     edit_oppo_form.txt_oppo_product.set(opportunity[:product])
     edit_oppo_form.txt_oppo_price.set(opportunity[:price])
     edit_oppo_form.txt_oppo_price.send_keys :tab
     edit_oppo_form.select_oppo_next_action.find('option', text: (opportunity[:action])).select_option
     edit_oppo_form.select_oppo_next_action.send_keys :tab
     edit_oppo_form.date_oppo_follow_up.set(opportunity[:follow_up])
     edit_oppo_form.date_oppo_follow_up.send_keys :tab
     edit_oppo_form.date_close_date.set(opportunity[:close_date])
     edit_oppo_form.date_close_date.send_keys :tab
     edit_oppo_form.txt_oppo_comment.set(opportunity[:comment])
     edit_oppo_form.txt_oppo_comment.send_keys :tab
     
     edit_oppo_form.btn_oppo_save.click

  end

  def validate_contact_opportunity_list(opportunity)
    puts 'validando...'
    self.access_crm_list
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
