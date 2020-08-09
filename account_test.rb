require "minitest/autorun"
require_relative "account"

class TestAccount < Minitest::Test

  def setup
    @account = Account.new("savings")
  end

  def test_initialize 
    assert_equal "savings" , @account.type
  end

  def test_deposit_funds
    assert_equal 20.0, @account.deposit_funds(20)
  end

  def test_withdraw_funds
    @account.balance = 30
    assert_equal 10.0, @account.withdraw_funds(20)
  end

end