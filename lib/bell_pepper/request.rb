require_relative "faraday" # !! Potential ruby 3.0 difference in module loading? relative differs from Serrano
require "faraday/follow_redirects"
require_relative "utils"
require "bell_pepper/error"

module BellPepper
  class Request
    attr_accessor :endpoint
    attr_accessor :verbose

    attr_accessor :options

    def initialize(**args)
      @endpoint = args[:endpoint]
      @verbose = args[:verbose]
      
      @id = args[:id]
      
      @city = args[:city]
      @continent = args[:continent]
      @county = args[:county]
      @country = args[:country]
      @country_code = args[:country_code]
      @give_me = args[:give_me]
      @locality = args[:locality]
      @state_province = args[:state_province]
      
      @options = args[:options] # TODO: not added at bell_pepper.rb
    end

    def perform

      for_location = {
        id: @id, 
        city: @city, 
        continent: @continent,
        county: @county,
        country: @country, 
        countrycode: @country_code, 
        locality: @locality, 
        stateprovince: @state_province
        }
      for_location = for_location.delete_if { |_k, v| v.nil? }
      body = {"give_me": @give_me, "for_location": for_location}

      conn = if verbose
               Faraday.new(url: BellPepper.base_url, request: { params_encoder: Faraday::FlatParamsEncoder }) do |f|
                 f.response :logger
                 f.request :json
                 f.use Faraday::BellPepperErrors::Middleware
                 f.adapter Faraday.default_adapter
               end
             else
               Faraday.new(url: BellPepper.base_url, request: { params_encoder: Faraday::FlatParamsEncoder }) do |f|
                 f.use Faraday::BellPepperErrors::Middleware
                 f.request :json
                 f.adapter Faraday.default_adapter
               end
             end

      conn.headers['Authorization'] = "Bearer #{@token}" unless @token.nil?
      conn.headers['Accept'] = 'application/json,*/*'
      conn.headers[:user_agent] = make_user_agent
      conn.headers["X-USER-AGENT"] = make_user_agent

      res = conn.post endpoint, body.to_json

      # Handles endpoints that do not return JSON
      begin
        MultiJson.load(res.body)
      rescue MultiJson::ParseError
        res.body
      end
      
    end
  end
end
