-- Sample Data for College Database
-- This script inserts sample data into the database for testing

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

-- Insert Mandatory Courses for each department and academic year
-- Computer Science mandatory courses
INSERT INTO MandatoryCourses (department_id, course_id, academic_year) VALUES
(1, 1, 1), -- CS101 is mandatory for year 1
(1, 2, 2); -- CS201 is mandatory for year 2

-- Mathematics mandatory courses
INSERT INTO MandatoryCourses (department_id, course_id, academic_year) VALUES
(2, 4, 1), -- MATH101 is mandatory for year 1
(2, 5, 2); -- MATH201 is mandatory for year 2

-- Physics mandatory courses
INSERT INTO MandatoryCourses (department_id, course_id, academic_year) VALUES
(3, 6, 1); -- PHY101 is mandatory for year 1

-- English mandatory courses
INSERT INTO MandatoryCourses (department_id, course_id, academic_year) VALUES
(4, 7, 1); -- ENG101 is mandatory for year 1

-- Business Administration mandatory courses
INSERT INTO MandatoryCourses (department_id, course_id, academic_year) VALUES
(5, 8, 1), -- BUS101 is mandatory for year 1
(5, 9, 2); -- BUS201 is mandatory for year 2

-- Insert Students (with academic_year field)
-- Note: The trigger will automatically enroll them in mandatory courses
INSERT INTO Students (first_name, last_name, email, phone, date_of_birth, enrollment_year, academic_year, major_department_id, gpa) VALUES
('Alice', 'Wilson', 'alice.wilson@student.college.edu', '555-1001', '2003-05-15', 2023, 1, 1, 3.85),
('Bob', 'Taylor', 'bob.taylor@student.college.edu', '555-1002', '2002-11-22', 2022, 2, 1, 3.45),
('Charlie', 'Moore', 'charlie.moore@student.college.edu', '555-1003', '2003-08-10', 2023, 1, 2, 3.72),
('Diana', 'Thomas', 'diana.thomas@student.college.edu', '555-1004', '2004-02-28', 2024, 1, 3, 3.90),
('Edward', 'Jackson', 'edward.jackson@student.college.edu', '555-1005', '2003-07-19', 2023, 1, 5, 3.55),
('Fiona', 'White', 'fiona.white@student.college.edu', '555-1006', '2002-12-05', 2022, 1, 4, 3.68),
('George', 'Harris', 'george.harris@student.college.edu', '555-1007', '2003-09-14', 2023, 1, 1, 3.25),
('Hannah', 'Martin', 'hannah.martin@student.college.edu', '555-1008', '2004-04-30', 2024, 2, 2, 3.95);

-- Insert additional Enrollments (non-mandatory courses)
-- Note: Mandatory courses are already enrolled via the trigger
INSERT INTO Enrollments (student_id, course_id, enrollment_date, is_mandatory, status) VALUES
-- Alice (CS student, year 1) - already has CS101 from trigger, adding MATH101
(1, 4, '2024-08-20', FALSE, 'Active'),
-- Bob (CS student, year 2) - already has CS201 from trigger, adding CS301
(2, 3, '2024-08-20', FALSE, 'Active'),
-- Charlie (Math student, year 1) - already has MATH101 from trigger, adding MATH201
(3, 5, '2024-08-20', FALSE, 'Active'),
-- Diana (Physics student, year 1) - already has PHY101 from trigger, adding ENG101
(4, 7, '2024-08-20', FALSE, 'Active'),
-- Fiona (English student, year 1) - already has ENG101 from trigger
-- Edward and George already have their mandatory courses from trigger
-- Hannah (Math student, year 2) - already has MATH201 from trigger, adding MATH101
(8, 4, '2024-08-20', FALSE, 'Active');

-- Insert Grades (replacing the old grade field in Enrollments)
INSERT INTO Grades (enrollment_id, grade_value, grade_type, grade_date, graded_by, is_current) VALUES
-- Alice's grades
(1, '5', 'Final', '2024-11-15', 1, TRUE),     -- CS101 (mandatory)
(2, '4', 'Final', '2024-11-15', 3, TRUE),     -- MATH101
-- Bob's grades
(3, '4', 'Final', '2024-11-15', 2, TRUE),     -- CS201 (mandatory)
(4, '3', 'Midterm', '2024-10-15', 1, TRUE),   -- CS301
-- Charlie's grades
(5, '5', 'Final', '2024-11-15', 3, TRUE),     -- MATH101 (mandatory)
(6, '5', 'Final', '2024-11-15', 4, TRUE),     -- MATH201
-- Diana's grades
(7, '5', 'Final', '2024-11-15', 5, TRUE),     -- PHY101 (mandatory)
(8, '4', 'Midterm', '2024-10-15', 6, TRUE),   -- ENG101
-- Edward's grades
(9, '4', 'Final', '2024-11-15', 7, TRUE),     -- BUS101 (mandatory)
-- Fiona's grades
(10, '4', 'Final', '2024-11-15', 6, TRUE),    -- ENG101 (mandatory)
-- George's grades
(11, '3', 'Final', '2024-11-15', 1, TRUE),    -- CS101 (mandatory)
-- Hannah's grades
(12, '5', 'Final', '2024-11-15', 4, TRUE),    -- MATH201 (mandatory)
(13, '5', 'Midterm', '2024-10-15', 3, TRUE);  -- MATH101

