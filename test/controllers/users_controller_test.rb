require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "GET signup renders the signup page" do
    get signup_path
    assert_response :success
  end

  test "POST signup with valid params creates user and logs in" do
    assert_difference('User.count', 1) do
      post signup_path, params: {
        user: {
          username: 'newuser',
          email: 'newuser@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end
    assert_redirected_to businesses_path
  end

  test "POST signup with invalid params redirects back to signup" do
    assert_no_difference('User.count') do
      post signup_path, params: {
        user: { username: '', email: '', password: 'password123' }
      }
    end
    assert_redirected_to signup_path
  end

  test "GET user show renders user profile" do
    get user_path(users(:alice))
    assert_response :success
  end
end
