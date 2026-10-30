-- SQL JOINs Practice Questions
-- PostgreSQL

-- ============================================================
--            DATASET SETUP
-- ============================================================

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category TEXT,
    price NUMERIC(10,2),
    stock_quantity INT,
    is_available BOOLEAN,
    added_on DATE
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    customer_name VARCHAR(50),
    payment_method VARCHAR(50),
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES products(product_id) ON DELETE CASCADE
);

-- Sample data inserts below are intended for a fresh/empty set of these tables.
-- If these IDs already exist in your tables, skip the INSERT statements.

INSERT INTO products
    (product_id, product_name, category, price, stock_quantity, is_available, added_on)
VALUES
    (1, 'Wireless Mouse', 'Electronics', 799.00, 50, TRUE,  '2026-01-10'),
    (2, 'Bluetooth Headphones', 'Electronics', 2499.00, 25, TRUE, '2026-01-12'),
    (3, 'Yoga Mat', 'Fitness', 899.00, 40, TRUE, '2026-01-15'),
    (4, 'Dumbbell Set', 'Fitness', 1799.00, 8, TRUE, '2026-01-18'),
    (5, 'Coffee Mug', 'Home', 299.00, 100, TRUE, '2026-01-20'),
    (6, 'Desk Lamp', 'Home', 1299.00, 0, FALSE, '2026-01-22'),
    (7, 'USB-C Hub', 'Electronics', 1599.00, 15, TRUE, '2026-01-25'),
    (8, 'Skipping Rope', 'Fitness', 399.00, 60, TRUE, '2026-01-27');

INSERT INTO orders
    (order_id, product_id, quantity, order_date, customer_name, payment_method)
VALUES
    (101, 1, 2,  '2026-02-01', 'Aarav Sharma', 'UPI'),
    (102, 2, 1,  '2026-02-02', 'Diya Verma', 'Card'),
    (103, 3, 3,  '2026-02-03', 'Aarav Sharma', 'UPI'),
    (104, 1, 4,  '2026-02-04', 'Kabir Singh', 'Cash'),
    (105, 4, 2,  '2026-02-05', 'Diya Verma', 'Card'),
    (106, 3, 5,  '2026-02-06', 'Meera Patel', 'UPI'),
    (107, 7, 2,  '2026-02-07', 'Kabir Singh', 'Card'),
    (108, 2, 1,  '2026-02-08', 'Aarav Sharma', 'UPI'),
    (109, 8, 6,  '2026-02-09', 'Meera Patel', 'Cash'),
    (110, 5, 4,  '2026-02-10', 'Diya Verma', 'UPI'),
    (111, 1, 1,  '2026-02-11', 'Meera Patel', 'Card'),
    (112, 4, 3,  '2026-02-12', 'Kabir Singh', 'UPI');

-- Inspect the data.
SELECT * FROM products ORDER BY product_id;
SELECT * FROM orders ORDER BY order_id;


-- ============================================================
--              QUESTION- ANSWER PRACTICES
-- ============================================================

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
