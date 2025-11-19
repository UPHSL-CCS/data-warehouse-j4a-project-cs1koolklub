SELECT
    -- Get the day of the week from the purchase date (like 'Monday')
    FORMAT_DATE('%A', PARSE_DATE('%m/%d/%Y', Time_of_Purchase)) AS day_of_week,
    
    -- Add up all the sales made on that day
    SUM(CAST(REPLACE(Purchase_Amount, '$', '') AS NUMERIC)) AS total_sales
FROM
    `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact`
GROUP BY
    day_of_week  -- Group sales by each day of the week
ORDER BY
    total_sales DESC;  -- Show the days with the highest sales first
