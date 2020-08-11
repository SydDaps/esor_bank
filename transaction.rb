require_relative "customer"
require_relative "teller"

class Transaction
  attr_accessor :type, :customer, :teller, :amount, :account_type
  def initialize(fields)
    @type = fields[:type]
    @customer = fields[:customer]
    @teller = fields[:teller]
    @amount = fields[:amount]
    @account_type = fields[:account_type]
  end

  def perform_transaction
    if @type == "deposit"
      @oldBalance = @customer.balance(@account_type)
      @customer.account[@account_type].deposit_funds(@amount)
    elsif @type == "withdrawal"
      @oldBalance = @customer.balance(@account_type)
      @customer.account[@account_type].withdraw_funds(@amount)
    end
  end

  def message
    message = <<~MESSAGE
      #{@type.capitalize} of GHC #{@amount.to_f} on #{@customer.first_name} #{@account_type} account 
      completed by #{@teller.first_name}. New account balance : GHC #{@customer.balance(@account_type).to_f}
    MESSAGE
    return message
  end
end
