# usuários




module Config
 #adicionar na master
  #access couchdb to get the account DB
  def get_couch_account_db(account_id)
    
    @account_id = ENV['R_CUSTOMER_ACCOUNT_ID']
   
    @accounts = HTTParty.get(
        "http://couchdb.#{ENV['ENVIRONMENT']}-voip.dev.ringbyname.com:5984/accounts/#{@account_id}"
    )
    
    @accounts = JSON.parse(@accounts)
  
    @accounts.each do |key, value|
        if key == 'pvt_account_db'
            @account_db = value
        end
    end
    @account_db
  end

  def get_couch_account_users()
    account_db = get_couch_account_db(@account_id)
    
    #access couchdb to get account users
    
    @account = HTTParty.get(
        "http://couchdb.#{ENV['ENVIRONMENT']}-voip.dev.ringbyname.com:5984/#{account_db}/_design/ipx_users/_view/listing_by_permission"
    )
    @account_users = JSON.parse @account.body
    
    @account_users.each do |key, value|
        if key == 'rows'
            users = value
        end
        users
    end
    
  end 

  def get_contact_group(group_name)
    @contact_groups = HTTParty.get(
      "http://couchdb.#{ENV['ENVIRONMENT']}-voip.dev.ringbyname.com:5984/#{@account_db}/_design/ipx_contacts_groups/_view/listing",
    )
    @groups = JSON.parse @contact_groups.body

    @groups.each do |key, value|
      if key == 'rows'
        @group_list = value
      end
    end
    @group_list.each do |group|
      if group['value']['description'] == group_name
        @group_name = group['value']['description']
      end
    end
    return @group_name
  end

#   #get first admin user to set like admin
  def get_admin
    account_id = ENV['R_CUSTOMER_ACCOUNT_ID']
    
    #access couchdb to get account users
    @account_users = get_couch_account_users()
    
    @account_users.each do |key, value|
      if key == 'rows'
        @users = value
      end
    end

    admin_user = nil
    i = 0
    @users.each do |u|
       
      if admin_user.nil? == true && u['value']['priv_level'] == "admin"
        admin_user =         
        {
          user_id: u['id'],
          username: u['value']['email'],
          password: '123456asd',
          account_id: u['value']['pvt_account_id'],
          priv_level: u['value']['priv_level'],
          extension: u['value']['caller_id']['internal']['number'],
          name: u['value']['caller_id']['internal']['name'],
          first_name: u['value']['first_name'],
          last_name: u['value']['last_name'],
          full_name: u['value']['first_name'] + ' ' + u['value']['last_name'],
          email: u['value']['email'],
          type: u['value']['package_name'],
          direct: u['value']['caller_id']['external']['number'],
          outbound_caller_id_name: u['value']['caller_id']['external']['name'],
          outbound_caller_id_number: u['value']['caller_id']['external']['number'],
          voicemail_password: u['value']['extras']['voicemail_pin'],
          number_of_rings: u['value']['extras']['ring_times'],
          contact_id: u['value']['contact_id']
        }
      end
    end
    
    return admin_user
  end

