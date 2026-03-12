require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "GET login renders the login page" do
    get login_path
    assert_response :success
  end

  test "POST login with valid credentials sets session and redirects" do
    post login_path, params: { username: users(:alice).username, password: 'password123' }
    assert_redirected_to businesses_path
    assert_equal users(:alice).id, session[:user_id]
  end

  test "POST login with invalid credentials redirects back to login" do
    post login_path, params: { username: users(:alice).username, password: 'wrongpassword' }
    assert_redirected_to '/login'
    assert_nil session[:user_id]
  end

  test "POST login with unknown username redirects back to login" do
    post login_path, params: { username: 'nobody', password: 'password123' }
    assert_redirected_to '/login'
    assert_nil session[:user_id]
  end

  test "DELETE logout clears session and redirects to root" do
    sign_in_as(users(:alice))
    delete logout_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end
end
