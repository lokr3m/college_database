# Kooli Andmebaasisüsteemi Nõuded

## PROJEKTI ÜLEVAADE

### Eesmärk
See projekt on terviklik andmebaasihaldussüsteem haridusasutustele, mis võimaldab hallata koole, rühmi, õpilasi, õpetajaid, õppetunde, hindeid ja klassiruume. Süsteem pakub kaasaegset veebipõhist kasutajaliidest ja RESTful API-d.

### Tehnoloogia Stack
- **Andmebaas**: MySQL 5.7 või uuem
- **Backend**: PHP 7.4+ koos PDO MySQL laiendusega
- **Frontend**: HTML5, CSS3, JavaScript (vanilla JS)
- **Veebiserver**: Apache, Nginx või PHP sisseehitatud server
- **API**: RESTful arhitektuur JSON andmevormingus

### Projekti Struktuur
```
college_database/
├── database/           # Andmebaasi skriptid
│   ├── config.sql     # Andmebaasi loomine
│   ├── schema.sql     # Tabelite loomine
│   └── sample_data.sql # Näidisandmed
├── backend/           # Backend API
│   ├── config.php    # Andmebaasi ühendus
│   └── api.php       # RESTful API lõpp-punktid
├── css/              # Stiilid
├── js/               # Frontend loogika
└── index.html        # Peamine rakenduse leht
```

## FUNKTSIONAALSED NÕUDED

### Koolide haldus
• Süsteemis saab lisada mitmeid koole
• Igal koolil on unikaalne nimi ja asukoht

### Rühmade haldus
• Igal koolil on üks või mitu rühma (nt 10A, 11B)
• Rühmad kuuluvad alati kindla kooli alla

### Õpilaste haldus
• Õpilased kuuluvad alati ühte rühma
• Õpilase kohta salvestatakse eesnimi ja perenimi
• Sama nimega õpilasi võib esineda mitmes rühmas
• Õpilastel on ka esindajad

### Õpetajate haldus
• Õpetajad on seotud ühe kindla kooliga
• Õpetaja kohta salvestatakse ees- ja perenimi
• Õpetaja võib õpetada mitmele rühmale ja mitut ainet
• Kindlasti peavad süsteemis olema ka õpetajate palgaandmed ning teave palkade väljamaksete kohta
• Õpetajate kohta tuleb sisestada ka kontaktandmed: arvestada tuleb, et ühel õpetajal võib olla mitu kontaktelefoni või aadressi

### Tundide haldus
• Õppetunnid seotakse õpetaja ja rühmaga
• Tunni kohta säilitatakse aine nimi ja kuupäev
• Iga tund kuulub konkreetsele rühmale

### Hinnete haldus
• Iga hinne on seotud konkreetse õpilase ja tunniga
• Hindeks lubatud väärtused on 1 kuni 5 (või muu skaalaga vastavalt vajadusele)
• Hinnetele võib lisada vabatekstilise kommentaari (nt „puudus", „hilines")

### Klassid
• Ruumid
• Muu info, näiteks töömehele, kel tarvis remonti teha

## MITTEFUNKTSIONAALSED NÕUDED

• Süsteem peab toetama andmebaasi laiendatavust (nt uued koolid, uued ained)
• Andmed peavad olema relatsiooniliselt seotud, vältides andmete dubleerimist (normaliseerimine)
• Kõik väljad peavad kasutama sobivat andmetüüpi
• Andmebaasis peab olema võimalik andmeid filtreerida ja liita (JOIN-id)
• Vajalik on andmete sisestus- ja päringukiirus mõistlikul tasemel

## SEOSENÕUDED

• Iga rühm kuulub ühele koolile
• Iga õpilane kuulub ühele rühmale
• Iga õpetaja kuulub ühele koolile
• Iga tund on seotud ühe õpetaja ja ühe rühmaga
• Iga hinne on seotud ühe õpilase ja ühe konkreetse tunniga

## KASUTAJA STSENAARIUMID

### Kasutaja A (koolisekretär)
• Lisab uue rühma koolile
• Lisab uue õpilase rühma
• Kontrollib, millised õpetajad õpetavad rühmas 10A

### Kasutaja B (õpetaja)
• Lisab oma tunnile õpilaste hinded
• Soovib vaadata, millised hinded andis ta 10. septembri matemaatika tunnis

### Kasutaja C (õpilane või lapsevanem)
• Soovib näha enda (või lapse) viimase kuu hinnete kokkuvõtet

## ANDMEBAASI STRUKTUUR

### Tabelid ja Seosed

