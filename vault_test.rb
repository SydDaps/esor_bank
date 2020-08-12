require "minitest/autorun"
require_relative "vault"


class TestCustomer < Minitest::Test
  def setup
    @customer_fields = {
      :first_name => "Sydney",
      :last_name => "Daps",
      :phone_number => "0246188069",
      :age => 23,
      :address => "23-455-445",
      :account => Account.new(:savings)
    }
    @customer_1 = Customer.new(@customer_fields)

    @customer_fields[:first_name] = "Tom"
    @customer_fields[:account] = Account.new(:savings)
    @customer_2 = Customer.new(@customer_fields)

    @customer_fields[:first_name] = "Joe"
    @customer_fields[:account] = Account.new(:savings)
    @customer_3 = Customer.new(@customer_fields)
    
    
    @teller_fields = {
      :first_name => "Ama",
      :last_name => "Yaaro",
      :phone_number => "0246188069",
      :age => 23,
      :address => "23-455-445"
    }
    teller_1 = Teller.new(@teller_fields)

    @teller_fields[:first_name] = "Zayn"
    teller_2 = Teller.new(@teller_fields)

    #creating 2 different transactions 
    @transaction_details = {
      :type => "deposit",
      :customer => @customer_1,
      :teller  => Teller.new(@teller_fields),
      :account_type => :savings,
      :amount => 100,
    }
    @transaction_1 = Transaction.new(@transaction_details)
   
    @transaction_details[:receiver] = @customer_2
    @transaction_details[:amount] = 40
    @transaction_details[:type] = "transfer"
    @transaction_2 = Transaction.new(@transaction_details)
    @transaction_details[:receiver] = nil

    @transaction_details[:type] = "deposit"
    @transaction_details[:amount] = 40
    @transaction_details[:customer] = @customer_3
    @transaction_3 = Transaction.new(@transaction_details)

    @transaction_details[:type] = "withdrawal"
    @transaction_details[:amount] = 30
    @transaction_details[:customer] = @customer_2
    @transaction_4 = Transaction.new(@transaction_details)

    @transaction_details[:type] = "deposit"
    @transaction_details[:amount] = 200
    @transaction_details[:customer] = @customer_2
    @transaction_5 = Transaction.new(@transaction_details)



    @esor_vault = Vault.new

  end

  def test_initialize
    assert_equal 0.0, @esor_vault.balance
    assert_equal [], @esor_vault.records
  end

  def test_vault_balance_after_transactions
    @transaction_1.perform_transaction
    @transaction_1.generate_message
    @esor_vault.deposit_funds(@transaction_1.amount)
    @esor_vault.records.push(@transaction_1)


    @transaction_2.perform_transaction
    @transaction_2.generate_message
    @esor_vault.records.push(@transaction_2)

    @transaction_3.perform_transaction
    @transaction_3.generate_message
    @esor_vault.deposit_funds(@transaction_3.amount)
    @esor_vault.records.push(@transaction_3)

    @transaction_4.perform_transaction
    @transaction_4.generate_message
    @esor_vault.withdraw_funds(@transaction_4.amount)
    @esor_vault.records.push(@transaction_4)

    @transaction_5.perform_transaction
    @transaction_5.generate_message
    @esor_vault.deposit_funds(@transaction_5.amount)
    @esor_vault.records.push(@transaction_5)

    assert_equal 310.0, @esor_vault.balance
  end

  def test_mini_statement
    sydney_statement = []
    tom_statement = []
    @transaction_1.perform_transaction
    @transaction_1.generate_message
    @esor_vault.deposit_funds(@transaction_1.amount)
    @esor_vault.records.push(@transaction_1)
    sydney_statement.push(@transaction_1.message)

    @transaction_2.perform_transaction
    @transaction_2.generate_message
    @esor_vault.records.push(@transaction_2)
    sydney_statement.push(@transaction_2.message)
    tom_statement.push(@transaction_2.message)

    @transaction_3.perform_transaction
    @transaction_3.generate_message
    @esor_vault.deposit_funds(@transaction_3.amount)
    @esor_vault.records.push(@transaction_3)

    @transaction_4.perform_transaction
    @transaction_4.generate_message
    @esor_vault.withdraw_funds(@transaction_4.amount)
    @esor_vault.records.push(@transaction_4)
    tom_statement.push(@transaction_4.message)


    @transaction_5.perform_transaction
    @transaction_5.generate_message
    @esor_vault.deposit_funds(@transaction_5.amount)
    @esor_vault.records.push(@transaction_5)
    tom_statement.push(@transaction_5.message)


    test_sydney_statement = []
    test_tom_statement = []
    @esor_vault.records.each do |record| 
      if record.customer.first_name == "Sydney"
        test_sydney_statement.push(record.message)
      elsif record.receiver
        if record.receiver.first_name == "Sydney"
          test_sydney_statement.push(record.message)
        end
      end
    end

    @esor_vault.records.each do |record| 
      if record.customer.first_name == "Tom"
        test_tom_statement.push(record.message)
      elsif record.receiver
        if record.receiver.first_name == "Tom"
          test_tom_statement.push(record.message)
        end
      end
    end
    
    assert_equal sydney_statement, test_sydney_statement
    assert_equal tom_statement, test_tom_statement
  end







end