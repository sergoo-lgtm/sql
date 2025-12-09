-- Project: School Management System 🎓
-- Problem Set: Students, Faculty, Courses, Enrollments, and Academic Operations
-- Source: SQL Roadmap for Data Analysis (Level 1)
-----------------------------------------------------------
-- Task 1: Create Students Table
-- Challenge: Design the Students table to enforce uniqueness and sensible defaults for missing data.
CREATE TABLE Students (
    student_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    roll_number TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT UNIQUE NOT NULL,
    address TEXT DEFAULT 'Not Provided'
);

-----------------------------------------------------------
-- Task 2: Create Faculty Table
-- Challenge: Build the Faculty table with enforced department categories.
CREATE TABLE Faculty (
    faculty_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT UNIQUE NOT NULL,
    department TEXT CHECK (department IN ('Science', 'Arts', 'Commerce', 'Engineering'))
);

-----------------------------------------------------------
-- Task 3: Create Courses Table
-- Challenge: Create Courses with credit constraints and a faculty link (implicit FK by id).
CREATE TABLE Courses (
    course_id INTEGER PRIMARY KEY,
    course_name TEXT NOT NULL,
    course_code TEXT UNIQUE NOT NULL,
    department TEXT CHECK (department IN ('Science', 'Arts', 'Commerce', 'Engineering')),
    credits INTEGER CHECK (credits > 0),
    faculty_id INTEGER NOT NULL
);

-----------------------------------------------------------
-- Task 4: Create Enrollments Table
-- Challenge: Track enrollments, restrict grades and set default statuses for new entries.
CREATE TABLE Enrollments (
    enrollment_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    grade TEXT CHECK (grade IN ('A', 'B', 'C', 'D', 'F')) DEFAULT 'Not Graded'
);

-----------------------------------------------------------
-- Task 5: Insert Sample Students
-- Challenge: Populate Students with realistic test records (10 entries).
INSERT INTO Students (student_id, name, roll_number, email, phone, address) VALUES
(1, 'John Doe', '101', 'john.doe@email.com', '9876543210', '123 Main St'),
(2, 'Jane Smith', '102', 'jane.smith@email.com', '9823456789', '45 Elm St'),
(3, 'Alice Brown', '103', 'alice.b@email.com', '9988776655', '78 Pine Ave'),
(4, 'Bob Johnson', '104', 'bob.j@email.com', '9765432109', '90 Oak Lane'),
(5, 'Charlie Lee', '105', 'charlie.l@email.com', '9234567890', 'Not Provided'),
(6, 'David White', '106', 'david.w@email.com', '9678991234', '12 Maple St'),
(7, 'Emily Clark', '107', 'emily.c@email.com', '9345678901', 'Not Provided'),
(8, 'Frank Harris', '108', 'frank.h@email.com', '9763214785', '56 Birch Road'),
(9, 'Grace Kelly', '109', 'grace.k@email.com', '9456123870', '32 Cedar Ave'),
(10, 'Henry Adams', '110', 'henry.a@email.com', '9312465789', '22 Walnut Lane');

-----------------------------------------------------------
-- Task 6: Insert Sample Faculty
-- Challenge: Seed Faculty with cross-disciplinary members to allow join-based exercises.
INSERT INTO Faculty (faculty_id, name, email, phone, department) VALUES
(1, 'Dr. Smith', 'smith@univ.com', '9876543211', 'Science'),
(2, 'Dr. Johnson', 'johnson@univ.com', '9823456781', 'Arts'),
(3, 'Dr. Williams', 'williams@univ.com', '9988776611', 'Commerce'),
(4, 'Dr. Brown', 'brown@univ.com', '9765432191', 'Engineering'),
(5, 'Dr. Davis', 'davis@univ.com', '9234567811', 'Science');

