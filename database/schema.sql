-- College Database Schema / Kolledži Andmebaasi Skeem
-- This script creates all necessary tables for the college database system
-- See skript loob kõik vajalikud tabelid kolledži andmebaasi süsteemi jaoks
--
-- TERMINOLOGY / TERMINOLOOGIA:
-- Departments = Colleges/Schools = Osakonnad/Kolledžid (näiteks IT-osakond, Matemaatika-osakond)
-- Instructors = Teachers = Õpetajad/Õppejõud
-- Courses = Classes/Lessons = Kursused/Ained (näiteks Programmeerimine I, Matemaatika)
-- Students = Õpilased/Üliõpilased
-- Enrollments = Course Registrations = Kursusele registreerimised
--
-- TIMESTAMPS:
-- created_at and updated_at fields are automatically managed by MySQL
-- and track when records are created and last modified.
-- Need väljad haldab MySQL automaatselt ja jälgivad, millal kirjed loodi ja viimati muudeti.

-- Drop tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS DepartmentHeads;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Instructors;
DROP TABLE IF EXISTS Departments;

-- ============================================================================
-- DEPARTMENTS TABLE (Osakonnad / Kolledžid)
-- ============================================================================
-- Purpose / Eesmärk: 
--   Stores information about academic departments/colleges within the institution.
--   Each department represents a distinct academic unit (e.g., Computer Science, Mathematics).
--   Salvestab infot akadeemiliste osakondade/kolledžide kohta.
--   Iga osakond esindab eraldi akadeemilist üksust (nt Informaatika, Matemaatika).
--
-- Fields / Väljad:
--   - department_id: Unique identifier for the department / Osakonna unikaalne identifikaator
--   - department_name: Official name of the department (must be unique) / Osakonna ametlik nimi (peab olema unikaalne)
--   - building: Physical location/building where department is located / Füüsiline asukoht/hoone, kus osakond asub
--   - budget: Annual or allocated budget for the department / Aasta- või eraldatud eelarve osakonnale
-- ============================================================================
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    building VARCHAR(100),
    budget DECIMAL(12, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================================================
-- INSTRUCTORS TABLE (Õpetajad / Õppejõud)
-- ============================================================================
-- Purpose / Eesmärk:
--   Stores information about teachers/instructors employed by the institution.
--   Each instructor belongs to exactly ONE department.
--   Salvestab infot õpetajate/õppejõudude kohta, kes töötavad asutuses.
--   Iga õpetaja kuulub täpselt ÜHTE osakonda.
--
-- Fields / Väljad:
--   - instructor_id: Unique identifier for the instructor / Õpetaja unikaalne identifikaator
--   - first_name: Instructor's first name / Õpetaja eesnimi
--   - last_name: Instructor's last name / Õpetaja perekonnanimi
--   - email: Contact email (must be unique) / Kontakt-email (peab olema unikaalne)
--   - phone: Contact phone number / Kontakttelefon
--   - department_id: Department where instructor works (REQUIRED) / Osakond, kus õpetaja töötab (KOHUSTUSLIK)
--   - salary: Monthly or annual salary / Kuu- või aastapalk
--   - hire_date: Date when instructor was hired / Kuupäev, millal õpetaja palgati
--
-- Business Rules / Ärireeglid:
--   - An instructor can work in ONLY ONE department
--   - An instructor can teach MULTIPLE courses
--   - Õpetaja võib töötada ainult ÜHES osakonnas
--   - Õpetaja võib õpetada MITUT kursust
-- ============================================================================
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department_id INT NOT NULL,
    salary DECIMAL(10, 2),
    hire_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE,
    INDEX idx_department (department_id),
    INDEX idx_email (email)
);

