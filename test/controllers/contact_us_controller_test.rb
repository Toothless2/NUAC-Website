require 'test_helper'

class ContactUsControllerTest < ActionDispatch::IntegrationTest
  test "should get contactus" do
    get contact_us_contactus_url
    assert_response :success
  end

end
