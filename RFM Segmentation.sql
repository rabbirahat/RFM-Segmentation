-- Select all data from the rfmdata table to check its initial state
SELECT * FROM rfm_analysis.rfmdata;

-- Update the `ORDERDATE.1` column to convert the string date format (dd/mm/yyyy) into a proper DATE format
UPDATE rfmdata
SET `ORDERDATE.1` = STR_TO_DATE(`ORDERDATE.1`, '%d/%m/%Y');

-- Check the updated rfmdata table to ensure that the date conversion was successful
SELECT * FROM rfmdata;

-- Common Table Expression (CTE) 1: Aggregate RFM metrics (Recency, Frequency, Monetary Value) for each customer
WITH cte1 AS (
    SELECT 
        customername,  -- Customer name
        ROUND(SUM(sales), 2) AS monetary_value,  -- Total monetary value of sales for the customer
        ROUND(AVG(sales), 2) AS avg_monetary_value,  -- Average sales per order for the customer
        COUNT(DISTINCT ordernumber) AS frequency,  -- Count of unique orders by the customer
        MAX(`ORDERDATE.1`) AS last_order_date,  -- Most recent order date for the customer
        (SELECT MAX(`ORDERDATE.1`) FROM rfmdata) AS final_date  -- Latest order date across all customers
    FROM rfmdata
    GROUP BY customername
),

-- CTE 2: Calculate the Recency for each customer (days since the last order)
cte2 AS (
    SELECT 
        *, 
        DATEDIFF(final_date, last_order_date) + 1 AS recency  -- Recency in days since the last order
    FROM cte1
    ORDER BY recency  -- Order by recency for easier analysis
),

-- CTE 3: Assign RFM scores to each customer using quartile-based segmentation
cte3 AS (
    SELECT 
        *,
        NTILE(4) OVER (ORDER BY recency DESC) AS rfm_recency,  -- Recency score (1 to 4, with 4 being least recent)
        NTILE(4) OVER (ORDER BY frequency) AS rfm_frequency,  -- Frequency score (1 to 4, with 4 being most frequent)
        NTILE(4) OVER (ORDER BY monetary_value) AS rfm_monetary  -- Monetary score (1 to 4, with 4 being the highest spenders)
    FROM cte2
),

-- CTE 4: Combine RFM scores into a single RFM_SCORE
cte4 AS (
    SELECT 
        *, 
        CONCAT(rfm_recency, rfm_frequency, rfm_monetary) AS RFM_SCORE  -- Combine RFM scores into a single metric
    FROM cte3
)

-- Final query: Assign customer segments based on the RFM_SCORE
SELECT 
    *, 
    CASE
        -- Define customer segments based on RFM_SCORE patterns
        WHEN RFM_SCORE IN ('414', '314', '424', '434', '444', '324', '334') THEN 'Loyal Customers'
        WHEN RFM_SCORE IN ('113', '124', '214') THEN 'Potential Churners'
        WHEN RFM_SCORE IN ('411', '422') THEN 'New Customers'
        WHEN RFM_SCORE IN ('314', '244') THEN 'Big Spenders'
        WHEN RFM_SCORE IN ('134', '244') THEN 'Cannot Lose Them'
        ELSE 'Other'  -- Default segment for scores not covered in the above patterns
    END AS Customer_Segment
FROM 
    cte4;
