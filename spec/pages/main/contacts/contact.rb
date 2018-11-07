
require_relative '../../../sections/main/contacts/contact_card'
require_relative '../../../sections/main/contacts/features/notes/contact_notes'
require_relative '../../../helpers'
require_relative '../../../pages/main/activities/activity'


 
class Contact < Home
  # element :contact_notes
  element :contact_crm, '.contact-card'
  element :message, 'div[class="noty_message"] > span'
  element :add_opportunity, 'div[class="icons-base"] > div > div > a[data-target="#contact-card-tab-crm"] > i:last-child'
  element :icon_opportunity_list, 'li.crm-tab'
  
  element :scroll, '.ps__scrollbar-y'

  section :contact_feature_list, Sections::ContactFeatureList, '.contact-card-container .nav.nav-tabs'
  section :contact_features, Sections::ContactFeature, '.icons-base'
  section :contact_card, Sections::ContactCard, '.contact-card-container'
  section :contact_group, Sections::ContactGroups, '.contact-info'
  section :contact_form, Sections::ContactForm, '.contact-card'
  section :contact_info, Sections::ContactInfo, '.contact-card'
  section :contact_modal, Sections::ContactModal, '.modal-content'

  section :oppo_form, Sections::ContactOpportunityForm, '#contact-card-tab-crm'
  section :edit_opportunity, Sections::EditContactOpportunityForm, '.crm-card-container'
  section :opportunity_details, Sections::OpportunityDetails, '.crm-card-container'
  elements :contact_opportunity_list, '.crm__history > table > tbody > tr'
  elements :pagination, '.pagination > li[ng-repeat^="pageNumber"] > a'

  def verify_contact(contact)
    wait_until_contact_card_visible
    true if contact_card.txt_contact_name.text.include?(contact[:full_name])
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
    opportunity[:follow_up].to_s
    opportunity[:close_date].to_s
    oppo_form.txt_oppo_name.set(opportunity[:name])
    oppo_form.select_oppo_source.find('option', text: (opportunity[:source])).select_option
    oppo_form.select_oppo_status.find('option', text: (opportunity[:status])).select_option
    oppo_form.select_oppo_prob.find('option', text: (opportunity[:probability])).select_option
    oppo_form.select_oppo_prob.send_keys :tab
    oppo_form.txt_oppo_product.set(opportunity[:product])
    oppo_form.txt_oppo_product.send_keys :tab
    oppo_form.txt_oppo_price.set(opportunity[:price])
    oppo_form.txt_oppo_price.send_keys :tab
    oppo_form.select_oppo_next_action.find('option', text: (opportunity[:action])).select_option
    oppo_form.select_oppo_next_action.send_keys :tab
    oppo_form.date_oppo_follow_up(visible: false).set(opportunity[:follow_up])
    oppo_form.date_close_date(visible: false).set(opportunity[:close_date])
    oppo_form.txt_oppo_comment.set(opportunity[:comment])
    oppo_form.txt_oppo_comment.send_keys :tab
    
    oppo_form.btn_oppo_save.click
    
  end

  def validate_contact_opportunity_list(opportunity)
    contact_card.wait_until_opportunity_list_item_visible
    contact_card.contact_opportunity_list.each do |u|
      if u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:price]) && u.text.include?(opportunity[:status]) #&& u.text.include?(opportunity[:follow_up].gsub("-", "/")) && u.text.include?(opportunity[:close_date].gsub("-", "/"))
        return true
      end
    end
    false
  end

  def select_opportunity(opportunity)
    wait_until_contact_opportunity_list_visible
    contact_card.contact_opportunity_list.each do |u|
      if u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:price]) && u.text.include?(opportunity[:status])
        u.click
        break
      end
    end
    
  end

  def goto_page(number)
    pagination.each do |u|
      u.click if number > 1
    end
  end

  def validate_contact_group_list(group_name)
    contact_group.contact_group_list.each do |group|
      if group.text == group_name
        return true
      end
    end
    return false
  end

  def remove_contact_group(group_name)
    contact_group.contact_group_list.each do |group|
      contact_group.remove_contact_group.each do |remove_icon|
        remove_icon.click
      end
    end
  end
  
  def validate_selected_contact_group(group_name)
    contact.selected_current_filters.each do |group|
      if group.text.include?(group_name)
        return true
      end
    end
    return false
  end

  def remove_selected_group_filter(group_name)
    contact.selected_current_filters.each do |group|
      contact.remove_current_filters.each do |clear|
        if group.text.include?(group_name)
          clear.click
        end
      end
    end
  end

  def fill_contact_email(index, email, label = nil)
    if label != nil
      email_index = contact_form.select_contact_email_label.length
      email_index = email_index - 1
      contact_form.select_contact_email_label[email_index].find('option', text: label).select_option
    end
    contact_form.txt_contact_email[index].set(email)
  end

  def fill_contact_phones(index, phone, extension = nil, label = nil)
    contact_form.txt_contact_phones[index].set(phone)
    if label != nil
      index = index - 1
      contact_form.select_contact_phone_label[index].find('option', text: label).select_option
    end
    if extension != nil
      if index == 0 
        contact_form.txt_contact_phone_extension[index].set(extension) 
      else contact_form.txt_contact_phone_extension.length != 0 && contact_form.txt_contact_phone_extension.empty? != true
        index = contact_form.txt_contact_phone_extension.length - 1
        contact_form.txt_contact_phone_extension[index].set(extension)
      end
    end
  end

  def fill_contact_address(index, address, label = nil)
    contact_form.txt_contact_address[index].set(address)
    if label != nil
      index = index - 1
      contact_form.select_contact_adddress_label[index].find('option', text: label).select_option
    end
  end

  def fill_contact_weblinks(index, weblink, label = nil)
    contact_form.txt_contact_weblink[index].set(weblink)
    if label != nil
      index = index - 1
      contact_form.select_contact_weblink_label[index].find('option', text: label).select_option
    end
    
  end

  def validate_contact_info(contact_data)
    self.contact_info.contact_info_list.each do |info|
      if info.text.include?(contact_data)
        return true
      end
    end
    return false
  end

  def validate_contact_in_contact_list(contact)
    self.contact.contact_list.each do |u|
      if u.text.include?(contact[:first_name])
        return true
      end
    end
    return false
  end

  def validate_contact_activity(contact)
    activity = Activity.new
    activity.my_activity.activity_list.each do |activity|
      if activity.text.include?(contact[:first_name])
        return true
      end
    end
    return false
  end

  def insert_contact(admin_user)

    user = { 'data' => {
      'username' => admin_user[:username],
      'password' => admin_user[:password],
      'stay_sign_in' => 0,
      'timezone' => 'America/Sao_Paulo'
    } }
    headers = {
      'X-Application-Id' => 'webapp',
      'X-Version' => 'v2'
    }

    @response = HTTParty.post(
      "http://api.#{$environment}-php56.dev.ringbyname.com/auth?",
      body: user.to_json,
      headers: headers
    )
    
    session_id = @response.parsed_response['data']['session_id']

    headers = {
      'X-Application-Id' => 'webapp',
      'X-Version' => 'v2',
      'X-Session-Id' => session_id    
    }
    
    contact = {"data"=>{
      "name"=>{"first_name"=>"Test","last_name"=>"Auto Contact"},
      "company"=>"Inphonex",
      "groups"=>[],
      "addresses"=>[{"label"=>"Work","value"=>{"address"=>"7206 NW 31st ST, Miami, FL 33122 US"}},
                   {"label"=>"Personal","value"=>{"address"=>"7998 NW 35st ST, Miami, FL 33122 US"}}],
      "emails"=>[{"label"=>"Work","value"=>"work_email@ringbyname.com"},
                {"label"=>"Personal","value"=>"personal_email@ringbyname.com"}],
      "phones"=>[{"label"=>"Main","value"=>"9876543210","extension"=>"1001"},
                {"label"=>"Fax","value"=>"9876543211"},
                {"label"=>"Home","value"=>"7410852963"},
                {"label"=>"Mobile","value"=>"8520147963"},
                {"label"=>"Work","value"=>"9632587410","extension"=>"1002"}],
      "weblinks"=>[{"label"=>"Work","value"=>"work_weblink.com.br"},
                  {"label"=>"Facebook","value"=>"Facebook_weblink.com.br"},
                  {"label"=>"Linkedin","value"=>"LinkedIN_weblink.com.br"},
                  {"label"=>"Twitter","value"=>"Twitter_weblink.com.br"},
                  {"label"=>"Personal","value"=>"Personal_weblink.com.br"},
                  {"label"=>"Other","value"=>"Other_weblink.com.br"}]}
      }
    
      @contact_response = HTTParty.post(
      "http://api.#{$environment}-php56.dev.ringbyname.com/contact",
      headers: headers,
      body: contact.to_json
    )
    
   
  end

  def remove_extra_emails
    contact_form.icon_remove_contact_email.each do |icon|
      icon.click
    end
  end
  
  def remove_extra_phones
    contact_form.icon_remove_contact_phone.each do |icon|
    index =  contact_form.icon_remove_contact_phone.index(icon)
    contact_form.icon_remove_contact_phone[index].click
    end
  end

  def remove_extra_address
    contact_form.icon_remove_contact_address.each do |icon|
      icon.click
    end
  end
  
  def remove_extra_weblink
    contact_form.icon_remove_contact_weblink.each do |icon|
      icon.click
    end
  end

end


