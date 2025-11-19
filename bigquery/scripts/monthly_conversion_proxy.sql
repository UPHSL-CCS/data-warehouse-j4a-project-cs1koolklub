SELECT
    -- Get the year and month from the purchase date
    FORMAT_DATE('%Y-%m', PARSE_DATE('%m/%d/%Y', Time_of_Purchase)) AS purchase_month,
    
    -- Count how many unique customers made purchases in that month
    COUNT(DISTINCT Customer_ID) AS total_customers,
    
    -- Find the average purchase amount per customer
    (SUM(CAST(REPLACE(Purchase_Amount, '$', '') AS NUMERIC)) / COUNT(DISTINCT Customer_ID)) AS avg_purchase_per_customer
FROM
    `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact` 
GROUP BY
    purchase_month  -- Group data by each month
ORDER BY
    purchase_month; -- Show results in month order
