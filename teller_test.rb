require "minitest/autorun"
require_relative "Teller"

class TestTeller < Minitest::Test
  
  def setup
    @fields = {
      :first_name => "sydney",
      :last_name => "Daps",
      :phone_number => "0246188069",
      :age => 23,
      :address => "23-455-445"
    }
    @teller = Teller.new(@fields)
  end

  def test_initialize
    assert_equal @fields[:first_name] , @teller.first_name 
    assert_equal @fields[:last_name] , @teller.last_name
    assert_equal @fields[:age] , @teller.age
    assert_equal @fields[:phone_number] , @teller.phone_number
    assert_equal @fields[:address] , @teller.address
  end
end