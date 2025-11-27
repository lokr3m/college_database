-- ============================================================================
-- TEST SCRIPT: Verify StudentHistory Triggers / Triggerite Testimise Skript
-- ============================================================================
-- This script tests that the StudentHistory triggers are working correctly.
-- Run this AFTER schema.sql and sample_data.sql have been executed.
--
-- See skript testib, et StudentHistory triggerid töötavad korrektselt.
-- Käivitage see PÄRAST schema.sql ja sample_data.sql täitmist.
--
-- Usage / Kasutamine:
--   mysql -u your_user -p college_db < database/test_triggers.sql
-- ============================================================================

-- Select the database
USE college_db;

-- ============================================================================
-- STEP 1: Check initial state / Algoleku kontrollimine
-- ============================================================================
SELECT '=== STEP 1: Initial State ===' AS test_step;
SELECT '--- Current Students table (first 3 records) ---' AS info;
SELECT student_id, first_name, last_name, gpa FROM Students LIMIT 3;

SELECT '--- Current StudentHistory count ---' AS info;
SELECT COUNT(*) AS history_count_before FROM StudentHistory;

-- ============================================================================
-- STEP 2: Test UPDATE trigger / UPDATE triggeri testimine
-- ============================================================================
SELECT '=== STEP 2: Testing UPDATE Trigger ===' AS test_step;

-- Store the current GPA of student 1 for reference
SELECT '--- Student 1 BEFORE update ---' AS info;
SELECT student_id, first_name, last_name, gpa FROM Students WHERE student_id = 1;

-- Perform an UPDATE - this should trigger trg_student_history_update
UPDATE Students SET gpa = 3.99 WHERE student_id = 1;

SELECT '--- Student 1 AFTER update ---' AS info;
SELECT student_id, first_name, last_name, gpa FROM Students WHERE student_id = 1;

-- Check if history was created
SELECT '--- StudentHistory after UPDATE (should show OLD gpa value) ---' AS info;
SELECT history_id, student_id, first_name, last_name, gpa, change_type, changed_at 
FROM StudentHistory 
WHERE student_id = 1 
ORDER BY changed_at DESC 
LIMIT 1;

-- ============================================================================
-- STEP 3: Test multiple UPDATEs / Mitme UPDATE testimine
-- ============================================================================
SELECT '=== STEP 3: Testing Multiple UPDATEs ===' AS test_step;

-- Update the same student again
UPDATE Students SET gpa = 4.00 WHERE student_id = 1;
UPDATE Students SET phone = '555-9999' WHERE student_id = 1;

SELECT '--- StudentHistory after multiple UPDATEs (should show 3 new records for student 1) ---' AS info;
SELECT history_id, student_id, first_name, gpa, phone, change_type, changed_at 
FROM StudentHistory 
WHERE student_id = 1 
ORDER BY changed_at DESC 
LIMIT 5;

-- ============================================================================
-- STEP 4: Test DELETE trigger / DELETE triggeri testimine
-- ============================================================================
SELECT '=== STEP 4: Testing DELETE Trigger ===' AS test_step;

-- First, create a temporary test student that we can safely delete
INSERT INTO Students (first_name, last_name, email, phone, date_of_birth, enrollment_year, major_department_id, gpa)
VALUES ('Test', 'Student', 'test.delete@student.college.edu', '555-0000', '2000-01-01', 2024, 1, 2.50);

SELECT '--- Test student created ---' AS info;
SELECT student_id, first_name, last_name, email, gpa FROM Students WHERE email = 'test.delete@student.college.edu';

-- Get the student_id of the test student
SET @test_student_id = (SELECT student_id FROM Students WHERE email = 'test.delete@student.college.edu');

-- Delete the test student - this should trigger trg_student_history_delete
DELETE FROM Students WHERE student_id = @test_student_id;

SELECT '--- StudentHistory after DELETE (should show the deleted student with change_type=DELETE) ---' AS info;
SELECT history_id, student_id, first_name, last_name, email, gpa, change_type, changed_at 
FROM StudentHistory 
WHERE email = 'test.delete@student.college.edu'
ORDER BY changed_at DESC;

-- ============================================================================
-- STEP 5: Final verification / Lõplik kontroll
-- ============================================================================
SELECT '=== STEP 5: Final Verification ===' AS test_step;

SELECT '--- Total StudentHistory records ---' AS info;
SELECT COUNT(*) AS total_history_records FROM StudentHistory;

SELECT '--- History records by change_type ---' AS info;
SELECT change_type, COUNT(*) AS count FROM StudentHistory GROUP BY change_type;

SELECT '--- Student 1 complete history (showing GPA progression) ---' AS info;
SELECT history_id, gpa, change_type, changed_at 
FROM StudentHistory 
WHERE student_id = 1 
ORDER BY changed_at ASC;

-- ============================================================================
-- STEP 6: Restore original state / Algoleku taastamine
-- ============================================================================
SELECT '=== STEP 6: Restoring Original State ===' AS test_step;

-- Restore student 1 to original values (from sample_data.sql: GPA 3.85, phone 555-1001)
UPDATE Students SET gpa = 3.85, phone = '555-1001' WHERE student_id = 1;

SELECT '--- Student 1 restored ---' AS info;
SELECT student_id, first_name, last_name, gpa, phone FROM Students WHERE student_id = 1;

-- ============================================================================
-- TEST COMPLETE / TEST LÕPETATUD
-- ============================================================================
SELECT '=== TEST COMPLETE ===' AS test_step;
SELECT 'If you see history records with both UPDATE and DELETE change_types, the triggers are working correctly!' AS result;
SELECT 'Kui näete ajalookirjeid nii UPDATE kui DELETE muudatuse tüüpidega, siis triggerid töötavad korrektselt!' AS tulemus;
