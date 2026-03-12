require 'test_helper'

class BusinessesControllerTest < ActionDispatch::IntegrationTest
  # --- Public access ---

  test "index is accessible by guests" do
    get businesses_path
    assert_response :success
  end

  test "show is accessible by guests" do
    get business_path(businesses(:pizza_place))
    assert_response :success
  end

  # --- Require login ---

  test "new redirects guests to login" do
    get new_business_path
    assert_redirected_to login_path
  end

  test "create redirects guests to login" do
    post businesses_path, params: { business: { name: 'Test' } }
    assert_redirected_to login_path
  end

  test "edit redirects guests to login" do
    get edit_business_path(businesses(:pizza_place))
    assert_redirected_to login_path
  end

  test "update redirects guests to login" do
    patch business_path(businesses(:pizza_place)), params: { business: { name: 'Updated' } }
    assert_redirected_to login_path
  end

  test "destroy redirects guests to login" do
    delete business_path(businesses(:pizza_place))
    assert_redirected_to login_path
  end

  # --- Logged-in user: create ---

  test "create succeeds for logged-in user with valid params" do
    sign_in_as(users(:alice))
    assert_difference('Business.count', 1) do
      post businesses_path, params: {
        business: {
          name: 'Unique New Business',
          description: 'A new place',
          phone_number: '555-0001',
          neighborhood_id: neighborhoods(:downtown).id,
          category_id: categories(:restaurant).id
        }
      }
    end
    assert_response :redirect
  end

  test "create fails for logged-in user with invalid params" do
    sign_in_as(users(:alice))
    assert_no_difference('Business.count') do
      post businesses_path, params: {
        business: { name: '', description: '', phone_number: '',
                    neighborhood_id: neighborhoods(:downtown).id,
                    category_id: categories(:restaurant).id }
      }
    end
    assert_response :success
  end

  # --- Authorization: owner-only actions ---

  test "edit accessible by business owner" do
    sign_in_as(users(:alice))
    get edit_business_path(businesses(:pizza_place))
    assert_response :success
  end

  test "edit redirects non-owner with alert" do
    sign_in_as(users(:bob))
    get edit_business_path(businesses(:pizza_place))
    assert_redirected_to businesses_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "update succeeds for business owner" do
    sign_in_as(users(:alice))
    patch business_path(businesses(:pizza_place)), params: {
      business: { description: 'Updated description' }
    }
    assert_redirected_to business_path(businesses(:pizza_place))
    assert_equal 'Updated description', businesses(:pizza_place).reload.description
  end

  test "update redirects non-owner with alert" do
    sign_in_as(users(:bob))
    patch business_path(businesses(:pizza_place)), params: {
      business: { description: 'Hacked' }
    }
    assert_redirected_to businesses_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "destroy succeeds for business owner" do
    sign_in_as(users(:alice))
    assert_difference('Business.count', -1) do
      delete business_path(businesses(:pizza_place))
    end
    assert_redirected_to businesses_path
  end

  test "destroy blocked for non-owner" do
    sign_in_as(users(:bob))
    assert_no_difference('Business.count') do
      delete business_path(businesses(:pizza_place))
    end
    assert_redirected_to businesses_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end
end
