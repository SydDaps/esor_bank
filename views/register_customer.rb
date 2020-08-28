require_relative "../customer"
require_relative "../teller"
require_relative "../transaction"
require_relative "../vault"
require_relative "../error"
require_relative "../database"
require_relative "../validator"
require_relative "../do_transaction"


class CustomerPage
  include Validate

  def initialize
    puts "------------------------------------------------"
    puts "Customer registration form"
    puts "  Enter first name :"
    first_name = gets 

    puts "  Enter last name :"
    last_name = gets 

    phone_number = take_phone_number

    puts "  Enter Address :"
    address = gets 

    age = take_age 

    @fields = {
      :first_name => first_name.chomp,
      :last_name => last_name.chomp,
      :phone_number => phone_number.chomp,
      :age => age.chomp,
      :address => address,
      :account => Account.new(:savings)
    }
  end

  def register
    cus = Customer.create(@fields)
    puts "#{cus.first_name} registered successfully *-*"
    puts "------------------------------------------------\n"
  end

end

