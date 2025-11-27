-- Sample Data for College Database
-- This script inserts sample data into the database for testing
--
-- ============================================================================
-- DATA GENERATION NOTE / ANDMETE GENEREERIMISE MÄRKUS:
-- ============================================================================
-- This sample data was generated using AI assistance to create realistic
-- student and faculty records for testing purposes.
--
-- See näidisandmed genereeriti AI abil realistlike õpilaste ja õppejõudude
-- kirjete loomiseks testimise eesmärgil.
--
-- The data includes:
-- - 5 academic departments with realistic budgets
-- - 8 instructors with varied hire dates and salaries
-- - 9 courses across different departments
-- - 12 students with diverse backgrounds (AI generated names)
-- - Course enrollments with grades and statuses
-- - Sample historical data to demonstrate the StudentHistory feature
--
-- Andmed sisaldavad:
-- - 5 akadeemilist osakonda realistlike eelarvetega
-- - 8 õppejõudu erinevate palkamise kuupäevade ja palkadega
-- - 9 kursust erinevates osakondades
-- - 12 õpilast mitmekesise taustaga (AI genereeritud nimed)
-- - Kursusele registreerimised hinnete ja olekutega
-- - Näidis ajaloolised andmed StudentHistory funktsiooni demonstreerimiseks
-- ============================================================================

-- Insert Departments
INSERT INTO Departments (department_name, building, budget) VALUES
('Computer Science', 'Engineering Building A', 500000.00),
('Mathematics', 'Science Building B', 350000.00),
('Physics', 'Science Building C', 450000.00),
('English', 'Humanities Building', 250000.00),
('Business Administration', 'Business Hall', 600000.00);

-- Insert Instructors
INSERT INTO Instructors (first_name, last_name, email, phone, department_id, salary, hire_date) VALUES
('John', 'Smith', 'john.smith@college.edu', '555-0101', 1, 85000.00, '2015-08-15'),
('Emily', 'Johnson', 'emily.johnson@college.edu', '555-0102', 1, 78000.00, '2017-01-10'),
('Michael', 'Williams', 'michael.williams@college.edu', '555-0103', 2, 82000.00, '2014-09-01'),
('Sarah', 'Brown', 'sarah.brown@college.edu', '555-0104', 2, 75000.00, '2018-08-20'),
('David', 'Jones', 'david.jones@college.edu', '555-0105', 3, 88000.00, '2013-07-15'),
('Jennifer', 'Garcia', 'jennifer.garcia@college.edu', '555-0106', 4, 72000.00, '2016-01-05'),
('Robert', 'Martinez', 'robert.martinez@college.edu', '555-0107', 5, 95000.00, '2012-09-01'),
('Lisa', 'Anderson', 'lisa.anderson@college.edu', '555-0108', 5, 87000.00, '2015-06-15');

-- Insert Department Heads
INSERT INTO DepartmentHeads (department_id, instructor_id, start_date) VALUES
(1, 1, '2020-01-01'),
(2, 3, '2019-07-01'),
(3, 5, '2018-01-01'),
(4, 6, '2021-01-01'),
(5, 7, '2017-09-01');

-- Insert Courses
INSERT INTO Courses (course_code, course_name, department_id, instructor_id, credits, semester, year, room_number, schedule) VALUES
('CS101', 'Introduction to Programming', 1, 1, 3, 'Fall', 2024, 'ENG-A101', 'Mon/Wed 9:00-10:30'),
('CS201', 'Data Structures', 1, 2, 4, 'Fall', 2024, 'ENG-A102', 'Tue/Thu 10:00-12:00'),
('CS301', 'Database Systems', 1, 1, 3, 'Spring', 2024, 'ENG-A103', 'Mon/Wed 14:00-15:30'),
('MATH101', 'Calculus I', 2, 3, 4, 'Fall', 2024, 'SCI-B201', 'Mon/Wed/Fri 11:00-12:00'),
('MATH201', 'Linear Algebra', 2, 4, 3, 'Fall', 2024, 'SCI-B202', 'Tue/Thu 13:00-14:30'),
('PHY101', 'Physics I', 3, 5, 4, 'Fall', 2024, 'SCI-C101', 'Mon/Wed 15:00-17:00'),
('ENG101', 'English Composition', 4, 6, 3, 'Fall', 2024, 'HUM-101', 'Tue/Thu 9:00-10:30'),
('BUS101', 'Introduction to Business', 5, 7, 3, 'Fall', 2024, 'BUS-201', 'Mon/Wed 10:00-11:30'),
('BUS201', 'Marketing Fundamentals', 5, 8, 3, 'Fall', 2024, 'BUS-202', 'Tue/Thu 14:00-15:30');

