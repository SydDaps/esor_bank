require "sqlite3"

db = SQLite3::Database.open("./database/esor_bank_test.db")
query =<<~SQL
CREATE TABLE IF NOT EXISTS account(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  customer_id INT NOT NULL,
  type INT NOT NULL,
  balance FLOAT DEFAULT 0.0,
  FOREIGN KEY(customer_id) REFERENCES customer(id)
  );
SQL

db.execute(query)