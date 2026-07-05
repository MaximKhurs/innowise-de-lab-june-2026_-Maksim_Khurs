INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0000006013','Baby Puree Apple Small Pack',12669.43,78028,'2022-10-09 18:36:01'),
	 ('T0000008027','Turkey Fillet Premium #39',7488.42,19564,'2023-09-26 13:52:55'),
	 ('T0000066519','Raspberries Classic #33',1754.06,31290,'2022-07-24 20:11:24'),
	 ('T0000080129','Ginger Shot Premium #35',2054.98,39900,'2023-07-13 00:05:55'),
	 ('T0000090083','Dog Food Grain Free #18',1888.43,24913,'2022-06-19 07:42:24'),
	 ('T0000101054','Sesame Crackers',5078.56,22815,'2023-04-24 23:25:02'),
	 ('T0000104687','Ginger Shot Premium #35',2075.21,20802,'2023-07-11 20:21:50'),
	 ('T0000141414','Trash Bags Biodegradable Family Pack',2729.7,43580,'2022-06-30 10:00:16'),
	 ('T0000207766','Beans in Water Classic',24987.57,65895,'2022-08-10 10:28:33'),
	 ('T0000270104','Berry Mix Small Pack #17',2163.75,18253,'2022-08-23 17:11:57');
INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0000280937','Baby Cereal Small Pack',14358.29,49381,'2022-06-28 01:32:34'),
	 ('T0000313704','Berry Mix Small Pack #17',11603.47,65909,'2022-03-27 18:21:45'),
	 ('T0000333616','Bananas Classic',6792.23,37015,'2022-05-05 15:08:05'),
	 ('T0000357822','Dog Food Grain Free #18',16919.72,21149,'2022-04-22 13:49:01'),
	 ('T0000371236','Ginger Shot Premium #35',2357.16,32074,'2023-07-19 15:23:11'),
	 ('T0000409853','Ginger Shot Premium #16',2365.09,7762,'2023-01-31 17:11:12'),
	 ('T0000441676','Mineral Water Classic',9194.02,15312,'2023-01-16 22:50:27'),
	 ('T0000476865','Rye Bread Small Pack #4',4616.24,38901,'2023-07-24 10:34:00'),
	 ('T0000485393','Carrots Classic',6536.57,88837,'2023-05-02 06:54:27'),
	 ('T0000486915','Spinach Leaves Small Pack #36',15786.37,71004,'2022-08-13 11:51:08');
INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0000535093','Frozen Peas Premium',3415.54,47716,'2022-08-09 00:32:42'),
	 ('T0000549203','Dish Soap #18',1926.26,54802,'2023-11-19 13:36:12'),
	 ('T0000560852','Cat Treats Soft Family Pack #6',18048.64,83839,'2023-08-18 07:05:42'),
	 ('T0000608203','Baby Puree Apple Family Pack',12412.2,31469,'2022-10-19 07:49:21'),
	 ('T0000658777','Ginger Shot Premium #16',4410.29,96331,'2023-08-15 15:03:06'),
	 ('T0000658976','Cashew Spread Small Pack #16',19163.38,15862,'2022-03-26 21:15:52'),
	 ('T0000694939','Almond Milk Family Pack #28',1814.32,51570,'2022-05-03 09:08:31'),
	 ('T0000713180','Plums Small Pack',20384.19,95019,'2023-03-15 05:02:16'),
	 ('T0000714054','Cucumbers Family Pack',28605.12,97318,'2023-11-18 12:27:27'),
	 ('T0000763326','Apple Juice Cloudy Family Pack #27',8060.15,99792,'2023-04-17 09:15:39');
INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0000765040','White Grapes Family Pack',7378.39,61190,'2023-05-04 00:46:51'),
	 ('T0000788056','Shrimp Cleaned Family Pack',7202.26,57068,'2022-07-04 20:57:46'),
	 ('T0000794739','Body Lotion Mild Small Pack',17548.72,15497,'2022-09-13 11:09:04'),
	 ('T0000805556','Plums Small Pack',31094.99,53333,'2022-05-04 19:16:32'),
	 ('T0000835617','Almond Milk Family Pack #28',15798.81,2736,'2022-05-22 02:36:17'),
	 ('T0000850244','Ginger Shot Family Pack',1529.41,87705,'2022-07-11 04:17:43'),
	 ('T0000869554','Chicken Breast Classic',1730.13,44580,'2023-07-08 13:33:47'),
	 ('T0000884300','Ginger Shot Premium #35',1768.58,87898,'2022-07-10 06:57:00'),
	 ('T0000918283','Ginger Shot',3339.88,50329,'2022-08-30 06:46:29'),
	 ('T0000928812','Beef Mince Family Pack #28',22205.51,5098,'2023-12-04 08:37:26');
INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0000940555','Green Tea Premium',15700.31,91864,'2022-10-30 17:30:29'),
	 ('T0000945521','Cold Pressed Orange Juice Family Pack',6527.77,11203,'2022-08-08 14:08:36'),
	 ('T0000957867','Apple Juice Cloudy Small Pack #17',1692.99,73574,'2022-07-12 05:05:14'),
	 ('T0000960614','Cat Treats Soft Family Pack',10425.79,4818,'2023-10-30 05:40:20'),
	 ('T0000985396','Apple Juice Cloudy Small Pack #17',1528.82,9549,'2023-07-11 14:52:25'),
	 ('T0000987023','Apple Juice Cloudy Small Pack #17',1605.34,18231,'2023-07-14 23:23:58'),
	 ('T0001006390','Dish Soap',1574.99,74482,'2022-06-14 00:29:36'),
	 ('T0001032589','Ground Coffee Medium Roast',6008.56,22292,'2022-04-22 20:41:50'),
	 ('T0001067214','Cat Treats Soft Family Pack #6',16939.09,61113,'2022-03-10 06:02:41'),
	 ('T0001089954','Probiotic Kefir #14',1786.0,65527,'2022-11-14 02:09:35');
INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0001094665','Zucchini #25',11502.26,45272,'2022-11-15 23:51:34'),
	 ('T0001107240','Cold Pressed Orange Juice Classic',1595.19,51021,'2022-07-19 17:59:05'),
	 ('T0001165610','Zucchini Small Pack',15900.06,35307,'2023-10-26 12:11:04'),
	 ('T0001188820','Carrots Premium #37',15596.38,67755,'2023-07-01 08:15:59'),
	 ('T0001192475','Sesame Crackers Premium #34',20542.7,16317,'2023-03-04 11:32:45'),
	 ('T0001199844','Chickpeas in Brine Small Pack',4031.66,28342,'2023-04-17 19:07:19'),
	 ('T0001204797','Almond Milk',29615.19,60092,'2022-08-04 12:36:08'),
	 ('T0001220002','Cold Pressed Orange Juice Family Pack',46536.42,1420,'2022-06-02 10:51:20'),
	 ('T0001250346','Raspberries Family Pack #26',18162.47,15411,'2023-11-14 16:01:24'),
	 ('T0001252613','Ginger Shot Premium #29',22227.8,98065,'2023-08-06 10:45:48');
INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0001260044','Zucchini #45',24969.1,77724,'2022-06-30 07:55:38'),
	 ('T0001278631','Frozen Peas #22',30677.68,51762,'2022-03-25 00:04:50'),
	 ('T0001295231','Shrimp Cleaned Family Pack',89454.14,60578,'2022-02-11 08:38:26'),
	 ('T0001333712','Body Lotion Mild Family Pack #18',10121.07,11293,'2022-06-17 07:17:14'),
	 ('T0001334406','Beef Mince',5426.54,59281,'2023-03-22 23:37:32'),
	 ('T0001431442','Frozen Peas Premium',2923.82,74096,'2022-03-03 02:37:07'),
	 ('T0001453384','Baby Cereal Premium #23',1954.86,31957,'2022-05-27 21:17:10'),
	 ('T0001467532','Chickpeas in Brine Small Pack',4663.37,9178,'2022-09-30 06:01:27'),
	 ('T0001506293','Chicken Breast Premium',21343.59,10078,'2022-08-15 04:48:22'),
	 ('T0001573653','Ginger Shot Premium #16',5849.83,99719,'2022-10-07 10:01:56');
INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0001584640','Dog Snacks Chewy Classic',2577.24,68652,'2023-07-31 10:17:05'),
	 ('T0001586932','Dog Food Grain Free #13',19549.28,53364,'2023-07-27 23:35:48'),
	 ('T0001635125','Sesame Crackers Premium #34',15933.83,99019,'2023-02-02 21:29:41'),
	 ('T0001635649','Cold Pressed Orange Juice Family Pack',1706.26,66490,'2022-07-23 05:41:30'),
	 ('T0001642605','Trash Bags Biodegradable Family Pack',7921.67,93456,'2023-08-16 22:03:26'),
	 ('T0001647525','Beef Mince',15282.04,50961,'2023-09-16 12:32:03'),
	 ('T0001674373','Apple Juice Cloudy Small Pack #17',1712.83,46987,'2023-07-12 23:27:20'),
	 ('T0001678668','Cod Fillet Classic #29',9168.15,83643,'2023-06-07 07:24:59'),
	 ('T0001726951','Beef Sirloin',31670.32,15893,'2023-05-15 06:40:11'),
	 ('T0001778715','Cold Pressed Orange Juice Family Pack',1559.14,70634,'2023-07-22 22:01:30');
INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0001798298','Salmon Fillet Premium',42365.19,14295,'2023-12-27 05:43:04'),
	 ('T0001811262','Turkey Fillet',6870.7,97852,'2022-08-05 00:14:00'),
	 ('T0001811266','Trash Bags Biodegradable Premium',15592.75,33822,'2022-03-20 12:20:12'),
	 ('T0001822530','Raspberries Classic #33',89116.63,31218,'2022-09-23 04:00:30'),
	 ('T0001822727','Seeded Loaf Premium #29',4494.99,10534,'2023-08-09 10:13:18'),
	 ('T0001840775','Spinach Leaves',12628.89,76028,'2023-05-15 15:51:23'),
	 ('T0001870614','Apple Juice Cloudy Small Pack #17',1625.53,8553,'2022-07-17 13:51:14'),
	 ('T0001901461','Ground Coffee Medium Roast Premium',19950.19,34136,'2023-08-16 10:48:58'),
	 ('T0001905708','Sesame Crackers Premium #27',29868.23,8965,'2022-08-10 02:55:12'),
	 ('T0001907078','Ground Coffee Medium Roast Small Pack',8363.25,46228,'2023-08-20 20:42:07');
INSERT INTO "SELECT 
    s.transaction_number,
    p.product_name,
    s.total_price,
    s.customer_id,
    s.sales_timestamp
from sales s 
inner join products p on s.product_id = p.product_id
where s.total_price > 1500 and p.class = 'A'
order by s.transaction_number 
" (transaction_number,product_name,total_price,customer_id,sales_timestamp) VALUES
	 ('T0001937279','Berry Mix Family Pack #30',22620.63,46673,'2022-11-28 09:36:23');
