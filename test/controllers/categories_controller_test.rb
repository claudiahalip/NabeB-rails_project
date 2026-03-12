require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  # --- Require login ---

  test "new redirects guests to login" do
    get new_category_path
    assert_redirected_to login_path
  end

  test "create redirects guests to login" do
    post categories_path, params: { category: { name: 'Healthcare' } }
    assert_redirected_to login_path
  end

  # --- Logged-in user ---

  test "new is accessible by logged-in user" do
    sign_in_as(users(:alice))
    get new_category_path
    assert_response :success
  end

  test "create succeeds for logged-in user with valid params" do
    sign_in_as(users(:alice))
    assert_difference('Category.count', 1) do
      post categories_path, params: { category: { name: 'Healthcare' } }
    end
    assert_response :redirect
  end

  test "create fails with duplicate name" do
    sign_in_as(users(:alice))
    assert_no_difference('Category.count') do
      post categories_path, params: { category: { name: categories(:restaurant).name } }
    end
    assert_response :success
  end
end
