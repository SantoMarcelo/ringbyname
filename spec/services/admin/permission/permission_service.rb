module PermissionService

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

 
  def get_permission_groups
    session_id = get_session_id

    headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2',
        'X-Session-Id' => session_id
    }

    response = HTTParty.get("http://api.#{$environment}-php56.dev.ringbyname.com/permission-group-admin/",
                            headers: headers
                            )

    permission_groups = JSON.parse response.body
    permission_groups = permission_groups['data']['rows']

    @all_permission_groups = Array.new
    i=0
    permission_groups.each do |item|
      permission = {
          id: item['id'],
          name: item['name'],
          rules: item['rules'],
          users: item['users']
      }
      @all_permission_groups[i] = (permission)
      i += 1
    end
    @all_permission_groups
  end

  def add_permission_group
    session_id = get_session_id
    user_id = get_user(3)
    puts user_id

    headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2',
        'X-Session-Id' => session_id
    }

    body = {
        "entity_id": "",
        "data": {
            "name": "Department test 3",
            "rules": [
                {
                    "id": 1
                },
                {
                    "id": 5
                }
            ],
            "users": [
                { "user_id": "529cefcb549265c382e6b9b005f48f64" }
            ]
        }
    }

    response = HTTParty.post("http://api.#{$environment}-php56.dev.ringbyname.com/permission-group-admin/",
                             headers: headers,
                             body: body
                             )

    puts "response"
     result = JSON.parse response.body
    puts result

  end

  def clear_permissions
    groups_to_delete = get_permission_groups
    session_id = get_session_id
    headers = {
        'X-Application-Id' => 'webapp',
        'X-Version' => 'v2',
        'X-Session-Id' => session_id
    }

    groups_to_delete.each do |item|
        puts item[:id]
        puts "http://api.#{$environment}-php56.dev.ringbyname.com/permission-group-admin/#{item[:id]}"
        puts headers
        @response = HTTParty.delete("http://api.#{$environment}-php56.dev.ringbyname.com/permission-group-admin/#{item[:id]}",
            headers: headers
            )
        puts @response
    end
    
  end

end