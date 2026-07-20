
CREATE SCHEMA silver;

CREATE TABLE silver.silver_countries(
    country_id INT,
    country_name VARCHAR(50),
    country_code VARCHAR(5)
);

CREATE TABLE silver.silver_categories(
    category_id INT,
    category_name VARCHAR(100)
);


CREATE TABLE silver.silver_cities(
    city_id INT,
    city_name VARCHAR(100),
    zipcode INT,
    country_id INT   
);

CREATE TABLE silver.silver_customers(
    customer_id INT,
    first_name VARCHAR(50),
    middle_initial VARCHAR(10),
    last_name VARCHAR(50),
    city_id INT,
    address TEXT
);

CREATE TABLE silver.silver_employees(
    employee_id INT,
    first_name VARCHAR(50),
    middle_initial VARCHAR(10),
    last_name VARCHAR(50),
    city_id INT,
    birth_date DATE,
    gender CHAR(1),
    shop_id INT,
    hire_date DATE
);


CREATE TABLE silver.silver_products(
    product_id INT,
    product_name TEXT,
    price NUMERIC(10,2),
    category_id INT,
    class TEXT,
    modify_timestamp TEXT,
    resistant BOOLEAN,
    is_allergic BOOLEAN,
    vitality_days INT
);

CREATE TABLE silver.silver_shops(
    shop_id INT,
    city_id INT,
    address TEXT
);

CREATE TABLE silver.silver_sales(
    sales_id INT,
    employee_id INT,
    customer_id INT,
    product_id INT,
    quantity INT,
    discount NUMERIC(10,2),
    total_price NUMERIC(10,2),
    sales_timestamp TIMESTAMP,
    transaction_number TEXT,
    city_id INT,
    shop_id INT
);