module Cucoo
  class Config
    class << self
      attr_accessor :app_port, :stub_host, :stub_port
    end
  end
end