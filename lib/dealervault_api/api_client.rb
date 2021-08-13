require 'faraday'
require 'faraday_middleware'

module DealervaultApi
  class ApiClient
    def initialize(user,subscription_key, config = {})
      @host = "https://authenticom.azure-api.net/dv-delivery/v1"
      @user_agent = "DealerVault-Api/#{VERSION}/ruby"

      set_config(config.merge!({user: user,
                                subscription_key: subscription_key}))
    end

    def set_config(config = {})
      @user= config[:user] || ''
      @subscription_key = config[:subscription_key] || ''
    end

    def call_api(http_method, path, opts = {})
      headers = {'X-User' => @user, 'Content-Type' => "application/json", 'Ocp-Apim-Subscription-Key': @subscription_key}
      if opts[:headers]
        headers.merge!(opts[:headers])
      end

      conn = Faraday.new(
        url: @host,
        params: opts[:query_params],
        headers: headers
      ) do |f|
        f.response :json # decode response bodies as JSON
      end
      res = nil
      case http_method.to_sym.downcase
      when :post, :put, :patch, :delete
        res = conn.run_request(http_method.to_sym.downcase, path,  opts[:body], nil)
      when :get
        res = conn.run_request(:get, path,  nil, nil)

      else
      end

      data = nil
      data = res.body if res.status == 200
      data = "success" if res.status == 204

      unless data
        fail ApiError.new(:status => res.status, :response_body => res.body)
      end

      data
    end
  end
end