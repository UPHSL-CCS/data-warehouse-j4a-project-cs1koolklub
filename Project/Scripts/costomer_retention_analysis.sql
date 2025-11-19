WITH MonthlyCustomers AS (
    -- Get each customer and the month when they made a purchase
    SELECT DISTINCT
        Customer_ID,

        -- Change the purchase date into the first day of the month (YYYY-MM-01)
        PARSE_DATE('%Y-%m-%d', CONCAT(
            FORMAT_DATE('%Y-%m', PARSE_DATE('%m/%d/%Y', Time_of_Purchase)), '-01'
        )) AS purchase_month,

        -- Keep the full original purchase date
        PARSE_DATE('%m/%d/%Y', Time_of_Purchase) AS original_purchase_date
    FROM
        `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact`
),

NextPurchaseDates AS (
    -- Find the customer’s next purchase date after their current purchase
    SELECT
        Customer_ID,
        purchase_month,
        original_purchase_date,

        -- Get the next purchase date for the same customer
        LEAD(original_purchase_date, 1) OVER (PARTITION BY Customer_ID ORDER BY original_purchase_date) AS next_purchase_date
    FROM
        MonthlyCustomers
)

-- Calculate repeat purchase rate
SELECT
    purchase_month,

    -- Count customers who bought something this month
    COUNT(DISTINCT Customer_ID) AS total_customers_start_month,

    -- Count customers who have any next purchase
    COUNT(DISTINCT CASE 
        WHEN next_purchase_date IS NOT NULL THEN Customer_ID 
        ELSE NULL 
    END) AS repeat_customers,

    -- Repeat purchase rate = repeat customers / total customers
    SAFE_DIVIDE(
        COUNT(DISTINCT CASE 
            WHEN next_purchase_date IS NOT NULL THEN Customer_ID 
            ELSE NULL 
        END), 
        COUNT(DISTINCT Customer_ID)
    ) AS retention_rate
FROM
    NextPurchaseDates
GROUP BY
    1
ORDER BY
    1;
