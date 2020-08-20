require "minitest/autorun"
require_relative "vault"



class TestVault < Minitest::Test

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

    @vault = Vault.new()

    @transaction_details = {
      :type => "deposit",
      :customer => @customer_1,
      :teller  => Teller.new(@teller_fields),
      :account_type => :savings,
      :amount => 100,

      :vault => @vault
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

  end

  def test_initialize
    assert_equal 0.0, @vault.balance
    assert_equal [], @vault.records
  end

  def test_vault_balance_after_transactions
    @transaction_1.do
   
    @transaction_2.do
    
    @transaction_3.do
    
    @transaction_4.do
    
    @transaction_5.do
   
    assert_equal 310.0, @vault.balance
  end

  def test_mini_statement
    
    @transaction_1.do
    @transaction_1.generate
   

    @transaction_2.do
    @transaction_2.generate
    

    @transaction_3.do
    @transaction_3.generate
    
    @transaction_4.do
    @transaction_4.generate
   


    @transaction_5.do
    @transaction_5.generate

    statement = <<~STATEMENT
    ------------------------------------------------
      DATE Deposit Amount : 40.0 by Zayn 
      Balance : 40.0
    ------------------------------------------------  
    STATEMENT

    assert_equal statement , @customer_3.account[:savings].statement[0]
  end



end