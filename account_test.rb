require "minitest/autorun"
require_relative "account"

class TestAccount < Minitest::Test

  def setup
    @account = Account.new("savings")
  end

  def test_initialize 
    assert_equal "savings" , @account.type
    assert_equal [], @account.statement
  end

  def test_deposit
    assert_equal 20.0, @account.deposit(20)
  end

  def test_withdraw
    @account.balance = 30
    assert_equal 10.0, @account.withdraw(20)
  end

  def test_add_statement
    statement_1 = "DATE  DEPOSIT AMOUNT"
    statement_2 = "DATE  WITHDRAWAL AMOUNT"
    @account.add(statement_1)
    @account.add(statement_2)
    assert_equal [statement_1, statement_2] , @account.statement
  end

end