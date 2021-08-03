# frozen_string_literal: true

require_relative "dealervault_api/version"
require_relative 'dealervault_api/api_client'
require_relative 'dealervault_api/api_error'

# APIs
require_relative 'dealervault_api/api/delivery'


module DealervaultApi
  class Error < StandardError; end

  class Client
    def initialize(user, subscription_key, config={})
      @api_client = ApiClient.new(user, subscription_key, config)
      @delivery = Delivery.new(@api_client)
    end

    def delivery
      @delivery
    end
  end


end
