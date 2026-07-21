-- ============================================================
-- ПРОЕКТ: Data Warehouse EcoMarket
-- СЛОЙ: Gold (Загрузка данных)
-- ФАЙЛ: gold_etl.sql
-- ОПИСАНИЕ: Загрузка данных из Silver в Gold
-- ============================================================

-- ============================================================
-- 1. ЗАГРУЗКА dim_date (Календарь)
-- ============================================================

INSERT INTO gold.dim_date (
    date_key, 
    full_date, 
    day_of_week, 
    week_num, 
    month_num, 
    month_name, 
    quarter_num, 
    year_num
)
SELECT DISTINCT
    -- date_key = число в формате YYYYMMDD
    (EXTRACT(YEAR FROM sales_timestamp) * 10000 
     + EXTRACT(MONTH FROM sales_timestamp) * 100 
     + EXTRACT(DAY FROM sales_timestamp))::INT AS date_key,
    
    sales_timestamp::DATE AS full_date,
    
    -- День недели (название)
    TO_CHAR(sales_timestamp, 'Day') AS day_of_week,
    
    -- Номер недели в году (1-53)
    EXTRACT(WEEK FROM sales_timestamp)::INT AS week_num,
    
    -- Номер месяца (1-12)
    EXTRACT(MONTH FROM sales_timestamp)::INT AS month_num,
    
    -- Название месяца
    TO_CHAR(sales_timestamp, 'Month') AS month_name,
    
    -- Номер квартала (1-4)
    EXTRACT(QUARTER FROM sales_timestamp)::INT AS quarter_num,
    
    -- Год (YYYY)
    EXTRACT(YEAR FROM sales_timestamp)::INT AS year_num
    
FROM silver.silver_sales
ON CONFLICT (date_key) DO NOTHING;

-- ============================================================
-- 2. ЗАГРУЗКА dim_time (Время суток)
-- ============================================================

INSERT INTO gold.dim_time (
    time_key, 
    full_time, 
    hour_num
)
SELECT DISTINCT
    -- time_key = количество секунд с начала суток
    (EXTRACT(HOUR FROM sales_timestamp) * 3600 
     + EXTRACT(MINUTE FROM sales_timestamp) * 60 
     + EXTRACT(SECOND FROM sales_timestamp))::INT AS time_key,
    
    sales_timestamp::TIME AS full_time,
    
    EXTRACT(HOUR FROM sales_timestamp)::INT AS hour_num
    
FROM silver.silver_sales
ON CONFLICT (time_key) DO NOTHING;

-- ============================================================
-- 3. ЗАГРУЗКА dim_category (Категории товаров)
-- ============================================================

INSERT INTO gold.dim_category (
    category_key,
    category_id,
    category_name
)
SELECT 
    category_id AS category_key,
    category_id,
    category_name
FROM silver.silver_categories
ON CONFLICT (category_key) DO NOTHING;

-- ============================================================
-- 4. ЗАГРУЗКА dim_shop (Магазины + География)
-- ============================================================

INSERT INTO gold.dim_shop (
    shop_key,
    shop_id,
    address,
    city_name,
    country_name,
    zipcode
)
SELECT 
    s.shop_id AS shop_key,
    s.shop_id,
    s.address,
    c.city_name,
    co.country_name,
    c.zipcode
FROM silver.silver_shops s
LEFT JOIN silver.silver_cities c ON s.city_id = c.city_id
LEFT JOIN silver.silver_countries co ON c.country_id = co.country_id
ON CONFLICT (shop_key) DO NOTHING;

-- ============================================================
-- 5. ЗАГРУЗКА dim_customer (Клиенты)
-- ============================================================

INSERT INTO gold.dim_customer (
    customer_key,
    customer_id,
    first_name,
    last_name,
    middle_initial,
    address
)
SELECT 
    customer_id AS customer_key,
    customer_id,
    first_name,
    last_name,
    middle_initial,
    address
FROM silver.silver_customers
ON CONFLICT (customer_key) DO NOTHING;

-- ============================================================
-- 6. ЗАГРУЗКА dim_employee (Сотрудники)
-- ============================================================

INSERT INTO gold.dim_employee (
    employee_key,
    employee_id,
    first_name,
    last_name,
    middle_initial,
    gender,
    hire_date
)
SELECT 
    employee_id AS employee_key,
    employee_id,
    first_name,
    last_name,
    middle_initial,
    gender,
    hire_date
FROM silver.silver_employees
ON CONFLICT (employee_key) DO NOTHING;

-- ============================================================
-- 7. ЗАГРУЗКА dim_product (Товары с SCD2)
-- ============================================================

INSERT INTO gold.dim_product (
    product_key,
    product_id,
    product_name,
    price,
    class,
    valid_from_dt,
    valid_to_dt,
    is_current
)
SELECT 
    product_id AS product_key,
    product_id,
    product_name,
    price,
    class,
    '1900-01-01'::DATE AS valid_from_dt,
    NULL::DATE AS valid_to_dt,
    TRUE AS is_current
FROM silver.silver_products
ON CONFLICT (product_key) DO NOTHING;

-- ============================================================
-- 8. ЗАГРУЗКА fact_sales (Факты продаж)
-- ============================================================

INSERT INTO gold.fact_sales (
    sales_key,
    date_key,
    time_key,
    product_key,
    category_key,
    customer_key,
    employee_key,
    shop_key,
    quantity,
    total_revenue,
    discount_amount
)
SELECT 
    s.sales_id AS sales_key,
    (EXTRACT(YEAR FROM s.sales_timestamp) * 10000 
     + EXTRACT(MONTH FROM s.sales_timestamp) * 100 
     + EXTRACT(DAY FROM s.sales_timestamp))::INT AS date_key,
    
    (EXTRACT(HOUR FROM s.sales_timestamp) * 3600 
     + EXTRACT(MINUTE FROM s.sales_timestamp) * 60 
     + EXTRACT(SECOND FROM s.sales_timestamp))::INT AS time_key,
    
    s.product_id AS product_key,
    p.category_id AS category_key,
    s.customer_id AS customer_key,
    s.employee_id AS employee_key,
    e.shop_id AS shop_key,
    
    s.quantity,
    
    -- total_revenue = total_price (уже со скидкой и за всё количество)
    ROUND(s.total_price::NUMERIC, 2) AS total_revenue,
    
    -- discount_amount = считаем от полной цены без скидки
    ROUND((s.total_price / (1 - s.discount) * s.discount)::NUMERIC, 2) AS discount_amount
    
FROM silver.silver_sales s
LEFT JOIN silver.silver_products p ON s.product_id = p.product_id
LEFT JOIN silver.silver_employees e ON s.employee_id = e.employee_id
ON CONFLICT (sales_key) DO NOTHING;
