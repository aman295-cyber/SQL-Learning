# PostgreSQL String Functions — Practical Exercises

This document contains 35 SQL practice questions on PostgreSQL string functions, with solutions and explanations.

> **Note:** The table-based examples use a table named `products` with columns such as `name` and `category`. Example outputs are illustrative; actual results depend on the data in your table. If the table is empty, the queries will return no rows.

## 1. Convert a category to uppercase

**Question:** Write a query to display all product categories in uppercase.

```sql
SELECT UPPER(category)
FROM products;
```

**Explanation:** `UPPER()` converts text to uppercase.

## 2. Convert a category to lowercase

**Question:** Write a query to display all product categories in lowercase.

```sql
SELECT LOWER(category)
FROM products;
```

**Explanation:** `LOWER()` converts text to lowercase.

## 3. Find the length of each product name

**Question:** Display each product name and the number of characters in that name.

```sql
SELECT name, LENGTH(name)
FROM products;
```

**Explanation:** `LENGTH()` returns the number of characters in a string.

## 4. Remove leading and trailing spaces

**Question:** Remove leading and trailing spaces from the string `'  HELLO SQL  '`.

```sql
SELECT TRIM('  HELLO SQL  ');
```

**Expected output:**
```text
HELLO SQL
```

**Explanation:** `TRIM()` removes spaces from the beginning and end of a string.

## 5. Join two strings with a space

**Question:** Combine `'Aman'` and `'Kumar'` to produce `Aman Kumar`.

```sql
SELECT CONCAT('Aman', ' ', 'Kumar');
```

**Expected output:**
```text
Aman Kumar
```

**Explanation:** `CONCAT()` joins two or more strings. The middle `' '` adds a space between the words.

## 6. Replace text in a string

**Question:** Replace `Python` with `SQL` in the string `'I Love Python'`.

```sql
SELECT REPLACE('I Love Python', 'Python', 'SQL');
```

**Expected output:**
```text
I Love SQL
```

**Explanation:** `REPLACE(string, old_text, new_text)` replaces matching text.

## 7. Extract the first four characters

**Question:** Extract the first four characters from `'DATABASE'`.

```sql
SELECT SUBSTRING('DATABASE', 1, 4);
```

**Expected output:**
```text
DATA
```

**Explanation:** `SUBSTRING(string, start, length)` extracts a portion of a string. PostgreSQL positions start at 1.

## 8. Extract the first seven characters

**Question:** Extract the first seven characters from `'MACHINE LEARNING'`.

```sql
SELECT LEFT('MACHINE LEARNING', 7);
```

**Expected output:**
```text
MACHINE
```

**Explanation:** `LEFT(string, count)` returns the specified number of characters from the left.

## 9. Extract the last three characters

**Question:** Extract the last three characters from `'POSTGRESQL'`.

```sql
SELECT RIGHT('POSTGRESQL', 3);
```

**Expected output:**
```text
SQL
```

**Explanation:** `RIGHT(string, count)` returns the specified number of characters from the right.

## 10. Find the position of a substring

**Question:** Find the starting position of `'BASE'` in `'DATABASE'`.

```sql
SELECT POSITION('BASE' IN 'DATABASE');
```

**Expected output:**
```text
5
```

**Explanation:** `POSITION(substring IN string)` returns the starting position of the first match. It returns 0 if the substring is not found.

## 11. Capitalize the first letter of each word

**Question:** Capitalize the first letter of each word in `'machine learning engineer'`.

```sql
SELECT INITCAP('machine learning engineer');
```

**Expected output:**
```text
Machine Learning Engineer
```

**Explanation:** `INITCAP()` capitalizes the first letter of each word and converts the remaining letters to lowercase.

## 12. Join strings using a hyphen

**Question:** Join `'Python'`, `'SQL'`, and `'Machine Learning'` using a hyphen as the separator.

```sql
SELECT CONCAT_WS('-', 'Python', 'SQL', 'Machine Learning');
```

**Expected output:**
```text
Python-SQL-Machine Learning
```

**Explanation:** `CONCAT_WS(separator, value1, value2, ...)` joins values using the first argument as the separator.

