use magist;
describe customers;
describe products;

/*1. How many orders are there in the dataset? */
SELECT 
    COUNT(*) AS order_count
FROM
    orders;
    
/* 2.Are orders actually delivered? */
   SELECT 
    order_status, COUNT(order_status)
FROM
    orders
GROUP BY order_status;
      
/* Is Magist having user growth? A platform losing users left and right isn’t going to be very useful to us. 
It would be a good idea to check for the number of orders grouped by year and month.*/
SELECT 
    YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_,
    COUNT(customer_id)
FROM
    orders
GROUP BY year_ , month_
ORDER BY year_ , month_;

/*4.How many products are there on the products table?*/

SELECT 
    COUNT(DISTINCT (product_id)) AS productcount
FROM
    products;-- 32951

/* 5.Which are the categories with the most products?*/
SELECT 
    product_category_name, COUNT(DISTINCT product_id) as n_products
FROM
    products
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC;

/*6.How many of those products were present in actual transactions? */
SELECT 
	count(DISTINCT product_id) AS n_products
FROM
	order_items;
    
/*7.What’s the price for the most expensive and cheapest products? */
   SELECT 
    MAX(price) AS most_expensive, MIN(price) AS cheapest
FROM
    order_items;
   -- most expensive  6735 with product ID
SELECT 
    MAX(o.price), p.product_id
FROM
    products P
        JOIN
    order_items o USING (product_id)
GROUP BY p.product_id
ORDER BY MAX(price) DESC
LIMIT 1; 
    
-- cheapest expensive with product ID 0.85 
SELECT 
    MIN(o.price), p.product_id
FROM
    products P
        JOIN
    order_items o USING (product_id)
GROUP BY p.product_id
ORDER BY MIN(price)
LIMIT 1; 

/*8.What are the highest and lowest payment values? */
SELECT 
    MAX(payment_value), MIN(payment_value)
FROM
    order_payments;
-- max and min payments with order_id
SELECT 
    order_id, MAX(payment_value)
FROM
    order_payments
GROUP BY order_id
ORDER BY MAX(payment_value) DESC
LIMIT 1;

SELECT 
    order_id, MIN(payment_value)
FROM
    order_payments
GROUP BY order_id
ORDER BY MIN(payment_value)
LIMIT 1;