1. **Departments (Osakonnad)** - Koolide/osakondade info
   - PRIMARY KEY: department_id
   - Väljad: department_name, building, budget

2. **Instructors (Õpetajad)** - Õpetajate andmed
   - PRIMARY KEY: instructor_id
   - FOREIGN KEY: department_id → Departments
   - Väljad: first_name, last_name, email, phone, salary, hire_date

3. **DepartmentHeads (Osakonnajuhatajad)** - Juhtide määramine
   - PRIMARY KEY: department_id
   - FOREIGN KEY: instructor_id → Instructors
   - Igal osakonnal saab olla ainult üks juhataja

4. **Courses (Kursused)** - Õppeained/kursused
   - PRIMARY KEY: course_id
   - FOREIGN KEY: department_id → Departments
   - FOREIGN KEY: instructor_id → Instructors
   - Väljad: course_code, course_name, credits, semester, year, room_number, schedule

5. **Students (Õpilased)** - Õpilaste info
   - PRIMARY KEY: student_id
   - FOREIGN KEY: major_department_id → Departments
   - Väljad: first_name, last_name, email, phone, date_of_birth, enrollment_year, gpa

6. **Enrollments (Registreerimised)** - Õpilaste kursustele registreerimine
   - PRIMARY KEY: enrollment_id
   - FOREIGN KEY: student_id → Students
   - FOREIGN KEY: course_id → Courses
   - Väljad: enrollment_date, grade, status
   - UNIQUE (student_id, course_id) - üks õpilane saab kursusele registreerida ainult üks kord

### Põhilised Seosed
```
Departments (1) ----< (M) Instructors
     |                       |
     | (1:1)                | (1)
     |                       |
     v                       v
DepartmentHeads       Courses (M)
                           |
                           | (M:N)
                           |
                           v
                    Enrollments ----< (M) Students
```

## KIIRE KÄIVITAMINE

### 1. Eeltingimused
```bash
# Kontrolli MySQL versiooni
mysql --version

# Kontrolli PHP versiooni (vajab 7.4+)
php --version

# Kontrolli PDO MySQL laiendust
php -m | grep -i pdo
```

### 2. Andmebaasi Seadistamine
```bash
# Logi MySQL-i sisse
mysql -u root -p

# Käivita setup skriptid
mysql> source database/config.sql;
mysql> source database/schema.sql;
mysql> source database/sample_data.sql;
mysql> exit;
```

### 3. Backend Konfigureerimine
Muuda `backend/config.php` failis andmebaasi volitusi:
```php
define('DB_HOST', 'localhost');
define('DB_PORT', '3306');
define('DB_NAME', 'college_db');
define('DB_USER', 'sinu_kasutajanimi');
define('DB_PASS', 'sinu_parool');
```

**TURVALISUSE MÄRKUS**: Ärge kasutage 'root' kasutajat! Looge piiratud õigustega kasutaja:
```sql
CREATE USER 'college_app'@'localhost' IDENTIFIED BY 'turvaline_parool';
GRANT SELECT, INSERT, UPDATE, DELETE ON college_db.* TO 'college_app'@'localhost';
FLUSH PRIVILEGES;
```

### 4. Rakenduse Käivitamine
```bash
# Arenduseks (PHP sisseehitatud server)
cd college_database
php -S localhost:8000

# Ava brauser: http://localhost:8000
```

## API LÕPP-PUNKTID

Süsteem pakub RESTful API järgmiste lõpp-punktidega:

### Osakonnad (Departments)
- **GET** `/backend/api.php?request=departments` - Kõik osakonnad
- **POST** `/backend/api.php?request=departments` - Uue osakonna loomine
- **PUT** `/backend/api.php?request=departments&id={id}` - Osakonna uuendamine
- **DELETE** `/backend/api.php?request=departments&id={id}` - Osakonna kustutamine

### Õpetajad (Instructors)
- **GET** `/backend/api.php?request=instructors` - Kõik õpetajad
- **POST** `/backend/api.php?request=instructors` - Uue õpetaja lisamine
- **PUT** `/backend/api.php?request=instructors&id={id}` - Õpetaja andmete uuendamine
- **DELETE** `/backend/api.php?request=instructors&id={id}` - Õpetaja kustutamine

### Õpilased (Students)
- **GET** `/backend/api.php?request=students` - Kõik õpilased
- **POST** `/backend/api.php?request=students` - Uue õpilase lisamine
- **PUT** `/backend/api.php?request=students&id={id}` - Õpilase andmete uuendamine
- **DELETE** `/backend/api.php?request=students&id={id}` - Õpilase kustutamine

