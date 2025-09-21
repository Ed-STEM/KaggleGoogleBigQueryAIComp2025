CREATE OR REPLACE TABLE `lightning_prices.ai_forecasted_strikes` AS  
  SELECT *
  FROM AI.FORECAST(
    (SELECT state_name, year AS ts, strikes
    FROM `lightning_prices.joined_lightning_housing`
    ORDER BY state_name, ts),
    data_col      => 'strikes',
    timestamp_col => 'ts',
    id_cols       => ['state_name'],
    horizon       => 1,
    confidence_level => 0.8
  );