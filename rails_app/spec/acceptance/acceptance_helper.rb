require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "steak"
require 'capybara/rspec'

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Capybara.default_driver = :selenium
Capybara.app_host = 'localhost:3000'
Capybara.default_wait_time = 5
Capybara.run_server = false
Capybara.default_selector = :xpath