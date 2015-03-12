require 'cucoo/version'
require 'cucoo/config'
require 'cucoo/api_driver'
require 'active_support'

module Cucoo

  extend ActiveSupport::Concern

  def self.config
    yield Config
    WebMock.disable_net_connect!(allow_localhost: true)
  end

end
