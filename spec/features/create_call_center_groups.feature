Feature: Create a new call center group
  As a admin user
  When I access the department admin page
  I want to manipulate call centers groups

  @inprogress
  Scenario: Call center groups list 
    Given I'm a admin user
    And I'm logged in the application
    When I access the department page in admin
    Then I have to see a table with the name and the number of users associated to the group

 # Next to the title, add a ? help with the text: Call center locations allow administrators to associate and view information about their call center agents based on their geographic locations.

Scenario: Validate help tooltip
  Given I'm a admin user
  And I'm logged in the application
  When I access the department page in admin
  And click in the help tooltip
  Then I have to see this text: 'Call center locations allow administrators to associate and view information about their call center agents based on their geographic locations.'

#Ability to add a call center group (add form will be in 3rd column
#When adding or editing, the 3rd column will display the name of the group (editable field) and a list of all users below so they can check the box (or uncheck) which users they want (just like departments do)
Scenario: Add call center group
  Given I'm a admin user
  And I'm logged in the application
  When I access the department page in admin
  And click to add new call center group
  And insert a new group with this informations:
      |name             |users         |
      |Call center group|User 1, User 2|
  Then I have to see success message: 'Call center Group inserted.'
  And I have to see this group in the group's list
    # Examples:
    #   |name             |users         |
    #   |Call center group|User 1, User 2|
      
Scenario: Validate required fields
  Given I'm a admin user
  And I'm logged in the application
  When I access the department page in admin
  And click to add new call center group
  And insert a new group with this informations: 
      |name             |users         |
      |                 |User 1, User 2|
  Then I have to see validation message: 'Sorry, you must set a name for this Call center Group.'
    # Examples:
    #   |name             |users         |
    #   |                 |User 1, User 2|

Scenario: Edit call center group
  Given I'm a admin user
  And I'm logged in the application
  When I access the department page in admin
  And I select a group in the list
  And I edit this group with this information: #<name> and <users>
      |name                    |users         |
      |Call center group Edited|User 3, User 4|
  Then I have to see success message: 'Call center Group updated.'
  And I have to see the list updated
    # Examples:
    #   |name                    |users         |
    #   |Call center group Edited|User 3, User 4|

