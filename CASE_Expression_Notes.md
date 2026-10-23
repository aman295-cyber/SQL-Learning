# PostgreSQL CASE Expression

## 1. What is CASE?

The `CASE` expression returns a result based on one or more conditions. It works similarly to `IF / ELSE` logic in programming.

### General Syntax

```sql
SELECT column_name,
       CASE
           WHEN condition_1 THEN result_1
           WHEN condition_2 THEN result_2
           ELSE default_result
       END AS new_column_name
FROM table_name;
```

### Main Keywords

- `CASE`: Starts the conditional expression.
- `WHEN`: Specifies a condition to check.
- `THEN`: Returns a result when the condition is true.
- `ELSE`: Returns a fallback result when no `WHEN` condition matches. It is optional.
- `END`: Closes the `CASE` expression.
- `AS`: Assigns an alias to the result column.

If no condition matches and `ELSE` is omitted, the result is `NULL`.

## 2. Types of CASE

### Searched CASE

Each `WHEN` contains a condition.

```sql
CASE
    WHEN price > 1000 THEN 'EXPENSIVE'
    WHEN price >= 500 THEN 'MODERATE'
    ELSE 'CHEAP'
END
```

### Simple CASE

One expression is compared against different values.

```sql
CASE department
    WHEN 'IT' THEN 'Technology'
    WHEN 'HR' THEN 'Human Resources'
    WHEN 'Finance' THEN 'Finance Team'
    ELSE 'Other Department'
END
```

## 3. Important Rules

1. Conditions are checked from top to bottom.
2. The result for the first matching `WHEN` is returned.
3. `ELSE` is optional; without a matching condition or `ELSE`, the result is `NULL`.
4. Result expressions should have compatible data types.
5. `CASE` can be used in queries such as `SELECT`, `ORDER BY`, and `UPDATE`.
6. `SELECT ... CASE` displays a calculated result without storing it in the table.
7. `UPDATE ... SET column = CASE ... END` stores the calculated result in the table.
8. When using `CASE` for grouping, group by the same `CASE` expression or by a previously stored category column.

## 4. Practical Examples

These examples assume a PostgreSQL `products` table with columns `name`, `price`, `stock_quantity`, and `is_available`.

### Example 1: Create a Price Tag in SELECT

**Question:** Display each product's name, price, and price tag. Prices above 1000 are `EXPENSIVE`, prices from 500 through 1000 are `MODERATE`, and lower prices are `CHEAP`.

```sql
SELECT name, price,
       CASE
           WHEN price > 1000 THEN 'EXPENSIVE'
           WHEN price BETWEEN 500 AND 1000 THEN 'MODERATE'
           ELSE 'CHEAP'
       END AS price_tag
FROM products;
```

### Example 2: Add and Update a Price Tag Column

**Question:** Add a `price_tag` column and store each product's price category.

```sql
ALTER TABLE products
ADD COLUMN price_tag TEXT;

UPDATE products
SET price_tag = CASE
    WHEN price > 1000 THEN 'EXPENSIVE'
    WHEN price BETWEEN 500 AND 1000 THEN 'MODERATE'
    ELSE 'CHEAP'
END;
```

> Run `ADD COLUMN` only if the column does not already exist.

### Example 3: Availability Status

**Question:** Display each product's name and availability status. A true value means `IN STOCK`; otherwise, display `OUT OF STOCK`.

```sql
SELECT name,
       CASE
           WHEN is_available = TRUE THEN 'IN STOCK'
           ELSE 'OUT OF STOCK'
       END AS availability_status
FROM products;
```

### Example 4: Stock Level

**Question:** Display each product's name, stock quantity, and stock level. At least 100 units means `HIGH STOCK`; at least 30 means `MEDIUM STOCK`; otherwise, `LOW STOCK`.

```sql
SELECT name, stock_quantity,
       CASE
           WHEN stock_quantity >= 100 THEN 'HIGH STOCK'
           WHEN stock_quantity >= 30 THEN 'MEDIUM STOCK'
           ELSE 'LOW STOCK'
       END AS stock_level
FROM products;
```

### Example 5: Count Products by Price Tag

**Question:** Count how many products belong to each stored price tag category.

```sql
SELECT price_tag, COUNT(*) AS total_products
FROM products
GROUP BY price_tag;
```

### Example 6: Update the Stored Price Tag

**Question:** Update the `price_tag` column for every product based on its price.

```sql
UPDATE products
SET price_tag = CASE
    WHEN price > 1000 THEN 'EXPENSIVE'
    WHEN price BETWEEN 500 AND 1000 THEN 'MODERATE'
    ELSE 'CHEAP'
END;
```

