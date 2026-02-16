require "test_helper"

class UserTripTest < ActiveSupport::TestCase
  def setup
    @user = users(:john_doe) # Fixture for the user
    @trip = trips(:summer_vacation) # Fixture for the trip
    @user_trip = UserTrip.new(user: @user, trip: @trip)
  end

  # Test if UserTrip is valid with valid attributes
  test "should be valid" do
    assert @user_trip.valid?
  end

  # Test presence of user
  test "should require a user" do
    @user_trip.user = nil
    assert_not @user_trip.valid?
    assert_includes @user_trip.errors[:user], "must exist"
  end

  # Test presence of trip
  test "should require a trip" do
    @user_trip.trip = nil
    assert_not @user_trip.valid?
    assert_includes @user_trip.errors[:trip], "must exist"
  end

  # Test associations
  test "should belong to user" do
    assert_respond_to @user_trip, :user
    assert_equal @user, @user_trip.user
  end

  test "should belong to trip" do
    assert_respond_to @user_trip, :trip
    assert_equal @trip, @user_trip.trip
  end
end
