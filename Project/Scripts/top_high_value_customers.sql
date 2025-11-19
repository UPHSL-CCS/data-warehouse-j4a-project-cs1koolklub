-- Select fields needed to analyze customer purchasing behavior
SELECT
    -- Unique identifier for each customer
    Customer_ID,
    
    -- Total number of purchases made by this customer
    COUNT(*) AS frequency_of_purchases,
    
    -- Total amount spent by this customer (convert string $ amount to numeric)
    SUM(CAST(REPLACE(Purchase_Amount, '$', '') AS NUMERIC)) AS total_monetary_value
FROM
    -- Source table containing transaction-level consumer behavior data
    `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact`
GROUP BY
    -- Aggregate results for each customer separately
    Customer_ID
ORDER BY
    -- Sort customers from highest spender to lowest
    total_monetary_value DESC,
    -- If monetary values match, sort by number of purchases
    frequency_of_purchases DESC
LIMIT 10;  
    -- Return only the top 10 customers based on spending and frequency