### Example 7: Add and Update Stock Status

**Question:** Add a `stock_status` column and store a category based on stock quantity.

```sql
ALTER TABLE products
ADD COLUMN stock_status TEXT;

UPDATE products
SET stock_status = CASE
    WHEN stock_quantity >= 100 THEN 'HIGH STOCK'
    WHEN stock_quantity >= 30 THEN 'MEDIUM STOCK'
    ELSE 'LOW STOCK'
END;
```

> Run `ADD COLUMN` only if the column does not already exist.

### Example 8: Count Products by Stock Status

**Question:** Count the products in each stored stock status category.

```sql
SELECT stock_status, COUNT(*) AS total_products
FROM products
GROUP BY stock_status;
```

### Example 9: Create and Count Stock Categories with CASE

**Question:** Create stock categories using `CASE` and count the products in each category.

```sql
SELECT
    CASE
        WHEN stock_quantity >= 100 THEN 'HIGH STOCK'
        WHEN stock_quantity >= 30 THEN 'MEDIUM STOCK'
        ELSE 'LOW STOCK'
    END AS stock_level,
    COUNT(*) AS total_products
FROM products
GROUP BY
    CASE
        WHEN stock_quantity >= 100 THEN 'HIGH STOCK'
        WHEN stock_quantity >= 30 THEN 'MEDIUM STOCK'
        ELSE 'LOW STOCK'
    END;
```

### Example 10: Multiple Conditions with AND

**Question:** Display each product's name, price, and category. A price above 1000 with stock above 50 is `PREMIUM AVAILABLE`; any other product priced above 1000 is `PREMIUM LOW STOCK`; all others are `REGULAR`.

```sql
SELECT name, price, stock_quantity,
       CASE
           WHEN price > 1000 AND stock_quantity > 50 THEN 'PREMIUM AVAILABLE'
           WHEN price > 1000 THEN 'PREMIUM LOW STOCK'
           ELSE 'REGULAR'
       END AS price_category
FROM products;
```

### Example 11: Sort Available Products First

**Question:** Display product name, price, and availability, sorting available products before unavailable products.

```sql
SELECT name, price, is_available
FROM products
ORDER BY CASE
    WHEN is_available = TRUE THEN 1
    ELSE 2
END;
```

### Example 12: Product Status Report

**Question:** Display each product's name, price, stock quantity, and status. An available product with stock above 50 is `READY TO SELL`; an available product with stock of 50 or less is `RESTOCK SOON`; otherwise, it is `UNAVAILABLE`.

```sql
SELECT name, price, stock_quantity,
       CASE
           WHEN is_available = TRUE AND stock_quantity > 50 THEN 'READY TO SELL'
           WHEN is_available = TRUE AND stock_quantity <= 50 THEN 'RESTOCK SOON'
           ELSE 'UNAVAILABLE'
       END AS product_status
FROM products;
```

## 5. Placement Interview Questions and Answers

### Q1. What is CASE in SQL?

`CASE` is a conditional expression that returns a result based on specified conditions.

### Q2. What is the difference between CASE and WHERE?

`WHERE` filters rows based on a condition. `CASE` returns different values based on conditions.

### Q3. Is ELSE mandatory in CASE?

No. If no condition matches and `ELSE` is omitted, `CASE` returns `NULL`.

### Q4. What happens when multiple WHEN conditions are true?

The result for the first matching `WHEN` condition is returned.

### Q5. What is the difference between simple CASE and searched CASE?

Simple `CASE` compares one expression against specified values. Searched `CASE` evaluates separate conditions.

### Q6. Can CASE be used in UPDATE?

Yes. `CASE` can assign different values to a column based on conditions within an `UPDATE` statement.

### Q7. Does CASE create a permanent column?

No. `CASE` alone does not create a column. Use `ALTER TABLE` to add a column and `UPDATE` to store values in it.

### Q8. Can CASE be used in ORDER BY?

Yes. `CASE` can assign sort priorities to rows, allowing custom ordering.

### Q9. Why does the order of WHEN conditions matter?

Conditions are evaluated from top to bottom. The first matching condition determines the result.

### Q10. Can CASE be used with GROUP BY?

Yes. You can group by a `CASE` expression or by a stored category column generated earlier.

## 6. Key Takeaway

Use `CASE` when you need conditional labels, classifications, or values in SQL. Use it in `SELECT` to display calculated results, in `UPDATE` to store calculated values, and in `ORDER BY` to apply custom sorting.
