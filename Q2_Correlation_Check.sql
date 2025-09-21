CREATE OR REPLACE TABLE `lightning_prices.joined_lightning_housing` AS
WITH lightning AS (
  SELECT
    UPPER(TRIM(b.state_name)) AS state_name,
    DATE_TRUNC(CAST(s.date AS DATE), YEAR) AS year,
    SUM(s.number_of_strikes) AS strikes
  FROM `bigquery-public-data.noaa_lightning.lightning_*` s
  TABLESAMPLE SYSTEM (1 PERCENT)  
  JOIN `bigquery-public-data.geo_us_boundaries.states` b
    ON ST_WITHIN(s.center_point_geom, b.state_geom)
  GROUP BY state_name, year
),
housing AS (
  SELECT
    UPPER(TRIM(RegionName)) AS state_name,
    DATE_TRUNC(CAST(date AS DATE), YEAR) AS year,
    AVG(avg_home_value) AS avg_home_value
  FROM `kaggle-gbq-ai-build.zillow_housing.zillow_state_values_unpivoted`
  GROUP BY state_name, year
)
SELECT
  l.state_name,
  l.year,
  l.strikes,
  h.avg_home_value
FROM lightning l
JOIN housing h
  USING (state_name, year)
ORDER BY state_name, year;