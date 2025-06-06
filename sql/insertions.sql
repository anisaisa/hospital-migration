INSERT INTO employee (eid, ename, esurname, ephone, esalary, egender) VALUES
('E001', 'John', 'Doe', '1234567890', 70000, 'Male'),
('E002', 'Jane', 'Smith', '0987654321', 75000, 'Female'),
('E003', 'Emily', 'Jones', '4567891230', 65000, 'Female'),
('E004', 'Michael', 'Brown', '7891234560', 72000, 'Male'),
('E005', 'Robert', 'White', '2345678901', 80000, 'Male'),
('E006', 'Laura', 'Green', '5678901234', 78000, 'Female'),
('E007', 'David', 'Clark', '6789012345', 60000, 'Male'),
('E008', 'Sophia', 'Hill', '8901234567', 62000, 'Female'),
('E009', 'Chris', 'Taylor', '9012345678', 70000, 'Male'),
('E010', 'Nancy', 'Martinez', '0123456789', 75000, 'Female'),
('E011', 'Tom', 'Harris', '3456789012', 71000, 'Male'),
('E012', 'Anna', 'Moore', '4567890123', 73000, 'Female'),
('E013', 'James', 'Lee', '5678901234', 68000, 'Male'),
('E014', 'Olivia', 'Walker', '6789012345', 66000, 'Female'),
('E015', 'Sophia', 'Allen', '7890123456', 69000, 'Female'),
('E016', 'Grace', 'Cruz', '1112223333', 71000, 'Female'),
('E017', 'Leo', 'Garcia', '2223334444', 69000, 'Male'),
('E018', 'Mia', 'Bell', '3334445555', 74000, 'Female'),
('E019', 'Liam', 'Hunt', '4445556666', 76000, 'Male'),
('E020', 'Ella', 'Stone', '5556667777', 68000, 'Female'),
('E021', 'Noah', 'Ford', '6667778888', 72000, 'Male'),
('E022', 'Ava', 'Lane', '7778889999', 73000, 'Female');
('E023', 'Ethan', 'Wells', '8889990000', 75000, 'Male'),
('E024', 'Lily', 'Hayes', '999001111', 70000, 'Female'),
('E025', 'Mason', 'Scott', '0001112222', 71000, 'Male');

INSERT INTO appointment (aid, adate, ahour, astatus, doctor_eid, patient_pid) VALUES
('A001', '2024-05-21', '09:00:00', 'Scheduled', 'E001', 'P008'),
('A002', '2024-05-21', '10:00:00', 'Scheduled', 'E002', 'P002'),
('A003', '2024-05-23', '11:00:00', 'Scheduled', 'E005', 'P003'),
('A004', '2024-05-24', '14:00:00', 'Scheduled', 'E006', 'P004'),
('A005', '2024-05-25', '15:00:00', 'Scheduled', 'E009', 'P005'),
('A006', '2024-05-26', '16:00:00', 'Scheduled', 'E010', 'P006'),
('A007', '2024-05-27', '10:00:00', 'Scheduled', 'E011', 'P007'),
('A008', '2024-05-28', '11:30:00', 'Scheduled', 'E012', 'P008'),
('A009', '2024-05-29', '13:00:00', 'Scheduled', 'E013', 'P009'),
('A010', '2024-05-30', '14:30:00', 'Scheduled', 'E014', 'P010'),
('A011', '2024-05-31', '15:30:00', 'Scheduled', 'E015', 'P011'),
('A021', '2024-06-10', '12:00:00', 'Scheduled', 'E006', 'P009'),
('A022', '2024-06-30', '12:20:00', 'Scheduled', 'E002', 'P006'),
('A023', '2024-07-19', '14:00:00', 'Scheduled', 'E006', 'P007'),
('A027', '2024-08-01', '09:00:00', 'Scheduled', 'E016', 'P012'),
('A028', '2024-08-02', '10:00:00', 'Scheduled', 'E017', 'P013'),
('A029', '2024-08-03', '11:00:00', 'Scheduled', 'E018', 'P014'),
('A030', '2024-08-04', '14:00:00', 'Scheduled', 'E019', 'P015'),
('A031', '2024-08-05', '15:00:00', 'Scheduled', 'E020', 'P016'),
('A032', '2024-08-06', '16:00:00', 'Scheduled', 'E021', 'P017'),
('A033', '2024-08-07', '10:00:00', 'Scheduled', 'E022', 'P018'),
('A034', '2024-08-07', '11:30:00', 'Scheduled', 'E023', 'P019'),
('A035', '2024-08-09', '13:00:00', 'Scheduled', 'E024', 'P020'),
('A036', '2024-08-10', '14:30:00', 'Scheduled', 'E025', 'P021');


