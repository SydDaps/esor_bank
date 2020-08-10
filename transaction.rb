require_relative "customer"
require_relative "teller"

class Transaction
  attr_accessor :transaction_type, :customer, :teller, :transaction_amount, :account_type
  def initialize(fields)
    @transaction_type = fields[:type]
    @customer = fields[:customer]
    @teller = fields[:teller]
    @transaction_amount = fields[:amount]
    @account_type = fields[:account_type]
  end

  def perform_transaction
    if @transaction_type == "deposit"
      @oldBalance = @customer.balance(@account_type)
      @customer.account[@account_type].deposit_funds(@transaction_amount)
    elsif @transaction_type == "withdrawal"
      @oldBalance = @customer.balance(@account_type)
      @customer.account[@account_type].withdraw_funds(@transaction_amount)
    end
  end

  def message
    message = <<~MESSAGE
      #{@transaction_type.capitalize} of GHC #{@transaction_amount.to_f} on #{@customer.first_name} #{@account_type} account 
      completed by #{@teller.first_name}. New account balance : GHC #{@customer.balance(@account_type).to_f}
    MESSAGE
    return message
  end
end
