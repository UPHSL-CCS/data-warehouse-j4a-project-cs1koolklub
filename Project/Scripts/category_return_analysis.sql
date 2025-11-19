-- Select fields to analyze return behavior by product category
SELECT
    -- The product category being evaluated
    Purchase_Category,
    
    -- Total number of returns summed across all transactions in the category
    SUM(Return_Rate) AS total_returns,
    
    -- Total number of transactions for that category
    COUNT(*) AS total_transactions,
    
    -- Return rate for the category calculated as total returns divided by total transactions
    (SUM(Return_Rate) / COUNT(*)) AS category_return_rate
FROM
    -- Source table containing customer behavior and purchase data
    `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact`
GROUP BY
    -- Group results by product category to aggregate metrics correctly
    Purchase_Category
ORDER BY
    -- Sort categories from highest to lowest return rate
    category_return_rate DESC;
