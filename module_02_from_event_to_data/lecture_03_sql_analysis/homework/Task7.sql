INSERT INTO "WITH all_shops_stats AS (
   
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        SUM(s.total_price::NUMERIC) AS shop_revenue
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id
),
country_totals AS (
    SELECT 
        country,
        SUM(shop_revenue) AS country_total
    FROM all_shops_stats
    GROUP BY country
),
shop_stats AS (
    
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        sh.address,
        COUNT(s.sales_id) AS total_sales_count,
        SUM(s.total_price::NUMERIC) AS total_sales_amount
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id, sh.address
    HAVING COUNT(s.sales_id) >= 2
)
SELECT 
    ss.country,
    ss.shop_id,
    ss.address,
    ss.total_sales_count,
    ROUND(ss.total_sales_amount, 2) AS total_sales_amount,
    ROUND(ct.country_total, 2) AS country_total,
    ROUND((ss.total_sales_amount / ct.country_total)::NUMERIC, 6) AS share,
    RANK() OVER (PARTITION BY ss.country ORDER BY ss.total_sales_amount DESC) AS rank,
    ROUND(
        SUM(ss.total_sales_amount) OVER (
            PARTITION BY ss.country 
            ORDER BY ss.total_sales_amount DESC 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS country_running_total
FROM shop_stats ss
INNER JOIN country_totals ct ON ss.country = ct.country
ORDER BY ss.country, rank" (country,shop_id,address,total_sales_count,total_sales_amount,country_total,"share","rank",country_running_total) VALUES
	 ('France',45,'SHOP0045 Roberson Passage',44173,4623384.73,29386392.18,0.157331,1,4623384.73),
	 ('France',49,'SHOP0049 Victor Hill',44245,2881029.54,29386392.18,0.098040,2,7504414.27),
	 ('France',41,'SHOP0041 Thomas Streets',38238,2609651.03,29386392.18,0.088805,3,10114065.30),
	 ('France',46,'SHOP0046 Eric Villages',37768,2413398.19,29386392.18,0.082126,4,12527463.49),
	 ('France',43,'SHOP0043 Samuel Hills',31558,2341045.11,29386392.18,0.079664,5,14868508.60),
	 ('France',36,'SHOP0036 Joseph Walk',24806,2191637.65,29386392.18,0.074580,6,17060146.25),
	 ('France',39,'SHOP0039 Jones Manors',18908,1800008.48,29386392.18,0.061253,7,18860154.73),
	 ('France',42,'SHOP0042 Michele Plains',19146,1683951.06,29386392.18,0.057304,8,20544105.79),
	 ('France',38,'SHOP0038 Thomas Crest',31425,1631601.23,29386392.18,0.055522,9,22175707.02),
	 ('France',44,'SHOP0044 Matthew Shore',18650,1303287.81,29386392.18,0.044350,10,23478994.83);
INSERT INTO "WITH all_shops_stats AS (
   
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        SUM(s.total_price::NUMERIC) AS shop_revenue
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id
),
country_totals AS (
    SELECT 
        country,
        SUM(shop_revenue) AS country_total
    FROM all_shops_stats
    GROUP BY country
),
shop_stats AS (
    
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        sh.address,
        COUNT(s.sales_id) AS total_sales_count,
        SUM(s.total_price::NUMERIC) AS total_sales_amount
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id, sh.address
    HAVING COUNT(s.sales_id) >= 2
)
SELECT 
    ss.country,
    ss.shop_id,
    ss.address,
    ss.total_sales_count,
    ROUND(ss.total_sales_amount, 2) AS total_sales_amount,
    ROUND(ct.country_total, 2) AS country_total,
    ROUND((ss.total_sales_amount / ct.country_total)::NUMERIC, 6) AS share,
    RANK() OVER (PARTITION BY ss.country ORDER BY ss.total_sales_amount DESC) AS rank,
    ROUND(
        SUM(ss.total_sales_amount) OVER (
            PARTITION BY ss.country 
            ORDER BY ss.total_sales_amount DESC 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS country_running_total
FROM shop_stats ss
INNER JOIN country_totals ct ON ss.country = ct.country
ORDER BY ss.country, rank" (country,shop_id,address,total_sales_count,total_sales_amount,country_total,"share","rank",country_running_total) VALUES
	 ('France',34,'SHOP0034 Pamela Stream',18635,1246822.70,29386392.18,0.042429,11,24725817.53),
	 ('France',35,'SHOP0035 William Roads',18691,1240733.78,29386392.18,0.042221,12,25966551.31),
	 ('France',40,'SHOP0040 Hernandez Trace',12721,853242.29,29386392.18,0.029035,13,26819793.60),
	 ('France',37,'SHOP0037 Tyler Union',18917,800468.14,29386392.18,0.027239,14,27620261.74),
	 ('France',47,'SHOP0047 Dunn Squares',31405,663918.89,29386392.18,0.022593,15,28284180.63),
	 ('France',48,'SHOP0048 Myers Springs',12577,655151.60,29386392.18,0.022294,16,28939332.23),
	 ('France',50,'SHOP0050 Jordan Spurs',12685,447059.95,29386392.18,0.015213,17,29386392.18),
	 ('Germany',12,'SHOP0012 Horn Points',50266,6992790.41,70592728.02,0.099058,1,6992790.41),
	 ('Germany',23,'SHOP0023 Rush Manors',62875,6029818.72,70592728.02,0.085417,2,13022609.13),
	 ('Germany',26,'SHOP0026 Murray Path',44446,4583231.49,70592728.02,0.064925,3,17605840.62);
INSERT INTO "WITH all_shops_stats AS (
   
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        SUM(s.total_price::NUMERIC) AS shop_revenue
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id
),
country_totals AS (
    SELECT 
        country,
        SUM(shop_revenue) AS country_total
    FROM all_shops_stats
    GROUP BY country
),
shop_stats AS (
    
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        sh.address,
        COUNT(s.sales_id) AS total_sales_count,
        SUM(s.total_price::NUMERIC) AS total_sales_amount
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id, sh.address
    HAVING COUNT(s.sales_id) >= 2
)
SELECT 
    ss.country,
    ss.shop_id,
    ss.address,
    ss.total_sales_count,
    ROUND(ss.total_sales_amount, 2) AS total_sales_amount,
    ROUND(ct.country_total, 2) AS country_total,
    ROUND((ss.total_sales_amount / ct.country_total)::NUMERIC, 6) AS share,
    RANK() OVER (PARTITION BY ss.country ORDER BY ss.total_sales_amount DESC) AS rank,
    ROUND(
        SUM(ss.total_sales_amount) OVER (
            PARTITION BY ss.country 
            ORDER BY ss.total_sales_amount DESC 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS country_running_total
FROM shop_stats ss
INNER JOIN country_totals ct ON ss.country = ct.country
ORDER BY ss.country, rank" (country,shop_id,address,total_sales_count,total_sales_amount,country_total,"share","rank",country_running_total) VALUES
	 ('Germany',27,'SHOP0027 Karen Falls',43999,3729151.18,70592728.02,0.052826,4,21334991.80),
	 ('Germany',22,'SHOP0022 Baker Via',37745,3410606.41,70592728.02,0.048314,5,24745598.21),
	 ('Germany',24,'SHOP0024 Gregory Burg',31538,3205144.26,70592728.02,0.045403,6,27950742.47),
	 ('Germany',11,'SHOP0011 Stacy Alley',56515,2969324.19,70592728.02,0.042063,7,30920066.66),
	 ('Germany',33,'SHOP0033 Anthony Village',37703,2935731.19,70592728.02,0.041587,8,33855797.85),
	 ('Germany',19,'SHOP0019 Gill Glen',25144,2471971.16,70592728.02,0.035017,9,36327769.01),
	 ('Germany',32,'SHOP0032 Stephanie Meadow',50220,2240568.88,70592728.02,0.031739,10,38568337.89),
	 ('Germany',16,'SHOP0016 Michael Ford',43942,2236830.82,70592728.02,0.031686,11,40805168.71),
	 ('Germany',17,'SHOP0017 Katherine Trace',31460,2214583.28,70592728.02,0.031371,12,43019751.99),
	 ('Germany',6,'SHOP0006 Allen View',18976,2014441.40,70592728.02,0.028536,13,45034193.39);
INSERT INTO "WITH all_shops_stats AS (
   
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        SUM(s.total_price::NUMERIC) AS shop_revenue
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id
),
country_totals AS (
    SELECT 
        country,
        SUM(shop_revenue) AS country_total
    FROM all_shops_stats
    GROUP BY country
),
shop_stats AS (
    
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        sh.address,
        COUNT(s.sales_id) AS total_sales_count,
        SUM(s.total_price::NUMERIC) AS total_sales_amount
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id, sh.address
    HAVING COUNT(s.sales_id) >= 2
)
SELECT 
    ss.country,
    ss.shop_id,
    ss.address,
    ss.total_sales_count,
    ROUND(ss.total_sales_amount, 2) AS total_sales_amount,
    ROUND(ct.country_total, 2) AS country_total,
    ROUND((ss.total_sales_amount / ct.country_total)::NUMERIC, 6) AS share,
    RANK() OVER (PARTITION BY ss.country ORDER BY ss.total_sales_amount DESC) AS rank,
    ROUND(
        SUM(ss.total_sales_amount) OVER (
            PARTITION BY ss.country 
            ORDER BY ss.total_sales_amount DESC 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS country_running_total
FROM shop_stats ss
INNER JOIN country_totals ct ON ss.country = ct.country
ORDER BY ss.country, rank" (country,shop_id,address,total_sales_count,total_sales_amount,country_total,"share","rank",country_running_total) VALUES
	 ('Germany',20,'SHOP0020 Martinez Trail',25331,1909245.72,70592728.02,0.027046,14,46943439.11),
	 ('Germany',30,'SHOP0030 Allen Curve',25073,1898922.34,70592728.02,0.026900,15,48842361.45),
	 ('Germany',25,'SHOP0025 Devon Lodge',24927,1846696.62,70592728.02,0.026160,16,50689058.07),
	 ('Germany',3,'SHOP0003 Christy Creek',31611,1823560.50,70592728.02,0.025832,17,52512618.57),
	 ('Germany',2,'SHOP0002 Nicole Station',25090,1712119.62,70592728.02,0.024253,18,54224738.19),
	 ('Germany',8,'SHOP0008 Rachael Mountain',31426,1457626.41,70592728.02,0.020648,19,55682364.60),
	 ('Germany',15,'SHOP0015 Hurst Ferry',18887,1452341.69,70592728.02,0.020574,20,57134706.29),
	 ('Germany',14,'SHOP0014 Barnes Union',25076,1393430.44,70592728.02,0.019739,21,58528136.73),
	 ('Germany',7,'SHOP0007 Jones Canyon',12661,1370948.06,70592728.02,0.019421,22,59899084.79),
	 ('Germany',31,'SHOP0031 Reilly Neck',25324,1265736.32,70592728.02,0.017930,23,61164821.11);
INSERT INTO "WITH all_shops_stats AS (
   
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        SUM(s.total_price::NUMERIC) AS shop_revenue
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id
),
country_totals AS (
    SELECT 
        country,
        SUM(shop_revenue) AS country_total
    FROM all_shops_stats
    GROUP BY country
),
shop_stats AS (
    
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        sh.address,
        COUNT(s.sales_id) AS total_sales_count,
        SUM(s.total_price::NUMERIC) AS total_sales_amount
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id, sh.address
    HAVING COUNT(s.sales_id) >= 2
)
SELECT 
    ss.country,
    ss.shop_id,
    ss.address,
    ss.total_sales_count,
    ROUND(ss.total_sales_amount, 2) AS total_sales_amount,
    ROUND(ct.country_total, 2) AS country_total,
    ROUND((ss.total_sales_amount / ct.country_total)::NUMERIC, 6) AS share,
    RANK() OVER (PARTITION BY ss.country ORDER BY ss.total_sales_amount DESC) AS rank,
    ROUND(
        SUM(ss.total_sales_amount) OVER (
            PARTITION BY ss.country 
            ORDER BY ss.total_sales_amount DESC 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS country_running_total
FROM shop_stats ss
INNER JOIN country_totals ct ON ss.country = ct.country
ORDER BY ss.country, rank" (country,shop_id,address,total_sales_count,total_sales_amount,country_total,"share","rank",country_running_total) VALUES
	 ('Germany',13,'SHOP0013 Arellano Ramp',18948,1252601.69,70592728.02,0.017744,24,62417422.80),
	 ('Germany',5,'SHOP0005 Lopez Groves',25002,1238843.93,70592728.02,0.017549,25,63656266.73),
	 ('Germany',9,'SHOP0009 Hart Locks',25203,1183690.81,70592728.02,0.016768,26,64839957.54),
	 ('Germany',29,'SHOP0029 Shelby Skyway',25144,1078050.51,70592728.02,0.015271,27,65918008.05),
	 ('Germany',1,'SHOP0001 Moore Mills',12503,968782.46,70592728.02,0.013724,28,66886790.51),
	 ('Germany',21,'SHOP0021 Virginia Tunnel',18906,898035.00,70592728.02,0.012721,29,67784825.51),
	 ('Germany',18,'SHOP0018 Anthony Radial',25007,777036.78,70592728.02,0.011007,30,68561862.29),
	 ('Germany',28,'SHOP0028 Lisa Keys',18771,766545.92,70592728.02,0.010859,31,69328408.21),
	 ('Germany',10,'SHOP0010 Fernandez Inlet',12559,704997.45,70592728.02,0.009987,32,70033405.66),
	 ('Germany',4,'SHOP0004 Candace Isle',12626,559322.36,70592728.02,0.007923,33,70592728.02);
INSERT INTO "WITH all_shops_stats AS (
   
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        SUM(s.total_price::NUMERIC) AS shop_revenue
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id
),
country_totals AS (
    SELECT 
        country,
        SUM(shop_revenue) AS country_total
    FROM all_shops_stats
    GROUP BY country
),
shop_stats AS (
    
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        sh.address,
        COUNT(s.sales_id) AS total_sales_count,
        SUM(s.total_price::NUMERIC) AS total_sales_amount
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id, sh.address
    HAVING COUNT(s.sales_id) >= 2
)
SELECT 
    ss.country,
    ss.shop_id,
    ss.address,
    ss.total_sales_count,
    ROUND(ss.total_sales_amount, 2) AS total_sales_amount,
    ROUND(ct.country_total, 2) AS country_total,
    ROUND((ss.total_sales_amount / ct.country_total)::NUMERIC, 6) AS share,
    RANK() OVER (PARTITION BY ss.country ORDER BY ss.total_sales_amount DESC) AS rank,
    ROUND(
        SUM(ss.total_sales_amount) OVER (
            PARTITION BY ss.country 
            ORDER BY ss.total_sales_amount DESC 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS country_running_total
FROM shop_stats ss
INNER JOIN country_totals ct ON ss.country = ct.country
ORDER BY ss.country, rank" (country,shop_id,address,total_sales_count,total_sales_amount,country_total,"share","rank",country_running_total) VALUES
	 ('Italy',56,'SHOP0056 Cody Drives',43773,3663606.32,19077289.38,0.192040,1,3663606.32),
	 ('Italy',51,'SHOP0051 Webster Run',31328,3383665.32,19077289.38,0.177366,2,7047271.64),
	 ('Italy',55,'SHOP0055 Alexander Bridge',25025,2874874.05,19077289.38,0.150696,3,9922145.69),
	 ('Italy',53,'SHOP0053 Jennings Garden',18964,1625924.74,19077289.38,0.085228,4,11548070.43),
	 ('Italy',57,'SHOP0057 Emily Way',31681,1601863.87,19077289.38,0.083967,5,13149934.30),
	 ('Italy',60,'SHOP0060 Myers Orchard',19086,1386782.37,19077289.38,0.072693,6,14536716.67),
	 ('Italy',52,'SHOP0052 Frank Ramp',18603,1264628.06,19077289.38,0.066290,7,15801344.73),
	 ('Italy',54,'SHOP0054 Allen Ford',12600,1190192.07,19077289.38,0.062388,8,16991536.80),
	 ('Italy',59,'SHOP0059 Cline Groves',12640,1055164.70,19077289.38,0.055310,9,18046701.50),
	 ('Italy',61,'SHOP0061 Daniel Groves',18706,771699.62,19077289.38,0.040451,10,18818401.12);
INSERT INTO "WITH all_shops_stats AS (
   
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        SUM(s.total_price::NUMERIC) AS shop_revenue
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id
),
country_totals AS (
    SELECT 
        country,
        SUM(shop_revenue) AS country_total
    FROM all_shops_stats
    GROUP BY country
),
shop_stats AS (
    
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        sh.address,
        COUNT(s.sales_id) AS total_sales_count,
        SUM(s.total_price::NUMERIC) AS total_sales_amount
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id, sh.address
    HAVING COUNT(s.sales_id) >= 2
)
SELECT 
    ss.country,
    ss.shop_id,
    ss.address,
    ss.total_sales_count,
    ROUND(ss.total_sales_amount, 2) AS total_sales_amount,
    ROUND(ct.country_total, 2) AS country_total,
    ROUND((ss.total_sales_amount / ct.country_total)::NUMERIC, 6) AS share,
    RANK() OVER (PARTITION BY ss.country ORDER BY ss.total_sales_amount DESC) AS rank,
    ROUND(
        SUM(ss.total_sales_amount) OVER (
            PARTITION BY ss.country 
            ORDER BY ss.total_sales_amount DESC 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS country_running_total
FROM shop_stats ss
INNER JOIN country_totals ct ON ss.country = ct.country
ORDER BY ss.country, rank" (country,shop_id,address,total_sales_count,total_sales_amount,country_total,"share","rank",country_running_total) VALUES
	 ('Italy',58,'SHOP0058 Robert Mission',6190,258888.26,19077289.38,0.013570,11,19077289.38),
	 ('Poland',72,'SHOP0072 Kiara Gardens',37874,1993748.76,5665698.43,0.351898,1,1993748.76),
	 ('Poland',70,'SHOP0070 Moses Land',12507,1412161.43,5665698.43,0.249248,2,3405910.19),
	 ('Poland',71,'SHOP0071 Candace Plaza',25223,1381393.89,5665698.43,0.243817,3,4787304.08),
	 ('Poland',69,'SHOP0069 Cooper Wells',18840,878394.35,5665698.43,0.155037,4,5665698.43),
	 ('Spain',68,'SHOP0068 Montoya Island',31611,2968952.84,13857301.13,0.214252,1,2968952.84),
	 ('Spain',63,'SHOP0063 Daniels Fork',43886,2260774.42,13857301.13,0.163147,2,5229727.26),
	 ('Spain',66,'SHOP0066 Daniel Centers',44009,2151085.87,13857301.13,0.155231,3,7380813.13),
	 ('Spain',64,'SHOP0064 Kevin Burg',37584,2090537.93,13857301.13,0.150862,4,9471351.06),
	 ('Spain',67,'SHOP0067 Bush Tunnel',37537,1959259.29,13857301.13,0.141388,5,11430610.35);
INSERT INTO "WITH all_shops_stats AS (
   
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        SUM(s.total_price::NUMERIC) AS shop_revenue
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id
),
country_totals AS (
    SELECT 
        country,
        SUM(shop_revenue) AS country_total
    FROM all_shops_stats
    GROUP BY country
),
shop_stats AS (
    
    SELECT 
        c2.country_name AS country,
        sh.shop_id,
        sh.address,
        COUNT(s.sales_id) AS total_sales_count,
        SUM(s.total_price::NUMERIC) AS total_sales_amount
    FROM sales s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN shops sh ON e.shop_id = sh.shop_id
    INNER JOIN cities c ON sh.city_id = c.city_id
    INNER JOIN countries c2 ON c.country_id = c2.country_id
    GROUP BY c2.country_name, sh.shop_id, sh.address
    HAVING COUNT(s.sales_id) >= 2
)
SELECT 
    ss.country,
    ss.shop_id,
    ss.address,
    ss.total_sales_count,
    ROUND(ss.total_sales_amount, 2) AS total_sales_amount,
    ROUND(ct.country_total, 2) AS country_total,
    ROUND((ss.total_sales_amount / ct.country_total)::NUMERIC, 6) AS share,
    RANK() OVER (PARTITION BY ss.country ORDER BY ss.total_sales_amount DESC) AS rank,
    ROUND(
        SUM(ss.total_sales_amount) OVER (
            PARTITION BY ss.country 
            ORDER BY ss.total_sales_amount DESC 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS country_running_total
FROM shop_stats ss
INNER JOIN country_totals ct ON ss.country = ct.country
ORDER BY ss.country, rank" (country,shop_id,address,total_sales_count,total_sales_amount,country_total,"share","rank",country_running_total) VALUES
	 ('Spain',62,'SHOP0062 Paula Mills',44186,1577717.69,13857301.13,0.113855,6,13008328.04),
	 ('Spain',65,'SHOP0065 Jacqueline Crest',18695,848973.09,13857301.13,0.061265,7,13857301.13);
