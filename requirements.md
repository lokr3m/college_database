## 🎯 Project Requirements

### Functional Requirements

The system is designed to create a comprehensive management system for educational institutions with the following capabilities:

#### College Management
- ✅ System supports multiple colleges
- ✅ Each college has a unique name and location

#### Group Management
- ✅ Each college has one or more groups (e.g., TA-23B, IT-25V)
- ✅ Groups always belong to a specific college

#### Student Management
- ✅ Students always belong to one group
- ✅ Student records include first name and last name
- ✅ Multiple students with the same name can exist in different groups
- ✅ Students have representatives/guardians

#### Teacher Management
- ✅ Teachers are associated with one specific college
- ✅ Teacher records include first and last name
- ✅ Teachers can teach multiple groups and multiple subjects
- ✅ System includes teacher salary data and payment information
- ✅ Teacher contact information is stored (multiple phone numbers and addresses possible per teacher)

#### Class/Lesson Management
- ✅ Lessons are linked to a teacher and a group
- ✅ Lesson information includes subject name and date
- ✅ Each lesson belongs to a specific group

#### Grade Management
- ✅ Each grade is associated with a specific student and lesson
- ✅ Grade values range from 1 to 5 (or other scale as needed)
- ✅ Grades can include free-text comments (e.g., "absent", "late")

#### Classroom Management
- ✅ Rooms/classrooms are tracked
- ✅ Additional information can be stored (e.g., maintenance needs, technician notes)

### Non-Functional Requirements

- ✅ **Extensibility**: System supports database expansion (new colleges, new subjects)
- ✅ **Normalization**: Data is relationally structured to avoid duplication
- ✅ **Data Types**: All fields use appropriate data types
- ✅ **Query Support**: Database supports filtering and JOIN operations
- ✅ **Performance**: Data entry and query performance at reasonable levels

### Relationship Requirements

The system enforces the following relationships:
- Each group belongs to one college
- Each student belongs to one group
- Each teacher belongs to one college
- Each lesson is associated with one teacher and one group
- Each grade is associated with one student and one specific lesson

### User Role Scenarios

The system provides access for different user roles:

#### User A (college Secretary)
- ✅ Add new groups to a college
- ✅ Add new students to a group
- ✅ Check which teachers teach in group TA-23B

#### User B (Teacher)
- ✅ Add student grades for their lessons
- ✅ View grades given in a specific lesson (e.g., mathematics on September 10th)

#### User C (Student or Parent)
- ✅ View summary of grades for the last month

### Future Expansion Possibilities

Potential features for future development:
- Separate subjects table (for better normalization)
- User accounts (students, teachers, administrators)
- Absence/attendance management
- Schedule/timetable management
- Inventory management

## 🎯 Projekti Nõuded (Estonian Version)

### Funktsionaalsed Nõuded

Süsteem on loodud haridusasutuste tervikliku haldussüsteemi loomiseks järgmiste võimalustega:

#### kolledži Haldamine
- ✅ Süsteem toetab mitut kolledžit
- ✅ Igal kolledžil on unikaalne nimi ja asukoht

#### Grupi/Klassi Haldamine
- ✅ Igal kolledžil on üks või mitu gruppi (nt TA-23B, IT-25V)
- ✅ Grupid kuuluvad alati konkreetsesse kolledži

#### Õpilaste Haldamine
- ✅ Õpilased kuuluvad alati ühte gruppi
- ✅ Õpilase andmed sisaldavad ees- ja perekonnanime
- ✅ Mitu sama nimega õpilast võib eksisteerida erinevates gruppides
- ✅ Õpilastel on esindajad/eestkostjad

#### Õpetajate Haldamine
- ✅ Õpetajad on seotud ühe konkreetse kolledžiga
- ✅ Õpetaja andmed sisaldavad ees- ja perekonnanime
- ✅ Õpetajad saavad õpetada mitut gruppi ja mitut ainet
- ✅ Süsteem sisaldab õpetajate palga- ja makseinfot
- ✅ Õpetajate kontaktandmed on salvestatud (õpetajal võib olla mitu telefoninumbrit ja aadressi)

#### Tunni/Õppetunni Haldamine
- ✅ Õppetunnid on seotud õpetaja ja grupiga
- ✅ Tunni info sisaldab aine nime ja kuupäeva
- ✅ Iga õppetund kuulub konkreetsesse gruppi

#### Hinnete Haldamine
- ✅ Iga hinne on seotud konkreetse õpilase ja õppetunniga
- ✅ Hinnete väärtused ulatuvad 1-st 5-ni (või muu skaala vastavalt vajadusele)
- ✅ Hinded võivad sisaldada vabateksti kommentaare (nt "puudus", "hilines")

#### Klassiruumide Haldamine
- ✅ Ruumid/klassid on jälgitavad
- ✅ Lisainfot saab salvestada (nt hoolduse vajadused, tehnikute märkused)

### Mittefunktsionaalsed Nõuded

- ✅ **Laiendatavus**: Süsteem toetab andmebaasi laienemist (uued kolledžid, uued ained)
- ✅ **Normaliseerimine**: Andmed on relatsiooniliselt struktureeritud, et vältida dubleerimist
- ✅ **Andmetüübid**: Kõik väljad kasutavad sobivaid andmetüüpe
- ✅ **Päringute Tugi**: Andmebaas toetab filtreerimist ja JOIN operatsioone
- ✅ **Jõudlus**: Andmesisestuse ja päringu jõudlus mõistlikul tasemel

### Seoste Nõuded

Süsteem jõustab järgmised seosed:
- Iga grupp kuulub ühte kolledži
- Iga õpilane kuulub ühte gruppi
- Iga õpetaja kuulub ühte kolledži
- Iga õppetund on seotud ühe õpetaja ja ühe grupiga
- Iga hinne on seotud ühe õpilase ja ühe konkreetse õppetunniga

### Kasutajarolli Stsenaariumid

Süsteem pakub juurdepääsu erinevatele kasutajarollidele:

#### Kasutaja A (kolledži Sekretär)
- ✅ Lisa kolledži uusi gruppe
- ✅ Lisa gruppi uusi õpilasi
- ✅ Kontrolli, millised õpetajad õpetavad grupis TA-23B

#### Kasutaja B (Õpetaja)
- ✅ Lisa õpilaste hindeid oma õppetundidele
- ✅ Vaata konkreetses õppetunnis antud hindeid (nt matemaatika 10. septembril)

#### Kasutaja C (Õpilane või Vanem)
- ✅ Vaata viimase kuu hinnete kokkuvõtet

### Tuleviku Laiendusvõimalused

Potentsiaalsed funktsioonid tulevaseks arenduseks:
- Eraldi ainete tabel (parema normaliseerimise jaoks)
- Kasutajakontod (õpilased, õpetajad, administraatorid)
- Puudumiste/kohaloleku haldamine
- Tunniplaani haldamine
- Inventari haldamine
