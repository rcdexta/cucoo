module StubHelper
  def expand_url(url)
    ['http://', Cucoo::Config.stub_host, ':', Cucoo::Config.stub_port, url].join
  end

  def assert_all_stubs!
    @stubs.each do |stub|
      expect(stub).to have_been_requested
    end
  end

  def stub_my_request(method, url, params={})
    response = if params[:file]
                 File.new(params['file']).read
               else
                 params[:response] || {}.to_json
               end
    status = params[:status] ? params[:status].to_i : 200
    stub_obj = stub_request(method, expand_url(url))
    @stubs << stub_obj
    stub_obj.with(body: params[:request], headers: {'Content-Type' => 'application/json'}) if params[:request]
    stub_obj.with(body: params[:form_params], headers: {'Content-Type' => 'application/x-www-form-urlencoded'}) if params[:form_params]
    stub_obj.to_return(body: response, status: status)
  end

  def clear_stubs!
    @stubs = []
  end
end

World(StubHelper)