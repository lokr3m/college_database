<?php
/**
 * Database Configuration / Andmebaasi Konfiguratsioon
 * Update these constants with your MySQL server details
 * Uuenda neid konstante oma MySQL serveri andmetega
 * 
 * ============================================================================
 * SECURITY WARNING / TURVALISUSE HOIATUS:
 * ============================================================================
 * DO NOT use 'root' user in production environments!
 * ÄRA kasuta 'root' kasutajat tootmiskeskkondades!
 * 
 * The 'root' user has unrestricted access to:
 * 'root' kasutajal on piiramatu juurdepääs järgmisele:
 *   - DROP databases and tables / Andmebaaside ja tabelite kustutamine
 *   - CREATE and modify users / Kasutajate loomine ja muutmine
 *   - Access all databases / Kõikidele andmebaasidele juurdepääs
 * 
 * For production, create a limited-privilege database user that can only:
 * Tootmiseks loo piiratud õigustega andmebaasi kasutaja, kes saab ainult:
 *   - SELECT, INSERT, UPDATE, DELETE on application tables
 *   - SELECT, INSERT, UPDATE, DELETE rakenduse tabelitel
 * 
 * Example SQL commands to create a secure user:
 * Näidis SQL käsud turvalise kasutaja loomiseks:
 * 
 *   CREATE USER 'college_app'@'localhost' IDENTIFIED BY 'secure_password';
 *   GRANT SELECT, INSERT, UPDATE, DELETE ON college_db.* TO 'college_app'@'localhost';
 *   FLUSH PRIVILEGES;
 * 
 * See database/config.sql and SETUP_GUIDE.md for more details.
 * Vaata database/config.sql ja SETUP_GUIDE.md täpsema info saamiseks.
 * ============================================================================
 */

define('DB_HOST', 'localhost');
define('DB_PORT', '3306');
define('DB_NAME', 'college_db');
define('DB_USER', 'root');  // WARNING: Change this for production! / HOIATUS: Muuda see tootmiseks!
define('DB_PASS', '');       // WARNING: Use a strong password! / HOIATUS: Kasuta tugevat parooli!
define('DB_CHARSET', 'utf8mb4');

/**
 * Get Database Connection
 * 
 * @return PDO|null Returns PDO connection or null on failure
 */
function getDBConnection() {
    try {
        $dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];
        
        $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
        return $pdo;
    } catch (PDOException $e) {
        error_log("Database connection failed: " . $e->getMessage());
        return null;
    }
}
?>
