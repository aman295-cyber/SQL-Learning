-- Aggregate Functions

-- Q1. Count the total number of rows in the products table.
SELECT COUNT(*) FROM products;

-- Q2. Count the number of product names that are not NULL.
SELECT COUNT(name) FROM products;

-- Q3. Count the number of distinct categories in the products table.
SELECT COUNT(DISTINCT category) AS total_categories FROM products;

-- Q4. Find the total stock quantity of all products.
SELECT SUM(stock_quantity) AS total_stock FROM products;

-- Q5. Find the average price of all products.
SELECT AVG(price) AS average_price FROM products;

-- Q6. Find the minimum price in the products table.
SELECT MIN(price) AS minimum_price FROM products;

-- Q7. Find the maximum price in the products table.
SELECT MAX(price) AS maximum_price FROM products;

-- Q8. Display the total number of products in each category.
SELECT category, COUNT(*) AS total_products FROM products
GROUP BY category;

-- Q9. Display the total stock quantity for each category.
SELECT category, SUM(stock_quantity) AS total_stock FROM products
GROUP BY category;

-- Q10. Display the average price of products in each category.
SELECT category, AVG(price) AS average_price FROM products
GROUP BY category;

-- Q11. Display the minimum and maximum price in each category.
SELECT category, MIN(price) AS minimum_price, MAX(price) AS maximum_price FROM products
GROUP BY category;

-- Q12. Display categories that have more than 5 products.
SELECT category, COUNT(*) AS total_products FROM products
GROUP BY category
HAVING COUNT(*) > 5;

-- Q13. Display categories whose total stock quantity is greater than 100.
SELECT category, SUM(stock_quantity) AS total_stock FROM products
GROUP BY category
HAVING SUM(stock_quantity) > 100;

-- Q14. Display categories whose average product price is greater than 1000.
SELECT category, AVG(price) AS average_price FROM products
GROUP BY category
HAVING AVG(price) > 1000;

-- Q15. Find the average price of products priced above 500 in each category, and show only categories whose average price is above 1000.
SELECT category, AVG(price) AS average_price FROM products
WHERE price > 500
GROUP BY category
HAVING AVG(price) > 1000;

-- Q16. Display the total number of products and average price for each category.
SELECT category, COUNT(*) AS total_products, AVG(price) AS average_price FROM products
GROUP BY category;

-- Q17. Find the name and price of the cheapest product in the entire table.
SELECT name, price FROM products
WHERE price = (SELECT MIN(price) FROM products);

-- Q18. Find the name and price of the most expensive product in the entire table.
SELECT name, price FROM products
WHERE price = (SELECT MAX(price) FROM products);

-- Q19. Display the name, category, and price of the most expensive product in each category.
SELECT name, category, price FROM products p
WHERE price = (SELECT MAX(price)
    FROM products
    WHERE category = p.category
);

-- Q20. Display the category with its total stock and total number of products, sorted by total stock in descending order.
SELECT category, SUM(stock_quantity) AS total_stock, COUNT(*) AS total_products FROM products
GROUP BY category
ORDER BY total_stock DESC;

-- Q21. Count products in each category, considering only products priced above 1000.
SELECT category, COUNT(*) AS total_products FROM products
WHERE price > 1000
GROUP BY category;

-- Q22. Find the total stock quantity for products that are available, grouped by category.
SELECT category, SUM(stock_quantity) AS total_stock FROM products
WHERE is_available = TRUE
GROUP BY category;

-- Q23. Display categories with at least 3 products and sort them by average price from highest to lowest.
SELECT category, COUNT(*) AS total_products, AVG(price) AS average_price FROM products
GROUP BY category
HAVING COUNT(*) >= 3
ORDER BY average_price DESC;

-- Q24. Display the total number of products, total stock quantity, average price, minimum price, and maximum price for the entire table.
SELECT
    COUNT(*) AS total_products,
    SUM(stock_quantity) AS total_stock,
    AVG(price) AS average_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM products;
