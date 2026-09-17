use magist;
describe customers;
describe products;

-- 2.2. In relation to the sellers:
-- 2.2.1  How many months of data are included in the magist database?*/
SELECT 
    MIN(order_purchase_timestamp) AS firstdate,
    MAX(order_purchase_timestamp) AS lastdate,
    TIMESTAMPDIFF(MONTH,
        MIN(order_purchase_timestamp),
        MAX(order_purchase_timestamp)) AS months_of_data
FROM
    orders;
    
    -- 2.2.2 How many sellers are there?  
 SELECT 
    COUNT(DISTINCT (seller_id)) AS countseller
FROM
    sellers;
    
-- 2.2.3 How many Tech sellers are there?
   /* tech products :: 'audio','cds_dvds_musicals','cine_photo','consoles_games','dvds_blu_ray',
'electronics','small_appliances','computers_accessories','pc_gamer','computers','telephony','fixed_telephony'*/
 
SELECT 
    COUNT(DISTINCT S.seller_id) AS tech_sellers
FROM
    sellers S
        JOIN
    order_items OI USING (seller_id)
        JOIN
    products P USING (product_id)
        JOIN
    product_category_name_translation PN USING (product_category_name)
WHERE
    PN.product_category_name IN ('audio' , 'cds_dvds_musicals',
        'cine_photo',
        'consoles_games',
        'dvds_blu_ray',
        'electronics',
        'small_appliances',
        'computers_accessories',
        'pc_gamer',
        'computers',
        'telephony',
        'fixed_telephony');
   
   
-- 2.2.4 What percentage of overall sellers are Tech sellers?
      
    SELECT 
    ROUND(COUNT(DISTINCT CASE
                    WHEN
                        PN.product_category_name IN ('audio' , 'cds_dvds_musicals',
                            'cine_photo',
                            'consoles_games',
                            'dvds_blu_ray',
                            'electronics',
                            'small_appliances',
                            'computers_accessories',
                            'pc_gamer',
                            'computers',
                            'telephony',
                            'fixed_telephony')
                    THEN
                        S.seller_id
                END) * 100.0 / COUNT(DISTINCT S.seller_id)) AS tech_sellers_percent
FROM
    sellers S
        JOIN
    order_items OI USING (seller_id)
        JOIN
    products P USING (product_id)
        JOIN
    product_category_name_translation PN USING (product_category_name);
  
   
-- 2.2.5  What is the total amount earned by all sellers? payment_value from order_payments table 
 
   SELECT 
    ROUND(SUM(OP.payment_value), 2) AS total_amount_earned
FROM
    order_payments OP
        JOIN
    orders O USING (order_id)
WHERE
    O.order_status = 'delivered';
 
 -- 2.2.5.1 amount earned by each seller 
   SELECT 
    OI.seller_id,
    SUM(OP.payment_value) AS amount_earned_each_seller
FROM
    order_payments OP
        LEFT JOIN
    orders O USING (order_id)
        JOIN
    order_items OI USING (order_id)
WHERE
    order_status = 'delivered'
GROUP BY OI.seller_id;
  
 -- 2.2.6 What is the total amount earned by all Tech sellers?
 SELECT 
    ROUND(SUM(OP.payment_value), 2) AS AMOUNT_tech_sellers
FROM
    order_payments OP
        JOIN
    orders O USING (order_id)
        JOIN
    order_items OI USING (order_id)
        JOIN
    products P USING (product_id)
        JOIN
    product_category_name_translation PN USING (product_category_name)
WHERE
    PN.product_category_name IN ('audio' , 'cds_dvds_musicals',
        'cine_photo',
        'consoles_games',
        'dvds_blu_ray',
        'electronics',
        'small_appliances',
        'computers_accessories',
        'pc_gamer',
        'computers',
        'telephony',
        'fixed_telephony')
        AND order_status = 'delivered';

-- 2.2.7 Can you work out the average monthly income of all sellers? 

SELECT 
    AVG(payment_value)
FROM
    order_payments
        LEFT JOIN
    orders USING (order_id)
        LEFT JOIN
    order_items USING (order_id);

-- 2.2.8 Can you work out the average monthly income of Tech sellers?
  
WITH monthly_seller_revenue AS (

    SELECT

        oi.seller_id,

        DATE_FORMAT(
            o.order_purchase_timestamp,
            '%Y-%m'
        ) AS sale_month,

        SUM(oi.price) AS monthly_revenue

    FROM order_items oi

    JOIN orders o
        ON oi.order_id = o.order_id

    JOIN products p
        ON oi.product_id = p.product_id

    JOIN product_category_name_translation pct
        ON p.product_category_name =
           pct.product_category_name

    WHERE o.order_status = 'delivered'

    AND pct.product_category_name_english IN (
        'computers',
        'electronics',
        'telephony',
        'tablets_printing_image'
    )

    GROUP BY
        oi.seller_id,
        sale_month

)

SELECT

    seller_id,

    AVG(monthly_revenue) AS average_monthly_income

FROM monthly_seller_revenue

GROUP BY seller_id

ORDER BY average_monthly_income DESC;
-- 2.2.9 seller with different geo earnings 
SELECT 
    COUNT(DISTINCT (state))
FROM
    geo;

-- 2.2.10 How many sellers have made at least one sale?
SELECT 
    COUNT(DISTINCT oi.seller_id) AS sellers_with_sales
FROM
    order_items oi
        JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'delivered';
    
-- 2.2.11 How many sellers have never sold anything?
SELECT 
    COUNT(*) AS sellers_without_sales
FROM
    sellers s
        LEFT JOIN
    order_items oi ON s.seller_id = oi.seller_id
        LEFT JOIN
    orders o ON oi.order_id = o.order_id
        AND o.order_status = 'delivered'
WHERE
    o.order_id IS NULL;

-- 2.2.12 Which states have the most sellers?
SELECT 
    g.state, COUNT(DISTINCT s.seller_id) AS seller_count
FROM
    sellers s
        JOIN
    geo g ON s.seller_zip_code_prefix = g.zip_code_prefix
GROUP BY g.state
ORDER BY seller_count DESC;

-- 2.2.13 Which cities have the most sellers?
SELECT 
    g.city, g.state, COUNT(DISTINCT s.seller_id) AS seller_count
FROM
    sellers s
        JOIN
    geo g ON s.seller_zip_code_prefix = g.zip_code_prefix
GROUP BY g.city , g.state
ORDER BY seller_count DESC;

-- Revenue Analysis
-- 2.2.14 What is the total amount earned by all sellers?
SELECT 
    SUM(oi.price) AS total_revenue
FROM
    order_items oi
        JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'delivered';

-- 2.2.15 What is the total amount earned by Tech sellers?
SELECT 
    SUM(oi.price) AS tech_revenue
FROM
    order_items oi
        JOIN
    orders o ON oi.order_id = o.order_id
        JOIN
    products p ON oi.product_id = p.product_id
        JOIN
    product_category_name_translation pct ON p.product_category_name = pct.product_category_name
WHERE
    o.order_status = 'delivered'
        AND pct.product_category_name_english IN ('computers' , 'electronics',
        'telephony',
        'tablets_printing_image');
