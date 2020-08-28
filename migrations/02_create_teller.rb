require "sqlite3"

db = SQLite3::Database.open("./database/esor_bank_test.db")
query =<<~SQL
CREATE TABLE IF NOT EXISTS teller(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  phone_number INT NOT NULL,
  pin TEXT NOT NULL,
  address TEXT
  );
SQL

db.execute(query)