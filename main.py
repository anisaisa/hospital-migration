import pyodbc

conn = pyodbc.connect(
    'Driver={SQL Server};'
    'SERVER=ANISA;'  # <-- Update this
    'DATABASE=Hospital;'
    'Trusted_Connection=yes;'             # <-- Update this
)

cursor = conn.cursor()
cursor.execute("SELECT * FROM employee")
rows = cursor.fetchall()

for row in rows:
    print(row)
