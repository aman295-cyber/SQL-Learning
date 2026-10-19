content = """# SQL Clauses in PostgreSQL

A practical reference for commonly used SQL clauses, with definitions, syntax, examples, common mistakes, and placement interview questions.

## Table of Contents

- [What Is a Clause?](#what-is-a-clause)
- [Sample Table](#sample-table)
- [SELECT](#1-select)
- [FROM](#2-from)
- [WHERE](#3-where)
- [DISTINCT](#4-distinct)
- [ORDER BY](#5-order-by)
- [LIMIT](#6-limit)
- [OFFSET](#7-offset)
- [GROUP BY](#8-group-by)
- [HAVING](#9-having)
- [AS](#10-as-alias)
- [IN](#11-in)
- [BETWEEN](#12-between)
- [LIKE-and-ILIKE](#13-like-and-ilike)
- [IS NULL](#14-is-null-and-is-not-null)
- [Logical Execution Order](#logical-execution-order)
- [Common Clause Combinations](#common-clause-combinations)
- [Common Mistakes](#common-mistakes)
- [Practice Questions](#practice-questions)
- [Placement Interview Questions](#placement-interview-questions)

## What Is a Clause?

A SQL clause is a part of a SQL statement that performs a specific job. Clauses help specify which columns to retrieve, which table to use, which rows to filter, how to group rows, and how to sort the result.

For example:

```sql
SELECT category, AVG(price) AS average_price
FROM products
WHERE price > 500
GROUP BY category
HAVING AVG(price) > 1000
ORDER BY average_price DESC
LIMIT 5;
```

This query selects each category, considers products priced above 500, calculates the average price for each category, keeps groups with an average above 1000, sorts them from highest to lowest average price, and returns at most five rows.

## Sample Table

The examples use a table named `products`.

| Column | Description |
|---|---|
| `product_id` | Unique product ID |
| `name` | Product name |
| `sku_code` | Unique product code |
| `price` | Product price |
| `stock_quantity` | Quantity in stock |
| `is_available` | Whether the product is available |
| `category` | Product category |
| `added_on` | Date the product was added |
| `last_update` | Date of last update |

The examples assume the `products` table already exists. They may return no rows if the table is empty or has no matching records.

## 1. SELECT

**Purpose:** Specifies which columns or expressions should appear in the result.

**Syntax:**

```sql
SELECT column1, column2
FROM table_name;
```

**Example:**

```sql
SELECT name, price
FROM products;
```

To return every column:

```sql
SELECT *
FROM products;
```

Prefer listing the required columns in production queries instead of using `*` when you do not need every column.

## 2. FROM

**Purpose:** Specifies the table or other data source from which to retrieve data.

**Syntax:**

```sql
SELECT column_name
FROM table_name;
```

**Example:**

```sql
SELECT name
FROM products;
```

Here, `products` is the source table.

## 3. WHERE

**Purpose:** Filters individual rows according to a condition. It is applied before grouping and aggregation.

**Syntax:**

```sql
SELECT column_names
FROM table_name
WHERE condition;
```

**Examples:**

```sql
-- Products priced above 1000
SELECT name, price
FROM products
WHERE price > 1000;

-- Products in the Electronics category
SELECT name, category
FROM products
WHERE category = 'Electronics';

-- Products that are available and priced above 500
SELECT name, price
FROM products
WHERE is_available = TRUE
  AND price > 500;
```

Common comparison operators include `=`, `<>`, `!=`, `>`, `<`, `>=`, and `<=`. In PostgreSQL, `<>` is the standard SQL not-equal operator; `!=` is also accepted.

## 4. DISTINCT

**Purpose:** Removes duplicate rows from the selected result.

**Syntax:**

```sql
SELECT DISTINCT column_name
FROM table_name;
```

**Examples:**

```sql
-- List each category once
SELECT DISTINCT category
FROM products;

-- List unique combinations of category and availability
SELECT DISTINCT category, is_available
FROM products;
```

When multiple columns are selected, `DISTINCT` applies to the complete combination of those columns.

## 5. ORDER BY

**Purpose:** Sorts the result by one or more columns or expressions.

- `ASC`: ascending order; this is the default.
- `DESC`: descending order.

**Examples:**

```sql
-- Cheapest products first
SELECT name, price
FROM products
ORDER BY price ASC;

-- Most expensive products first
SELECT name, price
FROM products
ORDER BY price DESC;

-- Sort by category, then by price from highest to lowest
SELECT name, category, price
FROM products
ORDER BY category ASC, price DESC;
```

In PostgreSQL, `NULL` values sort last by default in ascending order and first in descending order. You can specify `NULLS FIRST` or `NULLS LAST` explicitly.

```sql
SELECT name, price
FROM products
ORDER BY price DESC NULLS LAST;
```

## 6. LIMIT

**Purpose:** Restricts the maximum number of rows returned.

**Syntax:**

```sql
SELECT column_names
FROM table_name
LIMIT number;
```

**Examples:**

```sql
-- Return at most five products
SELECT name, price
FROM products
LIMIT 5;

-- Show the three most expensive products
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 3;
```

Without `ORDER BY`, the rows returned by `LIMIT` are not guaranteed to be in a particular order.

## 7. OFFSET

**Purpose:** Skips a specified number of rows before returning results. It is often combined with `LIMIT` for pagination.

**Example:**

```sql
-- Skip the first five rows and return the next five
SELECT name, price
FROM products
ORDER BY product_id
LIMIT 5 OFFSET 5;
```

For stable pagination, use an `ORDER BY` that uniquely determines row order, such as a unique ID.

## 8. GROUP BY

**Purpose:** Groups rows that have the same value in one or more columns. Aggregate functions can then calculate a result for each group.

**Syntax:**

```sql
SELECT group_column, AGGREGATE_FUNCTION(column_name)
FROM table_name
GROUP BY group_column;
```

**Examples:**

```sql
-- Count products in each category
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category;

-- Calculate average price for each category
SELECT category, AVG(price) AS average_price
FROM products
GROUP BY category;

-- Calculate total stock for each category
SELECT category, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category;
```

When using `GROUP BY`, selected columns generally need to be grouped or used inside an aggregate function, subject to PostgreSQL's functional-dependency rules.

## 9. HAVING

**Purpose:** Filters groups after `GROUP BY` and aggregation.

**Example:**

```sql
-- Show categories containing more than five products
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category
HAVING COUNT(*) > 5;
```

Another example:

```sql
-- Show categories whose average price is above 1000
SELECT category, AVG(price) AS average_price
FROM products
GROUP BY category
HAVING AVG(price) > 1000;
```

### WHERE vs HAVING

| `WHERE` | `HAVING` |
|---|---|
| Filters individual rows | Filters groups |
| Applied before grouping | Applied after grouping |
| Commonly uses row-level conditions | Commonly uses aggregate conditions |

They can be used together:

```sql
SELECT category, AVG(price) AS average_price
FROM products
WHERE price > 500
GROUP BY category
HAVING AVG(price) > 1000;
```

First, only products priced above 500 are considered. Then the remaining rows are grouped by category, and groups with an average price above 1000 are retained.

## 10. AS (Alias)

**Purpose:** Gives a temporary name to a column or table in a query result or query expression.

**Examples:**

```sql
SELECT name AS product_name, price AS product_price
FROM products;
```

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;
```

`AS` is optional for many aliases in PostgreSQL, but using it can make queries easier to read. A column alias changes the output heading; it does not rename the actual table column.

## 11. IN

**Purpose:** Checks whether a value matches any value in a list or the result of a subquery.

**Example:**

```sql
SELECT name, category
FROM products
WHERE category IN ('Electronics', 'Fitness', 'Home & Kitchen');
```

This is often shorter than joining several equality checks with `OR`.

## 12. BETWEEN

**Purpose:** Checks whether a value falls within a range. `BETWEEN` includes both endpoints.

**Example:**

```sql
SELECT name, price
FROM products
WHERE price BETWEEN 500 AND 2000;
```

This includes prices equal to 500 and 2000. For ranges where the endpoint should not be included, use comparison operators such as `>` and `<`.

## 13. LIKE and ILIKE

**Purpose:** Match text against a pattern.

- `%` matches zero or more characters.
- `_` matches exactly one character.
- `LIKE` is case-sensitive for ordinary text matching in PostgreSQL.
- `ILIKE` is PostgreSQL's case-insensitive pattern-matching operator.

**Examples:**

```sql
-- Names starting with 'S'
SELECT name
FROM products
WHERE name LIKE 'S%';

-- Names ending with 'phone'
SELECT name
FROM products
WHERE name LIKE '%phone';

-- Names containing 'book', case-insensitively
SELECT name
FROM products
WHERE name ILIKE '%book%';

-- Names whose second character is 'a'
SELECT name
FROM products
WHERE name LIKE '_a%';
```

## 14. IS NULL and IS NOT NULL

**Purpose:** Test whether a value is missing (`NULL`) or present (not `NULL`).

**Examples:**

```sql
SELECT name
FROM products
WHERE sku_code IS NULL;
```

```sql
SELECT name
FROM products
WHERE sku_code IS NOT NULL;
```

Do not use `= NULL` or `<> NULL` to test for null values. Use `IS NULL` or `IS NOT NULL`.

## Logical Execution Order

Although a query is written starting with `SELECT`, a simplified logical processing order is:

1. `FROM`
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. `SELECT`
6. `DISTINCT`
7. `ORDER BY`
8. `LIMIT` / `OFFSET`

This is a conceptual order, not a guarantee about the database engine's physical execution plan.

## Common Clause Combinations

### Filter, sort, and limit

```sql
SELECT name, price
FROM products
WHERE price > 500
ORDER BY price DESC
LIMIT 5;
```

### Group, filter groups, and sort

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category
HAVING COUNT(*) >= 3
ORDER BY total_products DESC;
```

### Find distinct categories in alphabetical order

```sql
SELECT DISTINCT category
FROM products
ORDER BY category ASC;
```

### Paginate results

```sql
SELECT product_id, name, price
FROM products
ORDER BY product_id
LIMIT 10 OFFSET 20;
```

## Common Mistakes

1. Using `HAVING` for ordinary row filtering when `WHERE` is more appropriate.
2. Using `WHERE COUNT(*) > 5`; aggregate conditions belong in `HAVING`.
3. Selecting a non-grouped column alongside aggregate results without a valid grouping or aggregation strategy.
4. Assuming `LIMIT` returns the same rows every time without `ORDER BY`.
5. Using `= NULL` instead of `IS NULL`.
6. Forgetting that `BETWEEN` includes both endpoints.
7. Assuming `LIKE` is case-insensitive in PostgreSQL; use `ILIKE` when case-insensitive matching is intended.
8. Expecting `DISTINCT category, is_available` to make each category unique regardless of availability. It removes duplicate pairs, not duplicate values in only the first column.

## Practice Questions

These questions use the `products` table described above.

### Q1. Display the name and price of every product.

```sql
SELECT name, price
FROM products;
```

### Q2. Display products whose price is greater than 1000.

```sql
SELECT name, price
FROM products
WHERE price > 1000;
```

### Q3. Display each category only once.

```sql
SELECT DISTINCT category
FROM products;
```

### Q4. Display products from cheapest to most expensive.

```sql
SELECT name, price
FROM products
ORDER BY price ASC;
```

### Q5. Display the five most expensive products.

```sql
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 5;
```

### Q6. Skip the first five products and display the next five, ordered by product ID.

```sql
SELECT product_id, name
FROM products
ORDER BY product_id
LIMIT 5 OFFSET 5;
```

### Q7. Count the number of products in each category.

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category;
```

### Q8. Display categories containing more than five products.

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category
HAVING COUNT(*) > 5;
```

### Q9. Display products priced between 500 and 2000, including both endpoints.

```sql
SELECT name, price
FROM products
WHERE price BETWEEN 500 AND 2000;
```

### Q10. Display product names that contain the word 'book', ignoring case.

```sql
SELECT name
FROM products
WHERE name ILIKE '%book%';
```

### Q11. Display products whose SKU code is missing.

```sql
SELECT name
FROM products
WHERE sku_code IS NULL;
```

### Q12. Display available products priced above 500, from highest to lowest price.

```sql
SELECT name, price
FROM products
WHERE is_available = TRUE
  AND price > 500
ORDER BY price DESC;
```

### Q13. Display each category's average price, highest average first.

```sql
SELECT category, AVG(price) AS average_price
FROM products
GROUP BY category
ORDER BY average_price DESC;
```

### Q14. Display categories whose total stock quantity exceeds 100.

```sql
SELECT category, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category
HAVING SUM(stock_quantity) > 100;
```

### Q15. Display categories with at least three products, ordered by product count from highest to lowest.

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category
HAVING COUNT(*) >= 3
ORDER BY total_products DESC;
```

## Placement Interview Questions

1. What is a SQL clause?
2. What is the purpose of `SELECT` and `FROM`?
3. What is the difference between `WHERE` and `HAVING`?
4. What is the purpose of `GROUP BY`?
5. What is the difference between `ORDER BY ASC` and `ORDER BY DESC`?
6. Why is `LIMIT` commonly combined with `ORDER BY`?
7. What does `OFFSET` do?
8. What is the difference between `DISTINCT` and `GROUP BY`?
9. What do `%` and `_` mean in a `LIKE` pattern?
10. What is the difference between `LIKE` and PostgreSQL's `ILIKE`?
11. Why should `NULL` be checked using `IS NULL`?
12. What is the logical processing order of a typical `SELECT` query?

## Quick Revision

- `SELECT`: choose output columns.
- `FROM`: choose the source table.
- `WHERE`: filter rows.
- `DISTINCT`: remove duplicate result rows.
- `ORDER BY`: sort results.
- `LIMIT`: cap the number of returned rows.
- `OFFSET`: skip rows.
- `GROUP BY`: create groups for aggregation.
- `HAVING`: filter grouped results.
- `AS`: assign an alias.
- `IN`: match values from a list or subquery.
- `BETWEEN`: test an inclusive range.
- `LIKE` / `ILIKE`: match text patterns.
- `IS NULL` / `IS NOT NULL`: test missing or non-missing values.
"""
