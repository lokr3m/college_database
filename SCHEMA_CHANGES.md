# Database Schema Changes

## Overview

This document describes the enhancements made to the college database schema to support new requirements:

1. Mandatory courses by department and academic year
2. Automatic enrollment of students in mandatory courses
3. Instructor payment tracking
4. Individual grades with correction history

## New Tables

### 1. MandatoryCourses

Defines which courses are mandatory for each department in each academic year (1 or 2).

**Fields:**
- `mandatory_course_id` - Primary key
- `department_id` - Reference to department
- `course_id` - Reference to the mandatory course
- `academic_year` - Academic year (1 or 2)

**Example:**
```sql
-- CS101 is mandatory for Computer Science students in year 1
INSERT INTO MandatoryCourses (department_id, course_id, academic_year) 
VALUES (1, 1, 1);
```

### 2. Grades

Stores individual grades for student enrollments. Supports multiple grades per course (homework, tests, exams).

**Fields:**
- `grade_id` - Primary key
- `enrollment_id` - Reference to the enrollment
- `grade_value` - The actual grade (e.g., "5", "4", "A", "B")
- `grade_type` - Type of assessment (e.g., "Homework", "Exam", "Final")
- `grade_date` - When the grade was given
- `comment` - Optional comment
- `graded_by` - Instructor who gave the grade
- `is_current` - Whether this is the current/active grade

**Example:**
```sql
-- Record a final exam grade
INSERT INTO Grades (enrollment_id, grade_value, grade_type, grade_date, graded_by) 
VALUES (1, '5', 'Final', '2024-11-15', 1);
```

### 3. GradeHistory

Tracks all grade corrections/changes to preserve the history.

**Fields:**
- `history_id` - Primary key
- `grade_id` - Reference to the current grade
- `old_grade_value` - Previous grade
- `new_grade_value` - New grade
- `change_date` - When the change was made
- `changed_by` - Instructor who made the change
- `change_reason` - Reason for the correction

**Example:**
```sql
-- Record a grade correction
INSERT INTO GradeHistory (grade_id, old_grade_value, new_grade_value, changed_by, change_reason) 
VALUES (1, '4', '5', 1, 'Correction after final exam review');
```

### 4. InstructorPayments

Tracks financial payments made to instructors.

**Fields:**
- `payment_id` - Primary key
- `instructor_id` - Reference to instructor
- `payment_date` - Date of payment
- `amount` - Payment amount
- `payment_type` - Type (e.g., "Monthly Salary", "Bonus")
- `description` - Optional description
- `fiscal_year` - Fiscal year

**Business Rule:** Total annual payments should be within ±10% of the instructor's annual salary.

**Example:**
```sql
-- Record a monthly salary payment
INSERT INTO InstructorPayments (instructor_id, payment_date, amount, payment_type, fiscal_year) 
VALUES (1, '2024-01-31', 7083.33, 'Monthly Salary', 2024);
```

## Modified Tables

### Students Table

**Added field:**
- `academic_year` - Current academic year (1 or 2), default 1

This field is used by the trigger to determine which mandatory courses to enroll the student in.

### Enrollments Table

**Modified fields:**
- Removed `grade` field (now in separate Grades table)
- Added `is_mandatory` field - Indicates if this enrollment is for a mandatory course

## New Triggers

### auto_enroll_mandatory_courses

Automatically enrolls new students in their department's mandatory courses when they are added to the system.

**Behavior:**
- Triggers AFTER INSERT on Students table
- Enrolls student in all mandatory courses matching their:
  - `major_department_id`
  - `academic_year`
- Sets `is_mandatory = TRUE` for these enrollments
- Sets `enrollment_date` to current date
- Sets `status = 'Active'`

**Example:**
```sql
-- When this student is inserted:
INSERT INTO Students (..., major_department_id, academic_year) 
VALUES (..., 1, 1);

-- The trigger automatically creates enrollments for all CS year 1 mandatory courses
```

## Migration from Old Schema

If you have existing data with grades in the Enrollments table:

```sql
-- Move existing grades to Grades table
INSERT INTO Grades (enrollment_id, grade_value, grade_type, grade_date, is_current)
SELECT 
    enrollment_id,
    grade,
    'Final',
    CURDATE(),
    TRUE
FROM Enrollments
WHERE grade IS NOT NULL;

-- Then you can remove the grade field from Enrollments
```

## Usage Examples

### 1. View all mandatory courses by department

```sql
SELECT 
    d.department_name,
    mc.academic_year,
    c.course_code,
    c.course_name
FROM MandatoryCourses mc
JOIN Departments d ON mc.department_id = d.department_id
JOIN Courses c ON mc.course_id = c.course_id
ORDER BY d.department_name, mc.academic_year;
```

### 2. Check automatic enrollments

```sql
SELECT 
    s.first_name,
    s.last_name,
    c.course_name,
    e.is_mandatory
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE e.is_mandatory = TRUE;
```

### 3. View student grades with history

```sql
SELECT 
    s.first_name,
    s.last_name,
    c.course_name,
    g.grade_value,
    g.grade_type,
    g.grade_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
LEFT JOIN Grades g ON e.enrollment_id = g.enrollment_id AND g.is_current = TRUE
ORDER BY s.last_name, s.first_name;
```

### 4. Verify instructor payments

```sql
SELECT 
    i.first_name,
    i.last_name,
    i.salary AS annual_salary,
    SUM(ip.amount) AS total_payments,
    ROUND((SUM(ip.amount) / i.salary) * 100, 1) AS percent_of_salary
FROM Instructors i
LEFT JOIN InstructorPayments ip ON i.instructor_id = ip.instructor_id 
    AND ip.fiscal_year = 2024
GROUP BY i.instructor_id;
```

### 5. Track grade corrections

```sql
SELECT 
    s.first_name,
    s.last_name,
    c.course_name,
    gh.old_grade_value,
    gh.new_grade_value,
    gh.change_reason,
    gh.change_date
FROM GradeHistory gh
JOIN Grades g ON gh.grade_id = g.grade_id
JOIN Enrollments e ON g.enrollment_id = e.enrollment_id
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
ORDER BY gh.change_date DESC;
```

## Testing

The schema has been tested with MySQL and includes comprehensive sample data demonstrating:
- ✅ Mandatory courses defined for 5 departments across 2 academic years
- ✅ Automatic enrollment of 8 students in their mandatory courses via trigger
- ✅ Payment tracking for 4 instructors with totals within ±10% of salary
- ✅ Individual grades for students with multiple assessment types
- ✅ Grade correction history with reasons

Run the test scripts:
```bash
# Create database and schema
sudo mysql --defaults-file=/etc/mysql/debian.cnf -e "CREATE DATABASE IF NOT EXISTS college_db;"
sudo mysql --defaults-file=/etc/mysql/debian.cnf college_db < database/schema.sql

# Load sample data
sudo mysql --defaults-file=/etc/mysql/debian.cnf college_db < database/sample_data.sql

# Verify the changes
sudo mysql --defaults-file=/etc/mysql/debian.cnf college_db -e "SELECT COUNT(*) FROM MandatoryCourses;"
sudo mysql --defaults-file=/etc/mysql/debian.cnf college_db -e "SELECT COUNT(*) FROM Grades;"
sudo mysql --defaults-file=/etc/mysql/debian.cnf college_db -e "SELECT COUNT(*) FROM InstructorPayments;"
```