-----------------------------------------------------------
-- Task 7: Insert Sample Courses
-- Challenge: Add courses tied to departments and faculty to enable relational queries.
INSERT INTO Courses (course_id, course_name, course_code, department, credits, faculty_id) VALUES
(1, 'Mathematics', 'MATH101', 'Science', 4, 1),
(2, 'English Literature', 'ENG102', 'Arts', 3, 2),
(3, 'Economics', 'ECO103', 'Commerce', 4, 3),
(4, 'Computer Science', 'CS104', 'Engineering', 4, 4),
(5, 'Physics', 'PHY105', 'Science', 3, 5);

-----------------------------------------------------------
-- Task 8: Insert Sample Enrollments
-- Challenge: Populate enrollments so you can test grade-based and date-based analytics.
INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) VALUES
(1, 1, 1, '2024-01-15', 'A'),
(2, 2, 2, '2024-01-16', 'B'),
(3, 3, 3, '2024-01-17', 'A'),
(4, 4, 4, '2024-01-18', 'C'),
(5, 5, 5, '2024-01-19', 'B'),
(6, 6, 1, '2024-01-20', 'A'),
(7, 7, 2, '2024-01-21', 'C'),
(8, 8, 3, '2024-01-22', 'B'),
(9, 9, 4, '2024-01-23', 'A'),
(10, 10, 5, '2024-01-24', 'B');

-----------------------------------------------------------
-- Task 9: Retrieve last Faculty record
-- Challenge: Verify the most recently added faculty entry for quick sanity checks.
SELECT * FROM Faculty ORDER BY faculty_id DESC LIMIT 1;

-----------------------------------------------------------
-- Task 10: Retrieve last Course record
-- Challenge: Verify the most recently added course entry.
SELECT * FROM Courses ORDER BY course_id DESC LIMIT 1;

-----------------------------------------------------------
-- Task 11: Retrieve last Enrollment record
-- Challenge: Verify the most recent enrollment entry.
SELECT * FROM Enrollments ORDER BY enrollment_id DESC LIMIT 1;

-----------------------------------------------------------
-- Task 12: Fetch all distinct departments from Faculty
-- Challenge: List all departments represented among faculty (deduplicate results).
SELECT DISTINCT department FROM Faculty;

-----------------------------------------------------------
-- Task 13: Enrollments with a specific grade
-- Challenge (made tougher): Find all enrollments where the recorded grade equals 'C' — check for potential data-cleaning needs.
SELECT * FROM Enrollments WHERE grade = 'C';

-----------------------------------------------------------
-- Task 14: Two most recent enrollments
-- Challenge: Extract the latest activity in the enrollments log.
SELECT * FROM Enrollments ORDER BY enrollment_date DESC LIMIT 2;

-----------------------------------------------------------
-- Task 15: Increase credits for Science courses
-- Challenge: Apply a curriculum change by increasing credits for all Science courses, then inspect one updated row.
UPDATE Courses 
SET credits = credits + 1 
WHERE department = 'Science';

SELECT course_name, department, credits FROM Courses 
WHERE department = 'Science' LIMIT 1;

-----------------------------------------------------------
-- Task 16: Add scholarship column to Students
-- Challenge: Extend Students with a scholarship field to support future reporting.
ALTER TABLE Students 
ADD COLUMN scholarship TEXT DEFAULT 'None';

SELECT student_id, name, scholarship FROM Students 
ORDER BY student_id ASC LIMIT 1;

-----------------------------------------------------------
-- Task 17: Convert unspecified addresses to 'Unknown'
-- Challenge: Standardize missing address values to a consistent 'Unknown' marker, then list affected students.
UPDATE Students SET address = 'Unknown' 
WHERE address = 'Not Provided';

SELECT student_id, name, address FROM Students 
WHERE address = 'Unknown';

-----------------------------------------------------------
-- Task 18: Add status column to Enrollments
-- Challenge: Introduce an enrollment status field to track active/inactive enrollments.
ALTER TABLE Enrollments ADD COLUMN status TEXT DEFAULT 'Active';

