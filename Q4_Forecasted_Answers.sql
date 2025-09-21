SELECT
  h.state_name,
  h.value AS forecasted_home_value,
  s.value AS forecasted_strikes
FROM `lightning_prices.lightning_housing_all` h
JOIN `lightning_prices.lightning_housing_all` s
  ON h.state_name = s.state_name
  AND h.ts = s.ts
WHERE h.metric = 'avg_home_value'
  AND h.source = 'forecast'
  AND s.metric = 'strikes'
  AND s.source = 'forecast'
ORDER BY forecasted_strikes DESC, forecasted_home_value ASC;