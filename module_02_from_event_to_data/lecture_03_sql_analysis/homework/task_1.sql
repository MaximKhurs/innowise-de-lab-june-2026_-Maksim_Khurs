INSERT INTO "select 
    s.sales_id,
    p.product_name,
    s2.address
from sales s 
inner join products p on s.product_id = p.product_id
inner join employees e on s.employee_id = e.employee_id 
inner join shops s2 on e.shop_id =s2.shop_id 
order  by s.sales_id 
limit 10" (sales_id,product_name,address) VALUES
	 (1,'Baby Wet Wipes #13','SHOP0038 Thomas Crest'),
	 (2,'Wholegrain Bread','SHOP0069 Cooper Wells'),
	 (3,'Sourdough Baguette Premium','SHOP0057 Emily Way'),
	 (4,'Granola Bar Classic','SHOP0005 Lopez Groves'),
	 (5,'Sesame Crackers Premium #27','SHOP0062 Paula Mills'),
	 (6,'Tomatoes Premium #14','SHOP0012 Horn Points'),
	 (7,'Dish Soap Premium','SHOP0032 Stephanie Meadow'),
	 (8,'Baby Wet Wipes Family Pack','SHOP0005 Lopez Groves'),
	 (9,'Bananas Family Pack #15','SHOP0020 Martinez Trail'),
	 (10,'Red Onions Classic','SHOP0057 Emily Way');
