-- ========================================
-- Выручка по месяцам и категориям
-- ========================================
SELECT 
    d.year_num,
    d.month_name,
    d.month_num,  -- добавили для ORDER BY
    cat.category_name,
    SUM(f.total_revenue) AS total_revenue,
    COUNT(DISTINCT f.sales_key) AS transactions_count
FROM gold.fact_sales f
JOIN gold.dim_date d ON f.date_key = d.date_key
JOIN gold.dim_category cat ON f.category_key = cat.category_key
GROUP BY d.year_num, d.month_name, d.month_num, cat.category_name
ORDER BY d.year_num, d.month_num, total_revenue DESC;

-- ========================================
-- Топ-10 клиентов по выручке
-- ========================================
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    SUM(f.total_revenue) AS total_revenue,
    COUNT(DISTINCT f.sales_key) AS orders_count,
    AVG(f.total_revenue) AS avg_order_value
FROM gold.fact_sales f
JOIN gold.dim_customer c ON f.customer_key = c.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC
LIMIT 10;
-- ========================================
-- Продажи по сотрудникам
-- ========================================
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COUNT(DISTINCT f.sales_key) AS transactions_count,
    SUM(f.quantity) AS total_items_sold,
    SUM(f.total_revenue) AS total_revenue,
    AVG(f.total_revenue) AS avg_transaction_value
FROM gold.fact_sales f
JOIN gold.dim_employee e ON f.employee_key = e.employee_key
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_revenue DESC
LIMIT 10;




