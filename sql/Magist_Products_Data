use magist;
describe customers;
describe products;
/*  
If you went through the lesson on Eniac’s strategy, you should remember that the company has two main concerns. 
In summary:
    Is Magist a good fit for high-end tech products?
    Are orders delivered on time?
*/
-- 1 What categories of tech products does Magist have?
SELECT DISTINCT
    pct.product_category_name_english AS tech_category

FROM product_category_name_translation pct

WHERE pct.product_category_name_english IN (
    'computers',
    'electronics',
    'telephony',
    'tablets_printing_image'
)

ORDER BY tech_category;

-- 2 How many products of these tech categories have been sold? 
-- What percentage does that represent from the overall number of products sold?
SELECT

    COUNT(DISTINCT CASE
        WHEN pct.product_category_name_english IN (
            'computers',
            'electronics',
            'telephony',
            'tablets_printing_image'
        )
        THEN oi.product_id
    END) AS tech_products_sold,

    COUNT(DISTINCT oi.product_id) AS total_products_sold,

    ROUND(

        COUNT(DISTINCT CASE
            WHEN pct.product_category_name_english IN (
                'computers',
                'electronics',
                'telephony',
                'tablets_printing_image'
            )
            THEN oi.product_id
        END) * 100.0
        / COUNT(DISTINCT oi.product_id),

        2

    ) AS tech_product_percentage

FROM order_items oi

JOIN orders o
    ON oi.order_id = o.order_id

JOIN products p
    ON oi.product_id = p.product_id

JOIN product_category_name_translation pct
    ON p.product_category_name =
       pct.product_category_name

WHERE o.order_status = 'delivered';

-- 3 What’s the average price of the products being sold?
SELECT

    ROUND(
        AVG(oi.price),
        2
    ) AS average_product_price

FROM order_items oi

JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered';

-- 4 Are expensive tech products popular? */
 SELECT

    pct.product_category_name_english AS category,

    ROUND(
        AVG(oi.price),
        2
    ) AS average_price,

    COUNT(*) AS products_sold

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

GROUP BY category

ORDER BY average_price DESC;
 
-- 5. Which product category has the most products?
SELECT

    product_category_name,

    COUNT(DISTINCT product_id) AS product_count

FROM products

GROUP BY product_category_name

ORDER BY product_count DESC;
-- 6. What are the top 10 largest categories by product count?
SELECT

    product_category_name,

    COUNT(DISTINCT product_id) AS product_count

FROM products

GROUP BY product_category_name

ORDER BY product_count DESC

LIMIT 10;

-- Sales Questions
-- 7. How many Tech products have been sold?
SELECT

    COUNT(*) AS tech_products_sold

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
  );

-- 8. Which Tech products are sold the most?
SELECT

    oi.product_id,

    pct.product_category_name_english AS category,

    COUNT(*) AS products_sold

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
    oi.product_id,
    category

ORDER BY products_sold DESC;


-- 9. What percentage of all sales come from Tech products?
SELECT

    ROUND(

        SUM(
            CASE
                WHEN pct.product_category_name_english IN (
                    'computers',
                    'electronics',
                    'telephony',
                    'tablets_printing_image'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),

        2

    ) AS tech_sales_percentage

FROM order_items oi

JOIN orders o
    ON oi.order_id = o.order_id

JOIN products p
    ON oi.product_id = p.product_id

JOIN product_category_name_translation pct
    ON p.product_category_name =
       pct.product_category_name

WHERE o.order_status = 'delivered';

-- 10. Which product categories generate the most revenue?
SELECT

    pct.product_category_name_english AS category,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_revenue

FROM order_items oi

JOIN orders o
    ON oi.order_id = o.order_id

JOIN products p
    ON oi.product_id = p.product_id

JOIN product_category_name_translation pct
    ON p.product_category_name =
       pct.product_category_name

WHERE o.order_status = 'delivered'

GROUP BY category

ORDER BY total_revenue DESC;


-- 12. What is the average price of products?
SELECT

    ROUND(
        AVG(oi.price),
        2
    ) AS average_price

FROM order_items oi

JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered';

-- 13. What is the average price of Tech products?
SELECT

    ROUND(
        AVG(oi.price),
        2
    ) AS average_tech_price

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
  );


-- 14. Which Tech categories contribute the most revenue?
SELECT

    oi.product_id,

    pct.product_category_name_english AS category,

    ROUND(
        SUM(oi.price),
        2
    ) AS product_revenue

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
    oi.product_id,
    category

ORDER BY product_revenue DESC

LIMIT 10;

