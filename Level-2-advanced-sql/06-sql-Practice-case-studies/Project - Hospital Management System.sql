-----------------------------------------------------------
-- Project: Hospital Management System
-- Database Design + Queries
-----------------------------------------------------------

-----------------------------------------------------------
-- SECTION 1: TABLE CREATION
-----------------------------------------------------------

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE,
    Gender TEXT CHECK (Gender IN ('Male', 'Female', 'Other')),
    ContactNumber VARCHAR(15),
    Address TEXT
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Status TEXT CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE SET NULL
);

CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Diagnosis VARCHAR(255),
    TreatmentDescription TEXT,
    TreatmentDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE SET NULL
);

CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY,
    PatientID INT,
    TreatmentID INT,
    Notes TEXT,
    RecordDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID) ON DELETE CASCADE
);

CREATE TABLE Billing (
    BillID INT PRIMARY KEY,
    PatientID INT,
    TreatmentID INT,
    Amount REAL,
    BillDate DATE,
    Status TEXT CHECK (Status IN ('Paid', 'Unpaid')),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID) ON DELETE CASCADE
);

-----------------------------------------------------------
-- SECTION 2: DATA INSERTION
-----------------------------------------------------------

INSERT INTO Doctors VALUES
(1, 'Dr. John Smith', 'Cardiology', '1234567890', 'john.smith@hospital.com'),
(2, 'Dr. Lisa Brown', 'Neurology', '0987654321', 'lisa.brown@hospital.com');

INSERT INTO Patients VALUES
(1, 'Alice Johnson', '1990-05-21', 'Female', '1112223333', '123 Main St'),
(2, 'Bob Martin', '1985-08-14', 'Male', '4445556666', '456 Elm St');

INSERT INTO Appointments VALUES
(1, 1, 1, '2025-02-15', 'Scheduled'),
(2, 2, 2, '2025-02-16', 'Completed');

INSERT INTO Treatments VALUES
(1, 1, 1, 'Hypertension', 'Prescribed medication', '2025-02-15'),
(2, 2, 2, 'Migraine', 'MRI Scan and medications', '2025-02-16');

INSERT INTO MedicalRecords VALUES
(1, 1, 1, 'Patient responding well to treatment', '2025-02-15'),
(2, 2, 2, 'Further evaluation required', '2025-02-16');

INSERT INTO Billing VALUES
(1, 1, 1, 200.00, '2025-02-15', 'Paid'),
(2, 2, 2, 500.00, '2025-02-16', 'Unpaid');

-----------------------------------------------------------
-- SECTION 3: JOIN QUERIES
-----------------------------------------------------------

-- Scheduled Appointments
SELECT
    a.AppointmentID,
    p.Name AS Patient,
    d.Name AS Doctor,
    a.AppointmentDate
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
WHERE a.Status = 'Scheduled';

-----------------------------------------------------------

-- All Patients Including Those Without Appointments
SELECT
    p.Name,
    a.AppointmentID,
    a.Status
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID;

-----------------------------------------------------------

-- Cardiology Doctors With Scheduled Appointments
SELECT DISTINCT
    d.Name
FROM Doctors d
JOIN Appointments a ON d.DoctorID = a.DoctorID
WHERE d.Specialization = 'Cardiology'
  AND a.Status = 'Scheduled';

-----------------------------------------------------------
-- SECTION 4: SUBQUERIES & SET OPERATIONS
-----------------------------------------------------------

-- Patients With Unpaid Bills
SELECT
    PatientID,
    Name
FROM Patients
WHERE PatientID IN (
    SELECT PatientID
    FROM Billing
    WHERE Status = 'Unpaid'
);

-----------------------------------------------------------

-- Latest Appointment Per Patient
SELECT
    p.PatientID,
    p.Name,
    (
        SELECT MAX(a.AppointmentDate)
        FROM Appointments a
        WHERE a.PatientID = p.PatientID
    ) AS LatestAppointment
FROM Patients p;

-----------------------------------------------------------

-- Patients Treated in Multiple Specializations
SELECT
    t.PatientID,
    p.Name,
    d.Specialization
FROM Treatments t
JOIN Patients p ON t.PatientID = p.PatientID
JOIN Doctors d ON t.DoctorID = d.DoctorID
WHERE t.PatientID IN (
    SELECT
        t2.PatientID
    FROM Treatments t2
    JOIN Doctors d2 ON t2.DoctorID = d2.DoctorID
    GROUP BY t2.PatientID
    HAVING COUNT(DISTINCT d2.Specialization) > 1
)
ORDER BY t.PatientID, d.Specialization;

-----------------------------------------------------------
-- SECTION 5: AGGREGATIONS & ANALYTICS
-----------------------------------------------------------

-- Count Patients Per Diagnosis
SELECT
    Diagnosis,
    COUNT(*) AS PatientCount
FROM Treatments
GROUP BY Diagnosis;

-----------------------------------------------------------
-- SECTION 6: ALTER & UPDATE
-----------------------------------------------------------

ALTER TABLE Treatments
ADD COLUMN FeedbackScore INT CHECK (FeedbackScore BETWEEN 1 AND 5);

UPDATE Treatments SET FeedbackScore = 5 WHERE TreatmentID = 1;
UPDATE Treatments SET FeedbackScore = 4 WHERE TreatmentID = 2;

SELECT * FROM Treatments;

-----------------------------------------------------------
-- SECTION 7: WINDOW FUNCTIONS
-----------------------------------------------------------

-- Rank Doctors Based on Average Feedback
SELECT
    d.DoctorID,
    d.Name,
    RANK() OVER (ORDER BY AVG(t.FeedbackScore) DESC) AS DoctorRank
FROM Doctors d
LEFT JOIN Treatments t ON d.DoctorID = t.DoctorID
GROUP BY d.DoctorID, d.Name;

-----------------------------------------------------------

-- Rank Doctors by Treatment Count Within Department
SELECT
    d.Specialization AS Department,
    d.Name AS Doctor,
    COUNT(t.TreatmentID) AS TotalTreatments,
    RANK() OVER (
        PARTITION BY d.Specialization
        ORDER BY COUNT(t.TreatmentID) DESC
    ) AS RankWithinDepartment
FROM Doctors d
LEFT JOIN Treatments t ON d.DoctorID = t.DoctorID
GROUP BY d.Specialization, d.Name
ORDER BY Department, RankWithinDepartment;

-----------------------------------------------------------
-- END OF PROJECT
-----------------------------------------------------------
