
--ONE-TO-ONE RELATIONSHIPS EXAMPLE-------

CREATE TABLE students(
student_id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

INSERT INTO students(name)
VALUES
('Aman Kumar'),
('Vivek Gupta'),
('Anita Singh');

SELECT * FROM students;


CREATE TABLE student_profiles (
student_id INT PRIMARY KEY,
address TEXT,
age INT,
phone VARCHAR(15)
);


INSERT INTO student_profiles(student_id, address, age, phone)
VALUES
(1,'DELHI,INDIA',22,9878765422),
(2,'VARANASI ,INDIA',24,7865120078),
(3,'BIHAR, INDIA',21,8999456782);


ALTER TABLE student_profiles
ADD CONSTRAINT fk_student_id
FOREIGN KEY (student_id)
REFERENCES students(student_id);


SELECT 
s.student_id,
s.name,
sp.address,
sp.age,
sp.phone
FROM students s
JOIN student_profiles sp
ON s.student_id =sp.student_id;