### Kursused (Courses)
- **GET** `/backend/api.php?request=courses` - Kõik kursused
- **POST** `/backend/api.php?request=courses` - Uue kursuse loomine
- **PUT** `/backend/api.php?request=courses&id={id}` - Kursuse uuendamine
- **DELETE** `/backend/api.php?request=courses&id={id}` - Kursuse kustutamine

### Registreerimised (Enrollments)
- **GET** `/backend/api.php?request=enrollments` - Kõik registreerimised
- **POST** `/backend/api.php?request=enrollments` - Uue registreerimise lisamine
- **PUT** `/backend/api.php?request=enrollments&id={id}` - Registreerimise uuendamine
- **DELETE** `/backend/api.php?request=enrollments&id={id}` - Registreerimise kustutamine

### Osakonnajuhatajad (Department Heads)
- **GET** `/backend/api.php?request=department-heads` - Kõik osakonnajuhatajad
- **POST** `/backend/api.php?request=department-heads` - Uue juhataja määramine
- **PUT** `/backend/api.php?request=department-heads&id={id}` - Juhataja vahetamine
- **DELETE** `/backend/api.php?request=department-heads&id={id}` - Juhataja eemaldamine

## KASULIKUD SQL PÄRINGUD

### Õpilaste hinnete kokkuvõte
```sql
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE s.student_id = ?
ORDER BY e.enrollment_date DESC;
```

### Õpetaja kursused
```sql
SELECT c.course_name, c.course_code, c.semester, c.year, 
       COUNT(e.enrollment_id) as enrolled_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE c.instructor_id = ?
GROUP BY c.course_id;
```

### Osakonna statistika
```sql
SELECT d.department_name,
       COUNT(DISTINCT i.instructor_id) as instructor_count,
       COUNT(DISTINCT c.course_id) as course_count,
       COUNT(DISTINCT s.student_id) as student_count
FROM Departments d
LEFT JOIN Instructors i ON d.department_id = i.department_id
LEFT JOIN Courses c ON d.department_id = c.department_id
LEFT JOIN Students s ON d.department_id = s.major_department_id
WHERE d.department_id = ?
GROUP BY d.department_id;
```

### Kursuste mahutavus
```sql
SELECT c.course_name, c.room_number, c.schedule,
       COUNT(e.enrollment_id) as enrolled_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE c.semester = ? AND c.year = ?
GROUP BY c.course_id
ORDER BY enrolled_count DESC;
```

## LAIENDUSVÕIMALUSED

Võimalused, millest ei olnud veel aega kokku leppida:
• Õppeainete tabel eraldi (normaliseerimiseks)
• Kasutajakontod (õpilased, õpetajad, administraatorid)
• Puudumiste haldus
• Tunniplaan
• Inventar
• Ajalooliste andmete säilitamine (nt varasemad osakonnajuhatajad)
• Ruumide detailne haldus (mahutavus, varustus)
• Õpilaste fotod ja dokumendid
• Õpetajate kvalifikatsioonide jälgimine
• Automatiseeritud hindearvutused (GPA)
• E-posti teavitused

## KASUTAJATE LOOMINE (näidis)

Esmalt teeme rolli ja siis lisame kasutajale rolli:

```sql
-- Rolli loomine
CREATE ROLE school_admin;

-- Õiguste andmine rollile
GRANT ALL PRIVILEGES ON koolid.* TO school_admin@localhost;

-- Kasutaja loomine
CREATE USER yllar@localhost IDENTIFIED BY 'yllarpassword';

-- Rolli määramine kasutajale
GRANT school_admin TO yllar@localhost;

-- Vaikimisi rolli seadmine
SET DEFAULT ROLE school_admin TO yllar@localhost;
```

## VEAOTSING (TROUBLESHOOTING)

### Andmebaasi ühendus ebaõnnestub
- Kontrolli, kas MySQL töötab: `sudo service mysql status`
- Kontrolli volitusi `backend/config.php` failis
- Veendu, et PDO MySQL laiend on paigaldatud: `php -m | grep pdo_mysql`

### 500 Internal Server Error
- Kontrolli PHP vealogie
- Veendu, et failide õigused on korrektsed
- Kontrolli PHP versiooni ühilduvust (vajab 7.4+)

