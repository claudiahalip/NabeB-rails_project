require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "guest can browse businesses without logging in" do
    get businesses_path
    assert_response :success
  end

  test "guest can browse neighborhoods without logging in" do
    get neighborhoods_path
    assert_response :success
  end

  test "guest can view individual business without logging in" do
    get business_path(businesses(:pizza_place))
    assert_response :success
  end

  test "guest is redirected to login when accessing new business form" do
    get new_business_path
    assert_redirected_to login_path
    assert_equal "You must be logged in to access this section", flash[:error]
  end

  test "logged-in user can create a business assigned to them" do
    sign_in_as(users(:alice))

    assert_difference('Business.count', 1) do
      post businesses_path, params: {
        business: {
          name: 'Integration Test Shop',
          description: 'Created via integration test',
          phone_number: '555-0042',
          neighborhood_id: neighborhoods(:downtown).id,
          category_id: categories(:retail).id
        }
      }
    end

    new_business = Business.find_by(name: 'Integration Test Shop')
    assert_not_nil new_business
    assert_equal users(:alice), new_business.user
  end

  test "business owner sees correct ownership — non-owner cannot update" do
    sign_in_as(users(:bob))
    patch business_path(businesses(:pizza_place)), params: {
      business: { name: 'Hijacked Name' }
    }
    assert_redirected_to businesses_path
    assert_equal 'Pizza Place', businesses(:pizza_place).reload.name
  end

  test "user can log in and log out successfully" do
    # Log in
    post login_path, params: { username: users(:alice).username, password: 'password123' }
    assert_redirected_to businesses_path
    assert_equal users(:alice).id, session[:user_id]

    # Log out
    delete logout_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end
end
