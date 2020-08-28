require_relative "../customer"
require_relative "../teller"
require_relative "../transaction"
require_relative "../vault"
require_relative "../error"
require_relative "../database"
require_relative "../validator"
require_relative "../do_transaction"
require_relative "register_customer"
require_relative "transactions_custromer"
require 'optparse'

class Cli
  @@database = Database.instance
  def initialize(teller)
    @teller = teller 
  end

  def self.run
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
      teller = @@database.database[:Teller].select do |record| 
        record.phone_number == options[:phone_number] and record.pin == options[:pin] 
      end
      if !teller[0]
        puts "Invalid teller phone number or pin"
      else
        new(teller.last).main_menu
      end
        
    end
  end

  def main_menu
    quit = false 
    until quit == true do 
      print <<~STATEMENT
      ------------------------------------------------
        ***Welcome #{@teller.first_name}***
        Select a number to continue:
          1.Register Customer
          2.Customer Transaction
          3.Customer statement
          4.Logout
      ------------------------------------------------  
      STATEMENT
      response = gets 
      
      case response.chomp
      when "1"
        CustomerPage.new().register
      when "2"
        transaction = TransactionsPage.new(@teller)
        form = transaction.form
        if form 
          transaction.do
        end
      else
        quit = true
      end
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

Cli.run