content = """# Aggregate Functions in PostgreSQL

This file contains concise notes and practice questions for SQL aggregate functions using PostgreSQL and the `products` table.

## Overview

Aggregate functions perform a calculation on multiple rows and return a single result. They are commonly used to summarize data, analyze sales or inventory, and prepare reports.

Common examples include:
- Counting products
- Calculating average prices
- Finding the cheapest or most expensive product
- Calculating total stock
- Comparing categories using `GROUP BY` and `HAVING`

## Table Used

The queries in this file use the `products` table with columns such as:

| Column | Description |
|---|---|
| `product_id` | Unique product ID |
| `name` | Product name |
| `price` | Product price |
| `stock_quantity` | Available stock quantity |
| `category` | Product category |
| `is_available` | Whether the product is available |

> Note: These queries assume that the `products` table already exists. If the table is empty, aggregate functions may return zero or `NULL`, and grouped queries may return no rows.

## Aggregate Functions

| Function | Purpose | Example |
|---|---|---|
| `COUNT(*)` | Counts all rows | `SELECT COUNT(*) FROM products;` |
| `COUNT(column)` | Counts non-`NULL` values in a column | `SELECT COUNT(name) FROM products;` |
| `COUNT(DISTINCT column)` | Counts unique, non-`NULL` values | `SELECT COUNT(DISTINCT category) FROM products;` |
| `SUM(column)` | Adds numeric values | `SELECT SUM(stock_quantity) FROM products;` |
| `AVG(column)` | Calculates the average | `SELECT AVG(price) FROM products;` |
| `MIN(column)` | Finds the smallest value | `SELECT MIN(price) FROM products;` |
| `MAX(column)` | Finds the largest value | `SELECT MAX(price) FROM products;` |

## Important Concepts

### 1. `COUNT(*)` vs `COUNT(column)`

- `COUNT(*)` counts every row.
- `COUNT(column)` counts only rows where that column is not `NULL`.
- `COUNT(DISTINCT column)` counts unique, non-`NULL` values.

### 2. `GROUP BY`

`GROUP BY` groups rows that share the same value in one or more columns. Aggregate functions can then calculate a result for each group.

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category;
```

### 3. `WHERE` vs `HAVING`

- `WHERE` filters individual rows before grouping.
- `HAVING` filters groups after aggregation.

```sql
SELECT category, AVG(price) AS average_price
FROM products
WHERE price > 500
GROUP BY category
HAVING AVG(price) > 1000;
```

In this example, only products priced above 500 are considered, and only categories with an average price above 1000 are shown.

### 4. Sorting Aggregate Results

Use `ORDER BY` to sort grouped results. You can sort by an aggregate alias.

```sql
SELECT category, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category
ORDER BY total_stock DESC;
```

### 5. Handling `NULL`

Most aggregate functions ignore `NULL` values. `COUNT(*)` is different because it counts rows regardless of column values. If a table has no rows, `COUNT(*)` returns `0`, while `SUM`, `AVG`, `MIN`, and `MAX` return `NULL`.

## General Syntax

```sql
SELECT group_column, AGGREGATE_FUNCTION(column_name)
FROM table_name
WHERE row_condition
GROUP BY group_column
HAVING group_condition
ORDER BY aggregate_result DESC;
```

Not every query needs all these clauses. Use only the clauses required by the task.

## Common Mistakes to Avoid

- Using `WHERE` to filter an aggregate result; use `HAVING` for group-level conditions.
- Selecting a normal column alongside an aggregate without including that column in `GROUP BY` or otherwise handling it.
- Confusing `COUNT(*)` with `COUNT(column)`.
- Assuming `AVG()` always returns an integer; PostgreSQL may return a numeric result with decimals.
- Forgetting that an aggregate query over an empty table can return `NULL` for functions such as `SUM()` and `AVG()`.

## Practice Questions and SQL Answers

## Q1. Count the total number of rows in the products table.

```sql
SELECT COUNT(*)
FROM products;
```

## Q2. Count the number of product names that are not NULL.

```sql
SELECT COUNT(name)
FROM products;
```

## Q3. Count the number of distinct categories in the products table.

```sql
SELECT COUNT(DISTINCT category) AS total_categories
FROM products;
```

## Q4. Find the total stock quantity of all products.

```sql
SELECT SUM(stock_quantity) AS total_stock
FROM products;
```

## Q5. Find the average price of all products.

```sql
SELECT AVG(price) AS average_price
FROM products;
```

## Q6. Find the minimum price in the products table.

```sql
SELECT MIN(price) AS minimum_price
FROM products;
```

## Q7. Find the maximum price in the products table.

```sql
SELECT MAX(price) AS maximum_price
FROM products;
```

## Q8. Display the total number of products in each category.

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category;
```

## Q9. Display the total stock quantity for each category.

```sql
SELECT category, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category;
```

## Q10. Display the average price of products in each category.

```sql
SELECT category, AVG(price) AS average_price
FROM products
GROUP BY category;
```

## Q11. Display the minimum and maximum price in each category.

```sql
SELECT category, MIN(price) AS minimum_price, MAX(price) AS maximum_price
FROM products
GROUP BY category;
```

## Q12. Display categories that have more than 5 products.

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category
HAVING COUNT(*) > 5;
```

## Q13. Display categories whose total stock quantity is greater than 100.

```sql
SELECT category, SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category
HAVING SUM(stock_quantity) > 100;
```

## Q14. Display categories whose average product price is greater than 1000.

```sql
SELECT category, AVG(price) AS average_price
FROM products
GROUP BY category
HAVING AVG(price) > 1000;
```

## Q15. Find the average price of products priced above 500 in each category, and show only categories whose average price is above 1000.

```sql
SELECT category, AVG(price) AS average_price
FROM products
WHERE price > 500
GROUP BY category
HAVING AVG(price) > 1000;
```

## Q16. Display the total number of products and average price for each category.

```sql
SELECT category, COUNT(*) AS total_products, AVG(price) AS average_price
FROM products
GROUP BY category;
```

## Q17. Find the name and price of the cheapest product in the entire table.

```sql
SELECT name, price
FROM products
WHERE price = (
    SELECT MIN(price)
    FROM products
);
```

## Q18. Find the name and price of the most expensive product in the entire table.

```sql
SELECT name, price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);
```

## Q19. Display the name, category, and price of the most expensive product in each category.

```sql
SELECT name, category, price
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category = p.category
);
```

## Q20. Display the category with its total stock and total number of products, sorted by total stock in descending order.

```sql
SELECT category, SUM(stock_quantity) AS total_stock, COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_stock DESC;
```

## Q21. Count products in each category, considering only products priced above 1000.

```sql
SELECT category, COUNT(*) AS total_products
FROM products
WHERE price > 1000
GROUP BY category;
```

## Q22. Find the total stock quantity for products that are available, grouped by category.

```sql
SELECT category, SUM(stock_quantity) AS total_stock
FROM products
WHERE is_available = TRUE
GROUP BY category;
```

## Q23. Display categories with at least 3 products and sort them by average price from highest to lowest.

```sql
SELECT category, COUNT(*) AS total_products, AVG(price) AS average_price
FROM products
GROUP BY category
HAVING COUNT(*) >= 3
ORDER BY average_price DESC;
```

## Q24. Display the total number of products, total stock quantity, average price, minimum price, and maximum price for the entire table.

```sql
SELECT
    COUNT(*) AS total_products,
    SUM(stock_quantity) AS total_stock,
    AVG(price) AS average_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM products;
```

## Quick Revision

- `COUNT` counts rows or non-`NULL` values.
- `SUM` adds numeric values.
- `AVG` calculates an average.
- `MIN` and `MAX` find the smallest and largest values.
- `GROUP BY` creates groups for aggregation.
- `WHERE` filters rows before grouping.
- `HAVING` filters groups after aggregation.
- `ORDER BY` sorts the final result.

## Placement Interview Questions

1. What is an aggregate function in SQL?
2. What is the difference between `COUNT(*)` and `COUNT(column)`?
3. What is the difference between `WHERE` and `HAVING`?
4. Why is `GROUP BY` used with aggregate functions?
5. How can you find the highest price in a table?
6. How can you count the number of unique categories?
7. How do aggregate functions handle `NULL` values?
"""
