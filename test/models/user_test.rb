require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid with all required attributes" do
    user = User.new(username: 'charlie', email: 'charlie@example.com', password: 'password123')
    assert user.valid?
  end

  test "invalid without username" do
    user = User.new(email: 'charlie@example.com', password: 'password123')
    assert_not user.valid?
    assert_includes user.errors[:username], "can't be blank"
  end

  test "invalid without email" do
    user = User.new(username: 'charlie', password: 'password123')
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "invalid with duplicate username" do
    user = User.new(username: users(:alice).username, email: 'new@example.com', password: 'password123')
    assert_not user.valid?
    assert_includes user.errors[:username], "has already been taken"
  end

  test "invalid with duplicate email" do
    user = User.new(username: 'newuser', email: users(:alice).email, password: 'password123')
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "has many businesses" do
    alice = users(:alice)
    assert_respond_to alice, :businesses
    assert_includes alice.businesses, businesses(:pizza_place)
  end

  test "authenticates with correct password" do
    alice = users(:alice)
    assert alice.authenticate('password123')
  end

  test "does not authenticate with wrong password" do
    alice = users(:alice)
    assert_not alice.authenticate('wrongpassword')
  end

  test "create_from_omniauth finds or creates user by uid and provider" do
    auth = {
      'uid' => '12345',
      'provider' => 'google_oauth2',
      'info' => { 'name' => 'OAuth User', 'email' => 'oauthuser@example.com' }
    }
    user = User.create_from_omniauth(auth)
    assert user.persisted?
    assert_equal 'OAuth User', user.username
    assert_equal 'oauthuser@example.com', user.email
  end
end
