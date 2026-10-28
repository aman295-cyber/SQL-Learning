# SQL Basic Commands — Revision Notes

**Database:** PostgreSQL  
**Tool:** pgAdmin

## 1. What is SQL?

SQL (Structured Query Language) is used to create, manage, retrieve, and modify data in relational databases.

## 2. Main Categories of SQL Commands

| Category | Full Form | Purpose | Common Commands |
|---|---|---|---|
| DDL | Data Definition Language | Defines or changes database objects | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| DML | Data Manipulation Language | Inserts or changes table data | `INSERT`, `UPDATE`, `DELETE` |
| DQL | Data Query Language | Retrieves data | `SELECT` |
| DCL | Data Control Language | Controls database permissions | `GRANT`, `REVOKE` |
| TCL | Transaction Control Language | Manages transactions | `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

## 3. Database Commands

### Create a database
```sql
CREATE DATABASE college_db;
```

### Connect to a database
In pgAdmin, select the database you want to work with and open its Query Tool. PostgreSQL's `\c` command is a `psql` terminal command, not a regular SQL statement for pgAdmin's Query Tool.

### Drop a database
```sql
DROP DATABASE college_db;
```
The database must not have active connections when dropped.

## 4. Table Commands (DDL)

### Create a table
```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    marks NUMERIC(5, 2)
);
```

### View table data
```sql
SELECT * FROM students;
```

### Add a column
```sql
ALTER TABLE students
ADD COLUMN email VARCHAR(150);
```

### Rename a column
```sql
ALTER TABLE students
RENAME COLUMN name TO student_name;
```

### Change a column's data type
```sql
ALTER TABLE students
ALTER COLUMN age TYPE SMALLINT;
```

### Rename a table
```sql
ALTER TABLE students
RENAME TO college_students;
```

### Remove a column
```sql
ALTER TABLE college_students
DROP COLUMN email;
```

### Remove all rows but keep the table
```sql
TRUNCATE TABLE college_students;
```

### Drop a table
```sql
DROP TABLE college_students;
```

## 5. CRUD Operations (DML + DQL)

CRUD stands for Create, Read, Update, and Delete.

### Create — INSERT
```sql
INSERT INTO students (name, age, marks)
VALUES
    ('Aman Kumar', 22, 85.50),
    ('Vivek Gupta', 21, 78.00);
```

### Read — SELECT
```sql
SELECT * FROM students;
```

Select specific columns:
```sql
SELECT name, marks
FROM students;
```

### Update — UPDATE
```sql
UPDATE students
SET marks = 90
WHERE student_id = 1;
```

**Important:** Use `WHERE` when you intend to update specific rows. Without it, every row is updated.

### Delete — DELETE
```sql
DELETE FROM students
WHERE student_id = 2;
```

**Important:** Without `WHERE`, `DELETE` removes all rows from the table.

## 6. Filtering and Sorting Basics

### WHERE
```sql
SELECT *
FROM students
WHERE marks >= 80;
```

### ORDER BY
```sql
SELECT name, marks
FROM students
ORDER BY marks DESC;
```

### DISTINCT
```sql
SELECT DISTINCT age
FROM students;
```

### LIMIT
```sql
SELECT *
FROM students
LIMIT 5;
```

## 7. Transactions (TCL)

### Start a transaction
```sql
BEGIN;
```

### Save changes
```sql
COMMIT;
```

### Undo uncommitted changes
```sql
ROLLBACK;
```

### Create a savepoint
```sql
SAVEPOINT before_update;
```

### Roll back to a savepoint
```sql
ROLLBACK TO SAVEPOINT before_update;
```

## 8. Permissions (DCL)

### Grant permission
```sql
GRANT SELECT ON students TO analyst_user;
```

### Revoke permission
```sql
REVOKE SELECT ON students FROM analyst_user;
```

The role must exist, and the executing user must have sufficient privileges.

## 9. Quick Revision

- `CREATE` creates database objects.
- `ALTER` changes an existing object's structure.
- `DROP` removes an object.
- `TRUNCATE` removes all rows while keeping the table structure.
- `INSERT` adds rows.
- `SELECT` retrieves rows.
- `UPDATE` modifies existing rows.
- `DELETE` removes selected rows.
- `COMMIT` saves a transaction.
- `ROLLBACK` cancels uncommitted transaction changes.
