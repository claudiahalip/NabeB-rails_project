require 'test_helper'

class NeighborhoodTest < ActiveSupport::TestCase
  def valid_neighborhood_attrs
    { name: 'Midtown', city: 'New York', state: 'NY', zipcode: '10036' }
  end

  test "valid with all required attributes" do
    neighborhood = Neighborhood.new(valid_neighborhood_attrs)
    assert neighborhood.valid?
  end

  test "invalid without name" do
    neighborhood = Neighborhood.new(valid_neighborhood_attrs.except(:name))
    assert_not neighborhood.valid?
    assert_includes neighborhood.errors[:name], "can't be blank"
  end

  test "invalid without city" do
    neighborhood = Neighborhood.new(valid_neighborhood_attrs.except(:city))
    assert_not neighborhood.valid?
    assert_includes neighborhood.errors[:city], "can't be blank"
  end

  test "invalid without state" do
    neighborhood = Neighborhood.new(valid_neighborhood_attrs.except(:state))
    assert_not neighborhood.valid?
    assert_includes neighborhood.errors[:state], "can't be blank"
  end

  test "invalid without zipcode" do
    neighborhood = Neighborhood.new(valid_neighborhood_attrs.except(:zipcode))
    assert_not neighborhood.valid?
    assert_includes neighborhood.errors[:zipcode], "can't be blank"
  end

  test "invalid with duplicate name in same zipcode" do
    neighborhood = Neighborhood.new(valid_neighborhood_attrs.merge(
      name: neighborhoods(:downtown).name,
      zipcode: neighborhoods(:downtown).zipcode
    ))
    assert_not neighborhood.valid?
    assert neighborhoods(:downtown).errors[:name].empty? || !neighborhood.valid?
  end

  test "valid with same name in different zipcode" do
    neighborhood = Neighborhood.new(valid_neighborhood_attrs.merge(
      name: neighborhoods(:downtown).name,
      zipcode: '99999'
    ))
    assert neighborhood.valid?
  end

  test "has many businesses" do
    downtown = neighborhoods(:downtown)
    assert_respond_to downtown, :businesses
    assert_includes downtown.businesses, businesses(:pizza_place)
  end

  test "has many categories through businesses" do
    downtown = neighborhoods(:downtown)
    assert_respond_to downtown, :categories
    assert_includes downtown.categories, categories(:restaurant)
  end

  test "alpha_sort scope orders by name" do
    sorted = Neighborhood.alpha_sort.map(&:name)
    assert_equal sorted.sort, sorted
  end

  test "search_neighborhood scope finds by name" do
    results = Neighborhood.search_neighborhood('downtown')
    assert_includes results, neighborhoods(:downtown)
    assert_not_includes results, neighborhoods(:uptown)
  end

  test "search_neighborhood scope is case insensitive" do
    results = Neighborhood.search_neighborhood('DOWNTOWN')
    assert_includes results, neighborhoods(:downtown)
  end

  test "sort_nebe_businesses returns neighborhoods sorted by business count descending" do
    sorted = Neighborhood.sort_nebe_businesses
    assert sorted.first.businesses.size >= sorted.last.businesses.size
  end
end
