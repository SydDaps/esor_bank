require_relative "../customer"
require_relative "../teller"
require_relative "../transaction"
require_relative "../vault"
require_relative "../error"
require_relative "../database"
require_relative "../validator"
require_relative "../do_transaction"

class TransactionsPage
  @@database = Database.instance
  def initialize(teller)
    @teller = teller
    print <<~STATEMENT
      ------------------------------------------------
        Select transaction to continue:
          1.Deposit
          2.Withdrawal
          3.Transfer
        Enter '0' to go back to the main menu
      ------------------------------------------------  
      STATEMENT
      response = gets
      case response.chomp

      when "1"
        @type = "deposit"
      when  "2"
        @type = "withdrawal"
      else
        @type = "transfer"
      end
  end


  def form
    quit = false
    until quit == true
      receiver = nil
      puts "------------------------------------------------"
      puts "Customer Transaction form."
      puts "  Enter Customers Phone number :"
      phone_number = gets
      customer = @@database.database[:Customer].select { |record| record.phone_number == phone_number.chomp}
      if !customer[0]
        puts "Customer not found!"
        puts "Enter '0' to go back or any number to try again"
        puts "------------------------------------------------"
        puts "\n"
        response = gets
        if response.chomp == "0"
          quit = true
        end
        next
      end

      if @type == "transfer"
        puts "  Enter recipient's Phone number :"
        phone_number = gets
        receiver = @@database.database[:Customer].select { |record| record.phone_number == phone_number.chomp}
        if !receiver[0]
          puts "Recipient account not found!"
          puts "Enter '0' to go back or any number to try again"
          puts "------------------------------------------------"
          response = gets
          if response.chomp == "0"
            quit = true
          end
          next
        end
         
        puts "Transfer to #{receiver[0].first_name} #{receiver[0].last_name} ?"
        puts " Enter '0' cancel or any number to confirm"
        puts "------------------------------------------------"
        response = gets
        if response.chomp == "0"
          quit = true
          break
        end

        receiver = receiver[0]

      end

      puts "  Enter Amount :"
      amount = gets
      

      @transaction_details = {
        :type => @type,
        :customer => customer[0],
        :receiver => receiver,
        :teller  => @teller,
        :account_type => :savings,
        :amount => amount.chomp.to_f ,
        :vault => Vault.new()
      }
      return true
      quit = true
    end
  end

  def do 
    transaction = Transaction.create(@transaction_details)
    error = transaction.do
    if error.class == TransactionError
      puts error.message
      transaction.status = "Failed"
    else
      transaction.generate
      transaction.status = "Success"
      puts transaction.message
    end
  end
end