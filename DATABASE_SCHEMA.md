# Database Schema Documentation / Andmebaasi Skeemi Dokumentatsioon

## Important Notes / Tähtsad Märkused

**Terminology / Terminoloogia:**
- **Departments** = Colleges/Schools = **Osakonnad/Kolledžid** (e.g., IT Department, Mathematics Department)
- **Instructors** = Teachers = **Õpetajad/Õppejõud**
- **Courses** = Classes/Subjects = **Kursused/Ained** (e.g., Programming I, Mathematics)
- **Students** = **Õpilased/Üliõilased**
- **Enrollments** = Course Registrations = **Kursusele registreerimised**

**Automatic Timestamps:**
All tables include `created_at` and `updated_at` fields that are automatically managed by MySQL. These track when records are created and last modified.

Kõik tabelid sisaldavad `created_at` ja `updated_at` välju, mida MySQL haldab automaatselt. Need jälgivad, millal kirjed loodi ja viimati muudeti.

## Entity Relationship Overview

```
┌─────────────────┐         ┌─────────────────┐
│   Departments   │◄────┐   │   Instructors   │
│                 │     │   │                 │
│ PK: dept_id     │     └───│ FK: dept_id     │
│                 │         │ PK: inst_id     │
└────────┬────────┘         └────────┬────────┘
         │                           │
         │ 1:1                       │ 1:1
         │                           │
         ▼                           ▼
┌─────────────────┐         ┌─────────────────┐
│ DepartmentHeads │         │     Courses     │
│                 │         │                 │
│ PK: dept_id     │         │ PK: course_id   │
│ FK: inst_id     │◄────────│ FK: dept_id     │
└─────────────────┘    1:M  │ FK: inst_id     │
                             └────────┬────────┘
                                      │
                                      │ M:N
                                      │
                                      ▼
                             ┌─────────────────┐
                             │   Enrollments   │
                             │                 │
                             │ PK: enroll_id   │
                             │ FK: student_id  │◄────┐
                             │ FK: course_id   │     │
                             └─────────────────┘     │
                                                     │
                                              ┌──────┴────────┐
                                              │   Students    │
                                              │               │
                                              │ PK: stud_id   │
                                              │ FK: major_id  │
                                              └───────────────┘
```

## Tables Details

### 1. Departments (Osakonnad / Kolledžid)
**Purpose / Eesmärk**: Stores information about academic departments/colleges
Salvestab infot akadeemiliste osakondade/kolledžide kohta

| Column | Type | Constraints | Description | Kirjeldus (Estonian) |
|--------|------|-------------|-------------|----------------------|
| department_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier | Unikaalne identifikaator |
| department_name | VARCHAR(100) | NOT NULL, UNIQUE | Department name (e.g., "Computer Science", "Mathematics") | Osakonna nimi |
| building | VARCHAR(100) | | Building location where department is housed | Hoone, kus osakond asub |
| budget | DECIMAL(12,2) | | Annual or allocated budget for the department | Aasta- või eraldatud eelarve |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time (automatic) | Kirje loomise aeg (automaatne) |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time (automatic) | Viimase uuenduse aeg (automaatne) |

**Relationships / Seosed**:
- One-to-Many with Instructors (üks-mitmele õpetajatega)
- One-to-Many with Courses (üks-mitmele kursustega)
- One-to-One with DepartmentHeads (üks-ühele osakonnajuhiga)
- One-to-Many with Students (major) (üks-mitmele üliõilastega - eriala järgi)

---

### 2. Instructors (Õpetajad / Õppejõud)
**Purpose / Eesmärk**: Stores instructor information and department association
Salvestab õpetajate infot ja osakonna kuuluvust

