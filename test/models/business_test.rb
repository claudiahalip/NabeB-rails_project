require 'test_helper'

class BusinessTest < ActiveSupport::TestCase
  def valid_business_attrs
    {
      name: 'New Shop',
      description: 'A brand new shop',
      phone_number: '555-9999',
      neighborhood: neighborhoods(:downtown),
      user: users(:alice),
      category: categories(:restaurant)
    }
  end

  test "valid with all required attributes" do
    business = Business.new(valid_business_attrs)
    assert business.valid?
  end

  test "invalid without name" do
    business = Business.new(valid_business_attrs.except(:name))
    assert_not business.valid?
    assert_includes business.errors[:name], "can't be blank"
  end

  test "invalid without description" do
    business = Business.new(valid_business_attrs.except(:description))
    assert_not business.valid?
    assert_includes business.errors[:description], "can't be blank"
  end

  test "invalid without phone_number" do
    business = Business.new(valid_business_attrs.except(:phone_number))
    assert_not business.valid?
    assert_includes business.errors[:phone_number], "can't be blank"
  end

  test "invalid with duplicate name" do
    business = Business.new(valid_business_attrs.merge(name: businesses(:pizza_place).name))
    assert_not business.valid?
    assert_includes business.errors[:name], "has already been taken"
  end

  test "invalid with duplicate phone_number" do
    business = Business.new(valid_business_attrs.merge(phone_number: businesses(:pizza_place).phone_number))
    assert_not business.valid?
    assert_includes business.errors[:phone_number], "has already been taken"
  end

  test "belongs to neighborhood" do
    assert_equal neighborhoods(:downtown), businesses(:pizza_place).neighborhood
  end

  test "belongs to user" do
    assert_equal users(:alice), businesses(:pizza_place).user
  end

  test "belongs to category" do
    assert_equal categories(:restaurant), businesses(:pizza_place).category
  end

  test "alpha_sort scope orders by name" do
    sorted = Business.alpha_sort.map(&:name)
    assert_equal sorted.sort, sorted
  end

  test "search_business scope finds by name" do
    results = Business.search_business('pizza')
    assert_includes results, businesses(:pizza_place)
    assert_not_includes results, businesses(:book_store)
  end

  test "search_business scope is case insensitive" do
    results = Business.search_business('PIZZA')
    assert_includes results, businesses(:pizza_place)
  end

  test "search_business scope finds by description" do
    results = Business.search_business('independent')
    assert_includes results, businesses(:book_store)
  end

  test "neighborhood_name= sets neighborhood by name" do
    business = Business.new(valid_business_attrs)
    business.neighborhood_name = 'Downtown'
    assert_equal neighborhoods(:downtown), business.neighborhood
  end
end
