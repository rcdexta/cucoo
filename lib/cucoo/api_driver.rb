require 'httparty'

module Cucoo
  class ApiDriver

    include ::HTTParty

    def post(url, body=nil)
      @response = self.class.post(url, {body: body})
    end

    def post_with_header(url, headers = {}, body=nil)
      @response = self.class.post(url, {body: body, headers: headers})
    end

    def put(url, body=nil)
      @response = self.class.put(url, {body: body})
    end

    def delete(url, body=nil)
      @response = self.class.delete(url, {body: body})
    end

    def get(url)
      @response = self.class.get(url)
    end

    def response
      @response
    end
  end

  class Driver
    extend SingleForwardable
    @api_driver = Cucoo::ApiDriver.new
    def_delegators :@api_driver, :post, :put, :get, :delete, :response, :post_with_header
  end

end