-- Insert Grade History (examples of grade corrections)
INSERT INTO GradeHistory (grade_id, old_grade_value, new_grade_value, changed_by, change_reason) VALUES
(1, '4', '5', 1, 'Correction after final exam review'),
(3, '3', '4', 2, 'Extra credit assignment completed');

-- Insert Instructor Payments
-- Payments should total approximately the instructor's annual salary (±10%)
-- John Smith - salary 85000.00, payments should be 76500-93500
INSERT INTO InstructorPayments (instructor_id, payment_date, amount, payment_type, fiscal_year) VALUES
(1, '2024-01-31', 7083.33, 'Monthly Salary', 2024),
(1, '2024-02-29', 7083.33, 'Monthly Salary', 2024),
(1, '2024-03-31', 7083.33, 'Monthly Salary', 2024),
(1, '2024-04-30', 7083.33, 'Monthly Salary', 2024),
(1, '2024-05-31', 7083.33, 'Monthly Salary', 2024),
(1, '2024-06-30', 7083.33, 'Monthly Salary', 2024),
(1, '2024-07-31', 7083.33, 'Monthly Salary', 2024),
(1, '2024-08-31', 7083.33, 'Monthly Salary', 2024),
(1, '2024-09-30', 7083.33, 'Monthly Salary', 2024),
(1, '2024-10-31', 7083.33, 'Monthly Salary', 2024),
(1, '2024-11-30', 7083.33, 'Monthly Salary', 2024),
(1, '2024-12-31', 7083.37, 'Monthly Salary', 2024);

-- Emily Johnson - salary 78000.00, monthly = 6500.00
INSERT INTO InstructorPayments (instructor_id, payment_date, amount, payment_type, fiscal_year) VALUES
(2, '2024-01-31', 6500.00, 'Monthly Salary', 2024),
(2, '2024-02-29', 6500.00, 'Monthly Salary', 2024),
(2, '2024-03-31', 6500.00, 'Monthly Salary', 2024),
(2, '2024-04-30', 6500.00, 'Monthly Salary', 2024),
(2, '2024-05-31', 6500.00, 'Monthly Salary', 2024),
(2, '2024-06-30', 6500.00, 'Monthly Salary', 2024),
(2, '2024-07-31', 6500.00, 'Monthly Salary', 2024),
(2, '2024-08-31', 6500.00, 'Monthly Salary', 2024),
(2, '2024-09-30', 6500.00, 'Monthly Salary', 2024),
(2, '2024-10-31', 6500.00, 'Monthly Salary', 2024),
(2, '2024-11-30', 6500.00, 'Monthly Salary', 2024),
(2, '2024-12-31', 6500.00, 'Monthly Salary', 2024);

-- Michael Williams - salary 82000.00, adding some bonus payments
INSERT INTO InstructorPayments (instructor_id, payment_date, amount, payment_type, fiscal_year) VALUES
(3, '2024-01-31', 6833.33, 'Monthly Salary', 2024),
(3, '2024-02-29', 6833.33, 'Monthly Salary', 2024),
(3, '2024-03-31', 6833.33, 'Monthly Salary', 2024),
(3, '2024-04-30', 6833.33, 'Monthly Salary', 2024),
(3, '2024-05-31', 6833.33, 'Monthly Salary', 2024),
(3, '2024-06-30', 6833.33, 'Monthly Salary', 2024),
(3, '2024-07-31', 6833.33, 'Monthly Salary', 2024),
(3, '2024-08-31', 6833.33, 'Monthly Salary', 2024),
(3, '2024-09-30', 6833.33, 'Monthly Salary', 2024),
(3, '2024-10-31', 6833.33, 'Monthly Salary', 2024),
(3, '2024-11-30', 6833.33, 'Monthly Salary', 2024),
(3, '2024-12-31', 6833.37, 'Monthly Salary', 2024),
(3, '2024-12-20', 3000.00, 'Bonus', 2024);

-- Sarah Brown - salary 75000.00
INSERT INTO InstructorPayments (instructor_id, payment_date, amount, payment_type, fiscal_year) VALUES
(4, '2024-01-31', 6250.00, 'Monthly Salary', 2024),
(4, '2024-02-29', 6250.00, 'Monthly Salary', 2024),
(4, '2024-03-31', 6250.00, 'Monthly Salary', 2024),
(4, '2024-04-30', 6250.00, 'Monthly Salary', 2024),
(4, '2024-05-31', 6250.00, 'Monthly Salary', 2024),
(4, '2024-06-30', 6250.00, 'Monthly Salary', 2024),
(4, '2024-07-31', 6250.00, 'Monthly Salary', 2024),
(4, '2024-08-31', 6250.00, 'Monthly Salary', 2024),
(4, '2024-09-30', 6250.00, 'Monthly Salary', 2024),
(4, '2024-10-31', 6250.00, 'Monthly Salary', 2024),
(4, '2024-11-30', 6250.00, 'Monthly Salary', 2024),
(4, '2024-12-31', 6250.00, 'Monthly Salary', 2024);
