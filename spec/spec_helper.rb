require 'selenium-webdriver'
require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'faker'
#require 'mongo'
require 'allure-rspec'
require 'logger'
require 'httparty'
require 'capybara-bootstrap-datepicker/rspec'
#require 'capybara-bootstrap-datepicker/rspec'
#require 'mysql'
#require 'CouchRest'
require 'json'
#adicionar na master
require_relative 'helpers'
require_relative 'object_factory'
require_relative 'config'
require_relative 'wait_for_ajax'
require_relative '../spec/services/admin/setup/user/center_service'

# Rspec configuration
RSpec.configure do |config|
  # config.expect_with :rspec do |expectations|
  #   expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  # end

  # config.mock_with :rspec do |mocks|
  #   mocks.verify_partial_doubles = true
  # end

  # config.before(:each, type: :system) do
  #   driven_by :rack_test
  # end

  # config.before(:each, type: :system, js: true) do
  #   driven_by :chrome_headless
  # end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include AllureRSpec::Adaptor
  config.include Capybara::DSL
  config.include Helpers
  config.include Pages
  config.include Config
  config.include HTTParty
  config.include CenterService
  # config.include Couch::Server
  config.include WaitForAjax, type: :feature
end


# Environment Configuration
# , :profile => $profile
browser = ENV['BROWSER']
$environment = ENV['ENVIRONMENT']
branch = ENV['BRANCH']
#account_id = '69aed2821f3005236e13b1360f99cf34' #ENV['R_CUSTOMER_ACCOUNT_ID']
# $profile = 'test'

options = Selenium::WebDriver::Firefox::Options.new
#options.profile = 'default'
options.add_preference('dom.webnotifications.enabled', false)

#argument to chromedriver
args = ['window-size=1920,1080']

Capybara.javascript_driver = :chrome_headless

Capybara.register_driver :selenium do |app|
 # headless
 # args.push('--disable-dev-shm-usage')
  
  if browser.include?('headless')
    args.push('headless')
    args.push('disable-gpu')
    args.push('--no-sandbox')
    args.push('--disable-dev-shm-usage')
    args.push('%w[window-size=1920,1080]')
    args.push('log-level=3')
  end

  chrome_caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    'chromeOptions' => {
      'args' => args
    }
  )
  #marionette: true,
  if browser.include?('chrome')
    $driver = Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: chrome_caps)
  elsif browser.include?('firefox')
    $driver = Capybara::Selenium::Driver.new(app, browser: :firefox, marionette: true,options: options)
  end
end

Capybara.configure do |c|
  c.default_driver = :selenium
  $url = c.app_host   = "http://login.#{$environment}.dev.ringbyname.com/#{branch}/"
  #default_max_wait_time = 20
end

Capybara.default_max_wait_time = 10
Capybara.page.driver.browser.manage.window.resize_to(1920,1080)
#Capybara.ignore_hidden_elements = false


AllureRSpec.configure do |c|
  c.output_dir = 'log/reports'
  c.clean_dir = true
  c.logging_level = Logger::WARN
end

