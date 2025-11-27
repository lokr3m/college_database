-- ============================================================================
-- EXTENDED SAMPLE DATA: 50+ Students for College Database
-- ============================================================================
-- This script inserts extended sample data with 50+ students for testing.
-- Run this AFTER schema.sql has been executed.
--
-- WARNING: This script will DELETE all existing data before inserting!
-- HOIATUS: See skript KUSTUTAB kõik olemasolevad andmed enne sisestamist!
--
-- See skript sisestab laiendatud näidisandmed 50+ õpilasega testimiseks.
-- Käivitage see PÄRAST schema.sql täitmist.
--
-- Usage / Kasutamine:
--   mysql -u your_user -p college_db < database/sample_data_extended.sql
--   OR in MySQL Workbench: File > Open SQL Script > Execute
-- ============================================================================

USE college_db;

-- ============================================================================
-- CLEAR EXISTING DATA (in correct order due to foreign keys)
-- ============================================================================
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE StudentHistory;
TRUNCATE TABLE Enrollments;
TRUNCATE TABLE DepartmentHeads;
TRUNCATE TABLE Courses;
TRUNCATE TABLE Students;
TRUNCATE TABLE Instructors;
TRUNCATE TABLE Departments;
SET FOREIGN_KEY_CHECKS = 1;

SELECT '=== Existing data cleared ===' AS status;

-- ============================================================================
-- Insert Departments (5 departments)
-- ============================================================================
INSERT INTO Departments (department_name, building, budget) VALUES
('Computer Science', 'Engineering Building A', 500000.00),
('Mathematics', 'Science Building B', 350000.00),
('Physics', 'Science Building C', 450000.00),
('English', 'Humanities Building', 250000.00),
('Business Administration', 'Business Hall', 600000.00);

-- ============================================================================
-- Insert Instructors (8 instructors)
-- ============================================================================
INSERT INTO Instructors (first_name, last_name, email, phone, department_id, salary, hire_date) VALUES
('John', 'Smith', 'john.smith@college.edu', '555-0101', 1, 85000.00, '2015-08-15'),
('Emily', 'Johnson', 'emily.johnson@college.edu', '555-0102', 1, 78000.00, '2017-01-10'),
('Michael', 'Williams', 'michael.williams@college.edu', '555-0103', 2, 82000.00, '2014-09-01'),
('Sarah', 'Brown', 'sarah.brown@college.edu', '555-0104', 2, 75000.00, '2018-08-20'),
('David', 'Jones', 'david.jones@college.edu', '555-0105', 3, 88000.00, '2013-07-15'),
('Jennifer', 'Garcia', 'jennifer.garcia@college.edu', '555-0106', 4, 72000.00, '2016-01-05'),
('Robert', 'Martinez', 'robert.martinez@college.edu', '555-0107', 5, 95000.00, '2012-09-01'),
('Lisa', 'Anderson', 'lisa.anderson@college.edu', '555-0108', 5, 87000.00, '2015-06-15');

-- ============================================================================
-- Insert Department Heads
-- ============================================================================
INSERT INTO DepartmentHeads (department_id, instructor_id, start_date) VALUES
(1, 1, '2020-01-01'),
(2, 3, '2019-07-01'),
(3, 5, '2018-01-01'),
(4, 6, '2021-01-01'),
(5, 7, '2017-09-01');

