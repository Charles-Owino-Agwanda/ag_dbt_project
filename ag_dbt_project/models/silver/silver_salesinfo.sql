WITH sales AS 
(
    SELECT
        sales_id,
        product_sk,
        customer_sk,
        gross_amount,
        {{ multiply('unit_price', 'quantity')}} AS calculated_amount,
        payment_method
    FROM 
        {{ ref('bronze_sale') }}
), 
products AS 
(
    SELECT
        product_sk,
        category
    FROM 
        {{ ref('bronze_dim_product') }}
),

customers AS 
(
    SELECT
        customer_sk,
        gender
    FROM 
        {{ ref('bronze_dim_customers') }}
), 
Joined_query AS 
(
    SELECT
        s.sales_id,
        p.category,
        c.gender,
        s.calculated_amount,
        s.payment_method
    FROM
        sales s
    JOIN
        products p ON s.product_sk = p.product_sk
    JOIN
        customers c ON s.customer_sk = c.customer_sk
)

SELECT
    category,
    gender,
    sum(calculated_amount) AS total_gross_amount
FROM
    Joined_query
group by
    category,
    gender
order by
    total_gross_amount desc