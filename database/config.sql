-- ============================================================================
-- Database Configuration / Andmebaasi Konfiguratsioon
-- ============================================================================
-- This script creates the college database.
-- See skript loob kolledži andmebaasi.
--
-- SECURITY WARNING / TURVALISUSE HOIATUS:
-- DO NOT use the 'root' user for application access in production!
-- ÄRA kasuta 'root' kasutajat rakenduse juurdepääsuks toodangus!
--
-- The root user has full privileges including DROP DATABASE and DROP TABLE.
-- For application use, create a limited-privilege user that can only:
--   - SELECT, INSERT, UPDATE, DELETE on tables
--   - Cannot DROP tables or databases
--   - Cannot create new users
--
-- Root kasutajal on täielikud õigused, sealhulgas DROP DATABASE ja DROP TABLE.
-- Rakenduse kasutamiseks loo piiratud õigustega kasutaja, kes saab ainult:
--   - SELECT, INSERT, UPDATE, DELETE tabelitel
--   - Ei saa DROP-ida tabeleid ega andmebaase
--   - Ei saa luua uusi kasutajaid
--
-- See the SETUP_GUIDE.md for instructions on creating a secure database user.
-- Vaata SETUP_GUIDE.md juhiseid turvalise andmebaasi kasutaja loomiseks.
-- ============================================================================

-- Create the database / Loo andmebaas
CREATE DATABASE IF NOT EXISTS college_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE college_db;

-- ============================================================================
-- OPTIONAL: Create a limited-privilege user for application use
-- VALIKULINE: Loo piiratud õigustega kasutaja rakenduse kasutamiseks
-- ============================================================================
-- Uncomment and customize these lines to create a secure application user:
-- Eemalda kommentaar ja kohanda neid ridu turvalise rakenduse kasutaja loomiseks:
--
-- CREATE USER IF NOT EXISTS 'college_app'@'localhost' IDENTIFIED BY 'your_secure_password';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON college_db.* TO 'college_app'@'localhost';
-- FLUSH PRIVILEGES;
--
-- Then update backend/config.php to use this user instead of root:
-- Seejärel uuenda backend/config.php, et kasutada seda kasutajat root asemel:
--   DB_USER: 'college_app'
--   DB_PASS: 'your_secure_password'
-- ============================================================================
