#Generates the PIVOT Query 1 if needed.

import pandas as pd
import pandas_gbq
zillow_df = pd.read_csv("State_zhvi_uc_sfrcondo_tier_0.33_0.67_sm_sa_month.csv")

# Extract all the date columns (they start after the first 5 columns in your file)
date_cols = zillow_df.columns[5:]

# Build the UNPIVOT list string for SQL
unpivot_cols = ", ".join([f"`{c}`" for c in date_cols])

unpivot_sql = f"""
CREATE OR REPLACE TABLE `my_dataset.zillow_state_values_unpivoted` AS
SELECT
  StateName AS state_name,
  PARSE_DATE('%Y-%m-%d', month) AS date,
  value AS avg_home_value
FROM `my_dataset.zillow_state_values`
UNPIVOT(value FOR month IN ({unpivot_cols}))
"""

print(unpivot_sql[:10000])  # print preview (first 1000 chars)