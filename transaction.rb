require_relative "customer"
require_relative "teller"

require_relative "vault"


class Transaction
  attr_accessor :type, :customer, :teller, :amount, :account_type, :receiver, :message , :vault
  def initialize(fields)
    @type = fields[:type]
    @customer = fields[:customer]
    @teller = fields[:teller]
    @amount = fields[:amount]
    @account_type = fields[:account_type]

    @vault = fields[:vault]
    @receiver = fields[:receiver] if fields[:receiver] 
  end

  def do
    @old_balance = @customer.balance(@account_type)
    if @type == "deposit"
      @customer.account[@account_type].deposit(@amount)
      @vault.deposit(@amount)
    elsif @type == "withdrawal"
      @customer.account[@account_type].withdraw(@amount)
      @vault.withdraw(@amount)
    elsif @type == "transfer"
      @customer.account[@account_type].withdraw(@amount)
      @receiver.account[@account_type].deposit(@amount)
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
        DATE #{@type.capitalize} Amount : #{@amount.to_f} by #{@teller.first_name} 
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


