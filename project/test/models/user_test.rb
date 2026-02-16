require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @john = users(:john_doe)
    @jane = users(:jane_doe)
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @john.valid?
  end

  test "should require an email" do
    @john.email = nil
    assert_not @john.valid?
    assert_includes @john.errors[:email], "can't be blank"
  end

  test "should require a valid email format" do
    @john.email = "invalid_email"
    assert_not @john.valid?
    assert_includes @john.errors[:email], "is invalid"
  end

  test "should require a unique email" do
    duplicate_user = @john.dup
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "should require a password of at least 6 characters" do
    @john.password = "short"
    assert_not @john.valid?
    assert_includes @john.errors[:password], "is too short (minimum is 6 characters)"
  end
end
