require 'test_helper'

class NeighborhoodsControllerTest < ActionDispatch::IntegrationTest
  # --- Public access ---

  test "index is accessible by guests" do
    get neighborhoods_path
    assert_response :success
  end

  test "show is accessible by guests" do
    get neighborhood_path(neighborhoods(:downtown))
    assert_response :success
  end

  # --- Require login ---

  test "new redirects guests to login" do
    get new_neighborhood_path
    assert_redirected_to login_path
  end

  test "create redirects guests to login" do
    post neighborhoods_path, params: { neighborhood: { name: 'Test' } }
    assert_redirected_to login_path
  end

  # --- Logged-in user ---

  test "new is accessible by logged-in user" do
    sign_in_as(users(:alice))
    get new_neighborhood_path
    assert_response :success
  end

  test "create succeeds for logged-in user with valid params" do
    sign_in_as(users(:alice))
    assert_difference('Neighborhood.count', 1) do
      post neighborhoods_path, params: {
        neighborhood: { name: 'Chelsea', city: 'New York', state: 'NY', zipcode: '10011' }
      }
    end
    assert_response :redirect
  end

  test "create fails with invalid params" do
    sign_in_as(users(:alice))
    assert_no_difference('Neighborhood.count') do
      post neighborhoods_path, params: {
        neighborhood: { name: '', city: '', state: '', zipcode: '' }
      }
    end
    assert_response :success
  end
end
