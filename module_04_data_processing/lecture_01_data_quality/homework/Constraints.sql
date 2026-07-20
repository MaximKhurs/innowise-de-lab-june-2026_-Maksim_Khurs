ALTER TABLE silver.silver_countries ADD PRIMARY KEY (country_id);
ALTER TABLE silver.silver_categories ADD PRIMARY KEY (category_id);
ALTER TABLE silver.silver_cities ADD PRIMARY KEY (city_id);
ALTER TABLE silver.silver_customers ADD PRIMARY KEY (customer_id);
ALTER TABLE silver.silver_employees ADD PRIMARY KEY (employee_id);
ALTER TABLE silver.silver_products ADD PRIMARY KEY (product_id);
ALTER TABLE silver.silver_shops ADD PRIMARY KEY (shop_id);
ALTER TABLE silver.silver_sales ADD PRIMARY KEY (sales_id);



ALTER TABLE silver.silver_cities 
ADD FOREIGN KEY (country_id) REFERENCES silver.silver_countries(country_id);

ALTER TABLE silver.silver_customers 
ADD FOREIGN KEY (city_id) REFERENCES silver.silver_cities(city_id);

ALTER TABLE silver.silver_employees 
ADD FOREIGN KEY (city_id) REFERENCES silver.silver_cities(city_id);

ALTER TABLE silver.silver_employees 
ADD FOREIGN KEY (shop_id) REFERENCES silver.silver_shops(shop_id);

ALTER TABLE silver.silver_products 
ADD FOREIGN KEY (category_id) REFERENCES silver.silver_categories(category_id);

ALTER TABLE silver.silver_sales 
ADD FOREIGN KEY (employee_id) REFERENCES silver.silver_employees(employee_id);

ALTER TABLE silver.silver_sales 
ADD FOREIGN KEY (customer_id) REFERENCES silver.silver_customers(customer_id);

ALTER TABLE silver.silver_sales 
ADD FOREIGN KEY (product_id) REFERENCES silver.silver_products(product_id);

ALTER TABLE silver.silver_sales 
ADD FOREIGN KEY (city_id) REFERENCES silver.silver_cities(city_id);

ALTER TABLE silver.silver_sales 
ADD FOREIGN KEY (shop_id) REFERENCES silver.silver_shops(shop_id);


ALTER TABLE silver.silver_employees 
ADD CHECK (hire_date > birth_date);