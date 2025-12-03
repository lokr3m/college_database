# College Database - Quick Setup Guide

## Step-by-Step Installation

### 1. Prerequisites Check
```bash
# Check MySQL
mysql --version

# Check PHP
php --version

# PHP should be 7.4 or higher with PDO MySQL extension
php -m | grep -i pdo
```

### 2. Database Setup

**Option A: Using MySQL Command Line**
```bash
# Login to MySQL
mysql -u root -p

# Run setup commands
mysql> source database/config.sql;
mysql> source database/schema.sql;
mysql> source database/sample_data.sql;
mysql> exit;
```

**Option B: Using phpMyAdmin**
1. Login to phpMyAdmin
2. Create database named `college_db`
3. Import `database/schema.sql`
4. Import `database/sample_data.sql`

### 3. Configure Backend

**Option A: Development (Not Secure - Only for Testing)**

Edit `backend/config.php`:
```php
define('DB_HOST', 'localhost');
define('DB_PORT', '3306');
define('DB_NAME', 'college_db');
define('DB_USER', 'root');              // Only for development!
define('DB_PASS', 'your_root_password'); // Only for development!
```

**Option B: Production (Secure - Recommended)**

1. Create a limited-privilege database user:
   ```bash
   mysql -u root -p
   ```

2. Run these SQL commands:
   ```sql
   -- Create application user with limited privileges
   CREATE USER 'college_app'@'localhost' IDENTIFIED BY 'your_secure_password';
   
   -- Grant only necessary permissions (SELECT, INSERT, UPDATE, DELETE)
   GRANT SELECT, INSERT, UPDATE, DELETE ON college_db.* TO 'college_app'@'localhost';
   
   -- Apply changes
   FLUSH PRIVILEGES;
   
   -- Verify permissions
   SHOW GRANTS FOR 'college_app'@'localhost';
   
   EXIT;
   ```

3. Edit `backend/config.php` to use the secure user:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_PORT', '3306');
   define('DB_NAME', 'college_db');
   define('DB_USER', 'college_app');           // Limited privilege user
   define('DB_PASS', 'your_secure_password');  // Strong password
   ```

**Benefits of limited-privilege user / Piiratud õigustega kasutaja eelised:**
- ✅ Cannot drop tables or database / Ei saa kustutada tabeleid ega andmebaasi
- ✅ Cannot create or modify users / Ei saa luua ega muuta kasutajaid
- ✅ Can only perform CRUD operations (Create, Read, Update, Delete)
- ✅ Limits damage if credentials are compromised / Piirab kahju, kui volitused on ohustatud

### 4. Start Application

**Development (PHP Built-in Server):**
```bash
cd college_database
php -S localhost:8000
```
### 5. Access the Application

Open browser and navigate to:
- `http://localhost:8000` (development)

## Troubleshooting

### Database Connection Failed
- Check MySQL is running: `sudo service mysql status`
- Verify credentials in `backend/config.php`
- Check PDO MySQL extension: `php -m | grep pdo_mysql`

### 500 Internal Server Error
- Check PHP error logs
- Ensure proper file permissions
- Verify PHP version compatibility

### API Not Responding
- Check `.htaccess` if using Apache
- Verify API endpoint URLs in `js/app.js`

## Default Sample Data

After running `sample_data.sql`, you'll have:
- 5 Departments (CS, Math, Physics, English, Business)
- 8 Instructors assigned to departments
- 8 Students with different majors
- 9 Courses across departments
- 16 Student enrollments
- 5 Department heads assigned

## Next Steps

1. **Customize**: Modify the sample data or add your own
2. **Secure**: Add authentication for production use
3. **Extend**: Add more features like attendance, grading, etc.
4. **Deploy**: Set up on a production server with HTTPS

## Support

For issues or questions:
- Check the main README.md
- Review database schema in `database/schema.sql`
- Examine API endpoints in `backend/api.php`
