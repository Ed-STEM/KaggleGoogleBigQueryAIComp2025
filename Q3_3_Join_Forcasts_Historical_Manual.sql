CREATE OR REPLACE TABLE `lightning_prices.lightning_housing_all` AS

-- Historical lightning
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

-- Historical housing
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

-- Forecast lightning
SELECT
  state_name,
  CAST(forecast_timestamp AS DATE) AS ts,
  forecast_value AS value,
  prediction_interval_lower_bound AS prediction_interval_lower,
  prediction_interval_upper_bound AS prediction_interval_upper,
  'strikes' AS metric,
  'forecast' AS source
FROM `lightning_prices.ai_forecasted_strikes`

UNION ALL

-- Forecast housing
SELECT
  state_name,
  CAST(forecast_timestamp AS DATE) AS ts,
  forecast_value AS value,
  prediction_interval_lower_bound AS prediction_interval_lower,
  prediction_interval_upper_bound AS prediction_interval_upper,
  'avg_home_value' AS metric,
  'forecast' AS source
FROM `lightning_prices.ai_forecasted_value`;