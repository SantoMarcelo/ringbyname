require_relative '../../../../../spec/helpers'
module CenterService

  def get_session_id
    admin_user = get_admin
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
    session_id
  end

  def get_center_list

    session_id = get_session_id()


    headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2',
        'X-Session-Id' => session_id
    }

    response = HTTParty.get("http://api.#{$environment}-php56.dev.ringbyname.com/user-admin/location?",
                            headers: headers)


    return response['data']['rows']

  end

  def remove_center_list
    session_id = get_session_id
    center_list = get_center_list

    headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2',
        'X-Session-Id' => session_id
    }

    center_list.each do |item|

      response = HTTParty.delete("http://api.#{$environment}-php56.dev.ringbyname.com/user-admin/location/#{item['id']}",
                                 headers:headers)

    end
    center_list_updated = get_center_list

    false if center_list_updated.length != 0

    true

  end

  def insert_center(quantity = 1)
    session_id = get_session_id

    body={
        'data' =>{
            'name' => 'wrfsfd',
            'address' => {
                "city"=>"sdfsdf",
                "state"=>"sdfsd",
                "country"=>"CA",
                "timezone"=>"Africa/Addis_Ababa"
            }
        }
    }
    headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2',
        'X-Session-Id' => session_id
    }
    quantity.times do |i|

      body={
          'data' =>{
              'name' => "Test Center #{i}",
              'address' => {
                  "city"=>"Miami Test #{i}",
                  "state"=>"Florida #{i}",
                  "country"=>"CA",
                  "timezone"=>"America/New_York"
              }
          }
      }

      response = HTTParty.post(
          "http://api.#{$environment}-php56.dev.ringbyname.com/user-admin/location?",
          headers:headers,
          body:body.to_json)

      i+=1
    end


  end

end