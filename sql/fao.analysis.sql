
-- FOOD WASTE INTELLIGENCE: AFRICA
-- FAO FOOD LOSS ANALYSIS

-- 1. VIEW THE AFRICA FAO DATASET


SELECT *
FROM fao_food_loss_africa
LIMIT 100;


-- 2. DATASET OVERVIEW

SELECT
    COUNT(*) AS total_observations,
    COUNT(DISTINCT country) AS countries,
    COUNT(DISTINCT commodity) AS commodities,
    COUNT(DISTINCT food_supply_stage) AS supply_chain_stages,
    MIN(year) AS earliest_year,
    MAX(year) AS latest_year
FROM fao_food_loss_africa;


-- 3. COUNTRIES REPRESENTED

SELECT DISTINCT
    country
FROM fao_food_loss_africa
ORDER BY country;


-- 4. AVERAGE REPORTED FOOD LOSS

SELECT
    ROUND(AVG(loss_percentage), 2)
        AS average_reported_loss_percentage,

    ROUND(MIN(loss_percentage), 2)
        AS minimum_reported_loss_percentage,

    ROUND(MAX(loss_percentage), 2)
        AS maximum_reported_loss_percentage

FROM fao_food_loss_africa
WHERE loss_percentage IS NOT NULL;


-- 5. FOOD LOSS BY SUPPLY-CHAIN STAGE

SELECT
    food_supply_stage,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage,

    ROUND(MIN(loss_percentage), 2)
        AS minimum_loss,

    ROUND(MAX(loss_percentage), 2)
        AS maximum_loss

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL

GROUP BY food_supply_stage

ORDER BY avg_loss_percentage DESC;


-- 6. FOOD LOSS BY COUNTRY

SELECT
    country,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage,

    ROUND(MIN(loss_percentage), 2)
        AS minimum_loss,

    ROUND(MAX(loss_percentage), 2)
        AS maximum_loss

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL

GROUP BY country

ORDER BY avg_loss_percentage DESC;


-- 7. FOOD LOSS BY COMMODITY
SELECT
    commodity,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL

GROUP BY commodity

HAVING COUNT(*) >= 5

ORDER BY avg_loss_percentage DESC;

-- 8. TOP 10 COMMODITIES BY REPORTED LOSS

SELECT
    commodity,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL

GROUP BY commodity

HAVING COUNT(*) >= 5

ORDER BY avg_loss_percentage DESC

LIMIT 10;

-- 9. FOOD LOSS BY CAUSE

SELECT
    cause_of_loss,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL
  AND cause_of_loss IS NOT NULL
  AND cause_of_loss <> ''

GROUP BY cause_of_loss

ORDER BY avg_loss_percentage DESC;


-- 10. FOOD LOSS BY ACTIVITY

SELECT
    activity,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL
  AND activity IS NOT NULL
  AND activity <> ''

GROUP BY activity

ORDER BY avg_loss_percentage DESC;


-- 11. FOOD LOSS BY YEAR

SELECT
    year,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL

GROUP BY year

ORDER BY year;

-- 12. COUNTRY + SUPPLY-CHAIN STAGE

SELECT
    country,
    food_supply_stage,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL

GROUP BY
    country,
    food_supply_stage

ORDER BY
    country,
    avg_loss_percentage DESC;


-- 13. CODITY + SUPPLY-CHAIN STAGE HOTSPOTS

SELECT
    commodity,
    food_supply_stage,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL

GROUP BY
    commodity,
    food_supply_stage

HAVING COUNT(*) >= 3

ORDER BY avg_loss_percentage DESC;


-- 14. NIGERIA FAO SUMMARY

SELECT
    COUNT(*) AS observations,
    COUNT(DISTINCT commodity) AS commodities,
    COUNT(DISTINCT food_supply_stage)
        AS supply_chain_stages,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE country = 'Nigeria';

-- 15. NIGERIA FOOD LOSS BY COMMODITY

SELECT
    commodity,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE country = 'Nigeria'
  AND loss_percentage IS NOT NULL

GROUP BY commodity

ORDER BY avg_loss_percentage DESC;


-- 16. NIGERIA FOOD LOSS BY SUPPLY-CHAIN STAGE
SELECT
    food_supply_stage,
    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage

FROM fao_food_loss_africa

WHERE country = 'Nigeria'
  AND loss_percentage IS NOT NULL

GROUP BY food_supply_stage

ORDER BY avg_loss_percentage DESC;

-- 17. FAO DATA QUALITY CHECK

SELECT
    COUNT(*) AS total_records,

    SUM(
        CASE
            WHEN loss_percentage IS NULL
            THEN 1 ELSE 0
        END
    ) AS missing_loss_percentage,

    SUM(
        CASE
            WHEN commodity IS NULL
              OR commodity = ''
            THEN 1 ELSE 0
        END
    ) AS missing_commodity,

    SUM(
        CASE
            WHEN food_supply_stage IS NULL
              OR food_supply_stage = ''
            THEN 1 ELSE 0
        END
    ) AS missing_supply_stage,

    SUM(
        CASE
            WHEN cause_of_loss IS NULL
              OR cause_of_loss = ''
            THEN 1 ELSE 0
        END
    ) AS missing_cause,

    SUM(
        CASE
            WHEN activity IS NULL
              OR activity = ''
            THEN 1 ELSE 0
        END
    ) AS missing_activity

FROM fao_food_loss_africa;


-- 18. CHECK FOR INVALID LOSS PERCENTAGES

SELECT *
FROM fao_food_loss_africa

WHERE loss_percentage < 0
   OR loss_percentage > 100;

-- 19. HIGHEST REPORTED FOOD-LOSS OBSERVATIONS

SELECT
    country,
    commodity,
    year,
    food_supply_stage,
    activity,
    loss_percentage,
    cause_of_loss

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL

ORDER BY loss_percentage DESC

LIMIT 20;


-- 20. COMPLETE FOOD-LOSS HOTSPOT ANALYSIS

SELECT
    country,
    commodity,
    food_supply_stage,
    activity,
    cause_of_loss,

    COUNT(*) AS observations,

    ROUND(AVG(loss_percentage), 2)
        AS avg_loss_percentage,

    ROUND(MIN(loss_percentage), 2)
        AS min_loss_percentage,

    ROUND(MAX(loss_percentage), 2)
        AS max_loss_percentage

FROM fao_food_loss_africa

WHERE loss_percentage IS NOT NULL

GROUP BY
    country,
    commodity,
    food_supply_stage,
    activity,
    cause_of_loss

HAVING COUNT(*) >= 3

ORDER BY avg_loss_percentage DESC;

