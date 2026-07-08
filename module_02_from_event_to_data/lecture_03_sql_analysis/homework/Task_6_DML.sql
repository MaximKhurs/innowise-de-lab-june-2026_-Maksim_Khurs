select 
    e.employee_id,
    concat(e.first_name, ' ', e.last_name) as full_name,
    sum(s.total_price) as total_sales
from employees e
join sales s on e.employee_id = s.employee_id
group by e.employee_id, e.first_name, e.last_name
having sum(s.total_price) > 1000
order by total_sales desc;


update products
set class = 'A'
where category_id in (
    select p.category_id
    from products p
    join sales s on p.product_id = s.product_id
    group by p.category_id
    having sum(s.total_price) > 5000
);



update products
set modify_timestamp = now()
where modify_timestamp is null;