-- ============================================================================
-- Insert Courses (9 courses)
-- ============================================================================
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
-- Insert 55 Students (AI Generated Sample Data)
-- ============================================================================
-- Mix of international and Estonian names for diversity
-- ============================================================================
INSERT INTO Students (first_name, last_name, email, phone, date_of_birth, enrollment_year, major_department_id, gpa) VALUES
-- Original students (1-12)
('Alice', 'Wilson', 'alice.wilson@student.college.edu', '555-1001', '2003-05-15', 2023, 1, 3.85),
('Bob', 'Taylor', 'bob.taylor@student.college.edu', '555-1002', '2002-11-22', 2022, 1, 3.45),
('Charlie', 'Moore', 'charlie.moore@student.college.edu', '555-1003', '2003-08-10', 2023, 2, 3.72),
('Diana', 'Thomas', 'diana.thomas@student.college.edu', '555-1004', '2004-02-28', 2024, 3, 3.90),
('Edward', 'Jackson', 'edward.jackson@student.college.edu', '555-1005', '2003-07-19', 2023, 5, 3.55),
('Fiona', 'White', 'fiona.white@student.college.edu', '555-1006', '2002-12-05', 2022, 4, 3.68),
('George', 'Harris', 'george.harris@student.college.edu', '555-1007', '2003-09-14', 2023, 1, 3.25),
('Hannah', 'Martin', 'hannah.martin@student.college.edu', '555-1008', '2004-04-30', 2024, 2, 3.95),
('Mari', 'Tamm', 'mari.tamm@student.college.edu', '555-1009', '2003-03-12', 2023, 1, 3.78),
('Kristjan', 'Kask', 'kristjan.kask@student.college.edu', '555-1010', '2002-07-25', 2022, 2, 3.62),
('Liisa', 'Mägi', 'liisa.magi@student.college.edu', '555-1011', '2004-01-08', 2024, 3, 3.88),
('Andres', 'Saar', 'andres.saar@student.college.edu', '555-1012', '2003-11-30', 2023, 5, 3.42),
-- Additional Estonian students (13-25)
('Kadri', 'Rebane', 'kadri.rebane@student.college.edu', '555-1013', '2003-06-18', 2023, 1, 3.67),
('Martin', 'Lepik', 'martin.lepik@student.college.edu', '555-1014', '2002-09-03', 2022, 2, 3.81),
('Anna', 'Sepp', 'anna.sepp@student.college.edu', '555-1015', '2004-03-22', 2024, 3, 3.54),
('Priit', 'Kuusk', 'priit.kuusk@student.college.edu', '555-1016', '2003-12-07', 2023, 4, 3.39),
('Kertu', 'Pärn', 'kertu.parn@student.college.edu', '555-1017', '2002-04-14', 2022, 5, 3.92),
('Taavi', 'Valk', 'taavi.valk@student.college.edu', '555-1018', '2003-08-29', 2023, 1, 3.76),
('Marika', 'Rand', 'marika.rand@student.college.edu', '555-1019', '2004-05-11', 2024, 2, 3.48),
('Siim', 'Koppel', 'siim.koppel@student.college.edu', '555-1020', '2002-10-26', 2022, 3, 3.83),
('Liina', 'Sild', 'liina.sild@student.college.edu', '555-1021', '2003-01-19', 2023, 4, 3.29),
('Rauno', 'Toom', 'rauno.toom@student.college.edu', '555-1022', '2004-07-04', 2024, 5, 3.71),
('Piret', 'Oja', 'piret.oja@student.college.edu', '555-1023', '2002-02-08', 2022, 1, 3.94),
('Meelis', 'Kivi', 'meelis.kivi@student.college.edu', '555-1024', '2003-11-13', 2023, 2, 3.56),
('Triin', 'Mets', 'triin.mets@student.college.edu', '555-1025', '2004-06-27', 2024, 3, 3.63),
-- International students (26-40)
('James', 'Anderson', 'james.anderson@student.college.edu', '555-1026', '2003-04-05', 2023, 1, 3.79),
('Emma', 'Thompson', 'emma.thompson@student.college.edu', '555-1027', '2002-08-20', 2022, 2, 3.87),
('William', 'Clark', 'william.clark@student.college.edu', '555-1028', '2004-01-15', 2024, 3, 3.44),
('Olivia', 'Lewis', 'olivia.lewis@student.college.edu', '555-1029', '2003-10-09', 2023, 4, 3.91),
('Benjamin', 'Walker', 'benjamin.walker@student.college.edu', '555-1030', '2002-05-28', 2022, 5, 3.33),
('Sophia', 'Hall', 'sophia.hall@student.college.edu', '555-1031', '2003-07-17', 2023, 1, 3.75),
('Lucas', 'Allen', 'lucas.allen@student.college.edu', '555-1032', '2004-12-03', 2024, 2, 3.58),
('Isabella', 'Young', 'isabella.young@student.college.edu', '555-1033', '2002-03-12', 2022, 3, 3.96),
('Mason', 'King', 'mason.king@student.college.edu', '555-1034', '2003-09-25', 2023, 4, 3.41),
('Ava', 'Wright', 'ava.wright@student.college.edu', '555-1035', '2004-04-18', 2024, 5, 3.82),
('Ethan', 'Scott', 'ethan.scott@student.college.edu', '555-1036', '2002-11-07', 2022, 1, 3.69),
('Mia', 'Green', 'mia.green@student.college.edu', '555-1037', '2003-02-22', 2023, 2, 3.53),
('Alexander', 'Adams', 'alexander.adams@student.college.edu', '555-1038', '2004-08-14', 2024, 3, 3.77),
('Charlotte', 'Baker', 'charlotte.baker@student.college.edu', '555-1039', '2002-06-30', 2022, 4, 3.89),
('Daniel', 'Nelson', 'daniel.nelson@student.college.edu', '555-1040', '2003-12-19', 2023, 5, 3.46),
-- More Estonian students (41-50)
('Kaarel', 'Põld', 'kaarel.pold@student.college.edu', '555-1041', '2004-02-11', 2024, 1, 3.72),
('Helen', 'Raud', 'helen.raud@student.college.edu', '555-1042', '2002-07-06', 2022, 2, 3.85),
('Ott', 'Laas', 'ott.laas@student.college.edu', '555-1043', '2003-05-24', 2023, 3, 3.38),
('Eliise', 'Nurm', 'eliise.nurm@student.college.edu', '555-1044', '2004-10-08', 2024, 4, 3.93),
('Rasmus', 'Hint', 'rasmus.hint@student.college.edu', '555-1045', '2002-01-29', 2022, 5, 3.51),
('Kätlin', 'Vaher', 'katlin.vaher@student.college.edu', '555-1046', '2003-08-03', 2023, 1, 3.66),
('Silver', 'Teder', 'silver.teder@student.college.edu', '555-1047', '2004-04-16', 2024, 2, 3.84),
('Moonika', 'Paju', 'moonika.paju@student.college.edu', '555-1048', '2002-09-21', 2022, 3, 3.47),
('Indrek', 'Lepp', 'indrek.lepp@student.college.edu', '555-1049', '2003-03-07', 2023, 4, 3.59),
('Getter', 'Aas', 'getter.aas@student.college.edu', '555-1050', '2004-11-25', 2024, 5, 3.78),
-- More international students (51-55)
('Noah', 'Carter', 'noah.carter@student.college.edu', '555-1051', '2002-12-14', 2022, 1, 3.91),
('Emily', 'Mitchell', 'emily.mitchell@student.college.edu', '555-1052', '2003-06-02', 2023, 2, 3.64),
('Liam', 'Perez', 'liam.perez@student.college.edu', '555-1053', '2004-09-19', 2024, 3, 3.73),
('Sophie', 'Roberts', 'sophie.roberts@student.college.edu', '555-1054', '2002-04-25', 2022, 4, 3.88),
('Jacob', 'Turner', 'jacob.turner@student.college.edu', '555-1055', '2003-10-31', 2023, 5, 3.42);