### API ei vasta
- Kontrolli `.htaccess` faili (kui kasutad Apache'd)
- Veendu, et API lõpp-punktide URL-id on õiged `js/app.js` failis
- Kontrolli CORS seadeid, kui kasutad erinevaid domeene

### Märgistiku (Character Encoding) probleemid
- Veendu, et andmebaas kasutab UTF-8: `ALTER DATABASE college_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`
- Lisa PHP faili algusesse: `header('Content-Type: text/html; charset=utf-8');`

## NÄIDISANDMED

Pärast `sample_data.sql` käivitamist on andmebaasis:
- 5 osakonda (CS, Math, Physics, English, Business)
- 8 õpetajat (määratud osakondadesse)
- 8 õpilast (erinevate erialadega)
- 9 kursust (erinevates osakondades)
- 16 registreerimist (õpilased kursustele)
- 5 osakonnajuhatajat

## TURVALISUSE MÄRKUSED

### Tootmiskeskkonna jaoks:
1. ✅ **Ära kasuta 'root' kasutajat** - Loo piiratud õigustega kasutaja
2. ✅ **Kasuta tugevaid paroole** - Minimaalselt 12 tähemärki, segatud sümbolid
3. ✅ **Luba HTTPS** - Krüpti kõik andmeedastused
4. ✅ **Piirange failide õigused** - 644 failidele, 755 kaustadele
5. ✅ **Vältida SQL injection** - Kasutatakse prepared statements
6. ✅ **Lisa autentimine** - Rakenda kasutajate sisselogimine
7. ✅ **Varundamine** - Seadista regulaarsed andmebaasi varukoopiad
8. ✅ **Logi jälgimine** - Jälgi ebatavalisi tegevusi

### Soovituslikud turva täiustused:
```sql
-- Piira sisselogimise katseid
CREATE TABLE login_attempts (
    attempt_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100),
    ip_address VARCHAR(45),
    attempt_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sessioonide haldus
CREATE TABLE user_sessions (
    session_id VARCHAR(255) PRIMARY KEY,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    ip_address VARCHAR(45)
);
```

## JÕUDLUSE OPTIMEERIMINE

### Indeksite seadistamine
Süsteemis on juba põhilised indeksid, kuid suurte andmehulkade puhul lisa:
```sql
-- Kiired otsingud nime järgi
CREATE INDEX idx_student_name ON Students(last_name, first_name);
CREATE INDEX idx_instructor_name ON Instructors(last_name, first_name);

-- Kiired filtreerimised semestri/aasta järgi
CREATE INDEX idx_course_semester ON Courses(semester, year);

-- Kiired registreerimiste päringud
CREATE INDEX idx_enrollment_status ON Enrollments(status, enrollment_date);
```

### Päringu optimeerimine
- Kasuta `EXPLAIN` käsku päringute analüüsimiseks
- Väldi `SELECT *` - vali ainult vajalikud väljad
- Kasuta `LIMIT` suurte tulemuste korral
- Rakenda andmete vahemällu salvestamist (caching)

## KASUTAJALIIDES

### Funktsioonid
- ✅ Täielik CRUD (Create, Read, Update, Delete) kõigile entiteetidele
- ✅ Kaasaegne, reageeriv UI gradient disainiga
- ✅ Reaalajas andmete uuendamine
- ✅ Vormi valideerimine
- ✅ Seoste haldamine
- ✅ Modaalsed vormid
- ✅ Tühjad olekud (empty states)
- ✅ Sujuvad animatsioonid

### Navigatsioon
Dashboard'il on juurdepääs kõigile moodulitele:
- Osakonnad (Departments)
- Õpetajad (Instructors)
- Õpilased (Students)
- Kursused (Courses)
- Registreerimised (Enrollments)
- Osakonnajuhatajad (Department Heads)

## LISARESSURSID

- `readme.md` - Põhjalik ingliskeelne dokumentatsioon
- `DATABASE_SCHEMA.md` - Üksikasjalik andmebaasi skeemi dokumentatsioon
- `SETUP_GUIDE.md` - Samm-sammult paigaldusjuhend
- `database/schema.sql` - Andmebaasi struktuur SQL-is
- `backend/api.php` - API lõpp-punktide lähtekood

## PROJEKTI EESMÄRGID

See projekt on loodud:
1. **Õppeeesmärkidel** - Näitamaks relatsioonilise andmebaasi disaini
2. **Praktilistel eesmärkidel** - Pakkudes töötavat haldussüsteemi
3. **Demonstratsiooniks** - Näitamaks API ja frontend integreerimist
4. **Alusena** - Võimaldamaks laiendamist ja kohandamist

## PANUSTAMINE

Tere tulemast panustama! Saada probleemid (issues) ja täiustamise soovid (enhancement requests).

## LITSENTS

See projekt on loodud hariduslikel eesmärkidel.

---
**Viimati uuendatud**: 2025-11-06
**Versioon**: 1.1
**Autor**: lokr3m
