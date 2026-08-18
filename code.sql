WITH EmployeeRank AS (
    SELECT
        employee_id,
        name,
        department,
        salary,
        RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT *
FROM EmployeeRank
WHERE salary_rank <= 3;