-- ============================================================================
-- Insert Enrollments for all 55 students
-- Each student is enrolled in 2-3 courses
-- ============================================================================
INSERT INTO Enrollments (student_id, course_id, enrollment_date, grade, status) VALUES
-- Students 1-12 (original)
(1, 1, '2024-08-20', 'A', 'Active'),
(1, 2, '2024-08-20', 'A-', 'Active'),
(1, 4, '2024-08-20', 'B+', 'Active'),
(2, 1, '2024-08-20', 'B+', 'Active'),
(2, 3, '2024-08-20', 'B', 'Active'),
(3, 4, '2024-08-20', 'A', 'Active'),
(3, 5, '2024-08-20', 'A-', 'Active'),
(4, 6, '2024-08-20', 'A', 'Active'),
(4, 7, '2024-08-20', 'A-', 'Active'),
(5, 8, '2024-08-20', 'B', 'Active'),
(5, 9, '2024-08-20', 'B+', 'Active'),
(6, 7, '2024-08-20', 'A-', 'Active'),
(6, 4, '2024-08-20', 'B+', 'Active'),
(7, 1, '2024-08-20', 'C+', 'Active'),
(7, 2, '2024-08-20', 'C', 'Active'),
(8, 4, '2024-08-20', 'A', 'Active'),
(8, 5, '2024-08-20', 'A', 'Active'),
(9, 1, '2024-08-20', 'A-', 'Active'),
(9, 2, '2024-08-20', 'B+', 'Active'),
(10, 4, '2024-08-20', 'A', 'Active'),
(10, 5, '2024-08-20', 'A-', 'Active'),
(11, 6, '2024-08-20', 'A', 'Active'),
(11, 7, '2024-08-20', 'B+', 'Active'),
(12, 8, '2024-08-20', 'B', 'Active'),
(12, 9, '2024-08-20', 'B+', 'Active'),
-- Students 13-25
(13, 1, '2024-08-20', 'A-', 'Active'),
(13, 3, '2024-08-20', 'B+', 'Active'),
(14, 4, '2024-08-20', 'A', 'Active'),
(14, 5, '2024-08-20', 'A-', 'Active'),
(15, 6, '2024-08-20', 'B+', 'Active'),
(15, 7, '2024-08-20', 'B', 'Active'),
(16, 7, '2024-08-20', 'B-', 'Active'),
(16, 4, '2024-08-20', 'C+', 'Active'),
(17, 8, '2024-08-20', 'A', 'Active'),
(17, 9, '2024-08-20', 'A-', 'Active'),
(18, 1, '2024-08-20', 'A-', 'Active'),
(18, 2, '2024-08-20', 'B+', 'Active'),
(19, 4, '2024-08-20', 'B', 'Active'),
(19, 5, '2024-08-20', 'B+', 'Active'),
(20, 6, '2024-08-20', 'A', 'Active'),
(20, 7, '2024-08-20', 'A-', 'Active'),
(21, 7, '2024-08-20', 'C+', 'Active'),
(21, 4, '2024-08-20', 'C', 'Active'),
(22, 8, '2024-08-20', 'A-', 'Active'),
(22, 9, '2024-08-20', 'B+', 'Active'),
(23, 1, '2024-08-20', 'A', 'Active'),
(23, 2, '2024-08-20', 'A', 'Active'),
(24, 4, '2024-08-20', 'B+', 'Active'),
(24, 5, '2024-08-20', 'B', 'Active'),
(25, 6, '2024-08-20', 'B+', 'Active'),
(25, 7, '2024-08-20', 'A-', 'Active'),
-- Students 26-40
(26, 1, '2024-08-20', 'A-', 'Active'),
(26, 3, '2024-08-20', 'A', 'Active'),
(27, 4, '2024-08-20', 'A', 'Active'),
(27, 5, '2024-08-20', 'A-', 'Active'),
(28, 6, '2024-08-20', 'B', 'Active'),
(28, 7, '2024-08-20', 'B+', 'Active'),
(29, 7, '2024-08-20', 'A', 'Active'),
(29, 4, '2024-08-20', 'A-', 'Active'),
(30, 8, '2024-08-20', 'C+', 'Active'),
(30, 9, '2024-08-20', 'B-', 'Active'),
(31, 1, '2024-08-20', 'A-', 'Active'),
(31, 2, '2024-08-20', 'B+', 'Active'),
(32, 4, '2024-08-20', 'B+', 'Active'),
(32, 5, '2024-08-20', 'B', 'Active'),
(33, 6, '2024-08-20', 'A', 'Active'),
(33, 7, '2024-08-20', 'A', 'Active'),
(34, 7, '2024-08-20', 'B', 'Active'),
(34, 4, '2024-08-20', 'B+', 'Active'),
(35, 8, '2024-08-20', 'A-', 'Active'),
(35, 9, '2024-08-20', 'A', 'Active'),
(36, 1, '2024-08-20', 'A-', 'Active'),
(36, 3, '2024-08-20', 'B+', 'Active'),
(37, 4, '2024-08-20', 'B', 'Active'),
(37, 5, '2024-08-20', 'B+', 'Active'),
(38, 6, '2024-08-20', 'A-', 'Active'),
(38, 7, '2024-08-20', 'B+', 'Active'),
(39, 7, '2024-08-20', 'A', 'Active'),
(39, 4, '2024-08-20', 'A-', 'Active'),
(40, 8, '2024-08-20', 'B', 'Active'),
(40, 9, '2024-08-20', 'B-', 'Active'),
-- Students 41-55
(41, 1, '2024-08-20', 'A-', 'Active'),
(41, 2, '2024-08-20', 'B+', 'Active'),
(42, 4, '2024-08-20', 'A', 'Active'),
(42, 5, '2024-08-20', 'A-', 'Active'),
(43, 6, '2024-08-20', 'C+', 'Active'),
(43, 7, '2024-08-20', 'B-', 'Active'),
(44, 7, '2024-08-20', 'A', 'Active'),
(44, 4, '2024-08-20', 'A', 'Active'),
(45, 8, '2024-08-20', 'B', 'Active'),
(45, 9, '2024-08-20', 'B+', 'Active'),
(46, 1, '2024-08-20', 'A-', 'Active'),
(46, 3, '2024-08-20', 'B+', 'Active'),
(47, 4, '2024-08-20', 'A', 'Active'),
(47, 5, '2024-08-20', 'A-', 'Active'),
(48, 6, '2024-08-20', 'B', 'Active'),
(48, 7, '2024-08-20', 'B+', 'Active'),
(49, 7, '2024-08-20', 'B+', 'Active'),
(49, 4, '2024-08-20', 'B', 'Active'),
(50, 8, '2024-08-20', 'A-', 'Active'),
(50, 9, '2024-08-20', 'A', 'Active'),
(51, 1, '2024-08-20', 'A', 'Active'),
(51, 2, '2024-08-20', 'A-', 'Active'),
(52, 4, '2024-08-20', 'B+', 'Active'),
(52, 5, '2024-08-20', 'A-', 'Active'),
(53, 6, '2024-08-20', 'A-', 'Active'),
(53, 7, '2024-08-20', 'B+', 'Active'),
(54, 7, '2024-08-20', 'A', 'Active'),
(54, 4, '2024-08-20', 'A-', 'Active'),
(55, 8, '2024-08-20', 'B', 'Active'),
(55, 9, '2024-08-20', 'B+', 'Active');

