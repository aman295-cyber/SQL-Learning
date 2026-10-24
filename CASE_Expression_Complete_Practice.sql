-- PostgreSQL CASE Expression Practice
-- Flipkart products table
-- Questions are written in English with their SQL answers.
-- Run ALTER TABLE statements only if the columns do not already exist.
-- Assumes products has: name, price, stock_quantity, is_available.

-- Question 1: Display each product's name, price, and price tag.
-- price > 1000 = EXPENSIVE; 500 through 1000 = MODERATE; otherwise CHEAP.
SELECT name, price,
       CASE
           WHEN price > 1000 THEN 'EXPENSIVE'
           WHEN price BETWEEN 500 AND 1000 THEN 'MODERATE'
           ELSE 'CHEAP'
       END AS price_tag
FROM products;

-- Question 2: Add price_tag and store the price category for every product.
ALTER TABLE products ADD COLUMN price_tag TEXT;

UPDATE products
SET price_tag = CASE
    WHEN price > 1000 THEN 'EXPENSIVE'
    WHEN price BETWEEN 500 AND 1000 THEN 'MODERATE'
    ELSE 'CHEAP'
END;

-- Question 3: Display each product's name and availability status.
-- TRUE = IN STOCK; otherwise = OUT OF STOCK.
SELECT name,
       CASE
           WHEN is_available = TRUE THEN 'IN STOCK'
           ELSE 'OUT OF STOCK'
       END AS availability_status
FROM products;

-- Question 4: Display each product's name, stock quantity, and stock level.
-- 100 or more = HIGH STOCK; 30 or more = MEDIUM STOCK; otherwise LOW STOCK.
SELECT name, stock_quantity,
       CASE
           WHEN stock_quantity >= 100 THEN 'HIGH STOCK'
           WHEN stock_quantity >= 30 THEN 'MEDIUM STOCK'
           ELSE 'LOW STOCK'
       END AS stock_level
FROM products;

-- Question 5: Count products in each stored price_tag category.
SELECT price_tag, COUNT(*) AS total_products
FROM products
GROUP BY price_tag;

-- Question 6: Display product names with their availability status using CASE.
SELECT name,
       CASE
           WHEN is_available THEN 'IN STOCK'
           ELSE 'OUT OF STOCK'
       END AS availability_status
FROM products;

-- Question 7: Update the stored price_tag for every product using its price.
UPDATE products
SET price_tag = CASE
    WHEN price > 1000 THEN 'EXPENSIVE'
    WHEN price BETWEEN 500 AND 1000 THEN 'MODERATE'
    ELSE 'CHEAP'
END;

-- Question 8: Add stock_status and store each product's stock category.
ALTER TABLE products ADD COLUMN stock_status TEXT;

UPDATE products
SET stock_status = CASE
    WHEN stock_quantity >= 100 THEN 'HIGH STOCK'
    WHEN stock_quantity >= 30 THEN 'MEDIUM STOCK'
    ELSE 'LOW STOCK'
END;

-- Question 9: Count products in each stored stock_status category.
SELECT stock_status, COUNT(*) AS total_products
FROM products
GROUP BY stock_status;

-- Additional practice: Create stock categories with CASE and count products in each.
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

-- Question 10: Display name, price, and price_category.
-- price > 1000 and stock > 50 = PREMIUM AVAILABLE;
-- other products with price > 1000 = PREMIUM LOW STOCK; otherwise REGULAR.
SELECT name, price, stock_quantity,
       CASE
           WHEN price > 1000 AND stock_quantity > 50 THEN 'PREMIUM AVAILABLE'
           WHEN price > 1000 THEN 'PREMIUM LOW STOCK'
           ELSE 'REGULAR'
       END AS price_category
FROM products;

-- Question 11: Display product details, sorting available products first.
SELECT name, price, is_available
FROM products
ORDER BY CASE
    WHEN is_available = TRUE THEN 1
    ELSE 2
END;

-- Question 12: Display name, price, stock quantity, and product_status.
-- Available and stock > 50 = READY TO SELL;
-- available and stock <= 50 = RESTOCK SOON; otherwise UNAVAILABLE.
SELECT name, price, stock_quantity,
       CASE
           WHEN is_available = TRUE AND stock_quantity > 50 THEN 'READY TO SELL'
           WHEN is_available = TRUE AND stock_quantity <= 50 THEN 'RESTOCK SOON'
           ELSE 'UNAVAILABLE'
       END AS product_status
FROM products;

-- Optional verification: View all columns and rows in the products table.
SELECT * FROM products;
