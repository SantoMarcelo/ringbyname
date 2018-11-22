
module Helpers
  def get_screenshot
    target = 'log/reports/temp.png'
    sleep(1)
    File.new(page.save_screenshot(File.join(Dir.pwd, target)))
  end

  #method to scroll to specifc element
  def scroll_to(element)
      script = <<-JS
        arguments[0].scrollIntoView(true);
      JS
  
      Capybara.current_session.driver.browser.execute_script(script, element.native)
  end

  #Method to fill dates fields
  def set_date(element, date)
      
      script = <<-JS
        $('#{element}').datepicker('setDate', '#{date}');
        
      JS
      #puts script
      Capybara.current_session.driver.browser.execute_script(script)
  end

  #Method to get session_id
  def get_header
      admin_user = get_admin()
      user = { 'data' => {
        'username' => admin_user[:username],
        'password' => admin_user[:password],
        'stay_sign_in' => 0,
        'timezone' => 'America/Sao_Paulo'
      }}
      headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2'
      }
    
      @response = HTTParty.post(
        'http://api.#{$environment}-php56.dev.ringbyname.com/auth?',
        body: user.to_json,
        headers: headers
      )
      session_id = @response.parsed_response['data']['session_id']
    
      headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2',
        'X-Session-Id' => session_id,
        'Content-Type' => 'application/json'
      }
      return headers
  end

  def provisioning(data = 'account', product = nil, value = nil) 
   
    body = {  
      'request_id' =>'5b157d4ca622d',
      'data' => {  
      'account' => {  
        'customer_id' =>'1168173',
        'first_name' =>'Marcelo',
        'last_name' =>'Santos',
        'email_address' =>'marcelo.santos@inphonex.com',
        'company' =>'Dev Marcelo',
        'company_document' =>'',
        'birth_date' =>'0000-00-00',
        'document' =>'',
        'pstn_phone' =>'3057284647',
        'pstn_fax' =>'',
        'address1' =>'NW 31st ST',
        'address2' =>'',
        'city' =>'Miami',
        'state' =>'FL',
        'postal_code' =>'33122',
        'house_number' =>'7206',
        'house_number_suffix' =>'',
        'prefix_directional' =>'',
        'post_directional' =>'',
        'street_type' =>'',
        'street_suffix' =>'',
        'unit_type' =>'unknown',
        'unit_number' =>'',
        'caller_name' =>'Marcelo Santos',
        'timezone_id' =>'318',
        'timezone_code' =>'America\/New_York',
        'timezone_name' =>'America\/New_York',
        'country_code' =>'US',
        'country_name' =>'United States',
        'language_locale' =>'en-US',
        'language_name' =>'English',
        'api_key' =>'65a9a9ed605ccdb4694e856203909d14c80a1ae6a497f64ae9cdbe7f2bc957cf',
        'is_local_resource' =>'0',
        'is_call_recording_enabled' =>'1',
        'call_conference_max_participants' =>'7',
        'call_conference_extra_spots' =>'2',
        'crm_licenses' =>'0',
        'email_domain' =>'ringbyname.com',
        'realm' =>'1168173.sip.ringbyname.com',
        'ezscore' => {  
           'status' =>true,
           'disclaimer' =>true
        }
      },
      'virtual_users' => {  
        '0' => {  
           'cust_plan_id' =>'407809',
           'first_name' =>'New user',
           'last_name' =>'9314131',
           'email_address' =>'407809@ringbyname.com',
           'username' =>'407809',
           'password' =>'ahc9Ha4rt4Aa',
           'timezone_id' =>'318',
           'timezone_code' =>'America\/New_York',
           'timezone_name' =>'America\/New_York',
           'language_locale' =>'en-US',
           'language_name' =>'English',
           'name' =>'R! US\/CA Virtual User',
           'company' =>'Dev Marcelo',
           'pstn_phone' =>'3057284647',
           'pstn_fax' =>'',
           'virtual_number' =>'9314131',
           'sip_password' =>'testtest',
           'pin' =>'14131',
           'caller_id_internal_number' =>'407809',
           'caller_id_internal_name' =>'Marcelo Santos',
           'caller_id_external_name' =>'Marcelo Santos',
           'package_name' =>'R! Virtual User',
           'caller_id_external_number' =>'2392068773',
           'mac_address' =>''
        },
        '1' => {  
           'cust_plan_id' =>'407808',
           'first_name' =>'New user',
           'last_name' =>'9314132',
           'email_address' =>'407808@ringbyname.com',
           'username' =>'407808',
           'password' =>'ahc9Ha4rt4Aa',
           'timezone_id' =>'318',
           'timezone_code' =>'America\/New_York',
           'timezone_name' =>'America\/New_York',
           'language_locale' =>'en-US',
           'language_name' =>'English',
           'name' =>'R! US\/CA Virtual User',
           'company' =>'Dev Marcelo',
           'pstn_phone' =>'3057284647',
           'pstn_fax' =>'',
           'virtual_number' =>'9314132',
           'sip_password' =>'testtest',
           'pin' =>'14132',
           'caller_id_internal_number' =>'407808',
           'caller_id_internal_name' =>'Marcelo Santos',
           'caller_id_external_name' =>'Marcelo Santos',
           'package_name' =>'R! Virtual User',
           'caller_id_external_number' =>'2392068773',
           'mac_address' =>''
        }
      },
      'company_numbers' => {  
        '0' => {  
           'did' =>'2392068773',
           'did_type' =>'company',
           'virtual_number' =>'5036322',
           'pin' =>'16755',
           'country_code' =>'US',
           'country_name' =>'United States',
           'state' =>'FL',
           'city' =>'Naples',
           'is_sms_enabled' =>'1'
        }
      },
      'fax_numbers' => {  
        '0' => {  
           'did' =>'2393022135',
           'did_type' =>'fax',
           'virtual_number' =>'5036322',
           'pin' =>'16755',
           'country_code' =>'US',
           'country_name' =>'United States',
           'state' =>'FL',
           'city' =>'Naples'
        }
      },
      'users' => {  
        '0' => {  
           'customer_id' =>'1168173',
           'cust_plan_id' =>'407811',
           'user_id' =>'',
           'first_name' =>'New user',
           'last_name' =>'9314129',
           'email_address' =>'407811@ringbyname.com',
           'username' =>'407811',
           'password' =>'ahc9Ha4rt4Aa',
           'verified' =>'1',
           'timezone_id' =>'318',
           'timezone_code' =>'America\/New_York',
           'timezone_name' =>'America\/New_York',
           'caller_number' =>'407811',
           'caller_name' =>'Marcelo Santos',
           'language_locale' =>'en-US',
           'language_name' =>'English',
           'name' =>'R! US\/CA User',
           'company' =>'Dev Marcelo',
           'pstn_phone' =>'3057284647',
           'pstn_fax' =>'',
           'did_type' =>'personal',
           'id' =>'438132',
           'did' =>'2392080525',
           'virtual_number' =>'9314129',
           'sip_password' =>'testtest',
           'pin' =>'14129',
           'caller_id_internal_number' =>'407811',
           'caller_id_internal_name' =>'Marcelo Santos',
           'caller_id_external_name' =>'Marcelo Santos',
           'caller_id_external_number' =>'2392080525',
           'package_name' =>'R! User',
           'is_local_calling' =>'0',
           'country_code' =>'US',
           'country_name' =>'United States',
           'state' =>'FL',
           'city' =>'Fort Myers',
           'mac_address' =>'',
           'is_admin_user' =>'0'
        },
        '1' => {  
           'customer_id' =>'1168173',
           'cust_plan_id' =>'407810',
           'user_id' =>'',
           'first_name' =>'New user',
           'last_name' =>'9314130',
           'email_address' =>'407810@ringbyname.com',
           'username' =>'407810',
           'password' =>'ahc9Ha4rt4Aa',
           'verified' =>'1',
           'timezone_id' =>'318',
           'timezone_code' =>'America\/New_York',
           'timezone_name' =>'America\/New_York',
           'caller_number' =>'407810',
           'caller_name' =>'Marcelo Santos',
           'language_locale' =>'en-US',
           'language_name' =>'English',
           'name' =>'R! US\/CA User',
           'company' =>'Dev Marcelo',
           'pstn_phone' =>'3057284647',
           'pstn_fax' =>'',
           'did_type' =>'personal',
           'id' =>'438131',
           'did' =>'2392065017',
           'virtual_number' =>'9314130',
           'sip_password' =>'testtest',
           'pin' =>'14130',
           'caller_id_internal_number' =>'407810',
           'caller_id_internal_name' =>'Marcelo Santos',
           'caller_id_external_name' =>'Marcelo Santos',
           'caller_id_external_number' =>'2392065017',
           'package_name' =>'R! User',
           'is_local_calling' =>'0',
           'country_code' =>'US',
           'country_name' =>'United States',
           'state' =>'FL',
           'city' =>'Naples',
           'mac_address' =>'',
           'is_admin_user' =>'0'
        }
      },
      'contacts' => {  

      }
     }
    }
    
    body['data'][data][product] = value

    headers = {
      'Content-Type' => 'application/json' 
    }

    response = HTTParty.put("http://api.#{$environment}-php56.dev.ringbyname.com/provisioning-admin/1168173",
      body: body.to_json,
      headers: headers, 
      timeout: 9999)
      if  response.parsed_response['code'] == 200
        puts "provisioning complete"
      elsif
        puts "provisioning failed"
      end

  end

  

end
