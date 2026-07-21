CREATE SCHEMA mart;


-- ============================================================
-- 1. mart_daily_anomaly
-- Анализ отклонений ежедневной выручки магазина от среднего за 30 дней
-- ============================================================

CREATE VIEW mart.mart_daily_anomaly AS
WITH daily_revenue AS (
    SELECT 
        s.shop_id,
        s.city_name,
        s.country_name,
        d.full_date,
        SUM(f.total_revenue) AS revenue,
        AVG(SUM(f.total_revenue)) OVER (
            PARTITION BY s.shop_id 
            ORDER BY d.full_date 
            ROWS BETWEEN 30 PRECEDING AND 1 PRECEDING
        ) AS expected_revenue
    FROM gold.fact_sales f
    JOIN gold.dim_shop s ON f.shop_key = s.shop_key
    JOIN gold.dim_date d ON f.date_key = d.date_key
    GROUP BY s.shop_id, s.city_name, s.country_name, d.full_date
)
SELECT 
    shop_id,
    city_name,
    country_name,
    full_date AS date,
    revenue,
    expected_revenue,
    CASE 
        WHEN expected_revenue IS NOT NULL AND expected_revenue > 0 
        THEN ROUND(((revenue - expected_revenue) / expected_revenue) * 100, 2)
        ELSE NULL 
    END AS uplift_percent
FROM daily_revenue
WHERE revenue IS NOT NULL
ORDER BY full_date DESC, shop_id;

-- ============================================================
-- 2. mart_shop_daily
-- Географическое распределение и результативность магазинов
-- ============================================================

CREATE VIEW mart.mart_shop_daily AS
SELECT 
    s.shop_id,
    s.address,
    s.city_name,
    s.country_name,
    s.zipcode,
    d.year_num,
    d.month_num,
    d.month_name,
    COUNT(DISTINCT f.sales_key) AS transactions_count,
    SUM(f.quantity) AS total_items_sold,
    SUM(f.total_revenue) AS total_revenue,
    ROUND(AVG(f.total_revenue)::NUMERIC, 2) AS avg_transaction_value,
    ROUND(SUM(f.total_revenue) / COUNT(DISTINCT f.customer_key)::NUMERIC, 2) AS revenue_per_customer
FROM gold.fact_sales f
JOIN gold.dim_shop s ON f.shop_key = s.shop_key
JOIN gold.dim_date d ON f.date_key = d.date_key
GROUP BY s.shop_id, s.address, s.city_name, s.country_name, s.zipcode, d.year_num, d.month_num, d.month_name
ORDER BY s.country_name, s.city_name, d.year_num, d.month_num;

-- ============================================================
-- 3. mart_customer_behavior
-- Ранжирование клиентов по активности и сегментации
-- ============================================================

CREATE VIEW mart.mart_customer_behavior AS
WITH customer_stats AS (
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COUNT(DISTINCT f.sales_key) AS total_orders,
        SUM(f.total_revenue) AS total_revenue,
        MAX(d.full_date) AS last_purchase_date,
        CURRENT_DATE - MAX(d.full_date) AS days_since_last_purchase
    FROM gold.fact_sales f
    JOIN gold.dim_customer c ON f.customer_key = c.customer_key
    JOIN gold.dim_date d ON f.date_key = d.date_key
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT 
    customer_id,
    customer_name,
    total_orders,
    total_revenue,
    last_purchase_date,
    days_since_last_purchase,
    CASE 
        WHEN days_since_last_purchase <= 30 THEN 'Active'
        WHEN days_since_last_purchase <= 90 THEN 'At Risk'
        ELSE 'Inactive'
    END AS customer_status,
    CASE 
        WHEN total_revenue >= 50000 THEN 'High Value'
        WHEN total_revenue >= 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_stats
ORDER BY total_revenue DESC;

-- ============================================================
-- 4. mart_employee_performance
-- Эффективность персонала (лидеры vs аутсайдеры)
-- ============================================================

CREATE VIEW mart.mart_employee_performance AS
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    e.hire_date,
    COUNT(DISTINCT f.sales_key) AS transactions_count,
    SUM(f.quantity) AS total_items_sold,
    SUM(f.total_revenue) AS total_revenue,
    ROUND(AVG(f.total_revenue)::NUMERIC, 2) AS avg_transaction_value,
    ROUND(SUM(f.total_revenue) / NULLIF(COUNT(DISTINCT f.customer_key), 0)::NUMERIC, 2) AS revenue_per_customer,
    ROUND(SUM(f.total_revenue) / NULLIF(COUNT(DISTINCT f.sales_key), 0)::NUMERIC, 2) AS revenue_per_transaction
FROM gold.fact_sales f
JOIN gold.dim_employee e ON f.employee_key = e.employee_key
GROUP BY e.employee_id, e.first_name, e.last_name, e.hire_date
ORDER BY total_revenue DESC;

-- ============================================================
-- 5. mart_product_seasonality
-- Сезонность продуктов (категории с максимальными продажами по периодам)
-- ============================================================

CREATE VIEW mart.mart_product_seasonality AS
WITH seasonal_sales AS (
    SELECT 
        cat.category_id,
        cat.category_name,
        d.year_num,
        d.month_num,
        d.month_name,
        SUM(f.quantity) AS total_quantity,
        SUM(f.total_revenue) AS total_revenue,
        SUM(SUM(f.quantity)) OVER (
            PARTITION BY cat.category_id 
            ORDER BY d.year_num, d.month_num 
            ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING
        ) AS moving_avg_quantity
    FROM gold.fact_sales f
    JOIN gold.dim_category cat ON f.category_key = cat.category_key
    JOIN gold.dim_date d ON f.date_key = d.date_key
    GROUP BY cat.category_id, cat.category_name, d.year_num, d.month_num, d.month_name
)
SELECT 
    category_id,
    category_name,
    year_num,
    month_num,
    month_name,
    total_quantity,
    total_revenue,
    moving_avg_quantity,
    CASE 
        WHEN moving_avg_quantity IS NOT NULL AND moving_avg_quantity > 0 
        THEN ROUND(((total_quantity - moving_avg_quantity) / moving_avg_quantity) * 100, 2)
        ELSE NULL 
    END AS seasonal_spike_percent
FROM seasonal_sales
ORDER BY category_name, year_num, month_num;