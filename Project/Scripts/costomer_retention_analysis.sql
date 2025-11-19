WITH MonthlyCustomers AS (
    -- Create a dataset of customers with their standardized purchase month and original dates
    SELECT DISTINCT
        -- Unique customer identifier
        Customer_ID,

        -- Convert the purchase date into the first day of its month (YYYY-MM-01 format)
        PARSE_DATE('%Y-%m-%d', CONCAT(
            -- Extract year-month from the original purchase date
            FORMAT_DATE('%Y-%m', PARSE_DATE('%m/%d/%Y', Time_of_Purchase)), 
            -- Append '-01' to form the first day of that month
            '-01'
        )) AS purchase_month,

        -- Store the original purchase date to determine next purchases
        PARSE_DATE('%m/%d/%Y', Time_of_Purchase) AS original_purchase_date
    FROM
        -- Source table containing customer purchase behavior
        `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact`
),

NextPurchaseDates AS (
    -- Identify the next purchase date for each customer
    SELECT
        -- Customer identifier
        Customer_ID,
        -- Standardized purchase month
        purchase_month,
        -- Exact date the purchase occurred
        original_purchase_date,

        -- Retrieve the next purchase date for the same customer using a window function
        LEAD(original_purchase_date, 1) OVER (
            PARTITION BY Customer_ID 
            ORDER BY original_purchase_date
        ) AS next_purchase_date
    FROM
        -- Use the previously created monthly customer data
        MonthlyCustomers
)

-- Calculate monthly customer retention and repeat purchase metrics
SELECT
    -- Month when the purchase occurred
    purchase_month,

    -- Count of unique customers who purchased in that month
    COUNT(DISTINCT Customer_ID) AS total_customers_start_month,

    -- Count customers who have a subsequent purchase date
    COUNT(DISTINCT CASE 
        WHEN next_purchase_date IS NOT NULL THEN Customer_ID 
        ELSE NULL 
    END) AS repeat_customers,

    -- Retention rate = repeat customers / original customers
    SAFE_DIVIDE(
        COUNT(DISTINCT CASE 
            WHEN next_purchase_date IS NOT NULL THEN Customer_ID 
            ELSE NULL 
        END), 
        -- Total customers for the month
        COUNT(DISTINCT Customer_ID)
    ) AS retention_rate
FROM
    -- Dataset containing purchase sequences
    NextPurchaseDates
GROUP BY
    -- Group results by purchase month
    1
ORDER BY
    -- Sort results chronologically by month
    1;
