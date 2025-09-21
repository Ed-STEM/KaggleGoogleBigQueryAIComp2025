# KaggleGoogleBigQueryAIComp2025
Ed di Girolamo Submission for the BigQuery AI - Building The Future of Data

# Lightning Strikes × Housing Prices with BigQuery ML

This repository investigates both the querying and statistical features of **Google BigQuery** and its **AI.FORECAST** capability.  

Optimized queries were written to efficiently forecast:

- **Lightning strikes per U.S. state (next year)** using NOAA public data.  
- **Housing prices per U.S. state (next year)** using Zillow public data.  

We also explore the **correlation** between lightning activity and housing prices to see how strongly they are related.

⚠️ **Note**: This is not a rigorous scientific study. Preliminary results showed that **lightning strikes and housing prices are always negatively correlated**, though the strength of the relationship varies from state to state.

---

## Guide to SQL Queries

### 0. PIVOT and create Table from Zillow data.
Once the zillow data is uploaded via the Google Big Query UI you can run the Pivot Query.
If you are running a new table I have provided a python script to extract the dates listed in the query.
You will need to replace the dates.

### 1. Joining the Tables
Data was sourced from:
- NOAA Lightning Strikes (public dataset)  
- U.S. State Boundaries (for geospatial joins)  
- Zillow State Housing Prices (CSV, reshaped into BigQuery long format)  

These were joined on **state** and **year** to align the datasets.

---

### 2. Correlation Study (Optional)
After building a unified dataset of lightning strikes and home values, we calculated the **correlation per state**. This step provides insight into the strength and direction of the relationship.

---

### 3. AI Forecasting Lightning and Prices
We run several UNION ALL statements to combine in a new table lightning strike and housing price forcasts.
Using BigQuery’s AI.FORECAST, we projected **state-level lightning strike totals** one year into the future.
Similarly, we applied AI.FORECAST to the housing dataset to project **average state-level home values** for the next year.

*Disclaimer There are 3 SQL code snippets here where the first is everything in one Query which should work, but
I recieved erroneous results some of the time (NAN in some records) so I split the queries into 3_1, 3_2, and 3_3, running the two forcasting and joins respectively.
---


## Summary
- Lightning strikes and housing values show a consistent **negative correlation** across states.  
- Forecasting provides a look at **how these two variables may evolve next year**.  
- This project highlights the ease of combining **SQL analytics** and **time-series forecasting** directly in BigQuery.  
- The correlation trend continues in the forcasts with the highest home values going to Texas, and lightning strikes to Wisconsin.  Which was different from historical Data.

---

## Future Improvements
- Refine to **monthly or seasonal forecasts**.  
- Experiment with **BigQuery ML regression models** to directly predict home values from lightning activity.  
- Add **visualizations** to complement the forecasts and correlations.
