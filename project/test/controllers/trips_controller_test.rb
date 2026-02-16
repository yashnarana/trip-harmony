require "test_helper"

class TripsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john_doe)
    @trip = trips(:summer_vacation)

    # Sign in user before each test
    sign_in(@user)
  end

  # Index action test
  test "should get index" do
    get trips_path
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:created_trips)
    assert_not_nil assigns(:participating_trips)
  end

  # Show action test
  test "should show trip" do
    get trip_path(@trip)
    assert_response :success
    assert_template :show
    assert_not_nil assigns(:user_debts_summary)
    assert_not_nil assigns(:user_owes_summary)
  end

  # New action test
  test "should get new" do
    get new_trip_path
    assert_response :success
    assert_template :new
  end

  # Create action test
  test "should create trip" do
    assert_difference "Trip.count", 1 do
      post trips_path, params: { trip: { name: "Test Trip", start_date: Date.today, end_date: Date.today + 7.days, hotel: "Test Hotel" } }
    end
    assert_redirected_to trip_path(Trip.last)
    assert_equal "Trip created successfully.", flash[:notice]
  end

  test "should not create trip with invalid data" do
    assert_no_difference "Trip.count" do
      post trips_path, params: { trip: { name: "", start_date: nil, end_date: nil } }
    end
    assert_template :new
  end

  # Edit action test
  test "should get edit trip" do
    get edit_trip_path(@trip)
    assert_response :success
    assert_template :edit
  end

  # Update action test
  test "should update trip" do
    patch trip_path(@trip), params: { trip: { name: "Updated Trip" } }
    assert_redirected_to trip_path(@trip)
    assert_equal "Trip updated successfully.", flash[:notice]
    @trip.reload
    assert_equal "Updated Trip", @trip.name
  end

  test "should not update trip with invalid data" do
    patch trip_path(@trip), params: { trip: { name: "" } }
    assert_template :edit
  end

  # Destroy action test
  test "should destroy trip" do
    assert_difference "Trip.count", -1 do
      delete trip_path(@trip)
    end
    assert_redirected_to trips_path
    assert_equal "Trip deleted successfully.", flash[:notice]
  end

  # Add participant action test
  test "should add participant" do
    assert_difference "@trip.participants.count", 1 do
      post add_participant_trip_path(@trip), params: { participant_email: users(:jane_doe).email }
    end
    assert_redirected_to edit_trip_path(@trip)
    assert_equal "User added as a participant.", flash[:notice]
  end

  test "should not add non-existent participant" do
    post add_participant_trip_path(@trip), params: { participant_email: "nonexistent@example.com" }
    assert_redirected_to edit_trip_path(@trip)
    assert_equal "User not found.", flash[:alert]
  end
end
