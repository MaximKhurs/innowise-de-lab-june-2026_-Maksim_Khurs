INSERT INTO "SELECT 
    e.first_name,
    e.last_name, 
    s.address,
    s2.total_price as max_amount
from employees e
inner join shops s on e.shop_id  = s.shop_id 
inner join sales s2 on e.employee_id =s2.employee_id 
where s2.total_price = (
    select MAX(total_price)
    from sales)
" (first_name,last_name,address,max_amount) VALUES
	 ('David','James','SHOP0009 Hart Locks',113089.86);
