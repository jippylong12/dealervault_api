module DealervaultApi
  class Delivery
    attr_accessor :api_client

    VALID_PARAMETERS = {
      feeds: [:fileTypeCode, :compareDate],
      create: [:type, :historicalMonths, :catchupStartDate, :catchupEndDate]
    }

    VALID_VALUES = {
      feeds: {
        fileTypeCode: %w[SL]
      },
      create: {
        type: %w[Sample Daily Historical Catchup],
        historicalMonths: true,
        catchupStartDate: true,
        catchupEndDate: true
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

    # GET - Retrieves a paged data set.
    def data_set(request_id, page_size, params={})
      local_var_path = "delivery"
      params.merge!({requestId: request_id, pageSize: page_size})
      @api_client.call_api(:GET, local_var_path, headers: {'X-Jwt-Token' => @jwt}, query_params: params)
    end

    # POST - Initiate a dealer delivery
    def create(program_id, rooftop_id, file_type, delivery_type, options={})
      local_var_path = "delivery"
      options.merge!({type: delivery_type})
      options = whitelist_params(options, VALID_PARAMETERS, :create)

      body = {
        programId: program_id,
        rooftopId: rooftop_id,
        fileType: file_type,
        options: options
      }

      body = @api_client.call_api(:POST, local_var_path, headers: {'X-Jwt-Token' => @jwt}, body: body)
      body
    end



    def whitelist_params(params, valid_params, key)
      params.slice(*valid_params[key])
    end
  end
end