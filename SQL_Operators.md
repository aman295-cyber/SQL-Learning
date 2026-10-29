# SQL Operators — Revision Notes

**Database:** PostgreSQL

SQL operators are used to compare values, combine conditions, perform calculations, and test whether values match a pattern or belong to a set.

Examples below use a table named `products` with columns such as `product_name`, `category`, `price`, and `stock`.

## 1. Arithmetic Operators

| Operator | Meaning | Example |
|---|---|---|
| `+` | Addition | `price + 100` |
| `-` | Subtraction | `price - 50` |
| `*` | Multiplication | `price * 2` |
| `/` | Division | `price / 2` |
| `%` | Remainder (modulo) | `stock % 2` |

```sql
SELECT product_name, price, price * 1.18 AS price_with_tax
FROM products;
```

## 2. Comparison Operators

| Operator | Meaning |
|---|---|
| `=` | Equal to |
| `<>` or `!=` | Not equal to |
| `>` | Greater than |
| `<` | Less than |
| `>=` | Greater than or equal to |
| `<=` | Less than or equal to |

```sql
SELECT *
FROM products
WHERE price >= 1000;
```

## 3. Logical Operators

### AND
All conditions must be true.
```sql
SELECT *
FROM products
WHERE price > 500 AND stock > 0;
```

### OR
At least one condition must be true.
```sql
SELECT *
FROM products
WHERE category = 'Electronics' OR category = 'Accessories';
```

### NOT
Negates a condition.
```sql
SELECT *
FROM products
WHERE NOT category = 'Electronics';
```

Use parentheses when combining multiple conditions to make the intended logic clear:
```sql
SELECT *
FROM products
WHERE (category = 'Electronics' OR category = 'Accessories')
  AND stock > 0;
```

## 4. BETWEEN

Checks whether a value is within an inclusive range.

```sql
SELECT *
FROM products
WHERE price BETWEEN 500 AND 1000;
```

`BETWEEN 500 AND 1000` includes both 500 and 1000.

Equivalent range condition:
```sql
SELECT *
FROM products
WHERE price >= 500 AND price <= 1000;
```

## 5. IN

Checks whether a value matches any value in a list.

```sql
SELECT *
FROM products
WHERE category IN ('Electronics', 'Accessories', 'Books');
```

Equivalent simple form:
```sql
SELECT *
FROM products
WHERE category = 'Electronics'
   OR category = 'Accessories'
   OR category = 'Books';
```

## 6. LIKE and ILIKE

`LIKE` performs pattern matching and is case-sensitive in PostgreSQL for ordinary text comparisons. `ILIKE` is PostgreSQL's case-insensitive pattern-matching operator.

| Pattern | Meaning |
|---|---|
| `'A%'` | Starts with A |
| `'%a'` | Ends with a |
| `'%phone%'` | Contains phone |
| `'_a%'` | Second character is a |

```sql
-- Product names starting with 'S'
SELECT *
FROM products
WHERE product_name LIKE 'S%';

-- Case-insensitive search for names containing 'phone'
SELECT *
FROM products
WHERE product_name ILIKE '%phone%';
```

`%` matches zero or more characters. `_` matches exactly one character.

## 7. IS NULL and IS NOT NULL

Use these to test for missing (`NULL`) values. Do not use `= NULL` or `<> NULL`.

```sql
SELECT *
FROM products
WHERE category IS NULL;
```

```sql
SELECT *
FROM products
WHERE category IS NOT NULL;
```

## 8. Concatenation Operator

In PostgreSQL, `||` concatenates strings.

```sql
SELECT product_name || ' - ' || category AS product_details
FROM products;
```

If a component is `NULL`, the concatenated result can become `NULL`. `CONCAT()` is another option that treats `NULL` arguments as empty strings.

## 9. EXISTS

Tests whether a subquery returns at least one row.

```sql
SELECT d.department_id, d.department_name
FROM departments AS d
WHERE EXISTS (
    SELECT 1
    FROM employees AS e
    WHERE e.department_id = d.department_id
);
```

## 10. ANY and ALL

These compare a value with results returned by a subquery.

```sql
-- Price is greater than at least one price in the subquery
SELECT *
FROM products
WHERE price > ANY (
    SELECT price
    FROM products
    WHERE category = 'Books'
);
```

```sql
-- Price is greater than every price in the subquery
SELECT *
FROM products
WHERE price > ALL (
    SELECT price
    FROM products
    WHERE category = 'Books'
);
```

## 11. Set Operators

Set operators combine the results of compatible `SELECT` statements.

### UNION
Combines results and removes duplicate rows.
```sql
SELECT city FROM customers
UNION
SELECT city FROM suppliers;
```

### UNION ALL
Combines results and retains duplicates.
```sql
SELECT city FROM customers
UNION ALL
SELECT city FROM suppliers;
```

### INTERSECT
Returns rows common to both results.
```sql
SELECT city FROM customers
INTERSECT
SELECT city FROM suppliers;
```

### EXCEPT
Returns rows from the first result that are absent from the second.
```sql
SELECT city FROM customers
EXCEPT
SELECT city FROM suppliers;
```

The corresponding `SELECT` statements must return the same number of columns with compatible data types.

## 12. Operator Precedence — Practical Reminder

Arithmetic operations are evaluated before comparisons; `NOT` is evaluated before `AND`, and `AND` before `OR`. Use parentheses rather than relying on memory when a condition is complex.

```sql
SELECT *
FROM products
WHERE (category = 'Books' OR category = 'Electronics')
  AND price < 2000;
```

## 13. Quick Revision

- Arithmetic: `+`, `-`, `*`, `/`, `%`
- Comparison: `=`, `<>`, `!=`, `>`, `<`, `>=`, `<=`
- Logical: `AND`, `OR`, `NOT`
- Range: `BETWEEN`
- List membership: `IN`
- Pattern matching: `LIKE`, `ILIKE`
- NULL checks: `IS NULL`, `IS NOT NULL`
- String concatenation in PostgreSQL: `||`
- Subquery tests: `EXISTS`, `ANY`, `ALL`
- Set operators: `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`
