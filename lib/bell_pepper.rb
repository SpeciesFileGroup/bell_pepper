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
  # @param id [String] an optional identifier that will be returned with the result
  #
  # @param city [String] The city
  # @param continent [String] The name of the continent in which the Location occurs
  # @param county [String] The full, unabbreviated name of the next smaller administrative region than stateProvince (county, shire, department, etc.) in which the Location occurs
  # @param country [String] The name of the country or major administrative unit in which the Location occurs
  # @param country_code [String] The ISO 3166-1-alpha-2 code for the country in which the Location occurs
  # @param give_me [String] The type of georeference match (BEST_GEOREF)
  # @param locality [String] The specific description of the place
  # @param state_province [String] The name of the next smaller administrative region than country (state, province, canton, department, region, etc.) in which the Location occurs
  #
  # @return [Hash] A georeference result hash
  def self.bestgeoref(id: nil, city: nil, continent: nil, county: nil, country: nil, country_code: nil, 
    give_me: "BEST_GEOREF", island: nil, locality: nil, municipality: nil, state_province: nil, verbose: false)
    endpoint = "bestgeoref"
    Request.new(
      endpoint: endpoint, 
      id: id, 
      city: city, 
      continent: continent, 
      county: county, 
      country: country, 
      country_code: country_code, 
      give_me: give_me, 
      locality: locality, 
      state_province: state_province,
      verbose: verbose).perform
  end
end
