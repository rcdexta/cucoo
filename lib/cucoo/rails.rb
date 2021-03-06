require 'capybara'
require 'json_spec/cucumber'
require 'webmock/cucumber'
require 'cucumber/rails' if defined?(Rails)
require 'rspec/mocks'
require 'cucoo/stub_helper'
require 'cucoo/cucumber'

Before do
  clear_stubs!
  Capybara.server_port = Cucoo::Config.app_port
  app_port = Capybara.current_session.server ? Capybara.current_session.server.port : Cucoo::Config.app_port
  Cucoo::ApiDriver.base_uri "localhost:#{app_port}"
end

World(RSpec::Mocks::ExampleMethods)

Before do
  RSpec::Mocks.setup
end

After do
  begin
    RSpec::Mocks.verify
  ensure
    RSpec::Mocks.teardown
  end
end

