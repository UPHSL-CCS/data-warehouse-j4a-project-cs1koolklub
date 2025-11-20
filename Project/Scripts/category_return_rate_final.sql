-- VIEW: category_return_analysis_FINAL_FIX
-- PURPOSE: Corrects the return rate calculation by treating any non-binary
--          value in Return_Rate (like '2') as a single return (1).

SELECT
    Purchase_Category,
    
    -- STEP 1: FIX THE CONTAMINATED DATA
    -- Use a CASE statement to ensure the numerator only sums 1s (or 0s).
    -- If Return_Rate > 0, we count it as 1 return.
    SUM(
        CASE 
            WHEN Return_Rate > 0 THEN 1 
            ELSE 0 
        END
    ) AS total_returned_items_cleaned,
    
    -- STEP 2: DENOMINATOR (Total Items Sold)
    COUNT(*) AS total_items_sold,
    
    -- STEP 3: FINAL RATIO
    -- Multiplied by 1.0 to ensure FLOAT division.
    (SUM(CASE WHEN Return_Rate > 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) AS category_return_rate_final
    
FROM
    `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact`
    
GROUP BY
    Purchase_Category
    
ORDER BY
    category_return_rate_final DESC