DELETE FROM silver.silver_employees s
WHERE s.employee_id IS NULL;



WITH duplicates AS (
    SELECT 
        employee_id,
        ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY employee_id) AS rn
    FROM silver.silver_employees
)
DELETE FROM silver.silver_employees
WHERE (employee_id) IN (
    SELECT employee_id 
    FROM duplicates 
    WHERE rn > 1
);


DELETE FROM silver.silver_employees
WHERE NOT EXISTS (
    SELECT 1 
    FROM silver.silver_sales s
    WHERE s.employee_id = silver_employees.employee_id
);