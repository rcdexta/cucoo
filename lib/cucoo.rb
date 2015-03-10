require 'cucoo/version'
require 'cucoo/config'
require 'cucoo/api_driver'

module Cucoo

  extend ActiveSupport::Concern

  def self.config
    yield Config
    WebMock.disable_net_connect!(allow: "localhost:#{Cucoo::Config.app_port}")
    WebMock.allow_net_connect!(:net_http_connect_on_start => true)
  end

end
