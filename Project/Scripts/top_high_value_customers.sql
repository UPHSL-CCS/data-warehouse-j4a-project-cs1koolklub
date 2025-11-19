SELECT
    -- Look at each customer
    Customer_ID,
    
    -- Count how many times this customer made purchases
    COUNT(*) AS frequency_of_purchases,
    
    -- Add up how much money this customer spent
    SUM(CAST(REPLACE(Purchase_Amount, '$', '') AS NUMERIC)) AS total_monetary_value
FROM
    `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact`
GROUP BY
    Customer_ID  -- Group data by each customer
ORDER BY
    total_monetary_value DESC,  -- Sort by who spent the most
    frequency_of_purchases DESC -- If same amount, sort by number of purchases
LIMIT 10;  -- Only show top 10 customers