#   #get all account users
  def get_user(index)

    
    @all_users = Array.new
    i=0
  
    @users.each do |u|
      user = {
        user_id: u['id'],
        priv_level: u['value']['priv_level'],
        extension: u['value']['caller_id']['internal']['number'],
        name: u['value']['caller_id']['internal']['name'],
        first_name: u['value']['first_name'],
        last_name: u['value']['last_name'],
        full_name: u['value']['first_name'] + ' ' + u['value']['last_name'],
        email: u['value']['email'],
        type: u['value']['package_name'],
        direct: u['value']['caller_id']['external']['number'],
        outbound_caller_id_name: u['value']['caller_id']['external']['name'],
        outbound_caller_id_number: u['value']['caller_id']['external']['number'],
        voicemail_password: u['value']['extras']['voicemail_pin'],
        number_of_rings: u['value']['extras']['ring_times'],
        contact_id: u['value']['contact_id'],
        username: u['value']['email'],
        password: '123456asd'
      }
      @all_users[i] = (user)
      i +=1
    end
    
      return @all_users[index]
    
  end

  def get_user_list()

    user = get_admin()
    puts user[:username]
    body_login = { 'data' => {
      'username' => user[:username],
      'password' => user[:password],
      'stay_sign_in' => 0,
      'timezone' => 'America/Sao_Paulo'
    } }
    headers = {
      'X-Application-Id' => 'webapp',
      'X-Version' => 'v2'
    }
    @response = HTTParty.post(
      "http://api.#{$environment}-php56.dev.ringbyname.com/auth?",
      body: body_login.to_json,
      headers: headers
    )
    session_id = @response.parsed_response['data']['session_id']
    @response = HTTParty.get(
      "http://api.#{$environment}-php56.dev.ringbyname.com/user-admin?X-Application-Id=webapp-admin&X-Session-Id=#{session_id}&X-Version=v2&limit=10&page=1&select=id%7Ccaller_id%7Cfirst_name%7Clast_name%7Cpackage_name%7Cassigned_phone_numbers%7Cis_local_calling%7Cpermission%7Cpersonal_phone_number%7Ccrm.is_enabled"
    
    )
    user_list = @response['data']['rows']
    return user_list
  end

  def get_contacts
    i=0
    admin_user = get_admin()
    #Get couch contacts
    # @contact_list= Array.new
    # @contacts_response = HTTParty.get(
    #   "http://couchdb.dev.ringbyname.com:5984/#{@account_db}/_design/ipx_contacts/_view/listing_by_name"
    # )
    # @account_contacts = JSON.parse @contacts_response.body
    # @account_contacts =  @account_contacts['rows']
    
    #Get Contacts through api request
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
    @contact_list= Array.new
    @contacts_response = HTTParty.get(
      "http://api.#{$environment}-php56.dev.ringbyname.com/contact",
      headers: headers 
    )
    @account_contacts = JSON.parse @contacts_response.body
    @account_contacts =  @account_contacts['data']['rows']
    
    i=0
    @account_contacts.each do |u|
    
      emails = Array.new
      phones = Array.new
      addresses = Array.new
      
      increment = 0
      u['emails'].each do |item|
        emails[increment]=
          {
          "email"=> item['value'],
          "label"=> item['label'],
          }
        increment += 1
      end
      increment = 0
      u['phones'].each do |item|
        phones[increment]=
          {
          "phone_number"=> item['value'],
          "label"=> item['label'],
          }
          increment += 1
      end
      increment = 0
      u['addresses'].each do |item|
        addresses[increment]=
          {
          "adrress"=> item['value']['address'],
          "label"=> item['label'],
          }
          increment += 1
      end
      
      contact = {
          contact_id: u['id'],
          first_name: u['name']['first_name'],
          last_name: u['name']['last_name'],
          full_name: u['name']['first_name'] + ' ' + u['name']['last_name'],
          company: u['company'],
          extension: u['extension'],
          phones: phones,
          emails: emails,
          addresses: addresses
        }
        
        @contact_list.push(contact)
      
    end
    return @contact_list
  end

  def get_reseted_password
    user = get_admin()
    @response = HTTParty.get("http://#{$environment}-voip.dev.ringbyname.com:5984/#{@account_db}/#{user[:user_id]}")

    password = JSON.parse(@response)

    password['password_confirmation']

  end

  def clear_notes
    account_db = get_couch_account_db(@account_id)

    @response = HTTParty.get("http://couchdb.#{ENV['ENVIRONMENT']}-voip.dev.ringbyname.com:5984/#{ account_db}/_design/ipx_notes/_view/listing")
    note_list = JSON.parse(@response)
    
    note_list.each do |key, value|
      if key == 'rows'
        @note_list_item =  value
      end
    end
    user = get_admin()
    body_login = { 'data' => {
      'username' => user[:username],
      'password' => user[:password],
      'stay_sign_in' => 0,
      'timezone' => 'America/Sao_Paulo'
    } }
    headers = {
      'X-Application-Id' => 'webapp',
      'X-Version' => 'v2'
    }

    @response = HTTParty.post(
      "http://api.#{$environment}-php56.dev.ringbyname.com/auth?",
      body: body_login.to_json,
      headers: headers
    )

    session_id = @response.parsed_response['data']['session_id']

    headers = {
      'X-Application-Id' => 'webapp',
      'X-Version' => 'v2',
      'X-Session-Id' => session_id
    }

    @note_list_item.each do |u|
      @delete_response = HTTParty.delete("http://api.#{$environment}-php56.dev.ringbyname.com/note/index/#{u['id']}?",
        headers: headers
      )
    end

  end
#   def set_user_data(user)

#     body_login = { 'data' => {
#         'username' => user[:username],
#         'password' => user[:password],
#         'stay_sign_in' => 0,
#         'timezone' => 'America/Sao_Paulo'
#     } }
#     headers = {
#         'X-Application-Id' => 'webapp',
#         'X-Version' => 'v2'
#     }

#     @response = HTTParty.post(
#         "http://api.#{$environment}-php56.dev.ringbyname.com/auth?",
#         body: body_login.to_json,
#         headers: headers
#     )

#     user_id = @response.parsed_response['data']['user']['id']
#     session_id = @response.parsed_response['data']['session_id']

