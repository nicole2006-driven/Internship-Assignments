CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers
(customer_id, customer_name, city)
VALUES
(1, 'Aarav', 'Mumbai'),
(2, 'Priya', 'Pune'),
(3, 'Rahul', 'Delhi'),
(4, 'Sneha', 'Mumbai'),
(5, 'Rohan', 'Bangalore');

SELECT * FROM customers;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products
(product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mouse', 'Accessories', 800),
(103, 'Keyboard', 'Accessories', 1500),
(104, 'Smartphone', 'Electronics', 25000),
(105, 'Headphones', 'Accessories', 2000);

SELECT * FROM products;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO orders
(order_id, customer_id, product_id, quantity, order_date)
VALUES
(1001, 1, 101, 1, '2026-01-05'),
(1002, 2, 102, 2, '2026-01-08'),
(1003, 3, 104, 1, '2026-01-10'),
(1004, 1, 103, 2, '2026-02-02'),
(1005, 4, 105, 3, '2026-02-10'),
(1006, 5, 101, 1, '2026-02-15'),
(1007, 2, 104, 2, '2026-03-01'),
(1008, 3, 102, 4, '2026-03-05'),
(1009, 4, 103, 1, '2026-03-12'),
(1010, 5, 105, 2, '2026-03-20');

SELECT * FROM orders;

SELECT customer_name, city
FROM customers;

SELECT *
FROM customers
WHERE city = 'Mumbai';

SELECT product_name, price
FROM products
WHERE price > 2000;

SELECT *
FROM orders
WHERE order_date >= '2026-02-01'
  AND order_date < '2026-03-01';

SELECT product_name, category, price
FROM products
ORDER BY price DESC;

SELECT customer_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY customer_id;

SELECT product_id,
       SUM(quantity) AS total_quantity_sold
FROM orders
GROUP BY product_id
ORDER BY total_quantity_sold DESC, product_id;

SELECT SUM(quantity) AS total_units_sold
FROM orders;

SELECT
    ROUND(AVG(price), 2) AS average_price,
    MAX(price) AS highest_price,
    MIN(price) AS lowest_price
FROM products;

SELECT
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id;

SELECT
    product_id,
    SUM(quantity) AS total_quantity
FROM orders
GROUP BY product_id
HAVING SUM(quantity) > 3
ORDER BY total_quantity DESC;

SELECT
    customer_id,
    SUM(quantity) AS total_items_purchased
FROM orders
GROUP BY customer_id
HAVING SUM(quantity) > 3
ORDER BY customer_id;

SELECT
    c.customer_name,
    o.order_id,
    o.quantity,
    o.order_date
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY o.order_id;

SELECT
    c.customer_name,
    p.product_name,
    o.quantity,
    p.price,
    (o.quantity * p.price) AS revenue
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
ORDER BY o.order_id;

SELECT
    c.customer_name,
    p.product_name,
    o.quantity,
    p.price,
    (o.quantity * p.price) AS revenue
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
ORDER BY price;

SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

SELECT
    c.customer_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;

SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

SELECT customer_name, city
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE product_id = 101
);

SELECT order_id, customer_id, quantity
FROM orders
WHERE quantity > (
    SELECT AVG(quantity)
    FROM orders
)
ORDER BY quantity DESC, order_id;


SELECT
    product_name,
    price,
    ROW_NUMBER() OVER (
        ORDER BY price DESC
    ) AS row_number
FROM products;


SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(o.quantity * p.price) DESC
    ) AS revenue_rank
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY revenue_rank;



