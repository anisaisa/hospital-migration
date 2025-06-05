import pyodbc
from pymongo import MongoClient

# Step 1: Connect to SQL Server (SSMS)
sql_conn = pyodbc.connect(
    'Driver={SQL Server};'
    'SERVER=ANISA;'
    'DATABASE=Hospital;'
    'Trusted_Connection=yes;'
)
sql_cursor = sql_conn.cursor()

# Step 2: Connect to MongoDB
mongo_client = MongoClient("mongodb://localhost:27017/")
mongo_db = mongo_client["Hospital"]
employees_collection = mongo_db["employees"]

# Step 3: Fetch all employee data
sql_cursor.execute("SELECT * FROM employee")
employees = sql_cursor.fetchall()

# Step 4: Fetch doctors and nurses
sql_cursor.execute("SELECT * FROM doctor")
doctors = {row.eid: row for row in sql_cursor.fetchall()}

sql_cursor.execute("SELECT * FROM nurse")
nurses = {row.eid: row for row in sql_cursor.fetchall()}

# Step 5: Transform and insert into MongoDB
for emp in employees:
    eid = emp.eid
    document = {
        "_id": eid,
        "ename": emp.ename,
        "esurname": emp.esurname,
        "ephone": emp.ephone,
        "esalary": emp.esalary,
        "egender": emp.egender,
    }

    if eid in doctors:
        document["role"] = "doctor"
        document["specialisation"] = doctors[eid].dspecialisation
        document["department"] = doctors[eid].ddepartment
    elif eid in nurses:
        document["role"] = "nurse"
    else:
        document["role"] = "other"

    employees_collection.insert_one(document)

print("✅ Employee migration completed successfully!")

# Step 6: Close connections
sql_cursor.close()
sql_conn.close()
mongo_client.close()
