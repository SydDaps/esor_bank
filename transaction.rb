require_relative "customer"
require_relative "teller"


class Transaction
  attr_accessor :type, :customer, :teller, :amount, :account_type, :receiver, :message
  def initialize(fields)
    @type = fields[:type]
    @customer = fields[:customer]
    @teller = fields[:teller]
    @amount = fields[:amount]
    @account_type = fields[:account_type]
    @receiver = fields[:receiver] if fields[:receiver] 
  end

  def perform_transaction
    @oldBalance = @customer.balance(@account_type)
    if @type == "deposit"
      @customer.account[@account_type].deposit_funds(@amount)
    elsif @type == "withdrawal"
      @customer.account[@account_type].withdraw_funds(@amount)
    elsif @type == "transfer"
      @customer.account[@account_type].withdraw_funds(@amount)
      @receiver.account[@account_type].deposit_funds(@amount)
    end
  end

  def generate_message
    if @type == "deposit" or @type == "withdrawal"
      action = "into"
      action = "from" if @type == "withdrawal"
      @message = <<~MESSAGE
        #{@type.capitalize} of GHC #{@amount.to_f} #{action} #{@customer.first_name}'s #{@account_type} account completed by #{@teller.first_name}. 
        Previous balance : GHC #{@oldBalance}
        New balance : GHC #{@customer.balance(@account_type).to_f}
      MESSAGE
    elsif @type == "transfer"
      @message = <<~MESSAGE
        GHC #{@amount.to_f} transferred from #{@customer.first_name} to #{@receiver.first_name}'s #{@account_type} account completed by #{@teller.first_name}. 
        Previous balance : GHC #{@oldBalance}
        New balance : GHC #{@customer.balance(@account_type).to_f}
      MESSAGE
    end
  end
end


