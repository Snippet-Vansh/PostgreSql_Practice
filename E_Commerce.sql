-- Create database
CREATE DATABASE ecommerce_db;

-- Switch to the database
\c ecommerce_db;

-- =========================
-- 1. Customers Table
-- =========================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 2. Products Table
-- =========================
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    stock INT
);

-- =========================
-- 3. Orders Table
-- =========================
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Pending'
);

-- =========================
-- 4. Order_Items Table (Many-to-Many)
-- =========================
CREATE TABLE order_items (
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

-- =========================
-- Insert Sample Data
-- =========================
INSERT INTO customers (first_name, last_name, email, phone)
VALUES
('Amit', 'Sharma', 'amit.sharma@example.com', '9876543210'),
('Priya', 'Patel', 'priya.patel@example.com', '9123456780');

INSERT INTO products (product_name, category, price, stock)
VALUES
('Laptop', 'Electronics', 55000, 10),
('Smartphone', 'Electronics', 25000, 20),
('Office Chair', 'Furniture', 7000, 15);

INSERT INTO orders (customer_id, status)
VALUES
(1, 'Completed'),
(2, 'Pending');

INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 1),  -- Amit bought 1 Laptop
(1, 3, 2),  -- Amit bought 2 Chairs
(2, 2, 1);  -- Priya ordered 1 Smartphone

-- =========================
-- Queries
-- =========================

-- 1. List all customers with their orders
SELECT c.first_name, c.last_name, o.order_id, o.status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- 2. Show order details with products
SELECT o.order_id, c.first_name, p.product_name, oi.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- 3. Total sales revenue
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 4. Products low in stock (< 10)
SELECT product_name, stock
FROM products
WHERE stock < 10;

-- 5. Pending orders
SELECT order_id, customer_id, status
FROM orders
WHERE status = 'Pending';
