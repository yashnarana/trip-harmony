require "test_helper"

class TripTest < ActiveSupport::TestCase
  def setup
    @user = users(:john_doe)
    @trip = trips(:summer_vacation)

    @trip.creator = @user
    @trip.save!
  end

  # Test if Trip is valid with valid attributes
  test "should be valid" do
    assert @trip.valid?
  end

  # Test presence of name
  test "should require a name" do
    @trip.name = nil
    assert_not @trip.valid?
    assert_includes @trip.errors[:name], "can't be blank"
  end

  # Test length of name
  test "name should not exceed maximum length" do
    @trip.name = "a" * 101
    assert_not @trip.valid?
    assert_includes @trip.errors[:name], "is too long (maximum is 100 characters)"
  end

  # Test presence of start_date
  test "should require a start_date" do
    @trip.start_date = nil
    assert_not @trip.valid?
    assert_includes @trip.errors[:start_date], "can't be blank"
  end

  # Test presence of end_date
  test "should require an end_date" do
    @trip.end_date = nil
    assert_not @trip.valid?
    assert_includes @trip.errors[:end_date], "can't be blank"
  end

  # Test end_date after start_date validation
  test "end_date should be after start_date" do
    @trip.end_date = @trip.start_date - 1.day
    assert_not @trip.valid?
    assert_includes @trip.errors[:end_date], "must be after the start date"
  end

  # Test hotel can be blank
  test "hotel can be blank" do
    @trip.hotel = nil
    assert @trip.valid?
  end

  # Test associations
  test "should belong to a creator" do
    assert_respond_to @trip, :creator
    assert_equal @user, @trip.creator
  end

  test "should have many participants through user_trips" do
    assert_respond_to @trip, :participants
  end

  test "should have many expenses" do
    assert_respond_to @trip, :expenses
  end

  # Test dependent destroy on user_trips
  test "destroying trip should destroy associated user_trips" do
    participant = users(:jane_doe)
    UserTrip.create!(user: participant, trip: @trip)
    assert_difference "UserTrip.count", -1 do
      @trip.destroy
    end
  end
end
