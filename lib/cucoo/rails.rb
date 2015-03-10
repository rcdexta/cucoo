require 'capybara'
require 'json_spec/cucumber'
require 'webmock/cucumber'
require 'cucumber/rails'
require 'rspec/mocks'
require 'cucoo/stub_helper'
require 'cucoo/cucumber'

Before do
  clear_stubs!
  Capybara.server_port = Cucoo::Config.app_port
  Cucoo::ApiDriver.base_uri "localhost:#{Capybara.current_session.server.port}"
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

