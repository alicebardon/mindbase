require "test_helper"

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get init" do
    get test_init_url
    assert_response :success
  end
end
