module DealervaultApi
  class Delivery
    attr_accessor :api_client

    def initialize(api_client)
      @api_client = api_client
    end

    # get jwt token
    def get_jwt_token
      local_var_path = 'token'
      @api_client.call_api(:GET, local_var_path)
    end
  end
end