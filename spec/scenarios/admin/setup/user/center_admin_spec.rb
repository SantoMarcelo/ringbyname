require_relative '../../../../pages/login/login'
require_relative '../../../../pages/admin/dashboard/dashboard'
require_relative '../../../../pages/admin/setup/user/users'
require_relative '../../../../pages/admin/setup/user/centers'
require_relative '../../../../sections/admin/setup/user/centers'
require_relative '../../../../services/admin/setup/user/center_service'

describe('Validate Center setup', :center_setup) do
  before(:each) do


   expect(remove_center_list).to eql true

    login_page.load
    login_page.do_login(get_admin())
    home.check_user_status
    visit('#!/admin/setup/user')
    #center.wait_for_load

    @center = {
        name: 'Test Center Name',
        name_validation: 'Test length name Test length name Te',
        city: 'Test city',
        state_validation: 'Test length state Test length state Te',
        state: 'Test Satate',
        country: 'United States',
        country_uf: 'US',
        time_zone: 'America/New_York'
    }
    @center_edited = {
        name: 'Test Center Name EDITED',
        name_validation: 'Test length name Test length name Te',
        city: 'Test city EDITED',
        state_validation: 'Test length state Test length state Te',
        state: 'Test Satate EDITED',
        country: 'Brazil',
        country_uf: 'BR',
        time_zone: 'America/Sao_Paulo'
    }

  end
  describe('Validate insert new center', :center_insert) do
    it ('Insert a new Center and see on the center list') do |e|
      e.step('Given Hasn\'t Centers rigistreds in system') do
        puts '  Given Hasn\'t Centers rigistreds in system'
        center.setup.wait_for_grid
        expect(center.setup.has_grid_items).to eql(false)
      end
      e.step('when I insert a new Center')do
        puts '  when I insert a new Center'
        center.setup.btn_add.click
        center.wait_for_load
        sleep 1
        center.details.wait_for_details
        expect(center.details.title.text).to eql('Center Details')
        center.details.name.set(@center[:name])
        center.details.city.set(@center[:city])
        center.details.state.set(@center[:state])
        center.details.select_country.find('option', text: (@center[:country])).select_option
        center.details.select_time_zone.find('option', text: (@center[:time_zone])).select_option
        center.details.btn_save.click
      end
      e.step('Then I should see the success message') do
        puts '  Then I should see the success message'
        center.wait_for_message
        expect(center.message.modal.text).to eql ('Call Center inserted')
        center.message.btn_ok.click
      end
      e.step('and I should see this center on center list') do
        puts '  and I should see this center on center list'
        center.setup.wait_for_grid
        expect(center.setup.grid_list_items.length).to eql(1)
        expect(center.check_is_center_in_grid(@center)).to eql(true)
      end
    end
  end
  describe('Validate insert validations', :center_validations) do
    it ('Insert Center validations messages') do |e|
      e.step('Given Hasn\'t Centers rigistreds in system') do
        puts '  Given Hasn\'t Centers rigistreds in system'
        center.setup.wait_for_grid
        expect(center.setup.has_grid_items).to eql(false)
      end
      e.step('when I try to insert with empty Name')do
        puts '  when I try to insert with empty Name'
        center.setup.btn_add.click
        center.wait_for_load
        sleep 1
        center.details.wait_for_details
        expect(center.details.title.text).to eql('Center Details')
        center.details.name.set("")
        center.details.city.set(@center[:city])
        center.details.state.set(@center[:state])
        center.details.select_country.find('option', text: (@center[:country])).select_option
        center.details.select_time_zone.find('option', text: (@center[:time_zone])).select_option
        center.details.btn_save.click
      end
      e.step('Then I should see the validation message') do
        puts '  Then I should see the validation message'
        center.wait_for_message
        expect(center.message.modal.text).to eql ('Sorry, you must set a name for this Call Center.')
        center.message.btn_ok.click
      end
      e.step('when I try to insert with empty City')do
        puts '  when I try to insert with empty City'
        center.details.wait_for_details
        center.details.name.set(@center[:name])
        center.details.city.set("")
        center.details.btn_save.click
      end
      e.step('Then I should see the validation message') do
        puts '  Then I should see the validation message'
        center.wait_for_message
        expect(center.message.modal.text).to eql ('You must provide a City to this Call Center.')
        center.message.btn_ok.click
      end
      e.step('when I try to insert with empty State')do
        puts '  when I try to insert with empty State'
        center.details.wait_for_details
        center.details.city.set(@center[:city])
        center.details.state.set("")
        center.details.btn_save.click
      end
      e.step('Then I should see the validation message') do
        puts '  Then I should see the validation message'
        center.wait_for_message
        expect(center.message.modal.text).to eql ('You must provide a State to this Call Center.')
        center.message.btn_ok.click
      end
      e.step('when I try to insert with empty Country')do
        puts '  when I try to insert with empty Country'
        center.setup.btn_add.click
        center.details.wait_for_details
        center.details.name.set(@center[:name])
        center.details.city.set(@center[:city])
        center.details.state.set(@center[:state])
        center.details.btn_save.click
      end
      e.step('Then I should see the validation message') do
        puts '  Then I should see the validation message'
        center.wait_for_message
        expect(center.message.modal.text).to eql ('You must provide a Country to this Call Center.')
        center.message.btn_ok.click
      end
      e.step('when I try to insert with empty TimeZone')do
        puts '  when I try to insert with empty TimeZone'
        center.setup.btn_add.click
        center.details.wait_for_details
        center.details.name.set(@center[:name])
        center.details.city.set(@center[:city])
        center.details.state.set(@center[:state])
        center.details.select_country.find('option', text: (@center[:country])).select_option
        center.details.btn_save.click
      end
      e.step('Then I should see the validation message') do
        puts '  Then I should see the validation message'
        center.wait_for_message
        expect(center.message.modal.text).to eql ('You must provide a Timezone to this Call Center.')
        center.message.btn_ok.click
      end
      e.step('when I try to insert name with more than 35 chars')do
        puts '  when I try to insert name with more than 35 chars'
        center.setup.btn_add.click
        center.details.wait_for_details
        center.details.name.set(@center[:name_validation])
        center.details.btn_save.click
      end
      e.step('Then I should see the validation message') do
        puts '  Then I should see the validation message'
        center.wait_for_message
        expect(center.message.modal.text).to eql ('Call Center name field length must be 35 characters maximum.')
        center.message.btn_ok.click
      end
      e.step('when I try to insert state with more than 35 chars')do
        puts '  when I try to insert state with more than 35 chars'
        center.setup.btn_add.click
        center.details.wait_for_details
        center.details.name.set(@center[:name])
        center.details.state.set(@center[:state_validation])
        center.details.btn_save.click
      end
      e.step('Then I should see the validation message') do
        puts '  Then I should see the validation message'
        center.wait_for_message
        expect(center.message.modal.text).to eql ('State field length must be 35 characters maximum.')
        center.message.btn_ok.click
      end
    end
  end
  describe('Validate update centers', :center_update) do
    it ('Update Centers') do |e|
      e.step('Given I had center registered in system')do
        puts '  Given I had center registered in system'
        insert_center(1)
        center.menu.departments.click
        center.menu.users.click
        @center_list = get_center_list

        puts @center_list[0]

        @new_center = {
            name: @center_list[0]['name'],
            city: @center_list[0]['address']['city'],
            state: @center_list[0]['address']['state'],
            country: @center_list[0]['address']['country'],
            country_uf: @center_list[0]['address']['country'],
            time_zone: @center_list[0]['address']['timezone']
        }
      end
      e.step('When I select this center to update') do
        puts '  When I select this center to update'
        center.setup.wait_for_grid
        center.select_center(@new_center)
        sleep 1
        center.details.wait_for_details
      end
      e.step('And I update center data and save') do
        puts '  And I update center data and save'
        expect(center.details.title.text).to eql('Center Details')
        center.details.name.set(@center_edited[:name])
        center.details.city.set(@center_edited[:city])
        center.details.state.set(@center_edited[:state])
        center.details.select_country.find('option', text: (@center_edited[:country])).select_option
        center.details.select_time_zone.find('option', text: (@center_edited[:time_zone])).select_option
        center.details.btn_save.click
      end
      e.step('Then I should see the success message') do
        puts '  Then I should see the success message'
        center.wait_for_message
        expect(center.message.modal.text).to eql ('Call Center updated')
        center.message.btn_ok.click
      end
      e.step('Then I should see the updated data on center grid') do
        puts '  Then I should see the updated data on center grid'
        center.setup.wait_for_grid
        center.check_is_center_in_grid(@center_edited)
        sleep 1
      end
      e.step('And I should see the updated data on form') do
        puts '  And I should see the updated data on form'
        center.select_center(@center_edited)
        expect(center.details.name.text.include?(@center_edited[:name]))
        expect(center.details.city.text.include?(@center_edited[:city]))
        expect(center.details.state.text.include?(@center_edited[:state]))
        expect(center.details.select_country.text.include?(@center_edited[:country_uf]))
        expect(center.details.select_time_zone.text.include?(@center_edited[:time_zone]))

      end
    end
  end
end