create function AvgSalesPerEmployee(p_employee_id integer)
returns numeric
language plpgsql
as $$
declare 
    avg_sales numeric;
begin
	select avg(total_price)
	into avg_sales
	from sales
	where employee_id = p_employee_id;


    return coalesce(avg_sales, 0);
   
end;
$$;


SELECT AvgSalesPerEmployee(43);



create view fullstatshops as
select 
    sh.shop_id,
    sh.shop_address,
    c2.country_name as country,
    count(s.sales_id) as total_sales_count,
    coalesce(sum(s.total_price), 0) as total_sales_amount
from shops sh
left join cities c on sh.city_id = c.city_id
left join countries c2 on c.country_id = c2.country_id
left join employees e on sh.shop_id = e.shop_id
left join sales s on e.employee_id = s.employee_id
group by sh.shop_id, sh.shop_address, c2.country_name
order by sh.shop_id;


select * from fullstatshops