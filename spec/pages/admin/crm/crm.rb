
require_relative '../admin'
require_relative '../../../sections/admin/crm/crm'
require_relative '../../../sections/admin/admin'
 
class Crm < Admin
  section :menu, Sections::SetupMenu, '.navigation-left'
  section :message, Sections::Messages, '.swal2-container'
  section :menu, Sections::CrmMenu, '.webapp-admin-page-sidebar'
  section :oppo, Sections::Opportunities, '.page-main'
  section :analytics, Sections::Analytics, '.page-main'
  section :sources, Sections::Sources, '.page-main'

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
               "cost" => 99.99,
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
