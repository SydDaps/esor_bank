require "minitest/autorun"
require_relative "Teller"

class TestTeller < Minitest::Test
  
  def setup
    @fields = {
      :fName => "sydney",
      :lName => "Daps",
      :phoneNumber => "0246188069",
      :age => 23,
      :address => "23-455-445"
    }
    @teller = Teller.new(@fields)
  end

  def test_initialize
    assert_equal @fields[:fName] , @teller.fName 
    assert_equal @fields[:lName] , @teller.lName
    assert_equal @fields[:age] , @teller.age
    assert_equal @fields[:phoneNumber] , @teller.phoneNumber
    assert_equal @fields[:address] , @teller.address
  end

end