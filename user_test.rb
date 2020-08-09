require "minitest/autorun"
require_relative "user"

class TestUser < Minitest::Test
  
  def setup
    @fields = {
      :fName => "sydney",
      :lName => "Daps",
      :phoneNumber => "0246188069",
      :age => 23,
      :address => "23-455-445"
    }
    @user = User.new(@fields)
  end

  def test_initialize
    assert_equal @fields[:fName] , @user.fName 
    assert_equal @fields[:lName] , @user.lName
    assert_equal @fields[:age] , @user.age
    assert_equal @fields[:phoneNumber] , @user.phoneNumber
    assert_equal @fields[:address] , @user.address
  end

end