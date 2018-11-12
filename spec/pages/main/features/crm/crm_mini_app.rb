
require_relative '../../../../sections/main/menu'
require_relative '../../../../sections/main/features/crm/crm_mini_app'
require_relative '../../../../sections/main/contacts/contact_card'
require_relative '../../../../pages/login/login'
require_relative '../../../../pages/main/contacts/contact'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/admin/dashboard/dashboard'
require_relative '../../../../config'
 
class CrmMiniApp < SitePrism::Page 
  section :home_features, Sections::FeaturesMenu, '.nav-middle-top'
  section :contact, Sections::Contact, '#contact-list'
  section :oppo_form, Sections::OpportunityEdit, '.crm-card-container'
  section :oppo_details, Sections::OpportunitDetails, '.crm-card-container'
  section :crm_container, Sections::CrmFeature, '.crm-card-container'
  element :message, 'div[class="noty_message"] > span'

  def access_crm
    home_features.crm.click
  end

  def select_contact(contact)
    wait_until_contact_visible
    sleep(3)
    self.contact.contact_list.each do |u|
      if u.text.include?(contact[:full_name])
        u.click
        break
      end
    end
  end

  def validate_list_ordenation(opportunity, order)
    # need to validate close date in this step: && u.text.include?(opportunity[:close_date])
    if crm_container.opportunity_list[order].text.include?(opportunity[:contact_owner]) &&
       crm_container.opportunity_list[order].text.include?(opportunity[:name]) &&
       crm_container.opportunity_list[order].text.include?(opportunity[:status]) &&
       crm_container.opportunity_list[order].text.include?(opportunity[:price])
      return true
    end
    return false
  end

  def validate_opportunity_list(opportunity)
   # need to validate close date in this step: && u.text.include?(opportunity[:close_date])
    crm_container.wait_for_opportunity_list
   crm_container.opportunity_list.each do |u|
      if u.text.include?(opportunity[:contact_owner]) && u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:status]) && u.text.include?(opportunity[:price]) #&& u.text.include?(opportunity[:close_date].gsub("-", "/"))  && u.text.include?(opportunity[:follow_up].gsub("-", "/"))
        return true
      end
    end
    false
  end

  def select_opportunity(opportunity)
    crm_container.wait_for_opportunity_list
    crm_container.opportunity_list.each do |u|
        if u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:price]) && u.text.include?(opportunity[:status])
          u.click
        break
      end
    end
  end

  def create_opportunity(opportunity)
    contact = Contact.new
    sleep(2)
    contact.add_opportunity.click
    contact.fill_opportunity_data(opportunity)
  end

  def goto_page(number)
    crm_container.pagination.each do |u|
      u.click if u.text.eql?(number.to_s)
    end
  end

  def insert_opportunity(admin_user, quantity)

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
    user_id = @response.parsed_response['data']['user']['id']
    session_id = @response.parsed_response['data']['session_id']

    headers = {
      'X-Application-Id' => 'webapp',
      'X-Version' => 'v2',
      'X-Session-Id' => session_id,
      '&search' => 'is_enabled:1'
    }

    @opportunity_source = HTTParty.get(
      "http://api.#{$environment}-php56.dev.ringbyname.com/crm-opportunity/source?",
      headers: headers 
    )
    @opportunity_source_index = @opportunity_source.parsed_response['data']['rows'][0]['id']
    @opportunity_source_max_index = @opportunity_source.parsed_response['data']['rows'].length
    #puts @opportunity_source_index

    i=1
    source_id = @opportunity_source_index
    status_id = 1
    probability_id = 1
    action_id = 1

    # puts $environment
    # if $environment == 'uat' || $environment == 'marcelo'
    #   source_id = 82
    # end

    
    quantity.times do
        date = Date.today
        opportunity = {  "data" => {  
               "name" => "Test Opportunity #{i}",
               "contact" => {  
                  "id" => admin_user[:contact_id]
               },
               "date_follow_up" => date +=i+2 ,
               "date_close" => date +=i,
               "product" => "Test Product #{i}",
               "cost" => "#{i}99.99",
               "comments" => "test test test test teste test test test test teste test test test test teste test test test test teste test test test test teste",
               "source" => {  
                  "id" => source_id
               },
               "status" => {  
                  "id" => status_id
               },
               "probability" => {  
                  "id"=> probability_id
               },
               "action"=>{  
                  "id"=>action_id
               }
            }
        }
        headers = {
            'X-Application-Id' => 'webapp',
            'X-Version' => 'v2',
            'X-Session-Id' => session_id
        }
        @opportunity = HTTParty.post(
            "http://api.#{$environment}-php56.dev.ringbyname.com/crm-opportunity?",
            body: opportunity.to_json,
            headers: headers
        )
        
        #puts opportunity.to_json
        #puts "###Request"
        #puts @opportunity

        source_id +=1
        status_id +=1
        probability_id +=1
        action_id +=1

        
        if source_id > @opportunity_source_max_index
          source_id = @opportunity_source_index
        end
        if status_id > 9
            status_id =1
        end
        if probability_id > 4
            probability_id =1
        end
        if action_id > 7
            action_id =1
        end
        i +=1
        
    end

    
  end
end
