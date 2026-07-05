INSERT INTO "SELECT 
    s.shop_id,
    s.address as shop_address,
    c.city_name,
    c2.country_name
from shops s 
inner join cities c on s.city_id =c.city_id 
inner join countries c2  on c.country_id = c2.country_id 
where c2.country_name = 'Poland'" (shop_id,shop_address,city_name,country_name) VALUES
	 (69,'SHOP0069 Cooper Wells','Warsaw','Poland'),
	 (70,'SHOP0070 Moses Land','Krakow','Poland'),
	 (71,'SHOP0071 Candace Plaza','Gdansk','Poland'),
	 (72,'SHOP0072 Kiara Gardens','Wroclaw','Poland');
