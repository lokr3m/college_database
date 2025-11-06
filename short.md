# Kooli Andmebaasisüsteemi Nõuded

## FUNKTSIONAALSED NÕUDED

### Koolide haldus
• Süsteemis saab lisada mitmeid koole
• Igal koolil on unikaalne nimi ja asukoht
• **Tabel: Departments** (Osakonnad/Koolid)
  - Salvestab kooli/osakonna nime (department_name) - peab olema unikaalne
  - Salvestab asukoha/hoone info (building)
  - Salvestab eelarve (budget) - rahaliseks planeerimiseks
  - Iga kirje identifitseeritakse automaatse numbriga (department_id)

### Rühmade haldus
• Igal koolil on üks või mitu rühma (nt 10A, 11B)
• Rühmad kuuluvad alati kindla kooli alla
• **Märkus:** Praeguses andmebaasis on rühmad implementeeritud läbi Courses tabeli, kus semester ja year väljad määravad õppeperioodi

### Õpilaste haldus
• Õpilased kuuluvad alati ühte rühma
• Õpilase kohta salvestatakse eesnimi ja perenimi
• Sama nimega õpilasi võib esineda mitmes rühmas
• Õpilastel on ka esindajad
• **Tabel: Students** (Õpilased)
  - Salvestab õpilase nime (first_name, last_name)
  - Salvestab kontaktandmed (email, phone)
  - Salvestab sünnikuupäeva (date_of_birth)
  - Salvestab õppeaasta alguse (enrollment_year) - mis aastal alustas
  - Salvestab eriala/põhiosakonna (major_department_id) - viitab Departments tabelile
  - Salvestab keskmise hinde (gpa) - Grade Point Average skaalal 0.00 kuni 5.00
  - Iga õpilane identifitseeritakse unikaalse numbriga (student_id)

### Õpetajate haldus
• Õpetajad on seotud ühe kindla kooliga
• Õpetaja kohta salvestatakse ees- ja perenimi
• Õpetaja võib õpetada mitmele rühmale ja mitut ainet
• Kindlasti peavad süsteemis olema ka õpetajate palgaandmed ning teave palkade väljamaksete kohta
• Õpetajate kohta tuleb sisestada ka kontaktandmed: arvestada tuleb, et ühel õpetajal võib olla mitu kontaktelefoni või aadressi
• **Tabel: Instructors** (Õpetajad/Õppejõud)
  - Salvestab õpetaja nime (first_name, last_name)
  - Salvestab kontaktandmed (email - unikaalne, phone)
  - Salvestab osakonna (department_id) - KOHUSTUSLIK, õpetaja töötab ainult ühes osakonnas
  - Salvestab palga info (salary) - kuu- või aastapalk detsimaalarvuna
  - Salvestab töölevõtmise kuupäeva (hire_date)
  - Iga õpetaja identifitseeritakse unikaalse numbriga (instructor_id)
  - Õpetaja saab õpetada mitut kursust (üks-mitmele seos Courses tabeliga)
  - Õpetaja saab olla ainult ühe osakonna juhataja (DepartmentHeads tabel)

### Tundide haldus
• Õppetunnid seotakse õpetaja ja rühmaga
• Tunni kohta säilitatakse aine nimi ja kuupäev
• Iga tund kuulub konkreetsele rühmale
• **Tabel: Courses** (Kursused/Õppeained)
  - Salvestab kursuse koodi (course_code) - unikaalne tunnuskood (nt CS101, MATH200)
  - Salvestab kursuse nime (course_name) - aine täisnimi
  - Salvestab osakonna (department_id) - millisesse osakonda kursus kuulub
  - Salvestab õpetaja (instructor_id) - kes kursust õpetab (üks kursus = üks õpetaja)
  - Salvestab krediidipunktid (credits) - vaikimisi 3, määrab kursuse mahu
  - Salvestab semestri (semester) - milline õppeperiood (nt "Fall 2024", "Spring 2025")
  - Salvestab aasta (year) - õppeaasta number
  - Salvestab ruumi (room_number) - kus tunnid toimuvad (nt "A-101", "Lab 3")
  - Salvestab ajakava (schedule) - millal nädalas tunnid on (nt "Mon/Wed 10:00-11:30")
  - Iga kursus identifitseeritakse unikaalse numbriga (course_id)

### Hinnete haldus
• Iga hinne on seotud konkreetse õpilase ja tunniga
• Hindeks lubatud väärtused on 1 kuni 5 (või muu skaalaga vastavalt vajadusele)
• Hinnetele võib lisada vabatekstilise kommentaari (nt „puudus", „hilines")
• **Tabel: Enrollments** (Registreerimised/Hinded)
  - Seob õpilase kursusega - mitu-mitmele seos (many-to-many)
  - Salvestab registreerumise kuupäeva (enrollment_date)
  - Salvestab hinde (grade) - lõplik hinne (nt "A", "B", "5", "4")
  - Salvestab staatuse (status) - "Active", "Completed", "Dropped", "Failed"
  - Iga registreerimine on unikaalne (enrollment_id)
  - OLULINE: Üks õpilane saab samale kursusele registreeruda ainult üks kord
  - Võimaldab õpilasel olla mitmel kursusel ja kursusel olla mitu õpilast

