require_relative "customer"
require_relative "teller"
require_relative "transaction"
require_relative "vault"
require_relative "error"
require_relative "database"
require_relative "validator"
require_relative "do_transaction"
require 'optparse'


class TellerCLi
  extend Validate
  extend DoTransactions
  @database = Database.instance
  def self.app
    options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: teller_cli.rb -i 0203669141 -p *******"
    
      opts.on("-i","--PhoneNumber i","Teller PhoneNumber") do |i|
        options[:phone_number] = i
      end

      opts.on("-p","--pin p","Teller pin") do |p|
        options[:pin] = p
      end

      opts.on("-h") do |help|
        puts opts
      end
    end.parse!
    
    if !options[:phone_number] or !options[:pin]
      puts "Enter teller phone number and pin to get started"
      puts "start program with '-h' for help"
    else
      teller = @database.database[:Teller].select { |record| record.phone_number == options[:phone_number] and record.pin == options[:pin] }
      if !teller[0]
        puts "Invalid teller phone number or pin"
      else 
        self.teller_page(teller[0])
      end
    end
  end

  def self.teller_page(teller)
    @teller = teller
    quit = false 
    until quit == true do 
      puts "-------------------------------"

      puts "***Welcome #{teller.first_name}***"
      puts "  1.Register Customer"
      puts "  2.Customer Transaction"
      puts "  3.Customer statement"
      puts "  4.Logout"

      puts "-------------------------------"
      puts "\n"
      response = gets 
      if response.chomp == "1"
        self.new_customer_page
      elsif response.chomp == "4"
        quit = true
      elsif response.chomp == "2"
        self.transaction_page
      elsif response.chomp == "3"
        self.customer_statement_page
      else 
        puts "Invalid input enter again!"
      end 
    end
  end

  def self.new_customer_page
    puts "-------------------------------"
    puts "CUstomer registration form"
    puts "  Enter first name :"
    first_name = gets 

    puts "  Enter last name :"
    last_name = gets 

    phone_number = take_phone_number

    puts "  Enter Address :"
    address = gets 

    age = take_age 

    fields = {
      :first_name => first_name.chomp,
      :last_name => last_name.chomp,
      :phone_number => phone_number.chomp,
      :age => age.chomp,
      :address => address,
      :account => Account.new(:savings)
    }

    cus = Customer.create(fields)
    puts "#{cus.first_name} registered successfully *-*"
    puts "-------------------------------"
    puts "\n"
    
    self.teller_page(@teller)
  end

  def self.transaction_page
    quit = false 
    until quit == true 
      puts "-------------------------------"
      puts "Select transaction"
      puts "1.Deposit"
      puts "2.Withdrawal"
      puts "3.Transfer"
      puts "Enter 0 to go back"
      puts "-------------------------------"
      puts "\n"
      response = gets
      if response.chomp == "1"
        puts "Deposit"
        deposit(@teller)
      elsif  response.chomp == "2"
        puts "Withdraw"
        withdrawal(@teller)
      elsif response.chomp == "3"
        puts "Transfer"
        transfer(@teller)
      elsif response.chomp ==  "0"
        self.teller_page(@teller)
      end
    end
  end

  def self.customer_statement_page 
    quit = false 
    until quit == true do 
      puts "Enter Customers Phone number :"
      phone_number = gets
      customer = @database.database[:Customer].select { |record| record.phone_number == phone_number.chomp}
      if !customer[0]
        puts "Customer not found!"

        puts "Enter '0' to go back or '1' try again"
        puts "-------------------------------"
        puts "\n"
        response = gets
        if response.chomp == "0"
          quit = true
        end
        next
      end

      puts "#{customer[0].first_name} #{customer[0].last_name} mini statement."
      customer[0].account[:savings].statement.map { |statement| puts statement }
      quit = true
    end 
  end

end

fields = {
  :first_name => "sydney",
  :last_name => "Daps",
  :phone_number => "0246188069",
  :age => 23,
  :address => "23-455-445",
  :pin => "0000"
}

Teller.create(fields)

fields = {
  :first_name => "Eminem",
  :last_name => "Daps",
  :phone_number => "0246188068",
  :age => 23,
  :address => "23-455-445",
  :pin => "0001"
}

Teller.create(fields)
fields = {
  :first_name => "sydney",
  :last_name => "Daps",
  :phone_number => "1111111111",
  :age => 23,
  :address => "23-455-445",
  :account => Account.new(:savings)
}
Customer.create(fields)

fields_2 = {
  :first_name => "Yvonne",
  :last_name => "Akkkss",
  :phone_number => "2222222222",
  :age => 23,
  :address => "23-455-445",
  :account => Account.new(:savings)
}

Customer.create(fields_2)
Database.instance.database[:Teller].select { |record| record.first_name == "sydney" }
TellerCLi.app





