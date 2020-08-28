require_relative "customer"
require_relative "teller"
require_relative "transaction"
require_relative "vault"
require_relative "account"
require_relative "error"
require_relative "database"
require_relative "validator"
require_relative "do_transaction"
require 'optparse'


fields = {
  :first_name => "KKKK",
  :last_name => "DDDD",
  :phone_number => "0246188068",
  :address => "23-455-445",
  :pin => "0001"
}

#Teller.create(fields)

fields_2 = {
  :first_name => "Yvonne",
  :last_name => "Akkkss",
  :phone_number => "2222222222",
  :address => "23-455-445",
}

#Customer.create(fields_2)


field = {
  :type => "savings",
  :customer_id => 4,
  :balance => 50.0
}

#Account.create(field)


# cus = Teller.find({:id => 1})

# cus.first_name = "hhhhhh"
# cus.last_name = "ttttttttt"
# cus.phone_number = 4466666666

# print cus.save()


trans_fields = {
  :type => "deposit",
  :customer_id => 3,
  :teller_id => 1,
  :amount => 3, 
  :recipient_id => 2, 
  :status => "Pending",
}

account = Account.find({:customer_id => trans_fields[:customer_id]})
account.type =  "aaaaa"
account.save()
#print Transaction.create(trans_fields)







































# begin
#   db = SQLite3::Database.open 'dest.db'
#   db.results_as_hash = true
#   db.execute "CREATE TABLE IF NOT EXISTS customers(id INT, first_name TEXT)"
#   db.execute "INSERT INTO customers  VALUES (?, ?)", 899,"ama"
#   results = db.query "SELECT * from customers"
#   results.each { |row| puts row }
# rescue SQLite3::Exception => e
#   print e
# end  


