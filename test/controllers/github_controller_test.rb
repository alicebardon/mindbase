require "test_helper"

class GithubControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get github_new_url
    assert_response :success
  end

  test "should get create" do
    get github_create_url
    assert_response :success
  end
end