### Klassid
• Ruumid
• Muu info, näiteks töömehele, kel tarvis remonti teha
• **Tabel: DepartmentHeads** (Osakonnajuhatajad/Juhtide määramine)
  - Seob osakonna ja õpetaja - üks-ühele seos
  - Iga osakonnal saab olla ainult üks juhataja korraga
  - Üks õpetaja saab juhtida ainult ühte osakonda
  - Salvestab alguskuupäeva (start_date) - millal juhataja ametisse asus
  - HOIATUS: Ainult praegune juhataja salvestatakse, ajalugu ei säilitata

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

## ANDMEBAASI TABELITE ÜLEVAADE

Süsteem kasutab 6 põhitabelit:

### 1. Departments (Osakonnad/Koolid)
**Eesmärk:** Salvestab koolide/osakondade põhiinfo
**Primaarvõti:** department_id (INT, AUTO_INCREMENT)
**Väljad:**
• department_name (VARCHAR 100) - UNIKAALNE, KOHUSTUSLIK - osakonna nimi
• building (VARCHAR 100) - hoone asukoht
• budget (DECIMAL 12,2) - eelarve rahaliseks planeerimiseks
• created_at, updated_at (TIMESTAMP) - automaatsed ajatemplid

### 2. Instructors (Õpetajad)
**Eesmärk:** Salvestab õpetajate andmed ja osakonna kuuluvus
**Primaarvõti:** instructor_id (INT, AUTO_INCREMENT)
**Välisvõtmed:** department_id → Departments
**Väljad:**
• first_name, last_name (VARCHAR 50) - KOHUSTUSLIK - nimi
• email (VARCHAR 100) - UNIKAALNE, KOHUSTUSLIK - e-post
• phone (VARCHAR 20) - telefoninumber
• department_id (INT) - KOHUSTUSLIK - kuhu osakonda kuulub
• salary (DECIMAL 10,2) - palk
• hire_date (DATE) - töölevõtmise kuupäev
• created_at, updated_at (TIMESTAMP) - automaatsed ajatemplid
**Reeglid:**
• Õpetaja PEAB kuuluma ühte osakonda (department_id ei tohi olla NULL)
• Õpetaja võib õpetada mitut kursust

### 3. DepartmentHeads (Osakonnajuhatajad)
**Eesmärk:** Määrab, kes on osakonna juhataja
**Primaarvõti:** department_id (INT) - tagab et ühel osakonnal üks juhataja
**Välisvõtmed:** 
• department_id → Departments
• instructor_id → Instructors (UNIKAALNE - õpetaja saab juhtida ainult ühte)
**Väljad:**
• instructor_id (INT) - UNIKAALNE, KOHUSTUSLIK - kes on juhataja
• start_date (DATE) - KOHUSTUSLIK - millal sai juhatajaks
• created_at, updated_at (TIMESTAMP) - automaatsed ajatemplid
**Reeglid:**
• Iga osakond võib omada kõige rohkem ühte juhatajat
• Üks õpetaja võib juhtida ainult ühte osakonda
• Osakond võib eksisteerida ilma juhatajata
• Ainult praegune juhataja salvestatakse (ajaloo ei säilitata!)

### 4. Courses (Kursused/Õppeained)
**Eesmärk:** Salvestab kursuste/ainete info ja ajakava
**Primaarvõti:** course_id (INT, AUTO_INCREMENT)
**Välisvõtmed:**
• department_id → Departments (KOHUSTUSLIK)
• instructor_id → Instructors (õpetaja kes kursust õpetab)
**Väljad:**
• course_code (VARCHAR 20) - UNIKAALNE, KOHUSTUSLIK - kursuse kood (nt CS101)
• course_name (VARCHAR 100) - KOHUSTUSLIK - kursuse nimi
• department_id (INT) - KOHUSTUSLIK - millise osakonna kursus
• instructor_id (INT) - milline õpetaja õpetab
• credits (INT) - KOHUSTUSLIK, vaikimisi 3 - krediidipunktid
• semester (VARCHAR 20) - semester (nt "Fall 2024", "Spring 2025")
• year (INT) - õppeaasta
• room_number (VARCHAR 20) - kus toimub (nt "A-101", "Lab 3")
• schedule (VARCHAR 100) - millal toimub (nt "Mon/Wed 10:00-11:30")
• created_at, updated_at (TIMESTAMP) - automaatsed ajatemplid
**Reeglid:**
• Üks kursus kuulub ühte osakonda
• Ühte kursust õpetab üks õpetaja