INSERT INTO billing (bid, bamount, bdate, payment_status, patient_pid) VALUES
('B001', 500, '2024-05-21', 'Paid', 'P001'),
('B002', 700, '2024-05-22', 'Pending', 'P002'),
('B003', 800, '2024-05-23', 'Pending', 'P003'),
('B004', 600, '2024-05-24', 'Paid', 'P004'),
('B005', 900, '2024-05-25', 'Pending', 'P005'),
('B006', 1000, '2024-05-26', 'Paid', 'P006'),
('B007', 1100, '2024-05-27', 'Pending', 'P007'),
('B008', 1200, '2024-05-28', 'Paid', 'P008'),
('B009', 1300, '2024-05-29', 'Pending', 'P009'),
('B010', 1400, '2024-05-30', 'Paid', 'P010'),
('B011', 1500, '2024-05-31', 'Pending', 'P011'),
('B012', 1600, '2024-06-01', 'Paid', 'P012'),
('B013', 1700, '2024-06-02', 'Pending', 'P013'),
('B014', 1800, '2024-06-03', 'Paid', 'P014'),
('B015', 1900, '2024-06-04', 'Pending', 'P015'),
('B016', 2000, '2024-06-05', 'Paid', 'P016'),
('B017', 2100, '2024-06-06', 'Pending', 'P017'),
('B018', 2200, '2024-06-07', 'Paid', 'P018'),
('B019', 2300, '2024-06-08', 'Pending', 'P019'),
('B020', 2400, '2024-06-09', 'Paid', 'P020'),
('B021', 2500, '2024-06-10', 'Pending', 'P021');


INSERT INTO governs (nurse_eid, room_rid) VALUES
('E003', 'R002'),
('E004', 'R001'),
('E007', 'R004'),
('E008', 'R003'),
('E011', 'R005'),
('E012', 'R006'),
('E013', 'R007'),
('E014', 'R008'),
('E015', 'R009'),
('E016', 'R011'),
('E017', 'R012'),
('E018', 'R013'),
('E019', 'R014'),
('E020', 'R015'),
('E021', 'R016'),
('E022', 'R017'),
('E023', 'R018'),
('E024', 'R019'),
('E025', 'R020');

INSERT INTO doctor (eid, dspecialisation, ddepartment) VALUES
('E001', 'Cardiologist', 'Cardiology'),
('E002', 'Neurologist', 'Neurology'),
('E005', 'Pediatrician', 'Pediatrics'),
('E006', 'Dermatologist', 'Dermatology'),
('E009', 'Orthopedic', 'Orthopedics'),
('E010', 'Gastroenterologist', 'Gastroenterology'),
('E011', 'Urologist', 'Urology'),
('E012', 'Oncologist', 'Oncology'),
('E013', 'Endocrinologist', 'Endocrinology'),
('E014', 'Pulmonologist', 'Pulmonology'),
('E015', 'Rheumatologist', 'Rheumatology'),
('E016', 'Cardiologist', 'Cardiology'),
('E017', 'Neurologist', 'Neurology'),
('E018', 'Pediatrician', 'Pediatrics'),
('E019', 'Dermatologist', 'Dermatology'),
('E020', 'Orthopedic', 'Orthopedics'),
('E021', 'Gastroenterologist', 'Gastroenterology'),
('E022', 'Urologist', 'Urology'),
('E023', 'Oncologist', 'Oncology'),
('E024', 'Endocrinologist', 'Endocrinology'),
('E025', 'Pulmonologist', 'Pulmonology');

