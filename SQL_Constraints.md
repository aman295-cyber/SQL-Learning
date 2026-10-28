# SQL Constraints — Revision Notes

**Database:** PostgreSQL

Constraints are rules applied to table columns or tables to help maintain valid and consistent data.

## 1. PRIMARY KEY

- Uniquely identifies each row.
- A primary key cannot contain `NULL`.
- A table can have only one primary key constraint, which may contain one or multiple columns.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
);
```

## 2. FOREIGN KEY

- Connects a column or group of columns to a key in another table (or the same table).
- Referenced columns must be a primary key or have a suitable unique constraint.
- It helps maintain referential integrity.

```sql
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
```

A Foreign Key column can contain `NULL` unless it is also declared `NOT NULL`.

## 3. NOT NULL

Prevents a column from storing `NULL`.

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);
```

Add it to an existing column:
```sql
ALTER TABLE users
ALTER COLUMN username SET NOT NULL;
```

Remove it:
```sql
ALTER TABLE users
ALTER COLUMN username DROP NOT NULL;
```

## 4. UNIQUE

Prevents duplicate values in a column or combination of columns.

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR(150) UNIQUE
);
```

Named constraint:
```sql
ALTER TABLE users
ADD CONSTRAINT uq_users_email UNIQUE (email);
```

In PostgreSQL, a standard `UNIQUE` constraint allows multiple `NULL` values by default.

## 5. CHECK

Requires values to satisfy a Boolean condition.

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    price NUMERIC(10, 2) CHECK (price >= 0),
    stock INT CHECK (stock >= 0)
);
```

Named constraint:
```sql
ALTER TABLE products
ADD CONSTRAINT check_price_positive
CHECK (price > 0);
```

Allowed-value example:
```sql
ALTER TABLE patient_details
ADD CONSTRAINT check_blood_group
CHECK (
    blood_group IN (
        'A+', 'A-', 'B+', 'B-',
        'AB+', 'AB-', 'O+', 'O-'
    )
);
```

A `CHECK` condition passes when it evaluates to `TRUE` or `NULL`; combine it with `NOT NULL` if nulls must be prohibited.

## 6. DEFAULT

Provides a value when an `INSERT` statement does not supply a value for that column.

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    status VARCHAR(20) DEFAULT 'Active',
    joining_date DATE DEFAULT CURRENT_DATE
);
```

Add a default to an existing column:
```sql
ALTER TABLE employees
ALTER COLUMN status SET DEFAULT 'Active';
```

Remove a default:
```sql
ALTER TABLE employees
ALTER COLUMN status DROP DEFAULT;
```

A `DEFAULT` does not prevent a user from explicitly inserting `NULL`; use `NOT NULL` as well when required.

## 7. Composite Primary Key

A primary key formed from more than one column.

```sql
CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id)
);
```

This prevents duplicate combinations of the same student and course.

## 8. Adding and Dropping Constraints

Add a named constraint:
```sql
ALTER TABLE employees
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);
```

Drop a named constraint:
```sql
ALTER TABLE employees
DROP CONSTRAINT fk_employee_department;
```

## 9. Foreign Key Actions

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    department_id INT REFERENCES departments(department_id)
        ON DELETE SET NULL
);
```

Common actions:

- `ON DELETE NO ACTION` — default behavior; deletion is rejected if it would violate the constraint.
- `ON DELETE CASCADE` — deletes referencing rows automatically.
- `ON DELETE SET NULL` — sets the referencing column to `NULL` (the column must allow it).
- `ON DELETE SET DEFAULT` — sets the referencing column to its default value, which must still satisfy the Foreign Key if applicable.
- `ON DELETE RESTRICT` — prevents deletion while referencing rows exist.

## 10. Quick Comparison

| Constraint | Main Purpose |
|---|---|
| `PRIMARY KEY` | Unique row identity; no NULLs |
| `FOREIGN KEY` | Valid relationship to referenced key |
| `NOT NULL` | Value is required |
| `UNIQUE` | Prevent duplicate values/combinations |
| `CHECK` | Enforce a condition |
| `DEFAULT` | Supply a value when omitted |

## 11. Important Notes

- Constraint names make schema changes easier to manage.
- Existing data must satisfy a new constraint before PostgreSQL can add it.
- A primary key is effectively unique and not null.
- A Foreign Key does not automatically make its column `NOT NULL`.
- `DEFAULT` and `NOT NULL` serve different purposes.
