INSERT INTO "SELECT 
    DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP) AS sale_month,
    SUM(s.total_price) AS monthly_revenue,
    COALESCE(LAG(SUM(s.total_price)) OVER (ORDER BY DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP)),0) AS previous_month_revenue,
    SUM(s.total_price) - coalesce(LAG(SUM(s.total_price)) OVER (ORDER BY DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP)),0) AS revenue_diff_vs_previous
FROM sales s
INNER JOIN employees e ON s.employee_id = e.employee_id
INNER JOIN shops sh ON e.shop_id = sh.shop_id
INNER JOIN cities c ON sh.city_id = c.city_id
INNER JOIN countries c2 ON c.country_id = c2.country_id
WHERE c2.country_name = 'Germany'
  AND s.sales_timestamp IS NOT NULL
  AND s.sales_timestamp != ''
  AND s.sales_timestamp != ' '
GROUP BY DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP)
ORDER BY sale_month" (sale_month,monthly_revenue,previous_month_revenue,revenue_diff_vs_previous) VALUES
	 ('2022-01-01 00:00:00',2637846.0,0.0,2637846.0),
	 ('2022-02-01 00:00:00',2710825.5,2637846.0,72979.5),
	 ('2022-03-01 00:00:00',2686530.5,2710825.5,-24295.0),
	 ('2022-04-01 00:00:00',2597119.0,2686530.5,-89411.5),
	 ('2022-05-01 00:00:00',2807936.5,2597119.0,210817.5),
	 ('2022-06-01 00:00:00',3166331.0,2807936.5,358394.5),
	 ('2022-07-01 00:00:00',3805560.5,3166331.0,639229.5),
	 ('2022-08-01 00:00:00',3066427.8,3805560.5,-739132.75),
	 ('2022-09-01 00:00:00',2750300.8,3066427.8,-316127.0),
	 ('2022-10-01 00:00:00',2704765.5,2750300.8,-45535.25);
INSERT INTO "SELECT 
    DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP) AS sale_month,
    SUM(s.total_price) AS monthly_revenue,
    COALESCE(LAG(SUM(s.total_price)) OVER (ORDER BY DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP)),0) AS previous_month_revenue,
    SUM(s.total_price) - coalesce(LAG(SUM(s.total_price)) OVER (ORDER BY DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP)),0) AS revenue_diff_vs_previous
FROM sales s
INNER JOIN employees e ON s.employee_id = e.employee_id
INNER JOIN shops sh ON e.shop_id = sh.shop_id
INNER JOIN cities c ON sh.city_id = c.city_id
INNER JOIN countries c2 ON c.country_id = c2.country_id
WHERE c2.country_name = 'Germany'
  AND s.sales_timestamp IS NOT NULL
  AND s.sales_timestamp != ''
  AND s.sales_timestamp != ' '
GROUP BY DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP)
ORDER BY sale_month" (sale_month,monthly_revenue,previous_month_revenue,revenue_diff_vs_previous) VALUES
	 ('2022-11-01 00:00:00',3000719.5,2704765.5,295954.0),
	 ('2022-12-01 00:00:00',3274583.2,3000719.5,273863.75),
	 ('2023-01-01 00:00:00',2835330.2,3274583.2,-439253.0),
	 ('2023-02-01 00:00:00',2584144.0,2835330.2,-251186.25),
	 ('2023-03-01 00:00:00',2697721.8,2584144.0,113577.75),
	 ('2023-04-01 00:00:00',2653231.8,2697721.8,-44490.0),
	 ('2023-05-01 00:00:00',2865419.5,2653231.8,212187.75),
	 ('2023-06-01 00:00:00',3096726.8,2865419.5,231307.25),
	 ('2023-07-01 00:00:00',3827575.8,3096726.8,730849.0),
	 ('2023-08-01 00:00:00',3035741.5,3827575.8,-791834.25);
INSERT INTO "SELECT 
    DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP) AS sale_month,
    SUM(s.total_price) AS monthly_revenue,
    COALESCE(LAG(SUM(s.total_price)) OVER (ORDER BY DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP)),0) AS previous_month_revenue,
    SUM(s.total_price) - coalesce(LAG(SUM(s.total_price)) OVER (ORDER BY DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP)),0) AS revenue_diff_vs_previous
FROM sales s
INNER JOIN employees e ON s.employee_id = e.employee_id
INNER JOIN shops sh ON e.shop_id = sh.shop_id
INNER JOIN cities c ON sh.city_id = c.city_id
INNER JOIN countries c2 ON c.country_id = c2.country_id
WHERE c2.country_name = 'Germany'
  AND s.sales_timestamp IS NOT NULL
  AND s.sales_timestamp != ''
  AND s.sales_timestamp != ' '
GROUP BY DATE_TRUNC('month', s.sales_timestamp::TIMESTAMP)
ORDER BY sale_month" (sale_month,monthly_revenue,previous_month_revenue,revenue_diff_vs_previous) VALUES
	 ('2023-09-01 00:00:00',2829692.0,3035741.5,-206049.5),
	 ('2023-10-01 00:00:00',2759847.2,2829692.0,-69844.75),
	 ('2023-11-01 00:00:00',2898611.2,2759847.2,138764.0),
	 ('2023-12-01 00:00:00',3289179.5,2898611.2,390568.25);