INSERT INTO nurse (eid) VALUES
('E003'),
('E004'),
('E007'),
('E008'),
('E011'),
('E012'),
('E013'),
('E014'),
('E015'),
('E016'),
('E017'),
('E018'),
('E019'),
('E020'),
('E021'),
('E022'),
('E023'),
('E024'),
('E025');
INSERT INTO patient (pid, pname, psurname, pdob, pphone, padress, insurance_info, room_rid) VALUES
('P001', 'Alice', 'Walker', '1990-01-01', '3216549870', '123 Elm St', 'Insurance_A', 'R002'),
('P002', 'Bob', 'Wilson', '1985-05-12', '6549873210', '456 Oak St', 'Insurance_B', 'R002'),
('P003', 'Charlie', 'Johnson', '1975-03-23', '5678901230', '789 Pine St', 'Insurance_C', 'R004'),
('P004', 'Diana', 'King', '1980-07-14', '6789012340', '101 Maple St', 'Insurance_D', 'R004'),
('P005', 'Edward', 'Carter', '1992-11-20', '3456789012', '234 Birch St', 'Insurance_E', 'R005'),
('P006', 'Fiona', 'Davis', '1978-08-30', '4567890123', '345 Cedar St', 'Insurance_F', 'R006'),
('P007', 'George', 'Hughes', '1987-02-11', '5678901234', '567 Spruce St', 'Insurance_G', 'R007'),
('P008', 'Hannah', 'Ross', '1995-04-16', '6789012345', '678 Walnut St', 'Insurance_H', 'R008'),
('P009', 'Ian', 'Patterson', '1983-09-23', '7890123456', '789 Chestnut St', 'Insurance_I', 'R009'),
('P010', 'Jack', 'Barnes', '1979-12-15', '8901234567', '890 Ash St', 'Insurance_J', 'R010'),
('P011', 'Kelly', 'Evans', '1991-03-22', '9012345678', '901 Beech St', 'Insurance_K', 'R010'),
('P012', 'Zoe', 'Griffin', '1990-06-01', '1212121212', '111 Maple St', 'Insurance_L', 'R011'),
('P013', 'Owen', 'Fox', '1985-08-13', '1313131313', '222 Oak St', 'Insurance_M', 'R012'),
('P014', 'Nina', 'Dean', '1992-09-03', '1414141414', '333 Pine St', 'Insurance_N', 'R013'),
('P015', 'Eli', 'Reed', '1987-10-04', '1515151515', '444 Cedar St', 'Insurance_O', 'R014'),
('P016', 'Ruby', 'Knight', '1991-11-05', '1616161616', '555 Birch St', 'Insurance_P', 'R015'),
('P017', 'Luke', 'Pearce', '1989-12-06', '1717171717', '666 Spruce St', 'Insurance_Q', 'R016'),
('P018', 'Lara', 'Norris', '1993-01-07', '1818181818', '777 Walnut St', 'Insurance_R', 'R017'),
('P019', 'Adam', 'Pope', '1986-02-08', '1919191919', '888 Chestnut St', 'Insurance_S', 'R018'),
('P020', 'Jade', 'Bishop', '1984-03-09', '2020202020', '999 Ash St', 'Insurance_T', 'R019'),
('P021', 'Carl', 'Perry', '1994-04-10', '2121212121', '101 Beech St', 'Insurance_U', 'R020');

INSERT INTO room (rid, rtype, rcapacity, ravailability) VALUES
('R001', 'Single', 1, 'Available'),
('R002', 'Double', 2, 'Occupied'),
('R003', 'Single', 1, 'Available'),
('R004', 'Double', 2, 'Available'),
('R005', 'Single', 1, 'Occupied'),
('R006', 'Double', 2, 'Available'),
('R007', 'Single', 1, 'Occupied'),
('R008', 'Double', 2, 'Occupied'),
('R009', 'Single', 1, 'Available'),
('R010', 'Double', 2, 'Available'),
('R011', 'Single', 1, 'Available'),
('R012', 'Double', 2, 'Occupied'),
('R013', 'Single', 1, 'Available'),
('R014', 'Double', 2, 'Available'),
('R015', 'Single', 1, 'Occupied'),
('R016', 'Double', 2, 'Available'),
('R017', 'Single', 1, 'Occupied'),
('R018', 'Double', 2, 'Occupied'),
('R019', 'Single', 1, 'Available'),
('R020', 'Double', 2, 'Available');


INSERT INTO test_report (treportid, tresult, ttest_type, patient_pid) VALUES
('T001', 'Negative', 'Blood Test', 'P001'),
('T002', 'Positive', 'MRI', 'P002'),
('T003', 'Positive', 'X-Ray', 'P003'),
('T004', 'Negative', 'CT Scan', 'P004'),
('T005', 'Positive', 'Blood Test', 'P005'),
('T006', 'Negative', 'Ultrasound', 'P006'),
('T007', 'Positive', 'Blood Test', 'P007'),
('T008', 'Negative', 'MRI', 'P008'),
('T009', 'Positive', 'X-Ray', 'P009'),
('T010', 'Negative', 'CT Scan', 'P010'),
('T011', 'Positive', 'Ultrasound', 'P011'),
('T012', 'Negative', 'Blood Test', 'P012'),
('T013', 'Positive', 'MRI', 'P013'),
('T014', 'Negative', 'X-Ray', 'P014'),
('T015', 'Positive', 'CT Scan', 'P015'),
('T016', 'Negative', 'Blood Test', 'P016'),
('T017', 'Positive', 'Ultrasound', 'P017'),
('T018', 'Negative', 'Blood Test', 'P018'),
('T019', 'Positive', 'MRI', 'P019'),
('T020', 'Negative', 'X-Ray', 'P020'),
('T021', 'Positive', 'CT Scan', 'P021');