| Column | Type | Constraints | Description | Kirjeldus (Estonian) |
|--------|------|-------------|-------------|----------------------|
| instructor_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier | Unikaalne identifikaator |
| first_name | VARCHAR(50) | NOT NULL | First name | Eesnimi |
| last_name | VARCHAR(50) | NOT NULL | Last name | Perekonnanimi |
| email | VARCHAR(100) | NOT NULL, UNIQUE | Email address | E-posti aadress |
| phone | VARCHAR(20) | | Phone number | Telefoninumber |
| department_id | INT | NOT NULL, FOREIGN KEY | Associated department (REQUIRED - instructor must belong to one department) | Seotud osakond (KOHUSTUSLIK) |
| salary | DECIMAL(10,2) | | Monthly or annual salary | Kuu- või aastapalk |
| hire_date | DATE | | Date of hire | Töölevõtmise kuupäev |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time (automatic) | Kirje loomise aeg (automaatne) |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time (automatic) | Viimase uuenduse aeg (automaatne) |

**Relationships / Seosed**:
- Many-to-One with Departments (mitu-ühele osakondadega)
- One-to-Many with Courses (üks-mitmele kursustega)
- One-to-One with DepartmentHeads (üks-ühele osakonnajuhiga)

**Constraints / Piirangud**:
- An instructor works in only ONE department / Õpetaja töötab ainult ÜHES osakonnas
- An instructor can teach multiple courses / Õpetaja võib õpetada mitut kursust

---

### 3. DepartmentHeads (Osakonnajuhatajad)
**Purpose / Eesmärk**: Manages department head assignments (one head per department)
Haldab osakonnajuhatajate määramist (üks juhataja osakonna kohta)

| Column | Type | Constraints | Description | Kirjeldus (Estonian) |
|--------|------|-------------|-------------|----------------------|
| department_id | INT | PRIMARY KEY, FOREIGN KEY | Department reference | Osakonna viide |
| instructor_id | INT | UNIQUE, NOT NULL, FOREIGN KEY | Instructor serving as head | Juhatajana töötav õpetaja |
| start_date | DATE | NOT NULL | Start date as head | Juhatajana alustamise kuupäev |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time (automatic) | Kirje loomise aeg (automaatne) |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time (automatic) | Viimase uuenduse aeg (automaatne) |

**Relationships / Seosed**:
- One-to-One with Departments (üks-ühele osakondadega)
- One-to-One with Instructors (üks-ühele õpetajatega)

**Constraints / Piirangud**:
- Each department has exactly ONE head / Igal osakonnal on täpselt ÜKS juhataja
- An instructor can be head of only ONE department / Õpetaja saab olla ainult ÜHE osakonna juhataja
- The instructor must work in the department they head / Õpetaja peab töötama osakonnas, mida ta juhib

**Historical Data / Ajaloolised Andmed**:
- **Current Design**: Only tracks the CURRENT department head. When a new head is assigned, the old record is replaced.
- **Praegune disain**: Jälgib ainult PRAEGUST osakonnajuhatajat. Kui määratakse uus juhataja, asendatakse vana kirje.
- **Future Consideration**: If historical tracking is needed, create a separate "DepartmentHeadHistory" table with fields like `end_date` and `reason`.
- **Tuleviku kaalutlus**: Kui ajaloolist jälgimist on vaja, loo eraldi "DepartmentHeadHistory" tabel väljadega nagu `end_date` ja `reason`.

---

### 4. Courses (Kursused / Ained)
**Purpose / Eesmärk**: Stores course offerings and assignments
Salvestab kursuste pakkumisi ja ülesandeid

| Column | Type | Constraints | Description | Kirjeldus (Estonian) |
|--------|------|-------------|-------------|----------------------|
| course_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier | Unikaalne identifikaator |
| course_code | VARCHAR(20) | NOT NULL, UNIQUE | Course code (e.g., CS101, MATH200) | Kursuse kood |
| course_name | VARCHAR(100) | NOT NULL | Course name | Kursuse nimi |
| department_id | INT | NOT NULL, FOREIGN KEY | Department offering course | Kursust pakkuv osakond |
| instructor_id | INT | FOREIGN KEY | Assigned instructor | Määratud õpetaja |
| credits | INT | NOT NULL, DEFAULT 3 | Credit hours/points | Krediidipunktid |
| semester | VARCHAR(20) | | Academic term when course is offered (e.g., "Fall 2024", "Spring 2025", "Sügis 2024") | Akadeemiline periood, millal kursust pakutakse |
| year | INT | | Academic year (e.g., 2024, 2025) | Õppeaasta |
| room_number | VARCHAR(20) | | Classroom/lecture hall location (e.g., "A-101", "Room 305") | Klassiruumi/loenguruumi asukoht |
| schedule | VARCHAR(100) | | Class meeting times (e.g., "Mon/Wed 10:00-11:30", "E/K 10:00-11:30") | Tundide toimumise ajad |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time (automatic) | Kirje loomise aeg (automaatne) |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time (automatic) | Viimase uuenduse aeg (automaatne) |

