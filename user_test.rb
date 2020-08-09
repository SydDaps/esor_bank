require "minitest/autorun"
require_relative "user"

class TestUser < Minitest::Test
  
  def setup
    @fields = {
      :first_name => "sydney",
      :last_name => "Daps",
      :phone_number => "0246188069",
      :age => 23,
      :address => "23-455-445"
    }
    @user = User.new(@fields)
  end

  def test_initialize
    assert_equal @fields[:first_name] , @user.first_name
    assert_equal @fields[:last_name] , @user.last_name
    assert_equal @fields[:age] , @user.age
    assert_equal @fields[:phone_number] , @user.phone_number
    assert_equal @fields[:address] , @user.address
  end

end