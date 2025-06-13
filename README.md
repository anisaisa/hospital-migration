# Hospital Database Migration Project (SQL ➡️ MongoDB)

##  Project Overview

This project demonstrates the migration of a **Hospital Management System** from a **relational database (SQL Server)** to a **NoSQL document database (MongoDB)**. The goal is to preserve and enhance data accessibility, structure, and analysis through document embedding, derived fields, and indexing.

---

##  Relational Schema (SQL Server)

### Tables Used:

* **Employee**: Employee details (doctors, nurses)
* **Doctor / Nurse**: ISA relationship with `Employee`
* **Patient**: Patients assigned to rooms
* **Appointment**: Doctor–Patient meeting logs
* **Billing**: Financial transactions per patient
* **Test\_Report**: Test results linked to patients
* **Room**: Room assignments and nurse governance
* **Governs**: Room–Nurse mapping table

---

##  MongoDB Structure (Post-Migration)

### Collections Created:

* **patients**
* **rooms**
* **audit\_logs** (for tracking updates)

###  Embedding Strategy:

* Appointments, test reports, and bills are embedded into each `patient` document.
* `room` documents include embedded nurse info and current patients.

---

##  Data Transformations (MongoDB Side)

### Patients:

* `age`: Derived from DOB
* `total_billed`: Sum of all paid bills
* `has_unpaid_bills`: Boolean if unpaid bills exist
* `risk_flag`: True if unpaid and total > 1000
* `last_appointment_date`: Most recent appointment
* Duplicate bills prevented per patient

### Rooms:

* `governed_by`: Embedded nurse name and ID
* `current_patients`: Embedded patient name and admission date
* `occupancy_rate`: Auto-calculated
* `is_full`: Boolean if room capacity is reached
* `long_term_occupied`: True if a patient stayed > 30 days
* Duplicate nurses and patients prevented

---

##  Technologies Used

* **SQL Server Management Studio (SSMS)** – Original relational database
* **MongoDB & Compass** – Target NoSQL database
* **Python (pyodbc + pymongo)** – Data migration scripts

---

##  Running the Project

### 1. Clone or Download Repository

```bash
git clone https://github.com/your-username/hospital-migration.git
cd hospital-migration
```

### 2. Run Migration Scripts

```bash
python migrate_patients.py
python migrate_rooms.py
python migrate_employees.py
```

### 3. View in MongoDB Compass

* Connect to `mongodb://localhost:27017`
* Explore the `Hospital` database

---

## Indexes Used

* `patients.pphone` (unique)
* `patients.has_unpaid_bills`
* `appointments.doctor_eid`
* `bills.payment_status`
* `rooms.rtype`, `ravailability`, `is_full`, `governed_by.nurse_name`

---






