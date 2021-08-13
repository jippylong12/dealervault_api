module DealervaultApi
  class Delivery
    attr_accessor :api_client

    VALID_PARAMETERS = {
      feeds: [:fileTypeCode, :compareDate]
    }

    VALID_VALUES = {
      feeds: {
        fileTypeCode: %w[SL]
      }
    }

    def initialize(api_client)
      @api_client = api_client
      @jwt = self.jwt_token
    end

    # GET - Acquires a JWT token for authentication. Token will be valid for 30 minutes.
    def jwt_token
      local_var_path = 'token'
      body = @api_client.call_api(:GET, local_var_path)
      body['token']
    end

    # GET - Gets information about a delivery.
    def information(request_id)
      local_var_path = "delivery/#{request_id}"
      @api_client.call_api(:GET, local_var_path, headers: {'X-Jwt-Token' => @jwt})
    end

    # GET - Retrieve feeds which DealerVault received updated data since the provided compare date.
    def feeds(program_id, compare_date, file_type_code='SL',params={} )
      local_var_path = "vendor/#{program_id}/feeds/updated-data"
      if compare_date.class == DateTime
        compare_date = compare_date.to_time
      end

      params.merge!({fileTypeCode: file_type_code, compareDate: compare_date.utc.strftime("%FT%T%:z")})
      params = whitelist_params(params, VALID_PARAMETERS, :feeds)
      @api_client.call_api(:GET, local_var_path, headers: {'X-Jwt-Token' => @jwt}, query_params: params)
    end





    def whitelist_params(params, valid_params, key)
      params.slice(*valid_params[key])
    end
  end
end