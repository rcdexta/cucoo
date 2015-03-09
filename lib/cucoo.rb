require 'cucoo/version'
require 'cucoo/config'
require 'cucoo/api_driver'

module Cucoo

  extend ActiveSupport::Concern

  def self.config
    yield Config
    WebMock.disable_net_connect!(allow: %W(127.0.0.1:#{Cucoo::Config.app_port} localhost:#{Cucoo::Config.app_port}))
  end

end
