#!/usr/bin/env python3
import psycopg2, os, sys, json

#DBCONN = "host=127.0.0.1 port=5433 dbname=postgres user=postgres password=postgres"
DBCONN = "host={} port={} dbname={} user={} password={}".format(
			os.environ['DB_HOST'],
			os.environ['DB_PORT'],
			os.environ['DB_NAME'],
			os.environ['DB_USER'],
			os.environ['DB_PASS'],
		)	

print(DBCONN)

# Create the database connection.
conn = psycopg2.connect(DBCONN)

# Open a cursor to perform database operations.
# The default mode for psycopg2 is "autocommit=false".

conn.set_session(autocommit=True)
cur = conn.cursor()

# Create the table. (It might preexist.)

cur.execute(
  """
  DROP TABLE IF EXISTS employee
  """)

cur.execute(
  """
  CREATE TABLE employee (id int PRIMARY KEY,
                         name varchar,
                         age int,
                         language varchar)
  """)
print("Created table employee")
cur.close()

# Take advantage of ordinary, transactional behavior for DMLs.

conn.set_session(autocommit=False)
cur = conn.cursor()

# Insert a row.

cur.execute("INSERT INTO employee (id, name, age, language) VALUES (%s, %s, %s, %s)",
            (1, 'John', 35, 'Python'))
print("Inserted (id, name, age, language) = (1, 'John', 35, 'Python')")

# Query the row.

cur.execute("SELECT name, age, language FROM employee WHERE id = 1")
row = cur.fetchone()
print("Query returned: %s, %s, %s" % (row[0], row[1], row[2]))

# Commit and close down.

conn.commit()
cur.close()
conn.close()
