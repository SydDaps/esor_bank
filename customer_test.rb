require "minitest/autorun"
require_relative "user"
require_relative "account"
require_relative "customer"

class TestCustomer < Minitest::Test
  def setup
    @fields = {
      :fName => "sydney",
      :lName => "Daps",
      :phoneNumber => "0246188069",
      :age => 23,
      :address => "23-455-445",
      :account => Account.new(:savings)
    }
    @customer = Customer.new(@fields)
  end

  def test_initialize 
    assert_equal @fields[:fName] , @customer.fName 
    assert_equal @fields[:lName] , @customer.lName
    assert_equal @fields[:age] , @customer.age
    assert_equal @fields[:phoneNumber] , @customer.phoneNumber
    assert_equal @fields[:address] , @customer.address
    assert_equal  @fields[:account], @customer.account[:savings]
  end

  def test_check_balance
    assert_equal @fields[:account].balance , @customer.balance(:savings)

    @customer.account[:savings].depositFunds(90)
    assert_equal 90 , @customer.balance(:savings)

    @customer.account[:savings].withdrawFunds(40)
    assert_equal 50 , @customer.balance(:savings)
  end

end