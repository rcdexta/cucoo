ENV['RAILS_ROOT'] = 'dummy'
require File.expand_path('../../../dummy/config/environment', __FILE__)

require File.expand_path('../../../lib/cucoo',  __FILE__)
require File.expand_path('../../../lib/cucoo/rails',  __FILE__)
require File.expand_path('../../../lib/cucoo/cucumber',  __FILE__)

Capybara.default_driver = :selenium

Cucoo.config do |config|
  config.app_port = 6666
  config.stub_host = 'api.com'
  config.stub_port = 4080
end