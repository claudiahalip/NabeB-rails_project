require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "valid with a name" do
    category = Category.new(name: 'Healthcare')
    assert category.valid?
  end

  test "invalid without name" do
    category = Category.new
    assert_not category.valid?
    assert_includes category.errors[:name], "can't be blank"
  end

  test "invalid with duplicate name" do
    category = Category.new(name: categories(:restaurant).name)
    assert_not category.valid?
    assert_includes category.errors[:name], "has already been taken"
  end

  test "has many businesses" do
    restaurant = categories(:restaurant)
    assert_respond_to restaurant, :businesses
    assert_includes restaurant.businesses, businesses(:pizza_place)
  end

  test "has many neighborhoods through businesses" do
    restaurant = categories(:restaurant)
    assert_respond_to restaurant, :neighborhoods
    assert_includes restaurant.neighborhoods, neighborhoods(:downtown)
  end
end
