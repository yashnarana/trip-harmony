require "test_helper"

class UserExpenseTest < ActiveSupport::TestCase
  def setup
    @user = users(:john_doe)
    @expense = expenses(:summer_vacation_hotel)
    @user_expense = UserExpense.new(user: @user, expense: @expense)
  end

  # Test setup validity
  test "should be valid" do
    assert @user_expense.valid?
  end

  # Test presence of user
  test "should require a user" do
    @user_expense.user = nil
    assert_not @user_expense.valid?
    assert_includes @user_expense.errors[:user], "must exist"
  end

  # Test presence of expense
  test "should require an expense" do
    @user_expense.expense = nil
    assert_not @user_expense.valid?
    assert_includes @user_expense.errors[:expense], "must exist"
  end

  # Test associations
  test "should belong to user" do
    assert_respond_to @user_expense, :user
    assert_equal @user, @user_expense.user
  end

  test "should belong to expense" do
    assert_respond_to @user_expense, :expense
    assert_equal @expense, @user_expense.expense
  end
end