**Field Explanations / Väljade selgitused**:

**semester** (semester/trimester):
- Indicates WHEN the course runs (which academic term)
- Examples: "Fall 2024", "Spring 2025", "Summer 2024"
- Estonian: "Sügis 2024", "Kevad 2025", "Suvi 2024"
- Näitab, MILLAL kursus toimub (milline akadeemiline periood)

**year** (õppeaasta):
- Academic year (e.g., 2024, 2025)
- Combined with semester to identify the course offering period
- Koos semestriga määrab kursuse pakkumise perioodi

**room_number** (klassiruumi number):
- Physical location where classes take place
- Examples: "A-101", "Room 305", "Building B-201"
- Füüsiline asukoht, kus tunnid toimuvad

**schedule** (ajakava):
- Class meeting times during the week
- Examples: "Mon/Wed 10:00-11:30", "Tue/Thu 14:00-16:00"
- Estonian format: "E/K 10:00-11:30" (Esmaspäev/Kolmapäev)
- Tundide toimumise ajad nädala jooksul

**Relationships / Seosed**:
- Many-to-One with Departments (mitu-ühele osakondadega)
- Many-to-One with Instructors (mitu-ühele õpetajatega)
- One-to-Many with Enrollments (üks-mitmele registreerimistega)

**Constraints / Piirangud**:
- Each course is taught by only ONE instructor / Iga kursust õpetab ainult ÜKS õpetaja
- A course belongs to exactly ONE department / Kursus kuulub täpselt ÜHTE osakonda

---

### 5. Students (Õpilased / Üliõilased)
**Purpose / Eesmärk**: Stores student information
Salvestab üliõilaste infot

| Column | Type | Constraints | Description | Kirjeldus (Estonian) |
|--------|------|-------------|-------------|----------------------|
| student_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier | Unikaalne identifikaator |
| first_name | VARCHAR(50) | NOT NULL | First name | Eesnimi |
| last_name | VARCHAR(50) | NOT NULL | Last name | Perekonnanimi |
| email | VARCHAR(100) | NOT NULL, UNIQUE | Email address | E-posti aadress |
| phone | VARCHAR(20) | | Phone number | Telefoninumber |
| date_of_birth | DATE | | Birth date | Sünnikuupäev |
| enrollment_year | INT | | Year first enrolled | Esmakordselt registreerumise aasta |
| major_department_id | INT | FOREIGN KEY | Major/primary department | Eriala/põhiosakond |
| gpa | DECIMAL(3,2) | | Grade Point Average (0.00 to 5.00) | Keskmine hinne |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time (automatic) | Kirje loomise aeg (automaatne) |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time (automatic) | Viimase uuenduse aeg (automaatne) |

**Relationships / Seosed**:
- Many-to-One with Departments (major) (mitu-ühele osakondadega - eriala)
- One-to-Many with Enrollments (üks-mitmele registreerimistega)

---

### 6. Enrollments (Kursusele registreerimised)
**Purpose / Eesmärk**: Manages student course enrollments (Many-to-Many relationship)
Haldab üliõilaste kursusele registreerimisi (Mitu-mitmele seos)

| Column | Type | Constraints | Description | Kirjeldus (Estonian) |
|--------|------|-------------|-------------|----------------------|
| enrollment_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier | Unikaalne identifikaator |
| student_id | INT | NOT NULL, FOREIGN KEY | Enrolled student | Registreerunud üliõilane |
| course_id | INT | NOT NULL, FOREIGN KEY | Enrolled course | Kursus, millele registreeruti |
| enrollment_date | DATE | NOT NULL | Date of enrollment | Registreerumise kuupäev |
| grade | VARCHAR(2) | | Final grade (e.g., "A", "B", "5", "4") | Lõplik hinne |
| status | VARCHAR(20) | DEFAULT 'Active' | Enrollment status: "Active", "Completed", "Dropped", "Failed" | Registreerumise olek |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time (automatic) | Kirje loomise aeg (automaatne) |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time (automatic) | Viimase uuenduse aeg (automaatne) |

