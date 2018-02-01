require 'selenium-webdriver'
require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'faker'
require 'mongo'
require 'allure-rspec'
require 'logger'
require 'httparty'
# require 'Couch'

require_relative 'helpers'
require_relative 'object_factory'
require_relative 'config'

# Rspec configuration
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
  # config.include Couch::Server
end

# Environment Configuration
# , :profile => $profile
$browser = ENV['BROWSER']
$environment = ENV['ENVIRONMENT']
$branch = ENV['BRANCH']
# $profile = 'test'

#options to start firefox
options = Selenium::WebDriver::Firefox::Options.new
options.profile = 'default'
options.add_preference('dom.webnotifications.enabled', false)
#options.add_argument('window-size=1920,1080')

#argument to chromedriver
args = ['window-size=1920,1080']

Capybara.register_driver :selenium do |app|
  # headless
  if $browser.include?('headless')
    args.push('headless')
    args.push('disable-gpu')
  end

  chrome_caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    'chromeOptions' => {
      'args' => args
    }
  )

  if $browser.include?('chrome')
    $driver = Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: chrome_caps)
  elsif $browser.include?('firefox')
    $driver = Capybara::Selenium::Driver.new(app, browser: :firefox, marionette: true, options: options)
  end
end

Capybara.configure do |c|
  c.default_driver = :selenium

  if $environment != 'production'
    $url = c.app_host   = "http://login.#{$environment}.dev.ringbyname.com/#{$branch}"
  else
    #$url = c.app_host   = 'http://login.ringbyname.com'
  end
end

Capybara.default_max_wait_time = 10
Capybara.page.driver.browser.manage.window.resize_to(1920,1080)
#Capybara.ignore_hidden_elements = true


AllureRSpec.configure do |c|
  c.output_dir = 'log/reports'
  c.clean_dir = false
  c.logging_level = Logger::WARN
end
