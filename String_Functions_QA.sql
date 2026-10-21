-- String Functions

-- Q1. Display all product categories in uppercase.
SELECT UPPER(category)
FROM products;

-- Q2. Display all product categories in lowercase.
SELECT LOWER(category)
FROM products;

-- Q3. Display each product name and the number of characters in that name.
SELECT name, LENGTH(name)
FROM products;

-- Q4. Remove the leading and trailing spaces from the string '  HELLO SQL  '.
SELECT TRIM('  HELLO SQL  ');

-- Q5. Combine 'Aman' and 'Kumar' with a space between them.
SELECT CONCAT('Aman', ' ', 'Kumar');

-- Q6. Replace 'Python' with 'SQL' in the string 'I Love Python'.
SELECT REPLACE('I Love Python', 'Python', 'SQL');

-- Q7. Extract the first four characters from the string 'DATABASE'.
SELECT SUBSTRING('DATABASE', 1, 4);

-- Q8. Extract the first seven characters from the string 'MACHINE LEARNING'.
SELECT LEFT('MACHINE LEARNING', 7);

-- Q9. Extract the last three characters from the string 'POSTGRESQL'.
SELECT RIGHT('POSTGRESQL', 3);

-- Q10. Find the starting position of 'BASE' in the string 'DATABASE'.
SELECT POSITION('BASE' IN 'DATABASE');

-- Q11. Capitalize the first letter of each word in 'machine learning engineer'.
SELECT INITCAP('machine learning engineer');

-- Q12. Join 'Python', 'SQL', and 'Machine Learning' using a hyphen as the separator.
SELECT CONCAT_WS('-', 'Python', 'SQL', 'Machine Learning');

-- Q13. Reverse the string 'DATABASE'.
SELECT REVERSE('DATABASE');

-- Q14. Repeat the string 'Hi ' four times.
SELECT REPEAT('Hi ', 4);

-- Q15. Make the string '42' five characters long by adding zeros on the left.
SELECT LPAD('42', 5, '0');

-- Q16. Make the string 'AI' five characters long by adding hyphens on the right.
SELECT RPAD('AI', 5, '-');

-- Q17. Replace 'World' with 'SQL' in the string 'Hello World'.
SELECT REPLACE('Hello World', 'World', 'SQL');

-- Q18. Display each product name and its uppercase version as upper_case.
SELECT name, UPPER(name) AS upper_case
FROM products;

-- Q19. Display each product name and its character count as name_length.
SELECT name, LENGTH(name) AS name_length
FROM products;

-- Q20. Combine each product name and category in the format 'Laptop - Electronics' as product_details.
SELECT CONCAT(name, ' - ', category) AS product_details
FROM products;

-- Q21. Replace 'Electronics' with 'Tech' in the category column and name the output column updated_category.
SELECT REPLACE(category, 'Electronics', 'Tech') AS updated_category
FROM products;

-- Q22. Display each category in title case as formatted_category.
SELECT INITCAP(category) AS formatted_category
FROM products;

-- Q23. Display the first three characters of each product name as short_name.
SELECT LEFT(name, 3) AS short_name
FROM products;

-- Q24. Display the last three characters of each product name as ending_chars.
SELECT RIGHT(name, 3) AS ending_chars
FROM products;

-- Q25. Reverse each product name and name the output column reversed_name.
SELECT REVERSE(name) AS reversed_name
FROM products;

-- Q26. Display the first four characters of each product name as short_name.
SELECT SUBSTRING(name, 1, 4) AS short_name
FROM products;

-- Q27. Find the position of the first lowercase 'a' in each product name as a_position.
SELECT POSITION('a' IN name) AS a_position
FROM products;

-- Q28. Remove leading and trailing spaces from each product name and name the output column clean_name.
SELECT TRIM(name) AS clean_name
FROM products;

-- Q29. Remove leading and trailing spaces from each product name, convert it to lowercase, and name the output column clean_lower_name.
SELECT LOWER(TRIM(name)) AS clean_lower_name
FROM products;

-- Q30. Join each product name and category using ' - ' as the separator and name the output column product_info.
SELECT CONCAT_WS(' - ', name, category) AS product_info
FROM products;

-- Q31. Repeat each product name twice and name the output column repeated_name.
SELECT REPEAT(name, 2) AS repeated_name
FROM products;

-- Q32. Make each product name 10 characters long by adding '*' characters on the left. Name the output column padded_name.
SELECT LPAD(name, 10, '*') AS padded_name
FROM products;

-- Q33. Make each product name 10 characters long by adding '-' characters on the right. Name the output column padded_name.
SELECT RPAD(name, 10, '-') AS padded_name
FROM products;

-- Q34. Remove leading and trailing spaces from each product name, convert it to uppercase, and name the output column clean_product_name.
SELECT UPPER(TRIM(name)) AS clean_product_name
FROM products;

-- Q35. Display each product name in uppercase as product_name and each category in lowercase as product_category.
SELECT
    UPPER(name) AS product_name,
    LOWER(category) AS product_category
FROM products;
