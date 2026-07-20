UPDATE silver.silver_sales 
SET 
    city_id = e.city_id,
    shop_id = e.shop_id
FROM silver.silver_employees e 
WHERE silver_sales.employee_id = e.employee_id;
