

Given("I'm a admin user") do
  #admin = get_admin
  config = Configuration.new()
  
  admin = config.get_admin()
  puts admin
  
end

Given("I'm logged in the application") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I access the department page in admin") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I have to see a table with the name and the number of users associated to the group") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("click in the help tooltip") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I have to see this text: {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

When("click to add new call center group") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("insert a new group with this informations: #<name> and <users>") do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I have to see success message: {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I have to see this group in the group's list") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("insert a new group with this information: #<name> and <users>") do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

When("I select a group in the list") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I edit this group with this information: #<name> and <users>") do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I have to see the list updated") do
  pending # Write code here that turns the phrase above into concrete actions
end