**Relationships / Seosed**:
- Many-to-One with Students (mitu-ühele üliõilastega)
- Many-to-One with Courses (mitu-ühele kursustega)

**Constraints / Piirangud**:
- UNIQUE(student_id, course_id) - A student can enroll in a course only once / Üliõilane saab kursusele registreeruda ainult üks kord
- Students can enroll in multiple courses / Üliõilased võivad registreeruda mitmele kursusele
- Courses can have multiple students / Kursustel võib olla mitu üliõilast

---

## Indexes

For optimal query performance, the following indexes are created:

- **Departments**: `department_name` (UNIQUE)
- **Instructors**: `email` (UNIQUE), `department_id`
- **Courses**: `course_code` (UNIQUE), `department_id`, `instructor_id`
- **Students**: `email` (UNIQUE), `major_department_id`
- **Enrollments**: `student_id`, `course_id`, UNIQUE(student_id, course_id)

## Cascade Rules

- **ON DELETE CASCADE**: Deleting a department removes all associated instructors, courses, and enrollments
- **ON DELETE SET NULL**: Deleting an instructor sets course instructor_id to NULL
- **ON DELETE CASCADE**: Deleting a student or course removes associated enrollments

## Business Rules Enforced by Schema

1. ✅ An instructor works in only one department (department_id is NOT NULL)
2. ✅ A course is taught by only one instructor (instructor_id is single value)
3. ✅ Each department has at most one head (department_id is PRIMARY KEY in DepartmentHeads)
4. ✅ An instructor can be head of only one department (instructor_id is UNIQUE)
5. ✅ Students can enroll in multiple courses (Many-to-Many via Enrollments)
6. ✅ Courses can have multiple students (Many-to-Many via Enrollments)
7. ✅ No duplicate enrollments (UNIQUE constraint on student_id + course_id)

## Security Best Practices / Turvalisuse Parimad Tavad

**Database User Permissions / Andmebaasi kasutaja õigused:**

⚠️ **CRITICAL WARNING / KRIITILINE HOIATUS:**

**DO NOT use the 'root' MySQL user for application access!**
**ÄRA kasuta 'root' MySQL kasutajat rakenduse juurdepääsuks!**

The 'root' user has dangerous privileges:
- ❌ DROP DATABASE (can delete entire database)
- ❌ DROP TABLE (can delete tables)
- ❌ CREATE USER (can create new users)
- ❌ GRANT (can give permissions to others)

Root kasutajal on ohtlikud õigused:
- ❌ DROP DATABASE (saab kustutada terve andmebaasi)
- ❌ DROP TABLE (saab kustutada tabeleid)
- ❌ CREATE USER (saab luua uusi kasutajaid)
- ❌ GRANT (saab anda teistele õigusi)

**Recommended Approach / Soovitatav lähenemisviis:**

1. Create a dedicated application user with limited privileges:
   ```sql
   CREATE USER 'college_app'@'localhost' IDENTIFIED BY 'strong_password';
   GRANT SELECT, INSERT, UPDATE, DELETE ON college_db.* TO 'college_app'@'localhost';
   FLUSH PRIVILEGES;
   ```

2. This user can ONLY:
   - ✅ SELECT (read data)
   - ✅ INSERT (create new records)
   - ✅ UPDATE (modify records)
   - ✅ DELETE (remove records)

3. This user CANNOT:
   - ❌ DROP tables or databases
   - ❌ CREATE or ALTER table structures
   - ❌ Create or modify users
   - ❌ Change permissions

See detailed instructions in:
- `database/config.sql`
- `SETUP_GUIDE.md`
- `backend/config.php`

Vaata üksikasjalikke juhiseid:
- `database/config.sql`
- `SETUP_GUIDE.md`
- `backend/config.php`
