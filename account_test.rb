require "minitest/autorun"
require_relative "account"

class TestAccount < Minitest::Test

  def setup
    @account = Account.new("savings")
  end

  def test_initialize 
    assert_equal "savings" , @account.type
  end

  def test_depositFunds
    assert_equal 20.0, @account.depositFunds(20)
  end

  def test_withdrawFunds
    @account.balance = 30
    assert_equal 10.0, @account.withdrawFunds(20)
  end

end