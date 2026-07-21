-- ============================================================
-- ПРОЕКТ: Data Warehouse EcoMarket
-- СЛОЙ: Gold (Аналитическая модель / Star Schema)
-- ФАЙЛ: gold_ddl.sql
-- ОПИСАНИЕ: Создание схемы, таблиц, SCD2, индексов и констрейнтов
-- ============================================================

-- 1. БИЗНЕС-ПРОЦЕСС
-- Моделируется процесс розничных продаж в сети продуктовых магазинов EcoMarket.
-- Основное событие аналитики — транзакция продажи товара конечному покупателю.

-- 2. УРОВЕНЬ ДЕТАЛИЗАЦИИ (GRAIN)
-- Одна строка в fact_sales соответствует одной транзакции продажи.
-- Уровень детализации: транзакционный (максимально детальный).

-- ============================================================
-- СХЕМА gold
-- ============================================================

CREATE SCHEMA IF NOT EXISTS gold;

-- ============================================================
-- ИЗМЕРЕНИЯ (DIMENSION TABLES)
-- ============================================================

-- 1. dim_date (Календарь)
CREATE TABLE gold.dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day_of_week VARCHAR(10),
    week_num INT,
    month_num INT,
    month_name VARCHAR(10),
    quarter_num INT,
    year_num INT
);

-- 2. dim_time (Время суток)
CREATE TABLE gold.dim_time (
    time_key INT PRIMARY KEY,
    full_time TIME NOT NULL,
    hour_num INT
);

-- 3. dim_product (Товары)
-- Хранит историю изменений цены и названия. Добавлены поля для SCD2
CREATE TABLE gold.dim_product (
    product_key INT PRIMARY KEY,
    product_id INT NOT NULL,
    product_name TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    class TEXT,
  
    valid_from_dt DATE NOT NULL,  
    valid_to_dt DATE,              
    is_current BOOLEAN NOT NULL    
);

-- 4. dim_category (Категории товаров)
CREATE TABLE gold.dim_category (
    category_key INT PRIMARY KEY,
    category_id INT NOT NULL,
    category_name TEXT NOT NULL
);

-- 5. dim_customer (Клиенты)
CREATE TABLE gold.dim_customer (
    customer_key INT PRIMARY KEY,
    customer_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    middle_initial VARCHAR(10),
    address TEXT
);

-- 6. dim_employee (Сотрудники)
CREATE TABLE gold.dim_employee (
    employee_key INT PRIMARY KEY,
    employee_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    middle_initial VARCHAR(10),
    gender CHAR(1),
    hire_date DATE
);

-- 7. dim_shop (Магазины + География)
-- Объединяет магазины, города и страны.
CREATE TABLE gold.dim_shop (
    shop_key INT PRIMARY KEY,
    shop_id INT NOT NULL,
    address TEXT,
    city_name VARCHAR(100),
    country_name VARCHAR(50),
    zipcode INT
);

-- ============================================================
-- ТАБЛИЦА ФАКТОВ (FACT TABLE)
-- ============================================================

CREATE TABLE gold.fact_sales (
    sales_key BIGINT PRIMARY KEY,
    
    -- Внешние ключи (ссылки на измерения)
    date_key INT REFERENCES gold.dim_date(date_key),
    time_key INT REFERENCES gold.dim_time(time_key),
    product_key INT REFERENCES gold.dim_product(product_key),
    category_key INT REFERENCES gold.dim_category(category_key),
    customer_key INT REFERENCES gold.dim_customer(customer_key),
    employee_key INT REFERENCES gold.dim_employee(employee_key),
    shop_key INT REFERENCES gold.dim_shop(shop_key),
    
    -- Метрики (факты)
    quantity INT NOT NULL,
    total_revenue NUMERIC(10,2) NOT NULL,
    discount_amount NUMERIC(10,2) NOT NULL
);

-- ============================================================
-- CHECK CONSTRAINTS (Бизнес-правила)
-- ============================================================

-- Проверка пола
ALTER TABLE gold.dim_employee 
ADD CHECK (gender IN ('M', 'F'));

-- Проверка, что скидка не отрицательная
ALTER TABLE gold.fact_sales 
ADD CHECK (discount_amount >= 0);

-- Проверка, что количество товаров > 0
ALTER TABLE gold.fact_sales 
ADD CHECK (quantity > 0);

-- Проверка, что total_revenue не отрицательная
ALTER TABLE gold.fact_sales 
ADD CHECK (total_revenue >= 0);

-- ============================================================
-- ИНДЕКСЫ (Для ускорения запросов)
-- ============================================================

-- Индексы для внешних ключей
CREATE INDEX idx_fact_date_key ON gold.fact_sales(date_key);
CREATE INDEX idx_fact_time_key ON gold.fact_sales(time_key);
CREATE INDEX idx_fact_product_key ON gold.fact_sales(product_key);
CREATE INDEX idx_fact_category_key ON gold.fact_sales(category_key);
CREATE INDEX idx_fact_customer_key ON gold.fact_sales(customer_key);
CREATE INDEX idx_fact_employee_key ON gold.fact_sales(employee_key);
CREATE INDEX idx_fact_shop_key ON gold.fact_sales(shop_key);

-- Индексы для бизнес-ключей
CREATE INDEX idx_product_business_key ON gold.dim_product(product_id);
CREATE INDEX idx_customer_business_key ON gold.dim_customer(customer_id);
CREATE INDEX idx_employee_business_key ON gold.dim_employee(employee_id);
CREATE INDEX idx_shop_business_key ON gold.dim_shop(shop_id);

-- ============================================================
-- УНИКАЛЬНЫЕ ОГРАНИЧЕНИЯ (Для бизнес-ключей)
-- ============================================================

-- Бизнес-ключи должны быть уникальными для текущих (активных) записей
CREATE UNIQUE INDEX uq_product_business_key ON gold.dim_product(product_id) WHERE is_current = TRUE;
CREATE UNIQUE INDEX uq_customer_business_key ON gold.dim_customer(customer_id);
CREATE UNIQUE INDEX uq_employee_business_key ON gold.dim_employee(employee_id);
CREATE UNIQUE INDEX uq_shop_business_key ON gold.dim_shop(shop_id);