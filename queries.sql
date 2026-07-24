-- Query 1: Repeat customers by traffic source
-- (Where do loyal, repeat-buying customers come from?)

SELECT 
  traffic_source,
  COUNT(DISTINCT user_id) AS total_customers,
  COUNTIF(purchase_rank = 1) AS first_time_buyers,
  COUNTIF(purchase_rank > 1) AS repeat_purchases
FROM (
  SELECT 
    o.user_id, u.traffic_source, o.order_id,
    RANK() OVER (PARTITION BY o.user_id ORDER BY o.created_at) AS purchase_rank
  FROM `bigquery-public-data.thelook_ecommerce.orders` o
  JOIN `bigquery-public-data.thelook_ecommerce.users` u ON o.user_id = u.id
)
GROUP BY traffic_source
ORDER BY total_customers DESC;
 
 
-- Query 2: How many customers return within 30 days of their first order?
-- (Grouped by the month they first joined = "cohort")

SELECT 
  FORMAT_DATE('%Y-%m', DATE(first_date)) AS cohort_month,
  COUNT(DISTINCT user_id) AS cohort_size,
  COUNTIF(days_to_next <= 30) AS retained_30day
FROM (
  SELECT 
    user_id,
    MIN(created_at) OVER (PARTITION BY user_id) AS first_date,
    DATE_DIFF(created_at, MIN(created_at) OVER (PARTITION BY user_id), DAY) AS days_to_next
  FROM `bigquery-public-data.thelook_ecommerce.orders`
)
WHERE days_to_next > 0
GROUP BY cohort_month
ORDER BY cohort_month;
 
 
-- Query 3a: Customers with 3+ orders, grouped by traffic source

SELECT 
  u.traffic_source,
  COUNT(DISTINCT sub.user_id) AS frequent_buyers
FROM (
  SELECT user_id, COUNT(DISTINCT order_id) AS total_orders
  FROM `bigquery-public-data.thelook_ecommerce.orders`
  GROUP BY user_id
  HAVING total_orders >= 3
) sub
JOIN `bigquery-public-data.thelook_ecommerce.users` u ON sub.user_id = u.id
GROUP BY u.traffic_source
ORDER BY frequent_buyers DESC;
 
-- Query 3b: Total customers per traffic source
-- (Needed to calculate repeat RATE, not just raw count -- see Query 3a)

SELECT 
  traffic_source,
  COUNT(DISTINCT id) AS total_customers
FROM `bigquery-public-data.thelook_ecommerce.users`
GROUP BY traffic_source
ORDER BY total_customers DESC;
 
 
-- Query 4: Which products get bought more than once by the same person?

SELECT 
  p.name AS product_name,
  COUNT(oi.order_id) AS times_purchased,
  COUNT(DISTINCT oi.user_id) AS unique_buyers
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p ON oi.product_id = p.id
GROUP BY p.name
HAVING times_purchased > unique_buyers
ORDER BY times_purchased DESC
LIMIT 20;
 
 
-- Query 5: How many days pass between a customer's 1st and 2nd order?

SELECT 
  DATE_DIFF(o2.created_at, o1.created_at, DAY) AS days_between_orders
FROM `bigquery-public-data.thelook_ecommerce.orders` o1
JOIN `bigquery-public-data.thelook_ecommerce.orders` o2 
  ON o1.user_id = o2.user_id AND o2.created_at > o1.created_at
QUALIFY ROW_NUMBER() OVER (PARTITION BY o1.user_id ORDER BY o2.created_at) = 1
ORDER BY days_between_orders;
 
 
-- Query 6: How many customers made at least a 2nd order? (true repeat rate)

SELECT 
  COUNT(DISTINCT user_id) AS customers_with_2plus_orders
FROM (
  SELECT user_id, COUNT(DISTINCT order_id) AS total_orders
  FROM `bigquery-public-data.thelook_ecommerce.orders`
  GROUP BY user_id
  HAVING total_orders >= 2
);