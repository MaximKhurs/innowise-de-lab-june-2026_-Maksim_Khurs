INSERT INTO "SELECT 
	c.country_name,
	COUNT(s.shop_id) as shop_count
from shops s 
inner join cities on s.city_id = cities.city_id 
inner join countries c on c.country_id = cities.country_id 
group by c.country_name 
order by COUNT(s.shop_id) desc" (country_name,shop_count) VALUES
	 ('Germany',33),
	 ('France',17),
	 ('Italy',11),
	 ('Spain',7),
	 ('Poland',4);
