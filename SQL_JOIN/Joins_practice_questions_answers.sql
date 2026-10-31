-- SQL JOINs Practical Practice
-- Dataset: products and orders
-- Database: PostgreSQL
--
-- Note:
-- These queries assume the `products` and `orders` tables already exist
-- and contain data. Run each question separately if desired.
--
-- Tables used:
-- products(product_id, product_name, category, price, stock_quantity,
--          is_available, added_on)
-- orders(order_id, product_id, quantity, order_date, customer_name,
--        payment_method)

-- Question 1: Show each order with its product name, price, order ID, and customer name.

SELECT p.product_name, p.price, o.order_id, o.customer_name
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id;


-- Question 2: Show all products, including products that have never been ordered.

SELECT p.product_name, o.order_id
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id;


-- Question 3: Show orders for products in the Electronics category.

SELECT p.product_name, o.order_id, p.category
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
WHERE p.category = 'Electronics';


-- Question 4: List all orders, sorted by product price from highest to lowest.

SELECT p.product_name, o.order_id, p.price
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
ORDER BY p.price DESC;


-- Question 5: Show the number of orders placed for each product.
-- LEFT JOIN includes products with no orders; COUNT(order_id) returns 0 for them.

SELECT p.product_id, p.product_name,
       COUNT(o.order_id) AS total_orders
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name;


-- Question 6: Calculate total revenue for each product.
-- Revenue per order line = quantity * product price.

SELECT p.product_id, p.product_name,
       SUM(o.quantity * p.price) AS revenue
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name;


-- Question 7: Show products whose total order revenue is greater than 2000.

SELECT p.product_id, p.product_name,
       SUM(o.quantity * p.price) AS revenue
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(o.quantity * p.price) > 2000;


-- Question 8: Show unique customers who ordered products in the Fitness category.

SELECT DISTINCT o.customer_name
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
WHERE p.category = 'Fitness';


-- Question 9: Show products that have never been ordered.

SELECT p.product_name, o.order_id, p.price
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL;


-- Question 10: Show each customer's total number of orders.

SELECT o.customer_name,
       COUNT(o.order_id) AS total_orders
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
GROUP BY o.customer_name;


-- Question 11: Show products that have been ordered more than once.

SELECT p.product_id, p.product_name,
       COUNT(o.order_id) AS total_orders
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(o.order_id) > 1;


-- Question 12: Calculate total revenue for each product category.

SELECT p.category,
       SUM(o.quantity * p.price) AS total_revenue
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.category;


-- Question 13: Show products whose total ordered quantity is greater than 10.

SELECT p.product_name, p.category,
       SUM(o.quantity) AS total_ordered
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category
HAVING SUM(o.quantity) > 10;


-- Question 14: Show all products and their order IDs, including products with no orders Sort product names in ascending order.

SELECT p.product_name, o.order_id
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id
ORDER BY p.product_name ASC;


-- Question 15: Show products that have never been ordered, sorted by price from lowest to highest.

SELECT p.product_name, p.price
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL
ORDER BY p.price ASC;