#     user_info = {
#             "data" =>{
#                 "id" =>"00edf3375cb2dbf353ac384209939dec",
#                 "contact_id" => "48987071f9335f9a0e1e2d1ae61a2d7f",
#                 "first_name" => "Dev Marcelo 1",
#                 "last_name" => "User",
#                 "full_name" => "Dev Marcelo 1 User",
#                 "email" => "devmarcelo.user1@ringbyname.com",
#                 "language" => "en_US",
#                 "timezone" => "America/New_York",
#                 "personal_phone_number" => {
#                     "id" => "+12392080525",
#                     "name" => "New user 9314129",
#                     "email" => nil,
#                     "allowed_users" => [

#                     ],
#                     "number" => "12392080525",
#                     "type" => "personal",
#                     "routing" => {
#                         "id" => "00edf3375cb2dbf353ac384209939dec",
#                         "type" => "user"
#                     },
#                     "greeting" => {
#                         "type" => "AUTO",
#                         "text_to_speech" => "",
#                         "file" => {
#                             "id" => ""
#                         },
#                         "voice" => "en_US",
#                         "is_great_by_name" => true,
#                         "welcome_back_routing" => false
#                     },
#                     "time_of_day" => {
#                         "monday" => {
#                             "is_enabled" => true,
#                             "from" => "09:00 AM",
#                             "to" => "05:00 PM"
#                         },
#                         "tuesday" => {
#                             "is_enabled" => true,
#                             "from" => "09:00 AM",
#                             "to" => "05:00 PM"
#                         },
#                         "wednesday" => {
#                             "is_enabled" => true,
#                             "from" => "09:00 AM",
#                             "to" => "05:00 PM"
#                         },
#                         "thursday" => {
#                             "is_enabled" => true,
#                             "from" => "09:00 AM",
#                             "to" => "05:00 PM"
#                         },
#                         "friday" => {
#                             "is_enabled" => true,
#                             "from" => "09:00 AM",
#                             "to" => "05:00 PM"
#                         },
#                         "saturday" => {
#                             "is_enabled" => false,
#                             "from" => "09:00 AM",
#                             "to" => "05:00 PM"
#                         },
#                         "sunday" => {
#                             "is_enabled" => false,
#                             "from" => "09:00 AM",
#                             "to" => "05:00 PM"
#                         },
#                         "timezone" => "America/New_York",
#                         "type" => "all_day",
#                         "custom" => {
#                             "timezone" => "America/New_York",
#                             "monday" => {
#                                 "is_enabled" => true,
#                                 "from" => "9:00 AM",
#                                 "to" => "5:00 PM"
#                             },
#                             "tuesday" => {
#                                 "is_enabled" => true,
#                                 "from" => "9:00 AM",
#                                 "to" => "5:00 PM"
#                             },
#                             "wednesday" => {
#                                 "is_enabled" => true,
#                                 "from" => "9:00 AM",
#                                 "to" => "5:00 PM"
#                             },
#                             "thursday" => {
#                                 "is_enabled" => true,
#                                 "from" => "9:00 AM",
#                                 "to" => "5:00 PM"
#                             },
#                             "friday" => {
#                                 "is_enabled" => true,
#                                 "from" => "9:00 AM",
#                                 "to" => "5:00 PM"
#                             },
#                             "saturday" => {
#                                 "is_enabled" => false,
#                                 "from" => "9:00 AM",
#                                 "to" => "5:00 PM"
#                             },
#                             "sunday" => {
#                                 "is_enabled" => false,
#                                 "from" => "9:00 AM",
#                                 "to" => "5:00 PM"
#                             }
#                         }
#                     },
#                     "caller_id_name" => "Dev Marcelo 1 U",
#                     "caller_id_number" => nil,
#                     "auto_greeting_name" => nil,
#                     "sms_allowed_users" => [

#                     ],
#                     "custom_hours_settings" => [

#                     ],
#                     "location" => {
#                         "country" => {
#                             "country_code" => "US",
#                             "country_name" => "United States"
#                         },
#                         "state" => "FL",
#                         "city" => "Fort Myers"
#                     }
#                 },
#                 "assigned_phone_numbers" => [
#                     {
#                         "id" => "+12392080525",
#                         "name" => "New user 9314129",
#                         "number" => "12392080525",
#                         "type" => "personal",
#                         "caller_id_name" => "Dev Marcelo 1 U",
#                         "allowed_users" => [

#                         ],
#                         "sms_allowed_users" => [

