use magist;
describe customers;
describe products;
/*2.3. In relation to the delivery time:

2.3.1 What’s the average time between the order being placed and the product being delivered?*/
    SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS avg_delivery_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;
  
/* 2.3.2 How many orders are delivered on time vs orders delivered with a delay?*/
   SELECT
    CASE
        WHEN order_delivered_customer_date
             <= order_estimated_delivery_date
        THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_status,

    COUNT(*) AS order_count

FROM orders

WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL

GROUP BY delivery_status;

/* 2.3.3 Is there any pattern for delayed orders, e.g. big products being delayed more often?*/
SELECT
    CASE
        WHEN p.product_weight_g < 1000 THEN 'Small'
        WHEN p.product_weight_g < 5000 THEN 'Medium'
        ELSE 'Large'
    END AS product_size,

    COUNT(DISTINCT o.order_id) AS total_orders,

    SUM(
        CASE
            WHEN o.order_delivered_customer_date
                 > o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS delayed_orders,

    ROUND(
        SUM(
            CASE
                WHEN o.order_delivered_customer_date
                     > o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(DISTINCT o.order_id),
        2
    ) AS delayed_percentage

FROM orders o

JOIN order_items oi
    ON o.order_id = oi.order_id

JOIN products p
    ON oi.product_id = p.product_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
  AND p.product_weight_g IS NOT NULL

GROUP BY product_size

ORDER BY delayed_percentage DESC;
   
-- 2.3.3 What is the average delivery time for Tech products?
SELECT
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),
        2
    ) AS avg_tech_delivery_days

FROM orders o

JOIN order_items oi
    ON o.order_id = oi.order_id

JOIN products p
    ON oi.product_id = p.product_id

JOIN product_category_name_translation pct
    ON p.product_category_name =
       pct.product_category_name

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL

  AND pct.product_category_name_english IN (
      'computers',
      'electronics',
      'telephony',
      'tablets_printing_image'
  );
/*2.3.4 Do Tech products take longer to deliver than non-Tech products?*/
SELECT

    CASE
        WHEN pct.product_category_name_english IN (
            'computers',
            'electronics',
            'telephony',
            'tablets_printing_image'
        )
        THEN 'Tech'
        ELSE 'Non-Tech'
    END AS product_type,

    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),
        2
    ) AS avg_delivery_days

FROM orders o

JOIN order_items oi
    ON o.order_id = oi.order_id

JOIN products p
    ON oi.product_id = p.product_id

JOIN product_category_name_translation pct
    ON p.product_category_name =
       pct.product_category_name

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL

GROUP BY product_type;

/*2.3.5 What is the minimum, maximum, and average delivery time?*/
SELECT

    MIN(
        DATEDIFF(
            order_delivered_customer_date,
            order_purchase_timestamp
        )
    ) AS min_delivery_days,

    MAX(
        DATEDIFF(
            order_delivered_customer_date,
            order_purchase_timestamp
        )
    ) AS max_delivery_days,

    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS avg_delivery_days

FROM orders

WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;
  
/*2.3.6 How many orders were delivered on time?*/

SELECT
    COUNT(*) AS on_time_orders

FROM orders

WHERE order_status = 'delivered'

  AND order_delivered_customer_date
      <= order_estimated_delivery_date;
      
-- 2.3.7. How many orders were delivered late?
SELECT
    COUNT(*) AS late_orders

FROM orders

WHERE order_status = 'delivered'

  AND order_delivered_customer_date
      > order_estimated_delivery_date;
      
-- 2.3.8. What percentage of orders were delivered late?
SELECT ROUND(
    SUM(
        CASE
            WHEN order_delivered_customer_date >
                 order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(*),
    2
) AS late_delivery_pct
FROM orders
WHERE order_status = 'delivered';
-- 2.3.9. What percentage of Tech orders were delivered late?
WITH tech_orders AS (

    SELECT DISTINCT
        o.order_id,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date

    FROM orders o

    JOIN order_items oi
        ON o.order_id = oi.order_id

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

)

SELECT

    ROUND(

        SUM(
            CASE
                WHEN order_delivered_customer_date
                     > order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),

        2

    ) AS late_tech_percentage

FROM tech_orders

WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;


-- 2.3.10. By how many days are late orders delayed on average?
SELECT

    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_estimated_delivery_date
            )
        ),
        2
    ) AS avg_delay_days

FROM orders

WHERE order_status = 'delivered'

  AND order_delivered_customer_date
      > order_estimated_delivery_date;
      
-- 2.3.11. Which seller has the fastest average delivery time?
SELECT

    oi.seller_id,

    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),
        2
    ) AS avg_delivery_days

FROM order_items oi

JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL

GROUP BY oi.seller_id

ORDER BY avg_delivery_days ASC

LIMIT 1;

-- 2.3.12 Average delivery time for all orders.
SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS avg_delivery_days
FROM orders
WHERE order_status = 'delivered';




