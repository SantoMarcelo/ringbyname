require 'selenium-webdriver'
require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'faker'
require 'mongo'
require 'allure-rspec'
require 'logger'
require 'httparty'
#require 'Couch'

require_relative 'helpers'
require_relative 'object_factory'
require_relative 'config'


#Rspec configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include AllureRSpec::Adaptor
  config.include Capybara::DSL
  config.include Helpers
  config.include Pages
  config.include Config
  config.include HTTParty
  #config.include Couch::Server
end

#Environment Configuration
$browser = 'firefox'
$environment = 'marcelo'
$branch = 'crm-phase2'
$profile = 'test'

#, :profile => $profile
Capybara.register_driver :selenium do |app|

  if $browser.include?('chrome')
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  elsif $browser.include?('firefox')
    $driver = Capybara::Selenium::Driver.new(app, browser: :firefox, marionette: true)
    
  end

end

Capybara.configure do |c|
  c.default_driver = :selenium

  if $environment != 'production'
    $url = c.app_host   = "http://login.#{$environment}.dev.ringbyname.com/#{$branch}"
  else
    $url = c.app_host   = "http://login.ringbyname.com"
  end
end

Capybara.default_max_wait_time = 10


AllureRSpec.configure do |c|
  c.output_dir = 'log/reports'
  c.clean_dir = false
  c.logging_level = Logger::WARN
end


