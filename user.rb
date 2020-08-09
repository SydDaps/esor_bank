class User
  attr_accessor :first_name, :last_name, :phone_number, :address, :age

  def initialize(fields)
    @first_name = fields[:first_name]
    @last_name = fields[:last_name]
    @age = fields[:age]
    @phone_number = fields[:phone_number]
    @address = fields[:address]
  end

end
