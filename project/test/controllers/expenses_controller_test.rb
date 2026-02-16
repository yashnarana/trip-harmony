require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:john_doe)
    @trip = trips(:summer_vacation)
    @expense = expenses(:summer_vacation_hotel)

    # Sign in user before each test
    sign_in(@user)
  end

  # New action test
  test "should get new" do
    get new_trip_expense_url(@trip)
    assert_response :success
    assert_template :new
  end

  # Create action test
  test "should create expense" do
    assert_difference("Expense.count", 1) do
      post trip_expenses_url(@trip), params: {
        expense: {
          description: "New Expense",
          t_amount: 100.0,
          expense_date: Date.today,
          categories: "Miscellaneous",
          include_all_trip_participants: "1"
        }
      }
    end
    assert_redirected_to expense_url(Expense.last)
    assert_equal "Expense created successfully!", flash[:notice]
  end

  test "should not create expense with invalid data" do
    assert_no_difference("Expense.count") do
      post trip_expenses_url(@trip), params: {
        expense: {
          description: "",
          t_amount: nil,
          expense_date: nil,
          categories: ""
        }
      }
    end
    assert_template :new
  end
end
