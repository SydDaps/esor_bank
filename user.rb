class User
  attr_accessor :fName, :lName, :phoneNumber, :address, :age

  def initialize(fields)
    @fName = fields[:fName]
    @lName = fields[:lName]
    @age = fields[:age]
    @phoneNumber = fields[:phoneNumber]
    @address = fields[:address]
  end
  
end

