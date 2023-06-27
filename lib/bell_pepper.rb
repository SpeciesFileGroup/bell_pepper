# frozen_string_literal: true

require "erb"
require_relative "bell_pepper/error"
require_relative "bell_pepper/version"
require_relative "bell_pepper/request"
require "bell_pepper/helpers/configuration"

module BellPepper
  extend Configuration

  define_setting :base_url, "https://localityservice.uc.r.appspot.com/api/"
  define_setting :mailto, ENV["BELL_PEPPER_API_EMAIL"]


  # Get a georeference
  #
  # @param give_me [String] The type of georeference match (BEST_GEOREF)
  # @param locality [String] The locality
  # @param city [String] The city
  # @param state_province [String] The state or province
  # @param county [String] The county
  # @param country [String] The country
  # @param country_code [String] The country code
  # @param continent [String] The continent
  # @param id [String] an optional identifier that will be returned with the result
  #
  # @return [Hash] A georeference result hash
  def self.bestgeoref(give_me: nil, locality: nil, city: nil, state_province: nil,
    county: nil, country: nil, country_code: nil, continent: nil, id: nil, verbose: false)
    endpoint = "bestgeoref"
    Request.new(endpoint: endpoint, give_me: give_me, locality: locality, city: city, state_province: state_province,
      county: county, country: country, country_code: country_code, continent: continent, id: id, 
      verbose: verbose).perform
  end
end
