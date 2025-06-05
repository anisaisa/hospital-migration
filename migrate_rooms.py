import pyodbc
from pymongo import MongoClient
from datetime import datetime, date
from collections import defaultdict

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
rooms_collection = mongo_db["rooms"]

# ---------------------------
# 3⃣ Load Data from SQL Server
# ---------------------------
def load_table(query):
    sql_cursor.execute(query)
    return [dict(zip([column[0] for column in sql_cursor.description], row)) for row in sql_cursor.fetchall()]

rooms = load_table("SELECT * FROM room")
governs = load_table("SELECT * FROM governs")
patients = load_table("SELECT * FROM patient")
nurses = load_table("""
    SELECT n.eid, e.ename
    FROM nurse n
    JOIN employee e ON n.eid = e.eid
""")

# Build nurse lookup
nurse_lookup = {n["eid"]: n["ename"] for n in nurses}

# Group governed_by map
room_nurse_map = defaultdict(list)
for g in governs:
    nurse_id = g["nurse_eid"]
    room_id = g["room_rid"]
    nurse_name = nurse_lookup.get(nurse_id, "Unknown")
    if all(existing["nurse_eid"] != nurse_id for existing in room_nurse_map[room_id]):
        room_nurse_map[room_id].append({
            "nurse_eid": nurse_id,
            "nurse_name": nurse_name
        })

# Group patients by room
room_patient_map = defaultdict(list)
today = date.today()

for p in patients:
    room_id = p["room_rid"]
    admitted_on = p.get("pdob")  # Assume admission logic tied to DOB if no other field
    patient_entry = {
        "pid": p["pid"],
        "pname": p["pname"],
        "admitted_on": str(admitted_on) if admitted_on else None
    }
    if all(existing["pid"] != patient_entry["pid"] for existing in room_patient_map[room_id]):
        room_patient_map[room_id].append(patient_entry)

# ---------------------------
# 4⃣ Build and Insert Rooms
# ---------------------------
for r in rooms:
    rid = r["rid"]
    capacity = int(r["rcapacity"])
    current_patients = room_patient_map.get(rid, [])
    occupancy = len(current_patients)
    occupancy_rate = (occupancy / capacity) * 100 if capacity else 0
    is_full = occupancy >= capacity

    long_term_occupied = False
    for p in current_patients:
        if p["admitted_on"]:
            try:
                dob = datetime.strptime(p["admitted_on"], "%Y-%m-%d").date()
                if (today - dob).days > 30:
                    long_term_occupied = True
                    break
            except:
                continue

    room_doc = {
        "_id": rid,
        "rtype": r["rtype"],
        "rcapacity": r["rcapacity"],
        "ravailability": r["ravailability"],
        "governed_by": room_nurse_map.get(rid, []),
        "governed_nurse_count": len(room_nurse_map.get(rid, [])),
        "current_patients": current_patients,
        "occupancy_rate": round(occupancy_rate, 2),
        "is_full": is_full,
        "long_term_occupied": long_term_occupied
    }

    rooms_collection.replace_one({"_id": rid}, room_doc, upsert=True)

print("\u2705 Room migration completed with occupancy and nurse enrichment!")

# ---------------------------
# 5⃣ Create Indexes
# ---------------------------
rooms_collection.create_index("rtype")
rooms_collection.create_index("ravailability")
rooms_collection.create_index("is_full")
rooms_collection.create_index("governed_by.nurse_name")

# ---------------------------
# 6⃣ Close Connections
# ---------------------------
sql_cursor.close()
sql_conn.close()
mongo_client.close()
