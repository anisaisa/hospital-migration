--Create new database

use master
go

--recreate the database

create database Hospital
go

use Hospital 
go


CREATE TABLE appointment (
    aid         VARCHAR(15) NOT NULL,
    adate       DATE NOT NULL,
    ahour       TIME NOT NULL,
    astatus     VARCHAR(10) NOT NULL,
    doctor_eid  VARCHAR(10) NOT NULL,
    patient_pid VARCHAR(10) NOT NULL
);
go
ALTER TABLE appointment ADD CONSTRAINT appointment_pk PRIMARY KEY ( aid );
go
CREATE TABLE billing (
    bid            VARCHAR(10) NOT NULL,
    bamount        VARCHAR(20) NOT NULL,
    bdate          DATE NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    patient_pid    VARCHAR(10) NOT NULL
);
go
ALTER TABLE billing ADD CONSTRAINT billing_pk PRIMARY KEY ( bid );
go
CREATE TABLE doctor (
    eid             VARCHAR(10) NOT NULL,
    dspecialisation VARCHAR(20) NOT NULL,
    ddepartment     VARCHAR(20) NOT NULL
);
go
ALTER TABLE doctor ADD CONSTRAINT doctor_pk PRIMARY KEY ( eid );
go
CREATE TABLE employee (
    eid      VARCHAR(10) NOT NULL,
    ename    VARCHAR(15) NOT NULL,
    esurname VARCHAR(10) NOT NULL,
    ephone   VARCHAR(15),
    esalary  VARCHAR(10),
    egender  CHAR(6)
);
go
ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( eid );
go
CREATE TABLE governs (
    nurse_eid VARCHAR(10) NOT NULL,
    room_rid  VARCHAR(10) NOT NULL
);
go
ALTER TABLE governs ADD CONSTRAINT governs_pk PRIMARY KEY ( nurse_eid,
                                                            room_rid );
go
CREATE TABLE nurse (
    eid VARCHAR(10) NOT NULL
);
go
ALTER TABLE nurse ADD CONSTRAINT nurse_pk PRIMARY KEY ( eid );
go
CREATE TABLE patient (
    pid            VARCHAR(10) NOT NULL,
    pname          VARCHAR(10) NOT NULL,
    psurname       VARCHAR(10) NOT NULL,
    pdob           DATE,
    pphone         VARCHAR(15),
    padress        VARCHAR(20),
    insurance_info VARCHAR(20) NOT NULL,
    room_rid       VARCHAR(10) NOT NULL
);
go
ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( pid );
go
CREATE TABLE room (
    rid           VARCHAR(10) NOT NULL,
    rtype         VARCHAR(20),
    rcapacity     VARCHAR(10),
    ravailability VARCHAR(15) NOT NULL
);
go
ALTER TABLE room ADD CONSTRAINT room_pk PRIMARY KEY ( rid );
go
CREATE TABLE test_report (
    treportid   VARCHAR(10) NOT NULL,
    tresult     VARCHAR(15) NOT NULL,
    ttest_type  VARCHAR(20) NOT NULL,
    patient_pid VARCHAR(10) NOT NULL
);
go
ALTER TABLE test_report ADD CONSTRAINT test_report_pk PRIMARY KEY ( treportid );
go
ALTER TABLE appointment
    ADD CONSTRAINT appointment_doctor_fk FOREIGN KEY ( doctor_eid )
        REFERENCES doctor ( eid );
go
ALTER TABLE appointment
    ADD CONSTRAINT appointment_patient_fk FOREIGN KEY ( patient_pid )
        REFERENCES patient ( pid );
go
ALTER TABLE billing
    ADD CONSTRAINT billing_patient_fk FOREIGN KEY ( patient_pid )
        REFERENCES patient ( pid );
go
ALTER TABLE doctor
    ADD CONSTRAINT doctor_employee_fk FOREIGN KEY ( eid )
        REFERENCES employee ( eid );
go
ALTER TABLE governs
    ADD CONSTRAINT governs_nurse_fk FOREIGN KEY ( nurse_eid )
        REFERENCES nurse ( eid );
go
ALTER TABLE governs
    ADD CONSTRAINT governs_room_fk FOREIGN KEY ( room_rid )
        REFERENCES room ( rid );
go
ALTER TABLE nurse
    ADD CONSTRAINT nurse_employee_fk FOREIGN KEY ( eid )
        REFERENCES employee ( eid );
go
ALTER TABLE patient
    ADD CONSTRAINT patient_room_fk FOREIGN KEY ( room_rid )
        REFERENCES room ( rid );
go
ALTER TABLE test_report
    ADD CONSTRAINT test_report_patient_fk FOREIGN KEY ( patient_pid )
        REFERENCES patient ( pid );
		go

				