#                         ],
#                         "routing" => {
#                             "id" => "00edf3375cb2dbf353ac384209939dec",
#                             "type" => "user"
#                         },
#                         "greeting" => {
#                             "type" => "AUTO",
#                             "text_to_speech" => "",
#                             "voice" => "en_US",
#                             "file" => {
#                                 "id" => ""
#                             },
#                             "is_great_by_name" => true,
#                             "welcome_back_routing" => false
#                         },
#                         "time_of_day" => {
#                             "type" => "all_day",
#                             "custom" => {
#                                 "timezone" => "America/New_York",
#                                 "monday" => {
#                                     "is_enabled" => true,
#                                     "from" => "9:00 AM",
#                                     "to" => "5:00 PM"
#                                 },
#                                 "tuesday" => {
#                                     "is_enabled" => true,
#                                     "from" => "9:00 AM",
#                                     "to" => "5:00 PM"
#                                 },
#                                 "wednesday" => {
#                                     "is_enabled" => true,
#                                     "from" => "9:00 AM",
#                                     "to" => "5:00 PM"
#                                 },
#                                 "thursday" => {
#                                     "is_enabled" => true,
#                                     "from" => "9:00 AM",
#                                     "to" => "5:00 PM"
#                                 },
#                                 "friday" => {
#                                     "is_enabled" => true,
#                                     "from" => "9:00 AM",
#                                     "to" => "5:00 PM"
#                                 },
#                                 "saturday" => {
#                                     "is_enabled" => false,
#                                     "from" => "9:00 AM",
#                                     "to" => "5:00 PM"
#                                 },
#                                 "sunday" => {
#                                     "is_enabled" => false,
#                                     "from" => "9:00 AM",
#                                     "to" => "5:00 PM"
#                                 }
#                             }
#                         },
#                         "custom_hours_settings" => [

#                         ],
#                         "location" => {
#                             "country" => {
#                                 "country_code" => "US",
#                                 "country_name" => "United States"
#                             },
#                             "state" => "FL",
#                             "city" => "Fort Myers"
#                         }
#                     }
#                 ],
#                 "departments" => [

#                 ],
#                 "devices" => [
#                     {
#                         "id" => "e456e3f159fbcf53370f6b665d81269f",
#                         "name" => "9314129",
#                         "device_type" => "softphone",
#                         "sip" => {
#                             "method" => "password",
#                             "invite_format" => "username",
#                             "username" => "9314129",
#                             "password" => "123456asd",
#                             "expire_seconds" => 360
#                         },
#                         "enabled" => true,
#                         "locked" => true,
#                         "owner_id" => "00edf3375cb2dbf353ac384209939dec",
#                         "call_forward" => {
#                             "enabled" => true
#                         },
#                         "registration" => {

#                         }
#                     }
#                 ],
#                 "permission" => "admin",
#                 "type" => "",
#                 "caller_id" => {
#                     "internal" => {
#                         "name" => "Dev Marcelo 1",
#                         "number" => "101"
#                     },
#                     "external" => {
#                         "name" => "Dev Marcelo 1 U",
#                         "number" => "12392080525"
#                     }
#                 },
#                 "call_recording" => {
#                     "is_inbound_enabled" => false,
#                     "is_outbound_enabled" => false
#                 },
#                 "call_pickup" => {
#                     "is_enabled" => true
#                 },
#                 "call_forward" => {
#                     "enabled" => false,
#                     "substitute" => false,
#                     "require_keypress" => true,
#                     "keep_caller_id" => false,
#                     "direct_calls_only" => false,
#                     "ignore_early_media" => false,
#                     "number" => ""
#                 },
#                 "extras" => {
#                     "update_all_voicemail_boxes" => false,
#                     "voicemail_id" => "671041820eb877a98b1636223349457e",
#                     "ring_times" => 5,
#                     "voicemail_id_created" => "671041820eb877a98b1636223349457e",
#                     "voicemail_pin" => "1234",
#                     "timezone" => "America/New_York",
#                     "is_voicemail_enabled" => true,
#                     "is_callback_request_enabled" => true,
#                     "greeting" => {
#                         "type" => "NONE",
#                         "file" => {
#                             "id" => ""
#                         }
#                     }
#                 },
#                 "crm" => {
#                     "is_enabled" => true
#                 },
#                 "status" => "AVAILABLE",
#                 "users_excluded_from_activities" => nil,
#                 "signature" => nil,
#                 "package_name" => "R! User",
#                 "is_office365_connected" => false,
#                 "is_local_calling" => false,
#                 "password" => "123456asd",
#                 "password_confirmation" => "123456asd"
#             }
#         }

#     headers = {
#         'X-Application-Id' => 'webapp-admin',
#         'X-Session-Id' => session_id,
#         'X-Version' => 'v2'

#     }

#     @reset = HTTParty.put("http://api.#{$environment}-php56.dev.ringbyname.com/user-admin/#{user[:user_id]}?",
#                           body: user_info.to_json,
#                           headers: headers
#     )

#   end
 
    #end
end
