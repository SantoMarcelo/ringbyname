require_relative "../../../../sections/admin/setup/user/user"
require_relative "../../../../sections/admin/setup/setup"
require_relative "../../../../pages/main/home"
require_relative "../../../../pages/admin/dashboard/dashboard"
require_relative "../setup"

class Department < Setup
  section :depto_main, Sections::SetupMain, ".webapp-admin-page-main"


  def access_depto_menu
    menu.departments.click
  end

  def insert_depto(quantity)
    user = { "data" => {
      "username" => "devmarcelo.user1@ringbyname.com",
      "password" => "123456asd",
      "stay_sign_in" => 0,
      "timezone" => "America/Sao_Paulo"
    } }
    headers = {
      "X-Application-Id" => "webapp",
      "X-Version" => "v2"
    }

    @response = HTTParty.post(
      "http://api.marcelo-php56.dev.ringbyname.com/auth?",
      body: user.to_json,
      headers: headers
    )

    session_id = @response.parsed_response["data"]["session_id"]
    i = 1

    quantity.times do
      department = { "data" => {
        "id" => nil,
        "data" => {
          "endpoints" => [
            {
              "id" => "00edf3375cb2dbf353ac384209939dec",
              "endpoint_type" => "user",
              "ring_delay" => 0,
              "ring_times" => 5,
              "order" => 1,
              "voicemail_enabled" => true,
              "full_name" => "Dev Marcelo 1 User"
            },
            {
              "id" => "1f7a884701de598593602736de01b1c1",
              "endpoint_type" => "user",
              "ring_delay" => 0,
              "ring_times" => 5,
              "order" => 2,
              "voicemail_enabled" => true,
              "full_name" => "Dev Marcelo 3 User"
            },
            {
              "id" => "a55452509cc5124390e5e2928f57eb33",
              "endpoint_type" => "user",
              "ring_delay" => 0,
              "ring_times" => 5,
              "order" => 3,
              "voicemail_enabled" => true,
              "full_name" => "Dev Marcelo 2 User"
            },
            {
              "id" => "529cefcb549265c382e6b9b005f48f64",
              "endpoint_type" => "user",
              "ring_delay" => 0,
              "ring_times" => 5,
              "order" => 4,
              "voicemail_enabled" => true,
              "full_name" => "Dev Marcelo 4 User"
            }
          ],
          "name" => "Test Department #{i}",
          "reference_tag" => "Ref Tag #{i}",
          "strategy" => "simultaneous"
        },
        "extras" => {
          "greeting" => {
            "type" => "NONE",
            "text_to_speech" => "",
            "voice" => "en_US",
            "file" => {
              "id" => ""
            }
          },
          "is_callback_request_enabled" => false,
          "is_call_recording_enabled" => false,
          "is_voicemail_enabled" => true,
          "timezone" => "America/New_York",
          "voicemail_id" => nil,
          "voicemail_pin" => 1234
        },
        "voicemail" => {
          "id" => nil,
          "mailbox" => nil,
          "name" => nil,
          "owner_id" => nil,
          "pin" => "1234",
          "timezone" => "America/New_York"
        },
        "call_queue" => {
          "id" => nil,
          "enabled" => nil,
          "url" => nil,
          "music_on_hold" => {
            "type" => "GENERAL",
            "custom" => {
              "type" => "NONE",
              "text_to_speech" => nil,
              "voice" => "",
              "file" => {
                "id" => ""
              }
            }
          }
        },
        "custom_hours_settings" => {
          "property_id" => nil
        },
        "time_of_day" => {
          "id" => "",
          "type" => "all_day",
          "custom" => {
            "monday" => {
              "is_enabled" => false,
              "from" => nil,
              "to" => nil
            },
            "tuesday" => {
              "is_enabled" => false,
              "from" => nil,
              "to" => nil
            },
            "wednesday" => {
              "is_enabled" => false,
              "from" => nil,
              "to" => nil
            },
            "thursday" => {
              "is_enabled" => false,
              "from" => nil,
              "to" => nil
            },
            "friday" => {
              "is_enabled" => false,
              "from" => nil,
              "to" => nil
            },
            "saturday" => {
              "is_enabled" => false,
              "from" => nil,
              "to" => nil
            },
            "sunday" => {
              "is_enabled" => false,
              "from" => nil,
              "to" => nil
            },
            "timezone" => "America/New_York"
          }
        }
      } }
      headers = {
        "X-Application-Id" => "webapp",
        "X-Version" => "v2",
        "X-Session-Id" => session_id
      }

      @opportunity = HTTParty.post(
        "http://api.marcelo-php56.dev.ringbyname.com/department-admin?",
        body: department.to_json,
        headers: headers
      )

      i += 1
    end
  end

  def validate_list_data(department)
    depto_main.grid_rows.each do |u|
      if u.text.include?(department[:name]) #&& u.text.include?(department[:vm_box])
        return true
      end
    end
    false
  end

  def goto_page(number)
    pagination.each do |u|
      u.click if number > 1
    end
  end
end