-- ============================================================================
-- DEPARTMENT HEADS TABLE (Osakonnajuhatajad)
-- ============================================================================
-- Purpose / Eesmärk:
--   Tracks which instructor is currently serving as the head of each department.
--   Each department can have only ONE head at a time.
--   An instructor can be head of only ONE department at a time.
--   Jälgib, milline õpetaja on praegu iga osakonna juhataja.
--   Igal osakonnal saab olla ainult ÜKS juhataja korraga.
--   Õpetaja saab olla ainult ÜHE osakonna juhataja korraga.
--
-- Fields / Väljad:
--   - department_id: Department being led (PRIMARY KEY) / Juhitav osakond (PRIMAARVÕTI)
--   - instructor_id: Instructor serving as head (must be unique) / Õpetaja, kes töötab juhatajana (peab olema unikaalne)
--   - start_date: Date when this instructor became head / Kuupäev, millal see õpetaja sai juhatajaks
--
-- Historical Data / Ajaloolised Andmed:
--   CURRENT DESIGN: This table only tracks the CURRENT department head.
--   When a new head is assigned, the old record is REPLACED (not preserved).
--   If historical tracking is needed in the future, consider creating a separate
--   "DepartmentHeadHistory" table with additional fields like end_date and reason.
--
--   PRAEGUNE DISAIN: See tabel jälgib ainult PRAEGUST osakonnajuhatajat.
--   Kui määratakse uus juhataja, asendatakse vana kirje (ei säilitata).
--   Kui tulevikus on vaja ajaloolist jälgimist, kaaluge eraldi 
--   "DepartmentHeadHistory" tabeli loomist täiendavate väljadega nagu end_date ja reason.
--
-- Business Rules / Ärireeglid:
--   - Each department can have at most ONE head
--   - An instructor can be head of only ONE department
--   - The instructor must work in the department they are heading
--   - Igal osakonnal võib olla kõige rohkem ÜKS juhataja
--   - Õpetaja saab olla ainult ÜHE osakonna juhataja
--   - Õpetaja peab töötama osakonnas, mida ta juhib
-- ============================================================================
CREATE TABLE DepartmentHeads (
    department_id INT PRIMARY KEY,
    instructor_id INT UNIQUE NOT NULL,
    start_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id) ON DELETE CASCADE
);

-- ============================================================================
-- COURSES TABLE (Kursused / Ained)
-- ============================================================================
-- Purpose / Eesmärk:
--   Stores information about courses/subjects offered by the institution.
--   Each course belongs to ONE department and is taught by ONE instructor.
--   Salvestab infot institutsioonide poolt pakutavate kursuste/ainete kohta.
--   Iga kursus kuulub ÜHTE osakonda ja seda õpetab ÜKS õpetaja.
--
-- Fields / Väljad:
--   - course_id: Unique identifier for the course / Kursuse unikaalne identifikaator
--   - course_code: Short code for the course (e.g., "CS101", "MATH200") / Lühike kood kursuse jaoks
--   - course_name: Full name of the course / Kursuse täisnimi
--   - department_id: Department offering this course (REQUIRED) / Osakond, mis pakub seda kursust (KOHUSTUSLIK)
--   - instructor_id: Instructor teaching this course / Õpetaja, kes õpetab seda kursust
--   - credits: Credit hours/points for the course / Krediidipunktid kursuse eest
--   - semester: Academic term when course is offered / Akadeemiline periood, millal kursust pakutakse
--               Examples: "Fall 2024", "Spring 2025", "Sügis 2024", "Kevad 2025"
--               This indicates WHEN the course runs (which semester/term)
--               See näitab, MILLAL kursus toimub (milline semester/trimester)
--   - year: Academic year / Õppeaasta
--           Examples: 2024, 2025
--           Combined with semester to uniquely identify the course offering period
--           Koos semestriga määrab kursuse pakkumise perioodi
--   - room_number: Classroom/lecture hall where course is held / Klassiruumi/loenguruumi number, kus kursus toimub
--                  Examples: "A-101", "Room 305", "Building B-201"
--                  This is the PHYSICAL LOCATION where classes take place
--                  See on FÜÜSILINE ASUKOHT, kus tunnid toimuvad
--   - schedule: Class meeting times / Tundide toimumise ajad
--               Examples: "Mon/Wed 10:00-11:30", "E/K 10:00-11:30", "Tue 14:00-16:00"
--               This indicates WHEN during the week the class meets
--               See näitab, MILLAL nädala jooksul tund toimub
--
-- Business Rules / Ärireeglid:
--   - Each course is taught by ONLY ONE instructor
--   - A course belongs to exactly ONE department
--   - An instructor can teach MULTIPLE courses
--   - Iga kursust õpetab ainult ÜKS õpetaja
--   - Kursus kuulub täpselt ÜHTE osakonda
--   - Õpetaja võib õpetada MITUT kursust
--
-- Note on Schedule Fields / Märkus ajakava väljade kohta:
--   The combination of semester, year, room_number, and schedule provides complete
--   information about when and where a course is offered. This is flexible and
--   allows for different scheduling patterns without requiring a complex timetable system.
--   
--   Semestri, aasta, ruumi numbri ja ajakava kombinatsioon annab täieliku
--   informatsiooni selle kohta, millal ja kus kursust pakutakse. See on paindlik ja
--   võimaldab erinevaid ajakava mustreid ilma keerulise tunniplaani süsteemita.
-- ============================================================================
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    instructor_id INT,
    credits INT NOT NULL DEFAULT 3,
    semester VARCHAR(20),
    year INT,
    room_number VARCHAR(20),
    schedule VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id) ON DELETE SET NULL,
    INDEX idx_department (department_id),
    INDEX idx_instructor (instructor_id),
    INDEX idx_course_code (course_code)
);

