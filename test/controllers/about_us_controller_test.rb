require 'test_helper'

class AboutUsControllerTest < ActionDispatch::IntegrationTest
  test "should get aboutus" do
    get about_us_aboutus_url
    assert_response :success
  end

end
