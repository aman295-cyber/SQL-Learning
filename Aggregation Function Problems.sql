-- Operators and Aggregation Functions

--Q1.Display the name and price of the cheapest product in the entire table.

SELECT name,price FROM products
WHERE price =( SELECT MIN(price) FROM products);

--Q2.Find the average price of products that belong to the 'Home & Kitchen' or 'Fitness' category

SELECT AVG(price) AS "Average Price" FROM products
WHERE category IN ('Home & Kitchen','Fitness')
GROUP BY category;

--Q3. Show product names and stock quantity where the product is available, stock is more than 50, and price is not equal to ₹299.

SELECT name,stock_quantity FROM products
WHERE Is_Available = TRUE
AND stock_quantity > 50 
AND price <> 299;

--Q4. Find the most expensive product in each category (name and price)

SELECT name,category,price FROM products
p WHERE price=(SELECT MAX(price)
                FROM products 
                WHERE category = p.category);
-----------------------------------OR-----------------------------------------
SELECT category, MAX(price) AS max_price
FROM products
GROUP BY category;

--Q5. Show all unique categories in uppercase, sorted in descending order

SELECT DISTINCT UPPER (category) AS "category upper" FROM products
ORDER BY "category upper" DESC;



