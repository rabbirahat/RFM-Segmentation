# RFM Segmentation Project

## Features
 - ### Data Preparation:
    - Formatting and cleaning the dataset 
    - Calculating RFM metrics for each customer
      - Recency: Days since the last purchase.
      - Frequency: Number of unique purchases.
      - Monetary Value: Total spending by the customer.
        
 - ### RFM Scoring:
   - Assigning quartile-based scores (1–4) for Recency, Frequency, and Monetary Value.
   - Combining the scores into an overall RFM score.
  
 - ### Customer Segmentation:
   - Defining customer segments based on RFM scores (e.g., Loyal Customers, Potential Churners, 
     Big Spenders).
   - Analyzing segment behaviour using descriptive statistics.
  
 - ### Visualizations:
   - Bar plots, box plots, and heatmaps to explore:
   - Distribution of customers across segments.
   - Metrics (recency, frequency, monetary) per segment.
   - Heatmap of RFM Scores (Monetary Value)
   - Relationships between RFM metrics using heatmaps.

### Heatmap of RFM Scores
![image](https://github.com/user-attachments/assets/d404bbe6-c0e5-4eba-9913-779e9c414510)

## Summary of the segment-wise heatmap:

![image](https://github.com/user-attachments/assets/d0e4e9bf-e67e-4ce4-99fb-1fd0ceb6b068)
![image](https://github.com/user-attachments/assets/dde1a701-4a71-487c-ad7d-599259b346ca)
![image](https://github.com/user-attachments/assets/02c754a4-8ef1-4687-a337-e77f30abaf44)



The heatmap shows important consumer segment behaviours according to their recency, frequency, and monetary value.
- **Big Spenders:** Customers who spend a lot.
- **Loyal Customers:** Customers who frequently purchase and spend a lot.
- **New Customers:** Customers who have recently made a first purchase though their monetary value is low.
- **Potential Churners:** Customers who haven't purchased recently
 
