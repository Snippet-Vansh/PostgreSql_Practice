-- 1. Create employees table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(10,2)
);

-- 2. Insert 5 employees
INSERT INTO employees (name, department, salary) VALUES
('Vansh', 'IT', 60000),
('Aditi', 'HR', 45000),
('Rahul', 'Finance', 70000),
('Neha', 'IT', 52000),
('Karan', 'Marketing', 30000);

-- 3. Employees from IT department
SELECT * FROM employees WHERE department = 'IT';

-- 4. Employees earning more than 50,000
SELECT * FROM employees WHERE salary > 50000;