-- ============================================================================
-- Sample StudentHistory records (demonstrating history tracking)
-- ============================================================================
INSERT INTO StudentHistory (student_id, first_name, last_name, email, phone, date_of_birth, enrollment_year, major_department_id, gpa, original_created_at, original_updated_at, changed_at, change_type) VALUES
-- Alice Wilson's GPA progression
(1, 'Alice', 'Wilson', 'alice.wilson@student.college.edu', '555-1001', '2003-05-15', 2023, 1, 3.50, '2023-09-01 10:00:00', '2023-09-01 10:00:00', '2023-12-15 14:30:00', 'UPDATE'),
(1, 'Alice', 'Wilson', 'alice.wilson@student.college.edu', '555-1001', '2003-05-15', 2023, 1, 3.65, '2023-09-01 10:00:00', '2023-12-15 14:30:00', '2024-05-20 09:15:00', 'UPDATE'),
(1, 'Alice', 'Wilson', 'alice.wilson@student.college.edu', '555-1001', '2003-05-15', 2023, 1, 3.75, '2023-09-01 10:00:00', '2024-05-20 09:15:00', '2024-09-10 11:00:00', 'UPDATE'),
-- Bob Taylor's changes
(2, 'Bob', 'Taylor', 'bob.taylor@student.college.edu', '555-1002-OLD', '2002-11-22', 2022, 1, 3.20, '2022-09-01 09:00:00', '2022-09-01 09:00:00', '2023-06-01 16:45:00', 'UPDATE'),
(2, 'Bob', 'Taylor', 'bob.taylor@student.college.edu', '555-1002', '2002-11-22', 2022, 1, 3.35, '2022-09-01 09:00:00', '2023-06-01 16:45:00', '2024-01-15 10:20:00', 'UPDATE'),
-- Mari Tamm changed major
(9, 'Mari', 'Tamm', 'mari.tamm@student.college.edu', '555-1009', '2003-03-12', 2023, 5, 3.60, '2023-09-01 08:30:00', '2023-09-01 08:30:00', '2024-02-01 13:00:00', 'UPDATE'),
-- Kadri Rebane GPA improvement
(13, 'Kadri', 'Rebane', 'kadri.rebane@student.college.edu', '555-1013', '2003-06-18', 2023, 1, 3.45, '2023-09-01 10:00:00', '2023-09-01 10:00:00', '2024-01-20 14:00:00', 'UPDATE'),
-- James Anderson phone update
(26, 'James', 'Anderson', 'james.anderson@student.college.edu', '555-1026-OLD', '2003-04-05', 2023, 1, 3.70, '2023-09-01 09:30:00', '2023-09-01 09:30:00', '2024-03-15 10:30:00', 'UPDATE');

-- ============================================================================
-- VERIFICATION: Show summary of inserted data
-- ============================================================================
SELECT '=== Data Summary ===' AS info;
SELECT 'Students' AS table_name, COUNT(*) AS count FROM Students
UNION ALL
SELECT 'Instructors', COUNT(*) FROM Instructors
UNION ALL
SELECT 'Departments', COUNT(*) FROM Departments
UNION ALL
SELECT 'Courses', COUNT(*) FROM Courses
UNION ALL
SELECT 'Enrollments', COUNT(*) FROM Enrollments
UNION ALL
SELECT 'StudentHistory', COUNT(*) FROM StudentHistory;

SELECT '=== Extended sample data loaded successfully! ===' AS result;
SELECT '55 students, 8 instructors, 5 departments, 9 courses loaded.' AS details;
