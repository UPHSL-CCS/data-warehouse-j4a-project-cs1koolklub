SELECT
    -- Look at each product category
    Purchase_Category,
    
    -- Add up all the returns in this category
    SUM(Return_Rate) AS total_returns,
    
    -- Count all transactions in this category
    COUNT(*) AS total_transactions,
    
    -- Calculate return rate for the category (returns ÷ total transactions)
    (SUM(Return_Rate) / COUNT(*)) AS category_return_rate
FROM
    `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact`
GROUP BY
    Purchase_Category  -- Group the data by category
ORDER BY
    category_return_rate DESC;  -- Show categories with highest return rates first
