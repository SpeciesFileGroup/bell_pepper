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
      res = BellPepper.bestgeoref(give_me: "BEST_GEOREF", id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code)
      assert_equal("123456", res['Message']['Result']['id'])
    end
  end

  def test_bels_match_string
    VCR.use_cassette("best_georef_id_test") do
      res = BellPepper.bestgeoref(give_me: "BEST_GEOREF", id: @id, locality: @locality, city: @city, state_province: @state_province, country_code: @country_code)
      assert_equal("usillinoismeadowbrookpark", res['Message']['Result']['bels_match_string'])
    end
  end
end
