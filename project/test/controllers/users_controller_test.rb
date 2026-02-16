require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Include Devise test helpers

  setup do
    @user = users(:john_doe) # Assuming a fixture for users is defined
    sign_in @user # Assuming Devise or similar authentication is used
  end

  test "should get show" do
    get user_profile_path # Replace with the correct route helper for the show action
    assert_response :success
    assert assigns(:user) == @user
    assert_not_nil assigns(:user_created_trips)
    assert_not_nil assigns(:user_participating_trips)
    assert_not_nil assigns(:created_trips_summary)
    assert_not_nil assigns(:other_trips_summary)
  end

  test "should get edit" do
    get edit_user_profile_path # Replace with the correct route helper for the edit action
    assert_response :success
    assert assigns(:user) == @user
  end

  test "should update user" do
    patch user_profile_path, params: { user: { first_name: "Updated", last_name: "Name" } }
    assert_redirected_to user_profile_path
    assert_equal "Updated", @user.reload.first_name
    assert_equal "Name", @user.reload.last_name
  end
end
