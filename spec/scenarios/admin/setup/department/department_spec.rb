require_relative '../../../../pages/login/login'
require_relative '../../../../pages/admin/dashboard/dashboard'
require_relative '../../../../pages/admin/setup/user/users'
require_relative '../../../../pages/admin/setup/department/department'

describe('Validate admin department', :department) do
  before(:each) do
    login_page.load
    login_page.do_login(get_admin())
    home.wait_until_home_features_visible
    home.wait_until_user_status_visible
    home.goto_admin
    admin_dashboard.wait_until_btn_continue_visible
    admin_dashboard.btn_continue.click

    
    #insert departments to validate
    #depto.insert_depto(2)

    @depto_sales = {
      name: 'Sales',
      reference_tag: 'Ref Tag Sales',
      vm_box: '10004',
      members: '4'
    }
    @depto_support = {
      name: 'Technical Support',
      reference_tag: 'Ref Tag Techical Support',
      vm_box: '10005',
      members: '4'
    }
    @depto1 = {
      name: 'Test Department 1',
      reference_tag: 'Ref Tag 1',
      vm_box: '1001',
      members: '4'
    }
    @depto2 = {
      name: 'Test Department 2',
      reference_tag: 'Ref Tag 2',
      vm_box: '1002',
      members: '4'
    }
    @depto3 = {
      name: 'Test Department 3',
      reference_tag: 'Ref Tag 3',
      vm_box: '1003',
      members: '4'
    }
    @depto4 = {
      name: 'Test Department 4',
      reference_tag: 'Ref Tag 4',
      vm_box: '1004',
      members: '4'
    }
    @depto5 = {
      name: 'Test Department 5',
      reference_tag: 'Ref Tag 5',
      vm_box: '1005',
      members: '4'
    }
    @depto6 = {
      name: 'Test Department 6',
      reference_tag: 'Ref Tag 6',
      vm_box: '1006',
      members: '4'
    }
    @depto7 = {
      name: 'Test Department 7',
      reference_tag: 'Ref Tag 7',
      vm_box: '1007',
      members: '4'
    }
    @depto8 = {
      name: 'Test Department 8',
      reference_tag: 'Ref Tag 8',
      vm_box: '1008',
      members: '4'
    }
    @depto9 = {
      name: 'Test Department 9',
      reference_tag: 'Ref Tag 9',
      vm_box: '1009',
      members: '4'
    }
    @depto10 = {
      name: 'Test Department 10',
      reference_tag: 'Ref Tag 10',
      vm_box: '10010',
      members: '4'
    }
    @depto11 = {
      name: 'Test Department 11',
      reference_tag: 'Ref Tag 11',
      vm_box: '10011',
      members: '4'
    }
    @depto12 = {
      name: 'Test Department 12',
      reference_tag: 'Ref Tag 12',
      vm_box: '10012',
      members: '4'
    }
    @depto13 = {
      name: 'Test Department 13',
      reference_tag: 'Ref Tag 13',
      vm_box: '10013',
      members: '4'
    }
end

  describe('validate department list', :department_list) do
    it('access department setup and check department list') do |e|
      puts 'access department setup and check department list'
      e.step('when I on admin page') do
        puts 'when I on admin page'
        admin_dashboard.options.admin_setup.click
      end
      e.step('I can see the setup setup') do
        puts 'I can see the setup setup'
        expect(depto.admin_title.text).to eql 'Setup'
      end
      e.step('and I can access the department settings') do
        puts 'and I can access the department settings'
        depto.access_depto_menu
        expect(depto.depto_main.title.text).to eql 'Departments'
      end
      e.step('then I can see the department list') do
        puts 'then I can see the department list'
        inserted_deptos = Array.new
        depto.depto_main.wait_for_grid_rows
        depto.depto_main.grid_rows.each do |u|
          puts "#####"
          puts u.text
          puts "#####"
          test = u.text.split(/ /,9)  
          puts test
        end
        # 
        # expect(depto.validate_list_data(@depto_sales)).to eql true
        # expect(depto.validate_list_data(@depto_support)).to eql true
        # expect(depto.depto_main.info_total_records.text).to eql '2'
      end
      # e.step('when I have many departments to validate the pagination') do
      #   puts 'when I have many departments to validate the pagination'
      #   depto.insert_depto(13)
      #   page.driver.browser.navigate.refresh
      #   depto.depto_main.wait_for_grid_rows
      # end
      # e.step('and I check the department list') do
      #   puts 'and I check the department list'
      #   # expect(depto.depto_main.info_total_records.text).to eql '15'
      #   # expect(depto.validate_list_data(@depto1)).to eql true
      #   # expect(depto.validate_list_data(@depto2)).to eql true
      #   # expect(depto.validate_list_data(@depto3)).to eql true
      #   # expect(depto.validate_list_data(@depto4)).to eql true
      #   # expect(depto.validate_list_data(@depto5)).to eql true
      #   # expect(depto.validate_list_data(@depto6)).to eql true
      #   # expect(depto.validate_list_data(@depto7)).to eql true
      #   # expect(depto.validate_list_data(@depto8)).to eql true
      # end
      # e.step('and I change to the second page') do
      #   puts 'and I change to the second page'
      #   depto.depto_main.change_page(2)
      #   depto.depto_main.wait_for_grid_rows
      # end
      # e.step('the I can see the second page data') do
      #   puts 'the I can see the second page data'
      #   expect(depto.validate_list_data(@depto9)).to eql true
      #   expect(depto.validate_list_data(@depto10)).to eql true
      #   expect(depto.validate_list_data(@depto11)).to eql true
      #   expect(depto.validate_list_data(@depto12)).to eql true
      #   expect(depto.validate_list_data(@depto13)).to eql true
      # end
    end
  end
end
