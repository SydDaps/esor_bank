class User
  attr_accessor :first_name, :last_name, :phone_number, :address, :age, :pin

  def initialize(fields)
    @first_name = fields[:first_name]
    @last_name = fields[:last_name]
    @phone_number = fields[:phone_number]
    @address = fields[:address]
    @pin = fields[:pin]
    @id = fields[:id]
  end
end