-- ============================================================================
-- Insert Students (AI Generated Sample Data / AI Genereeritud Näidisandmed)
-- ============================================================================
-- These student records include Estonian names to reflect the local context.
-- Need õpilaste kirjed sisaldavad eesti nimesid, et peegeldada kohalikku konteksti.
-- ============================================================================
INSERT INTO Students (first_name, last_name, email, phone, date_of_birth, enrollment_year, major_department_id, gpa) VALUES
('Alice', 'Wilson', 'alice.wilson@student.college.edu', '555-1001', '2003-05-15', 2023, 1, 3.85),
('Bob', 'Taylor', 'bob.taylor@student.college.edu', '555-1002', '2002-11-22', 2022, 1, 3.45),
('Charlie', 'Moore', 'charlie.moore@student.college.edu', '555-1003', '2003-08-10', 2023, 2, 3.72),
('Diana', 'Thomas', 'diana.thomas@student.college.edu', '555-1004', '2004-02-28', 2024, 3, 3.90),
('Edward', 'Jackson', 'edward.jackson@student.college.edu', '555-1005', '2003-07-19', 2023, 5, 3.55),
('Fiona', 'White', 'fiona.white@student.college.edu', '555-1006', '2002-12-05', 2022, 4, 3.68),
('George', 'Harris', 'george.harris@student.college.edu', '555-1007', '2003-09-14', 2023, 1, 3.25),
('Hannah', 'Martin', 'hannah.martin@student.college.edu', '555-1008', '2004-04-30', 2024, 2, 3.95),
-- Additional AI-generated Estonian students / Täiendavad AI-genereeritud Eesti õpilased
('Mari', 'Tamm', 'mari.tamm@student.college.edu', '555-1009', '2003-03-12', 2023, 1, 3.78),
('Kristjan', 'Kask', 'kristjan.kask@student.college.edu', '555-1010', '2002-07-25', 2022, 2, 3.62),
('Liisa', 'Mägi', 'liisa.magi@student.college.edu', '555-1011', '2004-01-08', 2024, 3, 3.88),
('Andres', 'Saar', 'andres.saar@student.college.edu', '555-1012', '2003-11-30', 2023, 5, 3.42);

-- Insert Enrollments
INSERT INTO Enrollments (student_id, course_id, enrollment_date, grade, status) VALUES
(1, 1, '2024-08-20', 'A', 'Active'),
(1, 2, '2024-08-20', 'A-', 'Active'),
(1, 4, '2024-08-20', NULL, 'Active'),
(2, 1, '2024-08-20', 'B+', 'Active'),
(2, 3, '2024-08-20', NULL, 'Active'),
(3, 4, '2024-08-20', 'A', 'Active'),
(3, 5, '2024-08-20', 'A-', 'Active'),
(4, 6, '2024-08-20', 'A', 'Active'),
(4, 7, '2024-08-20', NULL, 'Active'),
(5, 8, '2024-08-20', 'B', 'Active'),
(5, 9, '2024-08-20', 'B+', 'Active'),
(6, 7, '2024-08-20', 'A-', 'Active'),
(7, 1, '2024-08-20', 'C+', 'Active'),
(7, 2, '2024-08-20', NULL, 'Active'),
(8, 4, '2024-08-20', 'A', 'Active'),
(8, 5, '2024-08-20', NULL, 'Active'),
-- Enrollments for new Estonian students / Registreerimised uute Eesti õpilaste jaoks
(9, 1, '2024-08-20', 'A-', 'Active'),
(9, 2, '2024-08-20', 'B+', 'Active'),
(10, 4, '2024-08-20', 'A', 'Active'),
(10, 5, '2024-08-20', 'A-', 'Active'),
(11, 6, '2024-08-20', 'A', 'Active'),
(12, 8, '2024-08-20', 'B', 'Active'),
(12, 9, '2024-08-20', 'B+', 'Active');

