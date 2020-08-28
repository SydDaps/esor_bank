require "sqlite3"

db = SQLite3::Database.open("./database/esor_bank_test.db")
query =<<~SQL
CREATE TABLE IF NOT EXISTS customer(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  phone_number CHAR(10) NOT NULL,
  address TEXT,
  pin TEXT
  );
SQL

db.execute(query)