-- ============================================================================
-- MySQL Workbench Test Script: Verify StudentHistory Triggers
-- ============================================================================
-- How to use in MySQL Workbench:
-- 1. Open MySQL Workbench and connect to your database server
-- 2. Select the college_db database (or run: USE college_db;)
-- 3. Copy and paste this entire script into a new SQL tab
-- 4. Click the lightning bolt icon (⚡) or press Ctrl+Shift+Enter to execute all
-- 5. Check the Results Grid for output from each step
-- ============================================================================

USE college_db;

-- ============================================================================
-- STEP 1: View current state before testing
-- ============================================================================
-- Check current Students (first 5)
SELECT 'STEP 1: Current Students' AS step;
SELECT student_id, first_name, last_name, gpa FROM Students LIMIT 5;

-- Check current history count
SELECT 'Current history record count:' AS info, COUNT(*) AS count FROM StudentHistory;

-- ============================================================================
-- STEP 2: Test UPDATE trigger
-- ============================================================================
SELECT 'STEP 2: Testing UPDATE Trigger' AS step;

-- Show student 1 BEFORE update
SELECT 'Student 1 BEFORE update:' AS info;
SELECT student_id, first_name, last_name, gpa FROM Students WHERE student_id = 1;

-- Perform UPDATE - this triggers trg_student_history_update
UPDATE Students SET gpa = 3.99 WHERE student_id = 1;

-- Show student 1 AFTER update
SELECT 'Student 1 AFTER update:' AS info;
SELECT student_id, first_name, last_name, gpa FROM Students WHERE student_id = 1;

-- Check the history - should show OLD gpa (3.85) was saved
SELECT 'History created by UPDATE trigger (OLD value saved):' AS info;
SELECT history_id, student_id, first_name, last_name, gpa AS old_gpa, change_type, changed_at 
FROM StudentHistory 
WHERE student_id = 1 
ORDER BY history_id DESC 
LIMIT 1;

-- ============================================================================
-- STEP 3: Test DELETE trigger
-- ============================================================================
SELECT 'STEP 3: Testing DELETE Trigger' AS step;

-- Create a test student to delete
INSERT INTO Students (first_name, last_name, email, phone, date_of_birth, enrollment_year, major_department_id, gpa)
VALUES ('TestDelete', 'TriggerTest', 'test.trigger@test.edu', '000-0000', '2000-01-01', 2024, 1, 2.00);

-- Show the test student
SELECT 'Test student created:' AS info;
SELECT student_id, first_name, last_name, email, gpa FROM Students WHERE email = 'test.trigger@test.edu';

-- Store the ID for reference
SET @test_id = (SELECT student_id FROM Students WHERE email = 'test.trigger@test.edu');

-- Delete the test student - this triggers trg_student_history_delete
DELETE FROM Students WHERE email = 'test.trigger@test.edu';

-- Check history - the deleted student should be preserved
SELECT 'History created by DELETE trigger (deleted record preserved):' AS info;
SELECT history_id, student_id, first_name, last_name, email, gpa, change_type, changed_at 
FROM StudentHistory 
WHERE email = 'test.trigger@test.edu';

-- ============================================================================
-- STEP 4: Summary and Verification
-- ============================================================================
SELECT 'STEP 4: Summary' AS step;

-- Show history count by change type
SELECT 'History records by change type:' AS info;
SELECT change_type, COUNT(*) AS count FROM StudentHistory GROUP BY change_type;

-- Show all history for student 1
SELECT 'Complete history for Student 1:' AS info;
SELECT history_id, gpa, phone, change_type, changed_at 
FROM StudentHistory 
WHERE student_id = 1 
ORDER BY history_id;

-- ============================================================================
-- STEP 5: Restore original data
-- ============================================================================
SELECT 'STEP 5: Restoring original data' AS step;

-- Restore student 1 to original values
UPDATE Students SET gpa = 3.85, phone = '555-1001' WHERE student_id = 1;

SELECT 'Student 1 restored to original:' AS info;
SELECT student_id, first_name, last_name, gpa, phone FROM Students WHERE student_id = 1;

-- ============================================================================
-- TEST RESULTS
-- ============================================================================
SELECT '========== TEST COMPLETE ==========' AS result;
SELECT 'SUCCESS: If you see UPDATE and DELETE records in StudentHistory, triggers work!' AS message;
SELECT 'ÕNNESTUS: Kui näed UPDATE ja DELETE kirjeid StudentHistory tabelis, triggerid töötavad!' AS teade;
