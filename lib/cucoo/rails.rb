require 'cucoo/stub_helper'
require 'cucoo/step_definitions/api_steps'
require 'cucoo/step_definitions/stub_steps'
require 'cucoo/step_definitions/json_spec_steps'
require 'capybara'
require 'webmock/cucumber'

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

