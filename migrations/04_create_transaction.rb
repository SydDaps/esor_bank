require "sqlite3"

db = SQLite3::Database.open("./database/esor_bank_test.db")
query =<<~SQL
CREATE TABLE IF NOT EXISTS "transaction"(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  customer_id INT NOT NULL,
  recipient_id INT,
  type TEXT NOT NULL,
  account_id INT NOT NULL,
  status TEXT NOT NULL,
  teller_id INT NOT NULL,
  amount FLOAT NOT NULL,
  FOREIGN KEY(customer_id) REFERENCES customer(id),
  FOREIGN KEY(recipient_id) REFERENCES customer(id),
  FOREIGN KEY(account_id) REFERENCES account(id)
  );
SQL

db.execute(query)