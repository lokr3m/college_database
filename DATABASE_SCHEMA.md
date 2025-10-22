# Database Schema Documentation

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

### 1. Departments
**Purpose**: Stores information about academic departments

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| department_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier |
| department_name | VARCHAR(100) | NOT NULL, UNIQUE | Department name |
| building | VARCHAR(100) | | Building location |
| budget | DECIMAL(12,2) | | Department budget |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time |

**Relationships**:
- One-to-Many with Instructors
- One-to-Many with Courses
- One-to-One with DepartmentHeads
- One-to-Many with Students (major)

---

### 2. Instructors
**Purpose**: Stores instructor information and department association

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| instructor_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier |
| first_name | VARCHAR(50) | NOT NULL | First name |
| last_name | VARCHAR(50) | NOT NULL | Last name |
| email | VARCHAR(100) | NOT NULL, UNIQUE | Email address |
| phone | VARCHAR(20) | | Phone number |
| department_id | INT | NOT NULL, FOREIGN KEY | Associated department |
| salary | DECIMAL(10,2) | | Salary amount |
| hire_date | DATE | | Date of hire |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time |

**Relationships**:
- Many-to-One with Departments
- One-to-Many with Courses
- One-to-One with DepartmentHeads

**Constraints**:
- An instructor works in only ONE department
- An instructor can teach multiple courses

---

### 3. DepartmentHeads
**Purpose**: Manages department head assignments (one head per department)

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| department_id | INT | PRIMARY KEY, FOREIGN KEY | Department reference |
| instructor_id | INT | UNIQUE, NOT NULL, FOREIGN KEY | Instructor reference |
| start_date | DATE | NOT NULL | Start date as head |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time |

**Relationships**:
- One-to-One with Departments
- One-to-One with Instructors

**Constraints**:
- Each department has exactly ONE head
- An instructor can be head of only ONE department
- The instructor must work in the department they head

---

### 4. Courses
**Purpose**: Stores course offerings and assignments

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| course_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier |
| course_code | VARCHAR(20) | NOT NULL, UNIQUE | Course code (e.g., CS101) |
| course_name | VARCHAR(100) | NOT NULL | Course name |
| department_id | INT | NOT NULL, FOREIGN KEY | Department offering course |
| instructor_id | INT | FOREIGN KEY | Assigned instructor |
| credits | INT | NOT NULL, DEFAULT 3 | Credit hours |
| semester | VARCHAR(20) | | Semester (Fall/Spring/Summer) |
| year | INT | | Academic year |
| room_number | VARCHAR(20) | | Classroom location |
| schedule | VARCHAR(100) | | Class schedule |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time |

**Relationships**:
- Many-to-One with Departments
- Many-to-One with Instructors
- One-to-Many with Enrollments

**Constraints**:
- Each course is taught by only ONE instructor
- A course belongs to exactly ONE department

---

### 5. Students
**Purpose**: Stores student information

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| student_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier |
| first_name | VARCHAR(50) | NOT NULL | First name |
| last_name | VARCHAR(50) | NOT NULL | Last name |
| email | VARCHAR(100) | NOT NULL, UNIQUE | Email address |
| phone | VARCHAR(20) | | Phone number |
| date_of_birth | DATE | | Birth date |
| enrollment_year | INT | | Year enrolled |
| major_department_id | INT | FOREIGN KEY | Major department |
| gpa | DECIMAL(3,2) | | Grade point average |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time |

**Relationships**:
- Many-to-One with Departments (major)
- One-to-Many with Enrollments

---

### 6. Enrollments
**Purpose**: Manages student course enrollments (Many-to-Many relationship)

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| enrollment_id | INT | PRIMARY KEY, AUTO_INCREMENT | Unique identifier |
| student_id | INT | NOT NULL, FOREIGN KEY | Enrolled student |
| course_id | INT | NOT NULL, FOREIGN KEY | Enrolled course |
| enrollment_date | DATE | NOT NULL | Date of enrollment |
| grade | VARCHAR(2) | | Final grade |
| status | VARCHAR(20) | DEFAULT 'Active' | Enrollment status |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last update time |

**Relationships**:
- Many-to-One with Students
- Many-to-One with Courses

**Constraints**:
- UNIQUE(student_id, course_id) - A student can enroll in a course only once
- Students can enroll in multiple courses
- Courses can have multiple students

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
