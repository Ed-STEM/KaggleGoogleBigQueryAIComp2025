CREATE OR REPLACE TABLE `lightning_prices.ai_forecasted_value` AS  
  SELECT *
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