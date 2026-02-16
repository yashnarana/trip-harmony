require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get static_pages_landing_url
    assert_response :success
    assert_select "title", "Project"
  end
end
