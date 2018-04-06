
require_relative '../../../../sections/main/menu'
require_relative '../../../../sections/main/home'
require_relative '../../../../sections/main/contact_card'
require_relative '../../../../pages/login/login'
require_relative '../../../../pages/contact'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/admin/dashboard/dashboard'

class CrmMiniApp < SitePrism::Page 
  section :home_menu, Sections::FeaturesMenu, '.nav-middle-top'
  section :contact, Sections::Contact, '#contact-list'
  section :oppo_form, Sections::MiniAppOpportunityForm, '.modal-content'
  section :crm_container, Sections::CrmFeature, '.crm-card-container'

 

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
    wait_until_opportunity_list_visible
    opportunity_list.each do |u|
      puts u.text
      if u.text.include?(opportunity[:contact_owner]) && u.text.include?(opportunity[:name]) && u.text.include?(opportunity[:status]) && u.text.include?(opportunity[:price]) #&& u.text.include?(opportunity[:probability])
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
    sleep(2)
    contact.add_opportunity.click
    contact.fill_opportunity_data(opportunity)
  end

  def goto_page(number)
    pagination.each do |u|
      u.click if number > 1
    end
  end

  def insert_opportunity(quantity)
    user = { 'data' => {
      'username' => 'devmarcelo.user1@ringbyname.com',
      'password' => '123456asd',
      'stay_sign_in' => 0,
      'timezone' => 'America/Sao_Paulo'
    } }
    headers = {
      'X-Application-Id' => 'webapp',
      'X-Version' => 'v2'
    }

    @response = HTTParty.post(
      'http://api.marcelo-php56.dev.ringbyname.com/auth?',
      body: user.to_json,
      headers: headers
    )
    
    session_id = @response.parsed_response['data']['session_id']
    i=1
    source_id = 1
    status_id = 1
    probability_id = 1
    action_id = 1
    
    quantity.times do
        date = Date.today
        opportunity = {  "data" => {  
               "name" => "Test Opportunity #{i}",
               "contact" => {  
                  "id" => "48987071f9335f9a0e1e2d1ae61a2d7f"
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
            'http://api.marcelo-php56.dev.ringbyname.com/crm-opportunity?',
            body: opportunity.to_json,
            headers: headers
        )
         
        source_id +=1
        status_id +=1
        probability_id +=1
        action_id +=1

        if source_id > 9
            source_id =1
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
