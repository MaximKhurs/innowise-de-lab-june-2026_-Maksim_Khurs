update  products 
set price = price * 1.1
where category_id = (select category_id from categories where category_name = 'Fruits')
;

delete from employees e
where not exists(
    select 1
    from sales s
    where s.employee_id = e.employee_id 
)
;



begin;

insert into employees (employee_id, first_name, middle_initial, last_name, birth_date, gender, city_id, shop_id, hire_date)
values(327, 'Ivan', 'I', 'Ivanov', '2001-02-04', 'M', 6, 1, '2026-07-07')
;

insert into sales (sales_id, employee_id, customer_id, product_id, quantity, discount, total_price, sales_timestamp, transaction_number)
values (2000001, 327, 1, 1, 1, 0.01, 0.99, current_date, 'T0002000001')
;


commit;
