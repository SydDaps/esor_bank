require "minitest/autorun"
require_relative "Teller"
require_relative "database"

class TestTeller < Minitest::Test
  
  def setup
    @database = Database.instance
    @fields = {
      :first_name => "sydney",
      :last_name => "Daps",
      :phone_number => "0246188069",
      :age => 23,
      :address => "23-455-445"
    }
    @teller = Teller.new(@fields)
  end
  def teardown 
    Teller.class_variable_set(:@@teller_id, 1001)
  end

  def test_initialize
    assert_equal @fields[:first_name] , @teller.first_name 
    assert_equal @fields[:last_name] , @teller.last_name
    assert_equal @fields[:age] , @teller.age
    assert_equal @fields[:phone_number] , @teller.phone_number
    assert_equal @fields[:address] , @teller.address
  end

  def test_teller_create
    Teller.create(@fields)
    assert_equal  Teller , @database.database[:Teller].last.class
  end

  def test_teller_save
    @teller.save
    assert_equal Teller , @database.database[:Teller].last.class
  end

  def test_find_teller
    teller_1 = Teller.create(@fields)
    teller_2 = @teller.save
    assert_equal teller_1 , Teller.find(1002)
    assert_equal teller_2 , Teller.find(1001)
    assert_equal 0, Teller.find(1003)
  end

  def test_delete_teller
    teller_1 = Teller.create(@fields)
    teller_2 = @teller.save
    Teller.delete(1001)
    assert_equal 0 , Teller.find(1001)
  end

end