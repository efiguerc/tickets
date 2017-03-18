module Request
  module  JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def include_default_accept_headers(format = Mime::JSON)
      request.headers['Accept']       = "#{request.headers['Accept']},#{format}"
      request.headers['Content-Type'] = format.to_s
    end
  end
end

RSpec.configure do |config|
  config.include Request::JsonHelpers, type: :controller
  config.include Request::HeadersHelpers, type: :controller
  config.before(:each, type: :controller) do
    include_default_accept_headers
  end
end
