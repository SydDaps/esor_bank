require_relative "transaction"
require_relative "database"
require_relative "vault"

module DoTransactions
  @database = Database.instance
  def deposit(teller)
    quit = false 
    until quit == true
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
      else
        puts "Enter Amount :"
        amount = gets 
        vault = Vault.new()
        @transaction_details = {
          :type => "deposit",
          :customer => customer[0],
          :teller  => teller,
          :account_type => :savings,
          :amount => amount.chomp.to_i ,
          :vault => vault
        }
        transaction = Transaction.create(@transaction_details)
        transaction.do
        transaction.generate
        transaction.status = "Success"
        puts transaction.message
        

        puts "Enter '0' to go back or any number to do another deposit"
        puts "-------------------------------"
        puts "\n"
        response = gets 
        if response.chomp == "0"
          quit = true
        end
        next
      end 
    end
  end

  def withdrawal(teller)
    quit = false 
    until quit == true
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
      else
        puts "Enter Amount :"
        amount = gets 
        vault = Vault.new()
        @transaction_details = {
          :type => "withdrawal",
          :customer => customer[0],
          :teller  => teller,
          :account_type => :savings,
          :amount => amount.chomp.to_i ,
          :vault => vault
        }
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
        puts "Enter '0' to go back or  any number to do another withdrawal"
        puts "-------------------------------"
        puts "\n"
        response = gets 
        if response.chomp == "0"
          quit = true
        end
        next
      end 
    end
  end

  def transfer(teller)
    quit = false 
    until quit == true
      puts "Enter Customers Phone number :"
      phone_number = gets
      customer = @database.database[:Customer].select { |record| record.phone_number == phone_number.chomp}
      if !customer[0]
        puts "Customer not found!"
        puts "Enter '0' to go back or any number to try again"
        puts "-------------------------------"
        puts "\n"
        response = gets
        if response.chomp == "0"
          quit = true
        end
        next
      end

      puts "Enter recipient's Phone number :"
      phone_number = gets
      receiver = @database.database[:Customer].select { |record| record.phone_number == phone_number.chomp}
      if !receiver[0]
        puts "Recipient account not found!"
        puts "Enter '0' to go back or any number to try again"
        puts "-------------------------------"
        puts "\n"
        response = gets
        if response.chomp == "0"
          quit = true
        end
        next
      end

      puts "Enter Amount :"
      amount = gets
      puts "Transfer GHC #{amount} to #{receiver[0].first_name} #{receiver[0].last_name} ?"
      puts "Enter '0' cancel or any number to confirm"
      puts "-------------------------------"
      puts "\n"
      response = gets
      if response.chomp == "2"
        quit = true
      end

      @transaction_details = {
        :type => "transfer",
        :customer => customer[0],
        :receiver => receiver[0],
        :teller  => teller,
        :account_type => :savings,
        :amount => amount.chomp.to_f ,
        :vault => Vault.new()
      }
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
      puts "Enter '0' to go back or any number to do another transfer"
      puts "-------------------------------"
      puts "\n"
      response = gets 
      if response.chomp == "0"
        quit = true
      end
      next
    end 
  end
end