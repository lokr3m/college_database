# College Database Project

A comprehensive database management system for educational institutions with a modern web-based user interface.

## 📋 Project Description

This college database system manages the following relationships:
- A college contains many departments
- Each department can offer any number of courses
- Many instructors can work in a department, but an instructor can work only in one department
- For each department, there is a head, and an instructor can be the head of only one department
- Each instructor can take any number of courses, and a course can be taken by only one instructor
- A student can enroll in any number of courses and each course can have any number of students

## 📊 Database Schema

**Tables:**
1. **Departments** - Stores department information
2. **Instructors** - Stores instructor details and department association
3. **DepartmentHeads** - Manages department head assignments
4. **Courses** - Contains course information with department and instructor associations
5. **Students** - Stores student information
6. **Enrollments** - Manages student course enrollments (many-to-many relationship)

## 🚀 Setup Instructions

### Prerequisites
- MySQL Server (5.7 or higher)
- PHP (7.4 or higher) with PDO MySQL extension
- Web server (Apache, Nginx, or PHP built-in server)
- Modern web browser

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/lokr3m/college_database.git
   cd college_database
   ```

2. **Create the database**
   - Login to MySQL:
     ```bash
     mysql -u root -p
     ```
   - Create the database:
     ```sql
     source database/config.sql
     ```
   - Create the tables:
     ```sql
     source database/schema.sql
     ```
   - (Optional) Insert sample data:
     ```sql
     source database/sample_data.sql
     ```

3. **Configure the backend**
   - Edit `backend/config.php` and update the database credentials:
     ```php
     define('DB_HOST', 'localhost');
     define('DB_PORT', '3306');
     define('DB_NAME', 'college_db');
     define('DB_USER', 'your_username');
     define('DB_PASS', 'your_password');
     ```

4. **Start the web server**
   
   Using PHP built-in server (for development):
   ```bash
   php -S localhost:8000
   ```
   
   Or configure Apache/Nginx to serve the project directory.

5. **Access the application**
   - Open your browser and navigate to: `http://localhost:8000`

## 💻 Usage

The web interface provides the following features:

### Dashboard Navigation
- **Departments** - View, add, edit, and delete departments
- **Instructors** - Manage instructor information
- **Students** - Manage student records
- **Courses** - Create and manage courses
- **Enrollments** - Enroll students in courses and track grades
- **Department Heads** - Assign and manage department heads

### Features
- ✅ Full CRUD operations for all entities
- ✅ Beautiful, responsive UI with gradient design
- ✅ Real-time data updates
- ✅ Form validation
- ✅ Relationship management
- ✅ Modal-based forms

## 🗂️ Project Structure

```
college_database/
├── database/
│   ├── config.sql          # Database creation script
│   ├── schema.sql          # Table creation script
│   └── sample_data.sql     # Sample data for testing
├── backend/
│   ├── config.php          # Database connection configuration
│   └── api.php             # RESTful API endpoints
├── css/
│   └── styles.css          # Application styles
├── js/
│   └── app.js              # Frontend JavaScript logic
├── index.html              # Main application page
└── readme.md               # This file
```

## 🔧 API Endpoints

The backend provides RESTful API endpoints:

- **Departments**: `/backend/api.php?request=departments`
- **Instructors**: `/backend/api.php?request=instructors`
- **Students**: `/backend/api.php?request=students`
- **Courses**: `/backend/api.php?request=courses`
- **Enrollments**: `/backend/api.php?request=enrollments`
- **Department Heads**: `/backend/api.php?request=department-heads`

Each endpoint supports:
- `GET` - Retrieve records
- `POST` - Create new record
- `PUT` - Update existing record
- `DELETE` - Delete record

## 🎨 UI Features

- Modern gradient design with purple theme
- Responsive layout for all screen sizes
- Card-based data display
- Modal forms for data entry
- Success/error notifications
- Empty state handling
- Smooth animations and transitions

## 📝 Database Relationships

```
Departments (1) ----< (M) Instructors
     |                       |
     | (1)                   | (1)
     |                       |
     v                       v
DepartmentHeads (1:1) -------+
     
Departments (1) ----< (M) Courses >---- (1) Instructors
                            |
                            | (M)
                            |
                            v
                      Enrollments
                            |
                            | (M)
                            |
                            v
                       Students (M)
```

## 🔐 Security Notes

- Update database credentials in `backend/config.php`
- Use prepared statements to prevent SQL injection
- Implement proper authentication for production use
- Enable HTTPS in production
- Restrict file permissions appropriately

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This project is created for educational purposes.