require "minitest/autorun"
require_relative "customer"
require_relative "teller"
require_relative "transaction"
require_relative "vault"
require_relative "error"

class TestCustomer < Minitest::Test
  def setup
    #creating 2 customers 
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
    
    #creating teller to perform transaction_1
    @teller_fields = {
      :first_name => "Ama",
      :last_name => "Yaaro",
      :phone_number => "0246188069",
      :age => 23,
      :address => "23-455-445"
    }

    #creating 2 different transactions 
    @vault = Vault.new()
    @transaction_details = {
      :type => "withdrawal",
      :customer => @customer_1,
      :teller  => Teller.new(@teller_fields),
      :account_type => :savings,
      :amount => 90,
      :vault => @vault
    }
    @transaction_1 = Transaction.new(@transaction_details)
    @transaction_details[:receiver] = @customer_2
    @transaction_2 = Transaction.new(@transaction_details)
  end

  def test_initialize 
    assert_equal @transaction_details[:type] , @transaction_1.type
    assert_equal @transaction_details[:customer] , @transaction_1.customer
    assert_equal @transaction_details[:teller] , @transaction_1.teller
    assert_equal @transaction_details[:account_type] , @transaction_1.account_type
    assert_equal @transaction_details[:amount] , @transaction_1.amount
    assert_nil(@transaction_1.receiver)
    assert_equal @customer_2, @transaction_2.receiver
    assert_equal  @transaction_details[:vault] , @transaction_1.vault
    assert_equal  @transaction_details[:vault] , @transaction_2.vault
  end

  def test_withdrawal
    
    assert_raises  TransactionError do 
      @transaction_1.type = "withdrawal"
      @transaction_1.amount = 50.0
      @transaction_1.do
      #assert_equal 0.0,  @customer_1.balance(:savings)
    end
  end

  def test_deposit
    @transaction_1.type = "deposit"
    @transaction_1.do
    assert_equal 90.0, @customer_1.balance(:savings)
  end

  def test_transfer
    
    #deposit of GHC 90 into customer_1 account 
    @transaction_1.type = "deposit"
    @transaction_1.do
    #transfer of GHC 50 into custer_2 account
    @transaction_2.type = "transfer"
    @transaction_2.amount = 50
    @transaction_2.do
   
    assert_equal 40.0, @customer_1.balance(:savings)
    assert_equal 50.0, @customer_2.balance(:savings)
  end

  

  def test_deposit_message
    @transaction_1.type = "deposit"
    @transaction_1.do
    @transaction_1.generate
    message = <<~MESSAGE
      Deposit of GHC 90.0 into Sydney's savings account completed by Ama. 
      Previous balance : GHC 0.0
      New balance : GHC #{@customer_1.balance(:savings).to_f}
    MESSAGE
    assert_equal message , @transaction_1.message
  end

  def test_withdrawal_message
    skip
    @transaction_1.type = "withdrawal"
    @transaction_1.do
    @transaction_1.generate
    message = <<~MESSAGE
      Withdrawal of GHC 90.0 from Sydney's savings account completed by Ama. 
      Previous balance : GHC 0.0
      New balance : GHC #{@customer_1.balance(:savings).to_f}
    MESSAGE
    assert_equal message , @transaction_1.message
  end

  def test_transfer_message
    @transaction_1.type = "deposit"
    @transaction_1.do
    @transaction_2.type = "transfer"
    @transaction_2.amount = 50
    @transaction_2.do
    @transaction_2.generate
    
    message = <<~MESSAGE
      GHC 50.0 transferred from Sydney to Tom's savings account completed by Ama. 
      Previous balance : GHC 90.0
      New balance : GHC 40.0
    MESSAGE
    assert_equal message , @transaction_2.message
  end
end