## 13. Reverse a string

**Question:** Reverse the string `'DATABASE'`.

```sql
SELECT REVERSE('DATABASE');
```

**Expected output:**
```text
ESABATAD
```

**Explanation:** `REVERSE()` returns the characters in reverse order.

## 14. Repeat a string four times

**Question:** Repeat the string `'Hi '` four times.

```sql
SELECT REPEAT('Hi ', 4);
```

**Expected output:**
```text
Hi Hi Hi Hi 
```

**Explanation:** `REPEAT(string, count)` repeats a string the specified number of times. The example string contains a trailing space.

## 15. Pad a string on the left

**Question:** Make the string `'42'` five characters long by adding zeros on the left.

```sql
SELECT LPAD('42', 5, '0');
```

**Expected output:**
```text
00042
```

**Explanation:** `LPAD(string, length, fill)` pads a string on the left until it reaches the requested length.

## 16. Pad a string on the right

**Question:** Make the string `'AI'` five characters long by adding hyphens on the right.

```sql
SELECT RPAD('AI', 5, '-');
```

**Expected output:**
```text
AI---
```

**Explanation:** `RPAD(string, length, fill)` pads a string on the right until it reaches the requested length.

## 17. Choose the correct function to replace text

**Question:** Which function replaces `World` with `SQL` in `'Hello World'`?

**Answer:** `REPLACE()`

```sql
SELECT REPLACE('Hello World', 'World', 'SQL');
```

**Expected output:**
```text
Hello SQL
```

**Explanation:** `REPLACE()` substitutes matching text. `TRIM()` removes leading and trailing spaces, while `LENGTH()` counts characters.

## 18. Display the original and uppercase product names

**Question:** Display each product name and its uppercase version. Name the second output column `upper_case`.

```sql
SELECT name, UPPER(name) AS upper_case
FROM products;
```

**Explanation:** The query displays the original name and its uppercase version side by side.

## 19. Display each product name and its length

**Question:** Display each product name and its character count. Name the count column `name_length`.

```sql
SELECT name, LENGTH(name) AS name_length
FROM products;
```

**Explanation:** `AS` assigns an alias to the output column.

## 20. Combine a product name and category

**Question:** Combine each product's name and category in the format `Laptop - Electronics`. Name the output column `product_details`.

```sql
SELECT CONCAT(name, ' - ', category) AS product_details
FROM products;
```

**Explanation:** `CONCAT()` combines the name, a separator, and the category.

## 21. Replace a category name in the query output

**Question:** Replace `Electronics` with `Tech` in the `category` column and name the output column `updated_category`. Do not modify the stored data.

```sql
SELECT REPLACE(category, 'Electronics', 'Tech') AS updated_category
FROM products;
```

**Explanation:** This `SELECT` query changes only the displayed result, not the original table. In PostgreSQL, `REPLACE()` performs a case-sensitive match.

## 22. Format category names in title case

**Question:** Display each category in title case and name the output column `formatted_category`.

```sql
SELECT INITCAP(category) AS formatted_category
FROM products;
```

**Explanation:** `INITCAP()` capitalizes the first letter of each word.

## 23. Extract the first three characters of each product name

**Question:** Display the first three characters of each product name. Name the output column `short_name`.

```sql
SELECT LEFT(name, 3) AS short_name
FROM products;
```

**Explanation:** `LEFT()` extracts characters from the beginning of a string.

## 24. Extract the last three characters of each product name

**Question:** Display the last three characters of each product name. Name the output column `ending_chars`.

```sql
SELECT RIGHT(name, 3) AS ending_chars
FROM products;
```

**Explanation:** `RIGHT()` extracts characters from the end of a string.

## 25. Reverse each product name

**Question:** Reverse each product name and name the output column `reversed_name`.

```sql
SELECT REVERSE(name) AS reversed_name
FROM products;
```

**Explanation:** `REVERSE()` returns each name with its characters in reverse order.

## 26. Extract the first four characters of each product name

**Question:** Display the first four characters of every product name. Name the output column `short_name`.

```sql
SELECT SUBSTRING(name, 1, 4) AS short_name
FROM products;
```

