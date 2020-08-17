require "minitest/autorun"
require_relative "user"
require_relative "account"
require_relative "customer"

class TestCustomer < Minitest::Test
  def setup
    @fields = {
      :first_name => "sydney",
      :last_name => "Daps",
      :phone_number => "0246188069",
      :age => 23,
      :address => "23-455-445",
      :account => Account.new(:savings)
    }
    @customer = Customer.new(@fields)
  end

  def test_initialize 
    assert_equal @fields[:first_name] , @customer.first_name 
    assert_equal @fields[:last_name] , @customer.last_name
    assert_equal @fields[:age] , @customer.age
    assert_equal @fields[:phone_number] , @customer.phone_number
    assert_equal @fields[:address] , @customer.address
    assert_equal  @fields[:account], @customer.account[:savings]
  end

  def test_check_balance
    assert_equal @fields[:account].balance , @customer.balance(:savings)
  end

  def test_check_balance_after_deposit

    @customer.account[:savings].deposit(90)
    assert_equal 90 , @customer.balance(:savings)
  end

  def test_check_balance_after_withdrawal

    @customer.account[:savings].deposit(90)
    @customer.account[:savings].withdraw(40)

    assert_equal 50 , @customer.balance(:savings)
  end
end