-- SQL ALTER TABLE: Practical Questions and Answers
-- Database: PostgreSQL
-- Run the questions in sequence in your practice database.

-- Q1. Add an email column with a default value of 'NOT PROVIDED'.
ALTER TABLE employees
ADD COLUMN email VARCHAR(150) DEFAULT 'NOT PROVIDED';

-- Q2. Remove the department column from the employees table.
ALTER TABLE employees
DROP COLUMN department;

-- Q3. Rename the full_name column to employee_name.
ALTER TABLE employees
RENAME COLUMN full_name TO employee_name;

-- Q4. Change the data type of the age column to SMALLINT.
ALTER TABLE employees
ALTER COLUMN age TYPE SMALLINT;

-- Q5. Set the default value of age to 18.
ALTER TABLE employees
ALTER COLUMN age SET DEFAULT 18;

-- Q6. Remove the default value from the age column.
ALTER TABLE employees
ALTER COLUMN age DROP DEFAULT;

-- Q7. Add a CHECK constraint to ensure salary cannot be negative.
ALTER TABLE employees
ADD CONSTRAINT salary_check CHECK (salary >= 0);

-- Q8. Remove the salary_check constraint.
ALTER TABLE employees
DROP CONSTRAINT salary_check;

-- Q9. Rename the employees table to company_employees.
ALTER TABLE employees
RENAME TO company_employees;

-- Q10. Add a UNIQUE constraint to the email column.
ALTER TABLE company_employees
ADD CONSTRAINT email_unique UNIQUE (email);

-- Q11. Add a CHECK constraint to ensure salary is non-negative.
ALTER TABLE company_employees
ADD CONSTRAINT salary_check CHECK (salary >= 0);

-- Q12. Add a department_id column with VARCHAR(150) and a UNIQUE constraint.
ALTER TABLE company_employees
ADD COLUMN department_id VARCHAR(150) UNIQUE;

-- Q13. Create a departments table to reference department IDs.
CREATE TABLE departments (
    department_id VARCHAR(150) PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Q14. Add a foreign key referencing the departments table.
ALTER TABLE company_employees
ADD CONSTRAINT company_employees_department_fk
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

-- Q15. Remove the foreign key constraint.
ALTER TABLE company_employees
DROP CONSTRAINT company_employees_department_fk;

-- Q16. Rename department_id to dept_id.
ALTER TABLE company_employees
RENAME COLUMN department_id TO dept_id;

-- Q17. Change dept_id from VARCHAR to INTEGER, converting empty strings to NULL.
ALTER TABLE company_employees
ALTER COLUMN dept_id TYPE INTEGER
USING NULLIF(TRIM(dept_id), '')::INTEGER;

-- Q18. Make the email column NOT NULL.
ALTER TABLE company_employees
ALTER COLUMN email SET NOT NULL;

-- Q19. Allow NULL values in the email column again.
ALTER TABLE company_employees
ALTER COLUMN email DROP NOT NULL;

-- Q20. Change the default value of email to 'UNKNOWN'.
ALTER TABLE company_employees
ALTER COLUMN email SET DEFAULT 'UNKNOWN';

-- Q21. Remove the default value from the email column.
ALTER TABLE company_employees
ALTER COLUMN email DROP DEFAULT;

-- Q22. Add phone and joining_date columns in one statement.
ALTER TABLE company_employees
ADD COLUMN phone VARCHAR(15),
ADD COLUMN joining_date DATE;

-- Q23. Change salary to NUMERIC(12,2) and set its default to 25000.
ALTER TABLE company_employees
ALTER COLUMN salary TYPE NUMERIC(12,2),
ALTER COLUMN salary SET DEFAULT 25000;
