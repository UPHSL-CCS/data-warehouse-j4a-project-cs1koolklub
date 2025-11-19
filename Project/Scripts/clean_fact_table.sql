SELECT
    -- Remove the dollar sign and convert to a number
    CAST(REPLACE(Purchase_Amount, '$', '') AS NUMERIC) AS Purchase_Amount_Clean,

    -- Keep all other columns except the old Purchase_Amount
    * EXCEPT(Purchase_Amount)

FROM
    -- Main fact table
    `finals-project-478510.ecommerce_data.Consumer_Behavior_Fact`;
