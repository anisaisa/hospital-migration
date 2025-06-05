import pyodbc
from pymongo import MongoClient
from datetime import datetime, date

# ---------------------------
# 🔧 Calculate Age Function
# ---------------------------
def calculate_age(dob):
    if dob is None:
        return None
    if isinstance(dob, str):
        dob = datetime.strptime(dob, "%Y-%m-%d").date()
    return date.today().year - dob.year - ((date.today().month, date.today().day) < (dob.month, dob.day))

# ---------------------------
# 1⃣ Connect to SQL Server
# ---------------------------
sql_conn = pyodbc.connect(
    'Driver={SQL Server};'
    'SERVER=ANISA;'
    'DATABASE=Hospital;'
    'Trusted_Connection=yes;'
)
sql_cursor = sql_conn.cursor()

# ---------------------------
# 2⃣ Connect to MongoDB
# ---------------------------
mongo_client = MongoClient("mongodb://localhost:27017/")
mongo_db = mongo_client["Hospital"]
patients_collection = mongo_db["patients"]
audit_logs = mongo_db["audit_logs"]

# ---------------------------
# 3⃣ Fetch All Patients
# ---------------------------
sql_cursor.execute("SELECT * FROM patient")
patients = sql_cursor.fetchall()

# ---------------------------
# 4⃣ Preload Related Tables
# ---------------------------
def load_table(query):
    sql_cursor.execute(query)
    return [dict(zip([column[0] for column in sql_cursor.description], row)) for row in sql_cursor.fetchall()]

appointments = load_table("SELECT * FROM appointment")
billings = load_table("SELECT * FROM billing")
test_reports = load_table("SELECT * FROM test_report")
rooms = {row['rid']: row for row in load_table("SELECT * FROM room")}

# 🧠 Load doctor names + specialisations
doctor_lookup = {
    row["eid"]: {
        "doctor_name": row["ename"],
        "specialisation": row["dspecialisation"]
    }
    for row in load_table("""
        SELECT d.eid, e.ename, d.dspecialisation
        FROM doctor d
        JOIN employee e ON d.eid = e.eid
    """)
}

# ---------------------------
# 5⃣ Build & Upsert Documents
# ---------------------------
for p in patients:
    pid = p.pid

    # Room info
    room_data = rooms.get(p.room_rid, {})
    room_doc = {
        "rid": room_data.get("rid"),
        "rtype": room_data.get("rtype"),
        "rcapacity": room_data.get("rcapacity"),
        "ravailability": room_data.get("ravailability")
    }

    # Long-stay flag (dummy logic for now)
    long_stay = False

    # Appointments with doctor info
    patient_appointments = []
    for a in appointments:
        if a["patient_pid"] == pid:
            doc_info = doctor_lookup.get(a["doctor_eid"], {})
            appointment = {
                "aid": a["aid"],
                "adate": a["adate"],
                "ahour": str(a["ahour"]),
                "astatus": a["astatus"],
                "doctor_eid": a["doctor_eid"],
                "doctor_name": doc_info.get("doctor_name", "Unknown"),
                "specialisation": doc_info.get("specialisation", "Unknown")
            }
            patient_appointments.append(appointment)

    # Last visit
    last_visit = max([a["adate"] for a in patient_appointments], default=None)

    # Billing
    patient_bills = [
        {
            "bid": b["bid"],
            "bamount": b["bamount"],
            "bdate": b["bdate"],
            "payment_status": b["payment_status"]
        }
        for b in billings if b["patient_pid"] == pid
    ]

    # Derived billing fields
    total_billed = sum(
        float(b["bamount"]) for b in patient_bills if b["payment_status"].lower() == "paid"
    )
    has_unpaid_bills = any(
        b["payment_status"].lower() != "paid" for b in patient_bills
    )
    risk_flag = has_unpaid_bills and total_billed > 1000

    # Test Reports
    patient_reports = [
        {
            "treportid": t["treportid"],
            "tresult": t["tresult"],
            "ttest_type": t["ttest_type"]
        }
        for t in test_reports if t["patient_pid"] == pid
    ]

    # Final patient doc
    patient_doc = {
        "_id": pid,
        "pname": p.pname,
        "psurname": p.psurname,
        "pdob": p.pdob,
        "age": calculate_age(p.pdob),
        "pphone": p.pphone,
        "padress": p.padress,
        "insurance_info": p.insurance_info,
        "room": room_doc,
        "appointments": patient_appointments,
        "bills": patient_bills,
        "test_reports": patient_reports,
        "total_billed": total_billed,
        "has_unpaid_bills": has_unpaid_bills,
        "risk_flag": risk_flag,
        "last_appointment_date": last_visit,
        "long_stay": long_stay
    }

    # Audit log
    audit_logs.insert_one({
        "patient_id": pid,
        "action": "update_bills",
        "timestamp": datetime.now(),
        "details": {
            "total_billed": total_billed,
            "has_unpaid_bills": has_unpaid_bills
        }
    })

    # Upsert to MongoDB
    patients_collection.replace_one({"_id": pid}, patient_doc, upsert=True)

print("✅ Patient migration completed with derived fields, audit logs, and risk analysis!")

# ---------------------------
# 6️⃣ Create Indexes
# ---------------------------
patients_collection.create_index("pphone", unique=True)
patients_collection.create_index("has_unpaid_bills")
patients_collection.create_index("appointments.doctor_eid")
patients_collection.create_index("bills.payment_status")
patients_collection.create_index("risk_flag")

# ---------------------------
# 7️⃣ Close Connections
# ---------------------------
sql_cursor.close()
sql_conn.close()
mongo_client.close()
