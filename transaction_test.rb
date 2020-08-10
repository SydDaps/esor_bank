require "minitest/autorun"
require_relative "customer"
require_relative "teller"
require_relative "transaction"

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

    @teller_fields = {
      :first_name => "Ama",
      :last_name => "Yaaro",
      :phone_number => "0246188069",
      :age => 23,
      :address => "23-455-445",
    }

    @transaction_details = {
      :type => "withdrawal",
      :customer => Customer.new(@customer_fields),
      :teller  => Teller.new(@teller_fields),
      :account_type => :savings,
      :amount => 90
    }

    @transaction = Transaction.new(@transaction_details)
  end

  def test_initialize 
    assert_equal @transaction_details[:type] , @transaction.transaction_type
    assert_equal @transaction_details[:customer] , @transaction.customer
    assert_equal @transaction_details[:teller] , @transaction.teller
    assert_equal @transaction_details[:account_type] , @transaction.account_type
    assert_equal @transaction_details[:amount] , @transaction.transaction_amount
  end

  def test_withdrawal
    # message = <<~MESSAGE
    #   Withdrawal of GHC 90.0 on Sydney savings account 
    #   completed by Ama. New account balance : GHC -90.0
    # MESSAGE
    @transaction.perform_transaction

    assert_equal -90.0,  @transaction.customer.balance(:savings)
  end

  def test_deposit
    
    @transaction.transaction_type = "deposit"
    @transaction.perform_transaction
    
    
    assert_equal 90.0, @transaction.customer.balance(:savings)
  end

  def test_message
    @transaction.transaction_type = "deposit"
    @transaction.perform_transaction
    message = <<~MESSAGE
      Deposit of GHC 90.0 on Sydney savings account 
      completed by Ama. New account balance : GHC 90.0
    MESSAGE

    assert_equal message , @transaction.message
  end





end