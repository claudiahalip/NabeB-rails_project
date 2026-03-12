require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "root path renders welcome page" do
    get root_path
    assert_response :success
  end
end
