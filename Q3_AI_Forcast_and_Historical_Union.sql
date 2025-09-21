CREATE OR REPLACE TABLE `lightning_prices.lightning_housing_with_forecast` AS
-- Historical lightning strikes
SELECT
  state_name,
  CAST(year AS DATE) AS ts,
  strikes AS value,
  NULL AS prediction_interval_lower,
  NULL AS prediction_interval_upper,
  'strikes' AS metric,
  'historical' AS source
FROM `lightning_prices.joined_lightning_housing`

UNION ALL

-- Historical housing values
SELECT
  state_name,
  CAST(year AS DATE) AS ts,
  avg_home_value AS value,
  NULL AS prediction_interval_lower,
  NULL AS prediction_interval_upper,
  'avg_home_value' AS metric,
  'historical' AS source
FROM `lightning_prices.joined_lightning_housing`

UNION ALL

-- Forecast lightning strikes
SELECT
  state_name,
  CAST(forecast_timestamp AS DATE) AS ts,
  forecast_value AS value,
  prediction_interval_lower_bound,
  prediction_interval_upper_bound,
  'strikes' AS metric,
  'forecast' AS source
FROM AI.FORECAST(
  (SELECT state_name, year AS ts, strikes
   FROM `lightning_prices.joined_lightning_housing`
   ORDER BY state_name, ts),
  data_col      => 'strikes',
  timestamp_col => 'ts',
  id_cols       => ['state_name'],
  horizon       => 1,
  confidence_level => 0.8
)

UNION ALL

-- Forecast housing values
SELECT
  state_name,
  CAST(forecast_timestamp AS DATE) AS ts,
  forecast_value AS value,
  prediction_interval_lower_bound,
  prediction_interval_upper_bound,
  'avg_home_value' AS metric,
  'forecast' AS source
FROM AI.FORECAST(
  (SELECT state_name, year AS ts, avg_home_value
   FROM `lightning_prices.joined_lightning_housing`
   ORDER BY state_name, ts),
  data_col      => 'avg_home_value',
  timestamp_col => 'ts',
  id_cols       => ['state_name'],
  horizon       => 1,
  confidence_level => 0.8
);