-- ============================================================================
-- STUDENT HISTORY DEMONSTRATION / ÕPILASE AJALOO DEMONSTRATSIOON
-- ============================================================================
-- The following section demonstrates the history tracking feature by:
-- 1. First inserting historical records directly (simulating past changes)
-- 2. Then performing updates that will trigger automatic history creation
--
-- Järgmine osa demonstreerib ajaloo jälgimise funktsiooni:
-- 1. Esmalt sisestatakse ajaloolised kirjed otse (simuleerides varasemaid muudatusi)
-- 2. Seejärel tehakse uuendused, mis käivitavad automaatse ajaloo loomise
--
-- NOTE: In normal operation, you don't manually insert into StudentHistory.
-- The triggers handle this automatically when you UPDATE or DELETE students.
--
-- MÄRKUS: Tavapärases töös ei sisesta te käsitsi StudentHistory tabelisse.
-- Triggerid käsitlevad seda automaatselt, kui te UPDATE või DELETE õpilasi.
-- ============================================================================

-- Insert sample historical records (simulating past data states)
-- These records show what the data looked like before various changes
INSERT INTO StudentHistory (student_id, first_name, last_name, email, phone, date_of_birth, enrollment_year, major_department_id, gpa, original_created_at, original_updated_at, changed_at, change_type) VALUES
-- Alice Wilson's GPA history: started at 3.50, improved over time
(1, 'Alice', 'Wilson', 'alice.wilson@student.college.edu', '555-1001', '2003-05-15', 2023, 1, 3.50, '2023-09-01 10:00:00', '2023-09-01 10:00:00', '2023-12-15 14:30:00', 'UPDATE'),
(1, 'Alice', 'Wilson', 'alice.wilson@student.college.edu', '555-1001', '2003-05-15', 2023, 1, 3.65, '2023-09-01 10:00:00', '2023-12-15 14:30:00', '2024-05-20 09:15:00', 'UPDATE'),
(1, 'Alice', 'Wilson', 'alice.wilson@student.college.edu', '555-1001', '2003-05-15', 2023, 1, 3.75, '2023-09-01 10:00:00', '2024-05-20 09:15:00', '2024-09-10 11:00:00', 'UPDATE'),
-- Bob Taylor changed his phone number and improved GPA
(2, 'Bob', 'Taylor', 'bob.taylor@student.college.edu', '555-1002-OLD', '2002-11-22', 2022, 1, 3.20, '2022-09-01 09:00:00', '2022-09-01 09:00:00', '2023-06-01 16:45:00', 'UPDATE'),
(2, 'Bob', 'Taylor', 'bob.taylor@student.college.edu', '555-1002', '2002-11-22', 2022, 1, 3.35, '2022-09-01 09:00:00', '2023-06-01 16:45:00', '2024-01-15 10:20:00', 'UPDATE'),
-- Mari Tamm changed her major from Business (5) to Computer Science (1)
(9, 'Mari', 'Tamm', 'mari.tamm@student.college.edu', '555-1009', '2003-03-12', 2023, 5, 3.60, '2023-09-01 08:30:00', '2023-09-01 08:30:00', '2024-02-01 13:00:00', 'UPDATE');

-- ============================================================================
-- DEMONSTRATION: Trigger in Action / DEMONSTRATSIOON: Trigger Tegevuses
-- ============================================================================
-- The following UPDATE statements will automatically create history records
-- via the trg_student_history_update trigger.
--
-- To see the trigger in action, run these UPDATE statements:
-- Triggeri tegevuse nägemiseks käivitage need UPDATE laused:
--
-- UPDATE Students SET gpa = 3.90 WHERE student_id = 1;
-- -- This will save Alice's current state (GPA 3.85) to StudentHistory
-- -- See salvestab Alice praeguse oleku (GPA 3.85) StudentHistory tabelisse
--
-- UPDATE Students SET phone = '555-1002-NEW' WHERE student_id = 2;
-- -- This will save Bob's current state to StudentHistory
-- -- See salvestab Bobi praeguse oleku StudentHistory tabelisse
--
-- Then query the history:
-- Seejärel pärige ajalugu:
--   SELECT * FROM StudentHistory WHERE student_id = 1 ORDER BY changed_at DESC;
-- ============================================================================
