-- Create database
CREATE DATABASE company_db;

-- Switch to the database
\c company_db;

-- =========================
-- 1. Employees Table
-- =========================
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary NUMERIC(10,2),
    hire_date DATE
);

-- =========================
-- 2. Departments Table
-- =========================
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE
);

-- =========================
-- 3. Projects Table
-- =========================
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE
);

-- =========================
-- 4. Employee_Project Mapping (Many-to-Many)
-- =========================
CREATE TABLE employee_projects (
    emp_id INT REFERENCES employees(emp_id),
    project_id INT REFERENCES projects(project_id),
    role VARCHAR(50),
    PRIMARY KEY (emp_id, project_id)
);

-- =========================
-- Insert Sample Data
-- =========================
INSERT INTO departments (department_name)
VALUES ('IT'), ('HR'), ('Finance');

INSERT INTO employees (first_name, last_name, department_id, salary, hire_date)
VALUES
('Amit', 'Sharma', 1, 60000, '2022-01-15'),
('Priya', 'Patel', 2, 45000, '2021-11-01'),
('Rohan', 'Mehta', 3, 70000, '2020-06-20'),
('Sneha', 'Kumar', 1, 65000, '2023-03-10');

INSERT INTO projects (project_name, start_date, end_date)
VALUES
('ERP System Upgrade', '2023-01-01', '2023-12-31'),
('Recruitment Drive', '2023-05-01', '2023-08-31'),
('Financial Audit', '2023-02-15', '2023-06-30');

INSERT INTO employee_projects (emp_id, project_id, role)
VALUES
(1, 1, 'Developer'),
(4, 1, 'Tester'),
(2, 2, 'Coordinator'),
(3, 3, 'Auditor');

-- =========================
-- Queries
-- =========================

-- 1. List all employees with their department
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 2. Find employees working on projects
SELECT e.first_name, e.last_name, p.project_name, ep.role
FROM employees e
JOIN employee_projects ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id;

-- 3. Average salary per department
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 4. Employees hired after 2022
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > '2022-01-01';

-- 5. Projects ending in 2023
SELECT project_name, end_date
FROM projects
WHERE end_date BETWEEN '2023-01-01' AND '2023-12-31';
