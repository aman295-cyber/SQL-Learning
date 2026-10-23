# SQL ALTER TABLE — Complete Notes

## 1. What is ALTER TABLE?

`ALTER TABLE` is a Data Definition Language (DDL) command used to modify the structure of an existing table without recreating the entire table.

It can be used to:
- Add or remove columns.
- Rename columns and tables.
- Change column data types.
- Set or remove default values.
- Add or remove constraints.
- Change whether a column allows `NULL` values.

**Syntax:**
```sql
ALTER TABLE table_name
action;
```

## 2. Add a Column

Adds a new column to an existing table.

```sql
ALTER TABLE employees
ADD COLUMN email VARCHAR(150);
```

### Add a Column with a Default Value

```sql
ALTER TABLE employees
ADD COLUMN status VARCHAR(20) DEFAULT 'ACTIVE';
```

## 3. Add Multiple Columns

Multiple columns can be added in one statement.

```sql
ALTER TABLE employees
ADD COLUMN phone VARCHAR(15),
ADD COLUMN joining_date DATE;
```

## 4. Drop a Column

Removes a column and its stored data from the table.

```sql
ALTER TABLE employees
DROP COLUMN phone;
```

**Important:** Dropping a column removes its data. This operation should be used carefully.

## 5. Rename a Column

Changes the name of an existing column.

```sql
ALTER TABLE employees
RENAME COLUMN full_name TO employee_name;
```

## 6. Rename a Table

Changes the name of an existing table.

```sql
ALTER TABLE employees
RENAME TO company_employees;
```

## 7. Change a Column's Data Type

Use `ALTER COLUMN ... TYPE` to change a column's data type.

```sql
ALTER TABLE company_employees
ALTER COLUMN age TYPE SMALLINT;
```

### Convert VARCHAR to INTEGER Using USING

PostgreSQL's `USING` clause specifies how existing values should be converted.

```sql
ALTER TABLE company_employees
ALTER COLUMN dept_id TYPE INTEGER
USING NULLIF(TRIM(dept_id), '')::INTEGER;
```

- `TRIM()` removes leading and trailing spaces.
- `NULLIF(value, '')` converts an empty string into `NULL`.
- `::INTEGER` converts a value to an integer.
- Non-numeric strings such as `'IT'` will still cause a conversion error.

## 8. Set a Default Value

Sets a default value for future inserts when a value is omitted.

```sql
ALTER TABLE company_employees
ALTER COLUMN salary SET DEFAULT 25000;
```

## 9. Remove a Default Value

Removes the default setting from a column.

```sql
ALTER TABLE company_employees
ALTER COLUMN email DROP DEFAULT;
```

Removing a default does not delete existing data.

## 10. Set NOT NULL

Prevents a column from storing `NULL` values.

```sql
ALTER TABLE company_employees
ALTER COLUMN email SET NOT NULL;
```

This operation fails if existing rows contain `NULL` in that column.

## 11. Remove NOT NULL

Allows a column to store `NULL` values again.

```sql
ALTER TABLE company_employees
ALTER COLUMN email DROP NOT NULL;
```

## 12. Add a CHECK Constraint

A `CHECK` constraint ensures that values satisfy a specified condition.

```sql
ALTER TABLE company_employees
ADD CONSTRAINT salary_check
CHECK (salary >= 0);
```

This permits zero or positive salaries and rejects negative salaries.

## 13. Remove a Constraint

```sql
ALTER TABLE company_employees
DROP CONSTRAINT salary_check;
```

Use the actual constraint name defined in the database.

## 14. Add a UNIQUE Constraint

Ensures that values in the constrained column are unique.

```sql
ALTER TABLE company_employees
ADD CONSTRAINT email_unique UNIQUE (email);
```

PostgreSQL normally permits multiple `NULL` values under a standard `UNIQUE` constraint.

## 15. Add a FOREIGN KEY Constraint

A foreign key maintains a relationship between two tables.

Example parent table:

```sql
CREATE TABLE departments (
    department_id VARCHAR(150) PRIMARY KEY,
    department_name VARCHAR(100)
);
```

Add the foreign key:

```sql
ALTER TABLE company_employees
ADD CONSTRAINT company_employees_department_fk
FOREIGN KEY (department_id)
REFERENCES departments(department_id);
```

The referenced column must be a primary key, unique key, or otherwise eligible referenced key. Existing non-`NULL` child values must match a referenced value.

**Real-world note:** A foreign key usually does not need `UNIQUE` on the child column because multiple employees commonly belong to the same department.

## 16. Modify Multiple Properties in One Statement

PostgreSQL supports multiple alterations in a single `ALTER TABLE` statement.

```sql
ALTER TABLE company_employees
ALTER COLUMN salary TYPE NUMERIC(12,2),
ALTER COLUMN salary SET DEFAULT 25000;
```

This changes the data type and sets the default value.

## 17. DEFAULT vs CHECK

| DEFAULT | CHECK |
|---|---|
| Supplies a value when an insert omits the column. | Validates whether a value satisfies a condition. |
| Does not reject other explicitly supplied values by itself. | Rejects values that violate the condition. |
| Example: `SET DEFAULT 25000` | Example: `CHECK (salary >= 25000)` |

## 18. Important Points

