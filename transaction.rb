require_relative "customer"
require_relative "teller"
require_relative "vault"
require_relative "error"
require_relative "database"
require_relative "query"



class Transaction
  include Query
  extend Query

  attr_accessor :type, :customer_id, :teller_id, :amount, :recipient_id, :status, :account_id
 
  def initialize(fields)
    @type = fields[:type]
    @customer_id = fields[:customer_id]
    @teller_id = fields[:teller_id]
    @amount = fields[:amount]
    @recipient_id = fields[:recipient_id] if fields[:recipient_id] 
    @id = fields[:id]
    @status = fields[:status]
  end

  def do
    begin
      @old_balance = @customer.balance(@account_type)
      if @type == "deposit"
        @customer.account[@account_type].deposit(@amount)
        @vault.deposit(@amount)
      elsif @type == "withdrawal"
        raise TransactionError.new("Not enough funds to perform transaction", "insufficient_balance") if @old_balance < @amount
        @customer.account[@account_type].withdraw(@amount)
        @vault.withdraw(@amount)
      elsif @type == "transfer"
        raise TransactionError.new("Not enough funds to perform transaction", "insufficient_balance") if @old_balance < @amount
        @customer.account[@account_type].withdraw(@amount)
        @receiver.account[@account_type].deposit(@amount)
      end
    rescue TransactionError => e
      return e
    end
  end

  def generate
    if @type == "deposit" or @type == "withdrawal"
      action = "into"
      action = "from" if @type == "withdrawal"
      @message = <<~MESSAGE
        #{@type.capitalize} of GHC #{@amount.to_f} #{action} #{@customer.first_name}'s #{@account_type} account completed by #{@teller.first_name}. 
        Previous balance : GHC #{@old_balance}
        New balance : GHC #{@customer.balance(@account_type).to_f}
      MESSAGE
      

    elsif @type == "transfer"
      @message = <<~MESSAGE
        GHC #{@amount.to_f} transferred from #{@customer.first_name} to #{@receiver.first_name}'s #{@account_type} account completed by #{@teller.first_name}. 
        Previous balance : GHC #{@old_balance}
        New balance : GHC #{@customer.balance(@account_type).to_f}
      MESSAGE
      receiver_statement = <<~STATEMENT
      ------------------------------------------------
        DATE received Amount : #{@amount.to_f} by #{@teller.first_name} 
        Balance : #{@receiver.balance(@account_type).to_f}
      ------------------------------------------------  
      STATEMENT
      @receiver.account[@account_type].add(receiver_statement)
    end
    statement = <<~STATEMENT
    ------------------------------------------------
      DATE #{@type.capitalize} Amount : #{@amount.to_f} by #{@teller.first_name} 
      Balance : #{@customer.balance(@account_type).to_f}
    ------------------------------------------------  
    STATEMENT
    @customer.account[@account_type].add(statement)
    @vault.add(self)
  end
end