### 5. Students (Õpilased)
**Eesmärk:** Salvestab õpilaste põhiandmed
**Primaarvõti:** student_id (INT, AUTO_INCREMENT)
**Välisvõtmed:** major_department_id → Departments (eriala/põhiosakond)
**Väljad:**
• first_name, last_name (VARCHAR 50) - KOHUSTUSLIK - nimi
• email (VARCHAR 100) - UNIKAALNE, KOHUSTUSLIK - e-post
• phone (VARCHAR 20) - telefoninumber
• date_of_birth (DATE) - sünnikuupäev
• enrollment_year (INT) - mis aastal alustas
• major_department_id (INT) - põhieriala osakond
• gpa (DECIMAL 3,2) - keskmine hinne (0.00 kuni 5.00)
• created_at, updated_at (TIMESTAMP) - automaatsed ajatemplid

### 6. Enrollments (Kursusele registreerimised ja hinded)
**Eesmärk:** Seob õpilased kursustega (mitu-mitmele seos) ja salvestab hinded
**Primaarvõti:** enrollment_id (INT, AUTO_INCREMENT)
**Välisvõtmed:**
• student_id → Students (KOHUSTUSLIK)
• course_id → Courses (KOHUSTUSLIK)
**Väljad:**
• student_id (INT) - KOHUSTUSLIK - milline õpilane
• course_id (INT) - KOHUSTUSLIK - millisele kursusele
• enrollment_date (DATE) - KOHUSTUSLIK - registreerumise kuupäev
• grade (VARCHAR 2) - lõplik hinne (nt "A", "B", "5", "4")
• status (VARCHAR 20) - vaikimisi "Active" - olek: "Active", "Completed", "Dropped", "Failed"
• created_at, updated_at (TIMESTAMP) - automaatsed ajatemplid
**Reeglid:**
• UNIKAALNE(student_id, course_id) - õpilane saab kursusele registreeruda ainult üks kord
• Õpilane võib olla mitmel kursusel
• Kursusel võib olla mitu õpilast

## ANDMEBAASI SEOSTE SKEEM

```
Departments (Osakonnad)
    ├─→ 1:M → Instructors (Õpetajad)
    │         └─→ 1:M → Courses (Kursused)
    │                   └─→ M:N → Enrollments (Registreerimised)
    │                               └─→ M:1 → Students (Õpilased)
    │                                         └─→ M:1 → Departments (põhieriala)
    ├─→ 1:1 → DepartmentHeads (Juhatajad)
    │         └─→ 1:1 → Instructors
    └─→ 1:M → Students (põhieriala järgi)

Selgitus:
• 1:M = üks-mitmele (nt üks osakond, mitu õpetajat)
• 1:1 = üks-ühele (nt üks osakond, üks juhataja)
• M:N = mitu-mitmele (nt õpilased ja kursused läbi Enrollments tabeli)
```

## LAIENDUSVÕIMALUSED

Võimalused, millest ei olnud veel aega kokku leppida:
• Õppeainete tabel eraldi (normaliseerimiseks)
• Kasutajakontod (õpilased, õpetajad, administraatorid)
• Puudumiste haldus
• Tunniplaan
• Inventar

## KASULIKUD SQL PÄRINGUTE NÄITED

### Osakonna kõigi õpetajate vaatamine
```sql
SELECT i.first_name, i.last_name, i.email, i.salary
FROM Instructors i
JOIN Departments d ON i.department_id = d.department_id
WHERE d.department_name = 'Computer Science';
```

### Õpilase kõigi kursuste ja hinnete vaatamine
```sql
SELECT c.course_name, c.course_code, e.grade, e.status, 
       i.first_name AS teacher_first, i.last_name AS teacher_last
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
JOIN Students s ON e.student_id = s.student_id
JOIN Instructors i ON c.instructor_id = i.instructor_id
WHERE s.email = 'student@example.com'
ORDER BY e.enrollment_date DESC;
```

### Kursuse kõigi õpilaste vaatamine
```sql
SELECT s.first_name, s.last_name, s.email, e.grade, e.status
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_code = 'CS101'
ORDER BY s.last_name, s.first_name;
```

### Osakonna juhataja leidmine
```sql
SELECT d.department_name, i.first_name, i.last_name, dh.start_date
FROM DepartmentHeads dh
JOIN Departments d ON dh.department_id = d.department_id
JOIN Instructors i ON dh.instructor_id = i.instructor_id
WHERE d.department_name = 'Mathematics';
```

### Õpetaja kõigi kursuste vaatamine
```sql
SELECT c.course_name, c.course_code, c.semester, c.year,
       COUNT(e.enrollment_id) AS enrolled_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
JOIN Instructors i ON c.instructor_id = i.instructor_id
WHERE i.email = 'teacher@example.com'
GROUP BY c.course_id
ORDER BY c.year DESC, c.semester;
```

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