- `ALTER TABLE` modifies table structure.
- `DROP COLUMN` removes a column and its data.
- `RENAME COLUMN` changes a column's name.
- `TYPE` changes a column's data type.
- `USING` defines a conversion expression in PostgreSQL.
- `SET DEFAULT` affects future inserts where the column is omitted.
- `DROP DEFAULT` removes the default setting.
- `SET NOT NULL` fails if existing values are `NULL`.
- `DROP CONSTRAINT` removes a named constraint.
- `CHECK` validates a condition.
- `UNIQUE` prevents duplicate non-`NULL` values by default in PostgreSQL.
- `FOREIGN KEY` maintains referential integrity.
- `ALTER TABLE` syntax and supported options can differ between database systems.

# Placement Interview Questions and Answers

## Q1. What is ALTER TABLE?

**Answer:** `ALTER TABLE` is a DDL command used to modify the structure of an existing database table.

## Q2. How do you add a column to an existing table?

**Answer:**
```sql
ALTER TABLE employees
ADD COLUMN email VARCHAR(150);
```

## Q3. How do you remove a column?

**Answer:**
```sql
ALTER TABLE employees
DROP COLUMN email;
```

## Q4. How do you rename a column in PostgreSQL?

**Answer:**
```sql
ALTER TABLE employees
RENAME COLUMN name TO employee_name;
```

## Q5. How do you rename a table?

**Answer:**
```sql
ALTER TABLE employees
RENAME TO company_employees;
```

## Q6. How do you change a column's data type?

**Answer:**
```sql
ALTER TABLE employees
ALTER COLUMN age TYPE SMALLINT;
```

## Q7. What is the purpose of USING in PostgreSQL?

**Answer:** `USING` specifies an expression PostgreSQL should use to convert existing column values when changing a data type.

## Q8. What is the difference between SET DEFAULT and DROP DEFAULT?

**Answer:** `SET DEFAULT` assigns a default value for future inserts where the column is omitted. `DROP DEFAULT` removes that default setting.

## Q9. What is the difference between SET NOT NULL and DROP NOT NULL?

**Answer:** `SET NOT NULL` prevents `NULL` values. `DROP NOT NULL` allows them again.

## Q10. What happens if a column contains NULL values when SET NOT NULL is executed?

**Answer:** PostgreSQL rejects the operation until the existing `NULL` values are handled.

## Q11. What is a CHECK constraint?

**Answer:** A `CHECK` constraint ensures that inserted or updated values satisfy a specified condition.

## Q12. What is a UNIQUE constraint?

**Answer:** A `UNIQUE` constraint prevents duplicate values in the constrained column or combination of columns.

## Q13. What is a FOREIGN KEY?

**Answer:** A foreign key links a column to an eligible key in another table and enforces referential integrity.

## Q14. How do you remove a constraint?

**Answer:**
```sql
ALTER TABLE employees
DROP CONSTRAINT constraint_name;
```

## Q15. Can multiple columns be added in one ALTER TABLE statement?

**Answer:** Yes. Multiple `ADD COLUMN` clauses can be separated by commas.

## Q16. Does SET DEFAULT update existing rows?

**Answer:** No. It changes the default used for future inserts where a value is omitted; it does not automatically update existing rows.

## Q17. What is the difference between DEFAULT and CHECK?

**Answer:** `DEFAULT` supplies a value when one is omitted. `CHECK` validates a condition and rejects values that violate it.

## Q18. What happens when a column is dropped?

**Answer:** The column and its stored data are removed. Dependent objects may also affect whether the operation succeeds.

## Q19. Can ALTER TABLE change a column's data type when the table contains data?

**Answer:** Yes, if PostgreSQL can convert the existing values to the new type. Otherwise, the conversion may fail.

## Q20. Why should constraints be used?

**Answer:** Constraints help maintain data integrity by enforcing rules such as uniqueness, non-null values, valid ranges, and relationships between tables.

## Q21. What is the difference between PRIMARY KEY and FOREIGN KEY?

**Answer:** A primary key uniquely identifies each row in its table. A foreign key references an eligible key in another table to enforce a relationship.

## Q22. What does ADD CONSTRAINT do?

**Answer:** It adds a named rule to a table, such as a `CHECK`, `UNIQUE`, or `FOREIGN KEY` constraint.

## Q23. Can ALTER TABLE perform multiple changes at once?

**Answer:** Yes. PostgreSQL allows multiple compatible alterations in one statement, separated by commas.

## Q24. Is ALTER TABLE a DDL or DML command?

**Answer:** `ALTER TABLE` is a Data Definition Language (DDL) command because it modifies table structure.

## Q25. Why should DROP COLUMN be used carefully?

**Answer:** It removes the column and its stored data, so important information can be lost if it has not been backed up or migrated.

---

## Quick Revision

Remember these commands:

```sql
-- Add a column
ALTER TABLE employees ADD COLUMN email VARCHAR(150);

-- Drop a column
ALTER TABLE employees DROP COLUMN email;

-- Rename a column
ALTER TABLE employees RENAME COLUMN name TO employee_name;

-- Change a data type
ALTER TABLE employees ALTER COLUMN age TYPE SMALLINT;

-- Set a default
ALTER TABLE employees ALTER COLUMN salary SET DEFAULT 25000;

-- Remove a default
ALTER TABLE employees ALTER COLUMN salary DROP DEFAULT;

-- Set NOT NULL
ALTER TABLE employees ALTER COLUMN email SET NOT NULL;

-- Remove NOT NULL
ALTER TABLE employees ALTER COLUMN email DROP NOT NULL;

-- Drop a constraint
ALTER TABLE employees DROP CONSTRAINT constraint_name;
```

**Topic complete:** SQL `ALTER TABLE` in PostgreSQL.
