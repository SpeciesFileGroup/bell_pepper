require_relative "test_helper"

class TestBestGeoRef < Test::Unit::TestCase
  def setup
    @id = "123456"
    @locality = "Meadowbrook Park"
    @city = "Urbana"
    @county = "Champaign County"
    @state_province = "Illinois"
    @country_code = "US"
    @continent = "North America"
  end

  def test_id
    VCR.use_cassette("best_georef_id_test") do
      res = BellPepper.bestgeoref(id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code)
      assert_equal("123456", res['Message']['Result']['id'])
    end
  end

  def test_bels_match_string
    VCR.use_cassette("best_georef_match_string_test") do
      res = BellPepper.bestgeoref(id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code)
      assert_equal("usillinoismeadowbrookpark", res['Message']['Result']['bels_match_string'])
    end
  end

  def test_continent
    VCR.use_cassette("best_georef_continent_test") do
      res = BellPepper.bestgeoref(id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code, continent: 'Asia')
      assert_equal("Asia", res['Message']['Result']['continent'])
    end
  end

  def test_state_province
    VCR.use_cassette("best_georef_state_province_test") do
      res = BellPepper.bestgeoref(id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code)
      assert_equal("Illinois", res['Message']['Result']['stateprovince'])
    end
  end

  def test_city
    VCR.use_cassette("best_georef_city_test") do
      res = BellPepper.bestgeoref(id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code)
      assert_equal("Urbana", res['Message']['Result']['city'])
    end
  end

  def test_country
    VCR.use_cassette("best_georef_country_test") do
      res = BellPepper.bestgeoref(id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code, country: "United States of America")
      assert_equal("United States of America", res['Message']['Result']['country'])
    end
  end

  def test_country_code
    VCR.use_cassette("best_georef_country_code_test") do
      res = BellPepper.bestgeoref(id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code)
      assert_equal("US", res['Message']['Result']['countrycode'])
    end
  end

  def test_locality
    VCR.use_cassette("best_georef_locality_test") do
      res = BellPepper.bestgeoref(id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code)
      assert_equal("Meadowbrook Park", res['Message']['Result']['locality'])
    end
  end

  def test_county
    VCR.use_cassette("best_georef_county_test") do
      res = BellPepper.bestgeoref(id: @id, locality: @locality, city: @city, county: @county, state_province: @state_province, country_code: @country_code)
      assert_equal("Champaign County", res['Message']['Result']['county'])
    end
  end
end
