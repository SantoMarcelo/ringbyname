require_relative '../../../../pages/login/login'
require_relative '../../../../pages/admin/dashboard/dashboard'
require_relative '../../../../pages/admin/setup/user/users'
#require_relative '../../../../pages/admin/setup/permission/permission'
#require_relative '../../../../services/admin/permission/permission_service'



describe('validate permissions setup', :permission_admin) do

  before()do
    @permission_groups = get_permission_groups
    #add_permission_group
    login_page.load
    login_page.do_login(get_admin())
    home.wait_until_home_features_visible
    home.wait_until_user_status_visible
    home.goto_admin
    admin_dashboard.wait_until_btn_continue_visible
    admin_dashboard.btn_continue.click


#3. The search at the top will search names of permission groups and users within them.
# Make sure the search is working.
# Search for a group name, verify that it has returned correctly;
# Search for the name of a setup who is within one or more groups and verify that all groups that this setup belongs to are listed.
#4. Provide option to create a new group (to appear in 3rd column)
# Check for the option to create a new group.
# Select Create New Group and verify that the screen for setting up this new group is displayed.
# Create a new group by filling in only the required fields.
# Create a new group by filling in all the fields.
#5. Clicking on any existing group in the table will allow editing that group in the 3rd column
# Click on the group name and verify that its information will be uploaded for editing on the right side of the screen.
#6. 3rd Column editing/creation of group will allow for group name (must be unique) then display a list of rules that can be enabled or disabled. Default is disabled
# Make sure that when editing you can change the group name
# Try to enter an already existing name for the group so make sure the name is unique.
# Verify that the rules for groups are listed.
# Change some rules and save.
# Please edit and verify that your changes have been kept.
#7. Permission Rule 1: Limit setup view to assigned departments,
# Associate this rule with a group, and make sure that users who belong to this group have access only to your department
#8. Below the list of rules display the dual list of users so they can select which users these rules will apply to.
# check that just below the list of rules is displayed a list with the users.
# verify that you can select one or more users for a given rule
#9. Similar to what we do for e911, as setup can only be assigned to one permission group, so if they current belong to one, they cannot be assigned to another until they are unassigned from a group.
# Try associating a setup who is already in a group of permissions with another group, make sure the app does not allow it.
# Verify that a message is displayed to the setup.
#10. Permission Rule 2: Prevent users from changing Outbound Caller Id
# enable this rule for a setup, then verify that it will no longer be able to change the outgoing caller ID.
#11. Permission Rule 3: Training Status - Will not receive department calls (setup would be removed from call groups - can still receive direct and any other calls and can make calls)
# Enable this rule for a setup, so make sure he does not receive calls from the department.
# Verify that the setup can receive direct calls
# Verify that the setup can make calls.
#12. Permission groups names must unique.
# Verify that you can not save two groups with the same name.
#13. When assigning users to a permission group, admins must be grayed out and not selectable.
# Verify that in the list of users in each group, admin users are disabled for selection
#
  end
    describe('validate permissions groups', :permission_admin_groups) do
      before() do
        set_user_permission(get_user(2), "setup")
        #clear_permissions
        provisioning

        @permission_group = {
          group_name: "Test Permission Group",
          permission1: 'Disable changing Outbound Caller Id',
          permission2: 'View only assigned departments',
          permission3: 'Prevent receiving Department Calls',
          permission4: 'Access Reporting & Analytics',
          permission5: 'Hide Team Activity'          
        }
        
      end
      it('add permission and check if was inserted correctly', :add_permission_and_check) do |e|
        e.step('when I on admin page and access setup page') do
          puts ' when I on admin page and access setup page'
          admin_dashboard.options.admin_setup.click
        end
        e.step('then I have to see the admin setup page and the permission menu') do
          puts ' then I have to see the admin setup page and the permission menu'
          permission.wait_for_admin_title
          expect(permission.admin_title.text).to eql 'Setup'
          expect(permission.menu).to have_css(permission.menu.permission.instance_variable_get(:@query).locator)
        end
       # When selecting this tab, verify that the setup is directed to the permissions settings screen.
       e.step('when I select the permission option') do
         puts '  when I select the permission option'
         permission.menu.permission.click
       end
       e.step('then I have to see the admin permission page') do
          puts '  then I have to see the admin permission page'
          expect(permission.setup_permission.loaded?)
          expect(permission.setup_permission.title.has_content?('Permissions'))
       end
        e.step('when I select to add new permission group')do
          puts '  when I select to add new permission group'
          permission.setup_permission.add_new.click
          expect(permission.permission_details.title.has_content?('Permission Setting'))
          expect(permission.permission_details.loaded?)
        end
        e.step('and I fill permission informations') do
          puts '  and I fill permission informations'
          permission.permission_details.wait_for_permissions_list
          permission.permission_details.txt_group_name.set(@permission_group[:group_name])
          permission.select_option(permission.permission_details.permissions_list, @permission_group[:permission1])
          permission.select_option(permission.permission_details.permissions_list, @permission_group[:permission2])
          permission.select_option(permission.permission_details.permissions_list, @permission_group[:permission3])
          permission.select_option(permission.permission_details.permissions_list, @permission_group[:permission4])
          permission.select_option(permission.permission_details.permissions_list, @permission_group[:permission5])
          permission.select_option(permission.permission_details.users_list, get_user(2)[:full_name])
          permission.permission_details.btn_save.click
        end
        e.step('then I can see the confirmation message') do
          puts '  then I can see the confirmation message'
          permission.modal.loaded?
          expect(permission.modal.modal_text.text).to eql 'Permission Group inserted'
          permission.modal.modal_btn.click
          sleep 2
        end
        e.step('and I have to see this group in the list') do
          puts '  and I have to see this group in the list'
          expect(permission.is_permission_group_in_grid(@permission_group))
        end


      end
      it('check new menu permissions on admin setup', :check_permission_list ) do |e|
        puts '  check new menu permissions on admin setup'
        #1. Add new option, in admin, under RingByName setup for 'Permissions'. Place this below phone numbers.
        # Check the new tab in admin called Permissions;
         e.step('when I on admin page and access setup page') do
           puts ' when I on admin page and access setup page'
           admin_dashboard.options.admin_setup.click
         end
         e.step('then I have to see the admin setup page and the permission menu') do
           puts ' then I have to see the admin setup page and the permission menu'
           permission.wait_for_admin_title
           expect(permission.admin_title.text).to eql 'Setup'
           expect(permission.menu).to have_css(permission.menu.permission.instance_variable_get(:@query).locator)
         end
        # When selecting this tab, verify that the setup is directed to the permissions settings screen.
        e.step('when I select the permission option') do
          puts '  when I select the permission option'
          permission.menu.permission.click
        end
        e.step('then I have to see the admin permission page') do
          puts '  then I have to see the admin permission page'
          permission.setup_permission.wait_for_grid_rows
          expect(permission.setup_permission.title.has_content?('Permissions'))
        end
        #2. 2nd panel will display a table, like on other set up pages, that will display a list of existing permission groups and # of users assign to it.
        # # View the permissions screen and verify that a table is displayed that lists the existing permission groups
        # # Make sure the page labels and pop ups are correct as in the mockup.
        e.step('and I have to see a list of existing permission groups and # of users assign to it') do
          puts '  and I have to see a list of existing permission groups and # of users assign to it'
          expect(permission.setup_permission.permission_grid_header_name.has_content?('Permissions Groups'))
          expect(permission.setup_permission.permission_grid_header_number.has_content?('Number of Users'))
          expect(permission.is_permission_group_in_grid(@permission_groups[0]))
          expect(permission.is_permission_group_in_grid(@permission_groups[1]))
        end
        e.step('') do

        end

 
        # Change the number of items to display per page and verify that it displays the correct number of groups.
        # Select a group and verify that its settings are displayed on the right side.
      end


    end



end