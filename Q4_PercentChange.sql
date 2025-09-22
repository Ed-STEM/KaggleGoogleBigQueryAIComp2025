SELECT
  state_name,
  metric,
  SAFE_DIVIDE(
    (MAX(CASE WHEN source='historical' THEN value END) -
     MAX(CASE WHEN source='forecast' THEN value END)),
    MAX(CASE WHEN source='historical' THEN value END)
  ) * 100 AS pct_change
FROM `lightning_prices.lightning_housing_all`
GROUP BY state_name, metric
ORDER BY pct_change ASC;