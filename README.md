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
User class data : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- firstName  </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- lastName  </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- age  </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- phoneNumber  </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- address  </br>


Teller class data (inherit user data ): </br>


Acount class data: </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- type {saving / current}  </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp;- balance </br>

&ensp; &ensp; &ensp; &ensp; methods : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -doCrediting { credits account and returns message } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -doDebiting { debits account and returns message } </br>

                    
Customer class data(inherit user data ):  </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; - accounts { hash of all customer account types as keys and the actual account as the key  } </br>

     
Transaction class data : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -type { debit / credit  && on what account} </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -teller { teller performing transaction } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -customer { customer performing transaction } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -amount </br>
&ensp; &ensp; &ensp; &ensp; methods : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -genrateMessage { credits account and returns message } </br>

                         
Vault class data : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -branch </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -totalFunds </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -records { keeps all transaction of type Transactions } </br>
&ensp; &ensp; &ensp; &ensp; methods : </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -addFunds { after any credit transaction } </br>
&ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; &ensp; -subFunds { after debit transacrion } </br>
                     
