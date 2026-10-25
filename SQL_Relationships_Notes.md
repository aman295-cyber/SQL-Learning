# SQL Relationships — Theory and Syntax Notes

## 1. What Is a Relationship?

A relationship in a relational database represents an association between records in two or more tables. Relationships are commonly established using primary keys and foreign keys.

## 2. Keys Used in Relationships

### Primary Key (PK)

A **Primary Key** uniquely identifies each record in a table.

- Primary key values must be unique.
- Primary key values cannot be `NULL`.
- A primary key can consist of one column or multiple columns (a composite primary key).

**General syntax:**

```sql
CREATE TABLE table_name (
    column_name datatype PRIMARY KEY,
    other_column datatype
);
```

Composite primary key syntax:

```sql
PRIMARY KEY (column1, column2)
```

### Foreign Key (FK)

A **Foreign Key** is a column or group of columns that references a primary key or another eligible unique key. It helps establish relationships and maintain referential integrity.

**General syntax:**

```sql
CREATE TABLE table_name (
    id datatype PRIMARY KEY,
    foreign_key_column datatype,
    FOREIGN KEY (foreign_key_column)
        REFERENCES parent_table(parent_key_column)
);
```

Short column-level syntax:

```sql
foreign_key_column datatype
    REFERENCES parent_table(parent_key_column)
```

Foreign key values may repeat. They may be `NULL` unless the column is defined as `NOT NULL`.

## 3. Types of Relationships

### A. One-to-One (1:1)

Each record in one table is associated with at most one record in the other table, and vice versa.

A common way to implement this is to make the foreign key unique.

```sql
CREATE TABLE child_table (
    id datatype PRIMARY KEY,
    reference_id datatype UNIQUE,
    FOREIGN KEY (reference_id)
        REFERENCES parent_table(parent_key_column)
);
```

**Remember:** `UNIQUE` prevents the same non-NULL foreign key value from appearing more than once. If every parent must have a child, additional constraints or design choices may be needed.

### B. One-to-Many (1:N)

One record in a parent table can be associated with multiple records in a child table. Each child record references at most one parent record.

```sql
CREATE TABLE parent_table (
    parent_id datatype PRIMARY KEY
);

CREATE TABLE child_table (
    child_id datatype PRIMARY KEY,
    parent_id datatype,
    FOREIGN KEY (parent_id)
        REFERENCES parent_table(parent_id)
);
```

**Remember:** The foreign key is usually placed on the “many” side. Do not add `UNIQUE` to that foreign key if multiple child rows must be allowed to reference the same parent.

### C. Many-to-Many (M:N)

Multiple records in one table can be associated with multiple records in another table. This is usually implemented with a **junction table** (also called a bridge or associative table).

```sql
CREATE TABLE junction_table (
    first_id datatype,
    second_id datatype,
    PRIMARY KEY (first_id, second_id),
    FOREIGN KEY (first_id)
        REFERENCES first_table(first_key),
    FOREIGN KEY (second_id)
        REFERENCES second_table(second_key)
);
```

The composite primary key prevents duplicate pairs. The data types of the foreign key columns should match the referenced key columns.

### D. Self-Referencing Relationship

A table references another record in the same table. This is useful for hierarchical data, such as employees and managers.

```sql
CREATE TABLE table_name (
    id datatype PRIMARY KEY,
    reference_id datatype,
    FOREIGN KEY (reference_id)
        REFERENCES table_name(id)
);
```

## 4. Add a Foreign Key to an Existing Table

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
FOREIGN KEY (column_name)
REFERENCES parent_table(parent_key_column);
```

The constraint can fail if existing rows contain values that do not reference valid parent records.

## 5. ON DELETE and ON UPDATE Actions

These actions define what happens to referencing rows when the referenced key is deleted or updated.

```sql
FOREIGN KEY (column_name)
    REFERENCES parent_table(parent_key_column)
    ON DELETE CASCADE
    ON UPDATE CASCADE
```

Common actions:

| Action | Meaning |
|---|---|
| `CASCADE` | Propagates the delete or update to referencing rows. |
| `SET NULL` | Sets the foreign key value to `NULL`; the column must allow `NULL`. |
| `SET DEFAULT` | Sets the foreign key to its default value; that value must satisfy the constraint. |
| `RESTRICT` | Prevents deleting or updating a referenced row while dependent references exist. |
| `NO ACTION` | Rejects a constraint violation when checked; in PostgreSQL, checking can be deferred if the constraint is declared deferrable. |

Use cascading actions carefully because deleting a parent row may also delete related child rows.

## 6. Referential Integrity

**Referential integrity** means that each non-NULL foreign key value must refer to an existing row in the referenced table.

## 7. Cardinality and Optionality

- **Cardinality** describes how many records may be associated across a relationship: `1:1`, `1:N`, or `M:N`.
- **Optionality** describes whether participation in a relationship is optional or mandatory.
- A nullable foreign key can allow a child row to have no parent reference.
- A foreign key alone does not guarantee that every parent has at least one child.

## 8. Relationship Syntax Cheat Sheet

| Relationship / concept | General pattern |
|---|---|
| Primary key | `PRIMARY KEY (column_name)` |
| Foreign key | `FOREIGN KEY (column_name) REFERENCES parent_table(parent_key_column)` |
| One-to-One | Foreign key + `UNIQUE` |
| One-to-Many | Foreign key on the many-side table |
| Many-to-Many | Junction table with two foreign keys |
| Composite primary key | `PRIMARY KEY (column1, column2)` |
| Self-referencing | `REFERENCES same_table(id)` |
| Add foreign key later | `ALTER TABLE ... ADD CONSTRAINT ... FOREIGN KEY ...` |
| Delete/update behavior | `ON DELETE ... ON UPDATE ...` |

## 9. Placement Interview Questions and Answers

### Q1. What is a relationship in a relational database?

A relationship is an association between records in tables, commonly established using primary keys and foreign keys.

### Q2. What is a primary key?

A primary key uniquely identifies each record in a table. It cannot contain duplicate or `NULL` values.

### Q3. What is a foreign key?

A foreign key references a primary key or another eligible unique key and helps maintain referential integrity.

### Q4. Can a foreign key contain duplicate values?

Yes. In a one-to-many relationship, multiple child rows commonly reference the same parent key.

### Q5. How is a one-to-one relationship implemented?

A common implementation uses a foreign key with a `UNIQUE` constraint.

### Q6. How is a one-to-many relationship implemented?

The foreign key is generally placed in the child table, on the many side.

### Q7. How is a many-to-many relationship implemented?

It is generally implemented with a junction table containing foreign keys referencing both related tables.

### Q8. What is a composite primary key?

A composite primary key uses two or more columns together to uniquely identify a row.

### Q9. What is referential integrity?

Referential integrity ensures that non-NULL foreign key values refer to valid records in the referenced table.

### Q10. What does `ON DELETE CASCADE` do?

It automatically deletes referencing child rows when the referenced parent row is deleted.

### Q11. What is a self-referencing relationship?

It is a relationship in which a foreign key references a key in the same table.

### Q12. Does a foreign key have to be unique?

No. A foreign key can repeat unless a `UNIQUE` constraint is also applied.

---

## Important Note

These are general PostgreSQL-compatible syntax templates. Replace placeholder table names, column names, and data types with those required by your database. Create the referenced parent table and key before creating a foreign key that references it.
