-- ─────────────────────────────────────────────
-- TABLE SETUP
-- ─────────────────────────────────────────────
CREATE TABLE employees (
    id       INT,
    name     VARCHAR(50),
    dept     VARCHAR(50),
    salary   INT,
    manager_id INT
);

CREATE TABLE orders (
    order_id    INT,
    customer_id INT,
    amount      DECIMAL,
    order_date  DATE,
    status      VARCHAR(20)
);

CREATE TABLE products (
    product_id  INT,
    name        VARCHAR(50),
    category    VARCHAR(50),
    price       DECIMAL
);

-- ─────────────────────────────────────────────
-- Q1. SECOND HIGHEST SALARY
-- ─────────────────────────────────────────────
SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

-- using DENSE_RANK
SELECT salary FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 2;

-- ─────────────────────────────────────────────
-- Q2. TOP 3 SALARIES PER DEPARTMENT
-- ─────────────────────────────────────────────
SELECT dept, name, salary FROM (
    SELECT dept, name, salary,
           DENSE_RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk <= 3;

-- ─────────────────────────────────────────────
-- Q3. FIND DUPLICATE RECORDS
-- ─────────────────────────────────────────────
SELECT name, dept, salary, COUNT(*) AS cnt
FROM employees
GROUP BY name, dept, salary
HAVING COUNT(*) > 1;

-- ─────────────────────────────────────────────
-- Q4. RUNNING TOTAL OF ORDERS
-- ─────────────────────────────────────────────
SELECT order_id, customer_id, amount,
       SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM orders;

-- ─────────────────────────────────────────────
-- Q5. CUSTOMERS WHO NEVER ORDERED
-- ─────────────────────────────────────────────
-- using LEFT JOIN
SELECT e.id, e.name
FROM employees e
LEFT JOIN orders o ON e.id = o.customer_id
WHERE o.order_id IS NULL;

-- using NOT EXISTS
SELECT id, name FROM employees e
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = e.id
);

-- ─────────────────────────────────────────────
-- Q6. MONTH-WISE REVENUE
-- ─────────────────────────────────────────────
SELECT 
    YEAR(order_date)  AS year,
    MONTH(order_date) AS month,
    SUM(amount)       AS revenue,
    COUNT(order_id)   AS total_orders
FROM orders
WHERE status = 'completed'
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- ─────────────────────────────────────────────
-- Q7. EMPLOYEES EARNING MORE THAN MANAGER
-- ─────────────────────────────────────────────
SELECT e.name AS employee, e.salary,
       m.name AS manager,  m.salary AS manager_salary
FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE e.salary > m.salary;

-- ─────────────────────────────────────────────
-- Q8. CONSECUTIVE NUMBERS (3 times in a row)
-- ─────────────────────────────────────────────
SELECT DISTINCT l1.salary
FROM employees l1
JOIN employees l2 ON l1.id = l2.id - 1 AND l1.salary = l2.salary
JOIN employees l3 ON l2.id = l3.id - 1 AND l2.salary = l3.salary;

-- ─────────────────────────────────────────────
-- Q9. DEPARTMENT WITH HIGHEST AVG SALARY
-- ─────────────────────────────────────────────
SELECT dept, ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY dept
ORDER BY avg_salary DESC
LIMIT 1;

-- ─────────────────────────────────────────────
-- Q10. RETENTION: CUSTOMERS WHO ORDERED IN
--      BOTH LAST MONTH AND THIS MONTH
-- ─────────────────────────────────────────────
SELECT DISTINCT a.customer_id
FROM orders a
JOIN orders b ON a.customer_id = b.customer_id
WHERE MONTH(a.order_date) = MONTH(CURDATE())
  AND MONTH(b.order_date) = MONTH(CURDATE()) - 1;