**Explanation:** `SUBSTRING()` extracts four characters starting at position 1.

## 27. Find the position of lowercase 'a' in each product name

**Question:** Find the first position of the lowercase letter `a` in each product name. Name the output column `a_position`.

```sql
SELECT POSITION('a' IN name) AS a_position
FROM products;
```

**Explanation:** `POSITION()` returns the position of the first match, or 0 if lowercase `a` is not present. The search is case-sensitive.

## 28. Trim each product name

**Question:** Remove leading and trailing spaces from every product name and name the output column `clean_name`.

```sql
SELECT TRIM(name) AS clean_name
FROM products;
```

**Explanation:** `TRIM()` removes spaces at the start and end of each name.

## 29. Trim and lowercase each product name

**Question:** Remove leading and trailing spaces from each product name, convert it to lowercase, and name the output column `clean_lower_name`.

```sql
SELECT LOWER(TRIM(name)) AS clean_lower_name
FROM products;
```

**Explanation:** The inner `TRIM()` runs first, and the outer `LOWER()` converts the cleaned result to lowercase.

## 30. Combine product name and category with a spaced hyphen

**Question:** Join each product name and category using ` - ` as the separator. Name the output column `product_info`.

```sql
SELECT CONCAT_WS(' - ', name, category) AS product_info
FROM products;
```

**Explanation:** `CONCAT_WS()` inserts the specified separator between the supplied values.

## 31. Repeat each product name twice

**Question:** Repeat every product name twice and name the output column `repeated_name`.

```sql
SELECT REPEAT(name, 2) AS repeated_name
FROM products;
```

**Explanation:** `REPEAT()` repeats the product name two times.

## 32. Pad each product name on the left to length 10

**Question:** Make each product name a total of 10 characters long by adding `*` characters on the left. Name the output column `padded_name`.

```sql
SELECT LPAD(name, 10, '*') AS padded_name
FROM products;
```

**Explanation:** `LPAD()` adds padding on the left. If a name is already longer than the target length, PostgreSQL truncates the result to the requested length.

## 33. Pad each product name on the right to length 10

**Question:** Make each product name a total of 10 characters long by adding hyphens on the right. Name the output column `padded_name`.

```sql
SELECT RPAD(name, 10, '-') AS padded_name
FROM products;
```

**Explanation:** `RPAD()` adds padding on the right. If a name is already longer than the target length, PostgreSQL truncates the result to the requested length.

## 34. Trim and uppercase each product name

**Question:** Remove leading and trailing spaces from each product name, convert the result to uppercase, and name the output column `clean_product_name`.

```sql
SELECT UPPER(TRIM(name)) AS clean_product_name
FROM products;
```

**Explanation:** `TRIM()` removes outer spaces first; `UPPER()` then converts the cleaned name to uppercase.

## 35. Display uppercase product names and lowercase categories

**Question:** Display each product name in uppercase as `product_name` and each category in lowercase as `product_category`.

```sql
SELECT
    UPPER(name) AS product_name,
    LOWER(category) AS product_category
FROM products;
```

**Explanation:** `UPPER()` and `LOWER()` transform the two columns independently. The original table data remains unchanged.

---

## Quick Revision

| Function | Purpose |
|---|---|
| `UPPER()` | Convert text to uppercase |
| `LOWER()` | Convert text to lowercase |
| `LENGTH()` | Count characters |
| `TRIM()` | Remove leading and trailing spaces |
| `CONCAT()` | Join strings |
| `REPLACE()` | Replace matching text |
| `SUBSTRING()` | Extract part of a string |
| `LEFT()` | Extract characters from the left |
| `RIGHT()` | Extract characters from the right |
| `POSITION()` | Find the position of a substring |
| `INITCAP()` | Capitalize the first letter of each word |
| `CONCAT_WS()` | Join strings using a separator |
| `REVERSE()` | Reverse a string |
| `REPEAT()` | Repeat a string |
| `LPAD()` | Pad on the left |
| `RPAD()` | Pad on the right |


Save this file as `String_Functions.md` in your SQL learning repository, then commit and push it to GitHub.
