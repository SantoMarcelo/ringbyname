Feature: Queue monitor boxes
  As an admin, I want to see the queues and their stats/members

  #The default view will be the queue view and all queues and will be listed alphabetically. 
  #Each queue will be its own section and be collapsible, the default will be not collapsed

  Scenario: Queue list
    Given I'm a admin user
    And I have active queues
    And I'm logged in the application
    When I access the queue monitor
    Then I see all queues listed alphabetically
    And not collapsed

# Collapse the queue

Scenario: Queue collapsble
    Given I'm a admin user
    And I have active queues
    And I'm logged in the application
    When I access the queue monitor
    And  I click on collapsble icon
    Then I have to see especific queue collapsed
    And this following items "Calls, Dropped, Received Calls, Holding, Avg Hold Time, Avg Talk Time"

    



   