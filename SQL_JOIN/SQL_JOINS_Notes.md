# SQL JOINs — Theory and General Syntax Notes

## 1. What Is a JOIN?

A **JOIN** in SQL combines rows from two or more tables based on a related column or a specified join condition.

A foreign key is commonly used to represent a relationship between tables, but a declared foreign key constraint is not required to write a JOIN. The query needs a valid join condition when the JOIN type requires one.

## 2. General JOIN Syntax

```sql
SELECT columns
FROM table1
JOIN_TYPE table2
    ON table1.common_column = table2.common_column;
```

Replace `JOIN_TYPE` with the required join type and replace the table and column placeholders with names from your database.

## 3. Types of JOINs

### A. INNER JOIN

Returns only rows that satisfy the join condition in both tables.

```sql
SELECT columns
FROM table1
INNER JOIN table2
    ON table1.common_column = table2.common_column;
```

`JOIN` without a qualifier is equivalent to `INNER JOIN`.

### B. LEFT JOIN (LEFT OUTER JOIN)

Returns every row from the left table and matching rows from the right table. If there is no match, the right-side columns contain `NULL`.

```sql
SELECT columns
FROM table1
LEFT JOIN table2
    ON table1.common_column = table2.common_column;
```

### C. RIGHT JOIN (RIGHT OUTER JOIN)

Returns every row from the right table and matching rows from the left table. If there is no match, the left-side columns contain `NULL`.

```sql
SELECT columns
FROM table1
RIGHT JOIN table2
    ON table1.common_column = table2.common_column;
```

### D. FULL OUTER JOIN

Returns matching rows plus unmatched rows from both tables. Missing-side columns are filled with `NULL`.

```sql
SELECT columns
FROM table1
FULL OUTER JOIN table2
    ON table1.common_column = table2.common_column;
```

### E. CROSS JOIN

Returns every possible combination of rows from the two tables. It does not use an `ON` condition.

```sql
SELECT columns
FROM table1
CROSS JOIN table2;
```

If the first table has `m` rows and the second table has `n` rows, the result contains `m * n` rows.

### F. SELF JOIN

A self join joins a table to itself. It is a query pattern, not a separate JOIN keyword. Use aliases to refer to the same table in two roles.

```sql
SELECT columns
FROM table_name AS t1
JOIN table_name AS t2
    ON t1.common_column = t2.common_column;
```

A self join can use `INNER JOIN`, `LEFT JOIN`, or another suitable join type. The join condition depends on the relationship being queried.

## 4. Joining More Than Two Tables

```sql
SELECT columns
FROM table1
JOIN table2
    ON table1.id = table2.table1_id
JOIN table3
    ON table2.id = table3.table2_id;
```

Each JOIN should have a condition that expresses how the next table relates to the preceding tables.

## 5. Understanding the ON Clause

The `ON` clause specifies the condition used to match rows between joined tables.

```sql
SELECT columns
FROM table1
JOIN table2
    ON table1.id = table2.table1_id;
```

The columns do not need to have the same name, but their values and data types should make sense for the comparison.

## 6. JOIN Syntax Cheat Sheet

| JOIN type | General pattern | Result |
|---|---|---|
| INNER JOIN | `table1 INNER JOIN table2 ON condition` | Matching rows only |
| LEFT JOIN | `table1 LEFT JOIN table2 ON condition` | All left rows plus matches |
| RIGHT JOIN | `table1 RIGHT JOIN table2 ON condition` | All right rows plus matches |
| FULL OUTER JOIN | `table1 FULL OUTER JOIN table2 ON condition` | All rows from both sides |
| CROSS JOIN | `table1 CROSS JOIN table2` | Every possible row combination |
| SELF JOIN | Same table with two aliases | Relates rows within one table |

## 7. JOIN vs Relationship

| Relationship | JOIN |
|---|---|
| Describes a logical association between data in tables. | Combines table rows in a query result. |
| Commonly represented by primary and foreign keys. | Uses a join condition, often with matching key columns. |
| Relates to database design. | Relates to retrieving data. |

## 8. Placement Interview Questions and Answers

### Q1. What is a JOIN in SQL?

A JOIN combines rows from two or more tables based on a related column or a specified join condition.

### Q2. What is the difference between INNER JOIN and LEFT JOIN?

INNER JOIN returns only matching rows. LEFT JOIN returns every row from the left table and matching rows from the right table; unmatched right-side columns contain `NULL`.

### Q3. What is the difference between LEFT JOIN and RIGHT JOIN?

LEFT JOIN preserves every row from the left table, while RIGHT JOIN preserves every row from the right table.

### Q4. What does FULL OUTER JOIN return?

It returns matching rows and unmatched rows from both tables, filling missing-side columns with `NULL`.

### Q5. What is a CROSS JOIN?

A CROSS JOIN returns the Cartesian product: every possible combination of rows from the two tables.

### Q6. What is a SELF JOIN?

A SELF JOIN joins a table to itself, usually by assigning different aliases to the table.

### Q7. Is a foreign key mandatory for a JOIN?

No. A foreign key constraint is not mandatory. A JOIN can use any valid join condition between columns or expressions.

### Q8. What is the purpose of the ON clause?

The `ON` clause specifies the condition used to match rows between tables for the JOIN.

### Q9. Can we join more than two tables in one query?

Yes. Additional JOIN clauses can be added, each with an appropriate join condition when required.

### Q10. What is the difference between a relationship and a JOIN?

A relationship describes how data is associated across tables; a JOIN combines rows from those tables in a query result.

## Important Notes

- `JOIN` alone means `INNER JOIN`.
- `LEFT OUTER JOIN` and `LEFT JOIN` are equivalent; the same applies to `RIGHT OUTER JOIN` and `RIGHT JOIN`.
- `CROSS JOIN` does not use an `ON` clause.
- A self join is a pattern that uses the same table more than once with aliases.
- In outer joins, unmatched columns from the non-preserved side are returned as `NULL`.
- These templates are suitable for PostgreSQL. Replace all placeholder names with your actual table and column names.
