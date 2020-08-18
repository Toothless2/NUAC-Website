require 'test_helper'

class AdminPannelControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_pannel_index_url
    assert_response :success
  end

end