-- ============================================================================
-- STUDENTS TABLE (Õpilased / Üliõilased)
-- ============================================================================
-- Purpose / Eesmärk:
--   Stores information about students enrolled in the institution.
--   Salvestab infot institutsioonides õppivate õpilaste kohta.
--
-- Fields / Väljad:
--   - student_id: Unique identifier for the student / Õpilase unikaalne identifikaator
--   - first_name: Student's first name / Õpilase eesnimi
--   - last_name: Student's last name / Õpilase perekonnanimi
--   - email: Contact email (must be unique) / Kontakt-email (peab olema unikaalne)
--   - phone: Contact phone number / Kontakttelefon
--   - date_of_birth: Student's birth date / Õpilase sünnikuupäev
--   - enrollment_year: Year the student first enrolled / Aasta, millal õpilane esmakordselt registreerus
--   - major_department_id: Student's major/primary department / Õpilase eriala/põhiosakond
--   - gpa: Grade Point Average (0.00 to 5.00 scale) / Keskmine hinne (0.00 kuni 5.00 skaalal)
--
-- Business Rules / Ärireeglid:
--   - Students can enroll in MULTIPLE courses
--   - A student has ONE primary major department
--   - Õpilased võivad registreeruda MITMELE kursusele
--   - Õpilasel on ÜKS põhieriala osakond
-- ============================================================================
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    enrollment_year INT,
    major_department_id INT,
    gpa DECIMAL(3, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (major_department_id) REFERENCES Departments(department_id) ON DELETE SET NULL,
    INDEX idx_email (email),
    INDEX idx_major_department (major_department_id)
);

-- ============================================================================
-- ENROLLMENTS TABLE (Kursusele registreerimised)
-- ============================================================================
-- Purpose / Eesmärk:
--   Manages the many-to-many relationship between students and courses.
--   Tracks which students are enrolled in which courses and their grades.
--   Haldab mitme-mitmele suhet õpilaste ja kursuste vahel.
--   Jälgib, millised õpilased on registreerunud millistele kursustele ja nende hindeid.
--
-- Fields / Väljad:
--   - enrollment_id: Unique identifier for the enrollment / Registreerumise unikaalne identifikaator
--   - student_id: Student enrolled (REQUIRED) / Registreerunud õpilane (KOHUSTUSLIK)
--   - course_id: Course being taken (REQUIRED) / Võetav kursus (KOHUSTUSLIK)
--   - enrollment_date: Date when student enrolled in course / Kuupäev, millal õpilane kursusele registreerus
--   - grade: Final grade for the course / Lõplik hinne kursuse eest
--            Examples: "A", "B", "C", "5", "4", "3"
--   - status: Current enrollment status / Praegune registreerumise olek
--             Examples: "Active" (currently enrolled), "Completed" (finished), 
--                       "Dropped" (withdrew from course), "Failed" (did not pass)
--
-- Business Rules / Ärireeglid:
--   - A student can enroll in MULTIPLE courses
--   - A course can have MULTIPLE students
--   - A student can enroll in the same course only ONCE (enforced by UNIQUE constraint)
--   - Õpilane võib registreeruda MITMELE kursusele
--   - Kursusel võib olla MITU õpilast
--   - Õpilane saab samale kursusele registreeruda ainult ÜÜKS kord (tagatud UNIQUE piiranguga)
-- ============================================================================
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(2),
    status VARCHAR(20) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, course_id),
    INDEX idx_student (student_id),
    INDEX idx_course (course_id)
);
