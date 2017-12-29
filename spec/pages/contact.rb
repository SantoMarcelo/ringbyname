
require_relative '../sections/home/contact_card'

class Contact < SitePrism::Page
  element :txt_contact_name

  # element :contact_notes
  element :contact_crm, '.contact-card'
  element :message, 'div[class="noty_message"] > span'

  section :contact_card, Sections::ContactCard, '.contact-card'
  section :oppo_form, Sections::OpportunityForm, '.crm__form'

  def verify_contact(contact)
    self.wait_until_contact_card_visible
    true if self.contact_card.txt_contact_name.text.include?(contact[:name])
  end

  def access_crm_list
    find('div[class="ng-isolate-scope"] > ul > li[class^="crm-tab"]').click
    find('.crm-tab__add-button').click
  end

  def add_opportunity(opportunity)

    self.wait_until_oppo_form_visible
    sleep(1)
    self.oppo_form.txt_oppo_name.set('fixo')
    self.oppo_form.select_oppo_source.find('option', text: (opportunity[:source])).select_option
    self.oppo_form.select_oppo_status.find('option', text: (opportunity[:status])).select_option
    self.oppo_form.select_oppo_prob.find('option', text: (opportunity[:probability])).select_option
    
    self.oppo_form.txt_oppo_product.set(opportunity[:product])
    self.oppo_form.txt_oppo_price.set(opportunity[:price])

    self.oppo_form.select_oppo_next_action.find('option', text: (opportunity[:action])).select_option
    self.oppo_form.date_oppo_follow_up.set(opportunity[:follow_up])
    self.oppo_form.txt_oppo_comment.set(opportunity[:comment])

    self.oppo_form.btn_oppo_save.click
    
  end
    
  def validate_oppo_in_grid(opportunity)

    self.contact_card.contact_crm_list.each do |u|
      puts u.text
      if u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:price]) && u.text.include?(opportunity[:status])
      puts "OK"  
      end
      
    end

  end

end