SELECT enrollment_id, student_id, course_id, status FROM Enrollments
ORDER BY enrollment_id ASC LIMIT 1;

-----------------------------------------------------------
-- Task 19: Rename/change department for Computer Science
-- Challenge: Apply a department reclassification for a course and verify the update.
UPDATE Courses SET department = 'Technology' 
WHERE course_name = 'Computer Science';

SELECT course_id, course_name, department FROM Courses 
WHERE course_name = 'Computer Science';

-----------------------------------------------------------
-- Task 20: Delete students with unspecified addresses
-- Challenge: Clean records flagged 'Not Provided' (remove such students), then list remaining students.
DELETE FROM Students WHERE address = 'Not Provided';

SELECT student_id, name, address FROM Students;

-----------------------------------------------------------
-- Task 21: Delete enrollments with grade 'B'
-- Challenge: Remove enrollments matching grade 'B' (simulating a data purge), then show remaining enrollments.
DELETE FROM Enrollments WHERE grade = 'B';

SELECT enrollment_id, student_id, course_id, grade FROM Enrollments;

-----------------------------------------------------------
-- Task 22: Delete courses with credits less than 4
-- Challenge: Remove lower-credit offerings from the catalog, then inspect remaining courses.
DELETE FROM Courses WHERE credits < 4;

SELECT * FROM Courses;

-----------------------------------------------------------
-- Task 23: Delete students with '@email.com' addresses
-- Challenge: Purge all students whose email domain is 'email.com' to simulate domain-based cleanup.
DELETE FROM Students WHERE email LIKE '%@email.com';

SELECT * FROM Students;

-----------------------------------------------------------
-- Task 24: Add salary column to Faculty and set savepoint
-- Challenge: Prepare payroll by adding salary, create a savepoint, and populate salaries for analysis.
ALTER TABLE Faculty ADD COLUMN salary DECIMAL(10,2);

SAVEPOINT S1;

UPDATE Faculty SET salary = 100000 WHERE faculty_id = 1;
UPDATE Faculty SET salary = 95000 WHERE faculty_id = 2;
UPDATE Faculty SET salary = 85000 WHERE faculty_id = 3;
UPDATE Faculty SET salary = 110000 WHERE faculty_id = 4;
UPDATE Faculty SET salary = 92000 WHERE faculty_id = 5;

-----------------------------------------------------------
-- Task 25: Average faculty salary
-- Challenge: Compute the average payroll obligation for the faculty.
SELECT AVG(salary) AS avg_salary FROM Faculty;

-----------------------------------------------------------
-- Task 26: Total credits across courses (as sample aggregate)
-- Challenge: Sum course credits to get a quick capacity metric for the curriculum.
SELECT SUM(credits) AS total_credits FROM Courses;

-----------------------------------------------------------
-- Task 27: Rollback to savepoint and adjust salaries downward
-- Challenge: Revert to the savepoint, then apply a controlled salary reduction and re-evaluate payroll.
ROLLBACK TO S1;

UPDATE Faculty SET salary = 98000 WHERE faculty_id = 1;
UPDATE Faculty SET salary = 93000 WHERE faculty_id = 2;
UPDATE Faculty SET salary = 83000 WHERE faculty_id = 3;
UPDATE Faculty SET salary = 108000 WHERE faculty_id = 4;
UPDATE Faculty SET salary = 90000 WHERE faculty_id = 5;

SELECT faculty_id, name, salary FROM Faculty;

SELECT AVG(salary) AS avg_salary FROM Faculty;

-----------------------------------------------------------
-- Task 28: Final sanity-checks 
-- Challenge: Run a few final reads to ensure the DB state is consistent after modifications.
SELECT COUNT(*) AS student_count FROM Students;
SELECT COUNT(*) AS faculty_count FROM Faculty;
SELECT COUNT(*) AS course_count FROM Courses;
SELECT COUNT(*) AS enrollment_count FROM Enrollments;
