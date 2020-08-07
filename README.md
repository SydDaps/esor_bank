# esor_bank model
---
## Requirments of this application :
- Admins should be able to create new tellers to perform transactions 
- Tellers should be able to create new accounts for customers 
- Tellers should be able to aid customers in debiting or crediting their account 
- Admins should be able to see all records of transactions and the total amount in the vault at any time 
- customers should be able to see the current amount in their account and records of all their transactions 
---
## Programming logic
Teller class data : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- name  </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- age  </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- phoneNumber  </br>
                     
Customer class data :  </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; - name </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; - age </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; - phoneNumber </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; - accountBalance </br> 
&ensp; &ensp; &ensp; &ensp; methods : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; - credit { add funds } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; - debit  { subtract funds } </br>
                 
Transaction class data : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -type { debit / credit } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -teller { teller performing transaction } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -customer { customer performing transaction } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -amount </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -message </br>
&ensp; &ensp; &ensp; &ensp; methods : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -doCrediting { credits account and returns message } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -doDebiting { debits account and returns message } </br>
                         
Vault class data : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -totalFunds </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -records { keeps all transaction of type Transactions } </br>
&ensp; &ensp; &ensp; &ensp; methods : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -addFunds { after any credit transaction } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -subFunds { after debit transacrion } </br>
                     
## logic for cli in ruby
 - create function to create new Tellers, and Customers </br>
 &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; - take all neccsary inputs </br>
 &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; - validate inputs if invalid re render form  </br>
 &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -  valid data can be used to initialize 
 
