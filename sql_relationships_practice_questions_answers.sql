/*
SQL Relationships Practical Questions and Answers
Database: PostgreSQL

Contains 15 practice questions with correct SQL answers:
- One-to-One: 5 questions
- One-to-Many: 5 questions
- Many-to-Many: 5 questions
*/

/* ============================================================
   SECTION 1: ONE-TO-ONE RELATIONSHIP
   Scenario: Patients and patient details
   ============================================================ */

/*
Question 1:
Create patient_details to store each patient's blood group, emergency contact,
and address. patient_id must be both the Primary Key and a Foreign Key
referencing patients(patient_id).
*/
CREATE TABLE patient_details (
    patient_id INT PRIMARY KEY,
    blood_group VARCHAR(5),
    emergency_contact VARCHAR(15),
    address TEXT,
    CONSTRAINT fk_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
);

/*
Question 2:
Make blood_group mandatory in the existing patient_details table.
*/
ALTER TABLE patient_details
ALTER COLUMN blood_group SET NOT NULL;

/*
Question 3:
Add a UNIQUE constraint to emergency_contact.
*/
ALTER TABLE patient_details
ADD CONSTRAINT unq_emergency_contact
UNIQUE (emergency_contact);

/*
Question 4:
Allow only A+, A-, B+, B-, AB+, AB-, O+, and O- as blood groups.
*/
ALTER TABLE patient_details
ADD CONSTRAINT check_blood_group
CHECK (
    blood_group IN (
        'A+', 'A-', 'B+', 'B-',
        'AB+', 'AB-', 'O+', 'O-'
    )
);

/*
Question 5:
Update the address of patient 101 to 'Muzaffarpur, Bihar'.
*/
UPDATE patient_details
SET address = 'Muzaffarpur, Bihar'
WHERE patient_id = 101;


/* ============================================================
   SECTION 2: ONE-TO-MANY RELATIONSHIP
   ============================================================ */

/*
Question 1:
Create a classes table with class_id as Primary Key, a mandatory class_name,
and teacher_id referencing teachers(teacher_id).
*/
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    teacher_id INT,
    CONSTRAINT fk_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES teachers(teacher_id)
);

/*
Question 2:
In an existing employees table, make department_id mandatory and add a
Foreign Key referencing departments(department_id).
*/
ALTER TABLE employees
    ALTER COLUMN department_id SET NOT NULL,
    ADD CONSTRAINT fk_department_id
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id);

/*
Question 3:
Add a Foreign Key to books.author_id referencing authors.author_id.
The referenced authors.author_id must be a Primary Key or UNIQUE.
*/
ALTER TABLE books
ADD CONSTRAINT fk_author_id
FOREIGN KEY (author_id)
REFERENCES authors(author_id);

/*
Question 4:
Add a Foreign Key named fk_appointment_doctor so appointments.doctor_id
references doctors.doctor_id.
*/
ALTER TABLE appointments
ADD CONSTRAINT fk_appointment_doctor
FOREIGN KEY (doctor_id)
REFERENCES doctors(doctor_id);

/*
Question 5:
Add a Foreign Key from employees.department_id to departments.department_id.
When a department is deleted, its related employees should also be deleted.
*/
ALTER TABLE employees
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
ON DELETE CASCADE;


/* ============================================================
   SECTION 3: MANY-TO-MANY RELATIONSHIP
   ============================================================ */

/*
Question 1:
In student_clubs, add two Foreign Keys:
fk_sc_student: student_id references students(student_id)
fk_sc_club: club_id references clubs(club_id)
*/
ALTER TABLE student_clubs
ADD CONSTRAINT fk_sc_student
    FOREIGN KEY (student_id)
    REFERENCES students(student_id),
ADD CONSTRAINT fk_sc_club
    FOREIGN KEY (club_id)
    REFERENCES clubs(club_id);

/*
Question 2:
Make employee_id and project_id mandatory in employee_projects.
*/
ALTER TABLE employee_projects
    ALTER COLUMN employee_id SET NOT NULL,
    ALTER COLUMN project_id SET NOT NULL;

/*
Question 3:
Add a composite Primary Key to student_courses using student_id and course_id.
This prevents duplicate student-course combinations.
*/
ALTER TABLE student_courses
ADD CONSTRAINT pk_student_courses
PRIMARY KEY (student_id, course_id);

/*
Question 4:
Add assigned_date to employee_projects with DATE type and CURRENT_DATE default.
*/
ALTER TABLE employee_projects
ADD COLUMN assigned_date DATE DEFAULT CURRENT_DATE;

/*
Question 5:
Add joined_date to student_clubs as a DATE, defaulting to CURRENT_DATE,
and disallow NULL values.
*/
ALTER TABLE student_clubs
ADD COLUMN joined_date DATE DEFAULT CURRENT_DATE NOT NULL;

/* ========================= END OF FILE ========================= */
