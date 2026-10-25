
-- ONE-TO-MANY RELATIONSHIPS--Students & Marks

CREATE TABLE students(
student_id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

CREATE TABLE marks (
  mark_id SERIAL PRIMARY KEY,
  student_id INT,
  subject VARCHAR(50),
  marks INT,
  FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students(name)
VALUES
('Aman Kumar'),
('Vivek Gupta'),
('Anita Singh');


INSERT INTO marks (student_id, subject, marks)
VALUES
(1, 'English', 85),
(1, 'Math', 89), 
(1, 'Science', 92),

(2, 'English', 80),
(2, 'Math', 75), 
(2, 'Science', 78),

(3, 'English', 72),
(3, 'Math', 70), 
(3, 'Science', 74);

SELECT * FROM students s JOIN marks m 
ON s.student_id=m.student_id;

--1)Show each student's name along with their subject and marks.

SELECT s.name,m.subject,m.marks FROM students s JOIN marks m 
ON s.student_id=m.student_id;

--2)Show marks for only "Anita Singh" in all subjects

SELECT s.name,m.subject,m.marks 
FROM students s JOIN marks m 
ON s.student_id=m.student_id
WHERE name ='Anita Singh';

--3) Show only those subjects where marks are above 75

SELECT s.name,m.subject,m.marks 
FROM students s JOIN marks m 
ON s.student_id=m.student_id
WHERE marks > 75;

--4) Sort all students’ subject marks in descending order of marks.

SELECT s.name,m.subject,m.marks 
FROM students s JOIN marks m 
ON s.student_id=m.student_id
ORDER BY marks DESC;

--5)Show each student's average marks

SELECT s.name,ROUND(AVG(m.marks)) AS average_marks
FROM students s
JOIN marks m 
ON s.student_id=m.student_id
GROUP BY s.student_id,s.name;







