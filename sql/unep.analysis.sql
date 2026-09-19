
-- FOOD WASTE INTELLIGENCE: AFRICA
-- UNEP FOOD WASTE ANALYSIS


SELECT *
FROM UNEPFoodWaste;



-- 2. DATASET OVERVIEW

SELECT
    COUNT(*) AS total_observations,
    COUNT(DISTINCT country) AS countries,
    COUNT(DISTINCT study_area) AS study_locations,
    MIN(study_year) AS earliest_study_year,
    MAX(study_year) AS latest_study_year
FROM UNEPFoodWaste;


-- 3. COUNTRIES REPRESENTED

SELECT DISTINCT
    country,
    country_code
FROM UNEPFoodWaste
ORDER BY country;


-- 4. AVERAGE REPORTED HOUSEHOLD FOOD WASTE BY COUNTRY

SELECT
    country,
    COUNT(*) AS observations,
    ROUND(AVG(food_waste_kg_capita_year), 2)
        AS avg_food_waste_kg_per_person_year,
    ROUND(MIN(food_waste_kg_capita_year), 2)
        AS minimum_reported_waste,
    ROUND(MAX(food_waste_kg_capita_year), 2)
        AS maximum_reported_waste
FROM UNEPFoodWaste
WHERE food_waste_kg_capita_year IS NOT NULL
GROUP BY country
ORDER BY avg_food_waste_kg_per_person_year DESC;


-- 5. TOP 10 HIGHEST REPORTED FOOD-WASTE OBSERVATIONS

SELECT
    country,
    study_area,
    study_year,
    food_waste_kg_capita_year,
    data_confidence,
    study_scope
FROM UNEPFoodWaste
WHERE food_waste_kg_capita_year IS NOT NULL
ORDER BY food_waste_kg_capita_year DESC
LIMIT 10;


-- 6. LOWEST REPORTED FOOD-WASTE OBSERVATIONS

SELECT
    country,
    study_area,
    study_year,
    food_waste_kg_capita_year,
    data_confidence,
    study_scope
FROM UNEPFoodWaste
WHERE food_waste_kg_capita_year IS NOT NULL
ORDER BY food_waste_kg_capita_year ASC
LIMIT 10;

-- 7. FOOD WASTE BY STUDY LOCATION

SELECT
    country,
    study_area,
    COUNT(*) AS observations,
    ROUND(AVG(food_waste_kg_capita_year), 2)
        AS avg_food_waste
FROM UNEPFoodWaste
WHERE food_waste_kg_capita_year IS NOT NULL
GROUP BY
    country,
    study_area
ORDER BY avg_food_waste DESC;


-- 8. FOOD WASTE BY STUDY YEAR

SELECT
    study_year,
    COUNT(*) AS number_of_observations,
    ROUND(AVG(food_waste_kg_capita_year), 2)
        AS avg_reported_food_waste
FROM UNEPFoodWaste
WHERE study_year IS NOT NULL
GROUP BY study_year
ORDER BY study_year;


-- 9. DATA CONFIDENCE

SELECT
    data_confidence,
    COUNT(*) AS observations,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM UNEPFoodWaste),
        2
    ) AS percentage_of_observations
FROM UNEPFoodWaste
GROUP BY data_confidence
ORDER BY observations DESC;

-- 10. STUDY SCOPE

SELECT
    study_scope,
    COUNT(*) AS observations,
    ROUND(AVG(food_waste_kg_capita_year), 2)
        AS avg_reported_waste
FROM UNEPFoodWaste
WHERE food_waste_kg_capita_year IS NOT NULL
GROUP BY study_scope
ORDER BY observations DESC;


-- 11. GEOGRAPHIC COVERAGE
SELECT
    COUNT(*) AS total_observations,

    SUM(
        CASE
            WHEN latitude IS NOT NULL
             AND longitude IS NOT NULL
            THEN 1
            ELSE 0
        END
    ) AS observations_with_coordinates,

    ROUND(
        SUM(
            CASE
                WHEN latitude IS NOT NULL
                 AND longitude IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS geographic_coverage_percentage

FROM UNEPFoodWaste;



-- 12. CHECK FOR DUPLICATE OBSERVATIONS
SELECT
    country,
    study_area,
    study_year,
    food_waste_kg_capita_year,
    COUNT(*) AS duplicate_count
FROM UNEPFoodWaste
GROUP BY
    country,
    study_area,
    study_year,
    food_waste_kg_capita_year
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- 13. CHECK FOR MISSING VALUES
SELECT
    SUM(
        CASE
            WHEN country IS NULL OR country = ''
            THEN 1 ELSE 0
        END
    ) AS missing_country,

    SUM(
        CASE
            WHEN study_year IS NULL
            THEN 1 ELSE 0
        END
    ) AS missing_study_year,

    SUM(
        CASE
            WHEN food_waste_kg_capita_year IS NULL
            THEN 1 ELSE 0
        END
    ) AS missing_food_waste,

    SUM(
        CASE
            WHEN latitude IS NULL
            THEN 1 ELSE 0
        END
    ) AS missing_latitude,

    SUM(
        CASE
            WHEN longitude IS NULL
            THEN 1 ELSE 0
        END
    ) AS missing_longitude,

    SUM(
        CASE
            WHEN data_confidence IS NULL
              OR data_confidence = ''
            THEN 1 ELSE 0
        END
    ) AS missing_confidence

FROM UNEPFoodWaste;


-- 14. NIGERIA SUMMARY

SELECT
    country,
    COUNT(*) AS observations,
    ROUND(AVG(food_waste_kg_capita_year), 2)
        AS avg_reported_waste,
    ROUND(MIN(food_waste_kg_capita_year), 2)
        AS minimum_reported_waste,
    ROUND(MAX(food_waste_kg_capita_year), 2)
        AS maximum_reported_waste
FROM UNEPFoodWaste
WHERE country = 'Nigeria'
GROUP BY country;


-- 15. NIGERIAN STUDY LOCATIONS

SELECT
    study_area,
    study_year,
    food_waste_kg_capita_year,
    latitude,
    longitude,
    data_confidence,
    study_scope
FROM UNEPFoodWaste
WHERE country = 'Nigeria'
ORDER BY food_waste_kg_capita_year DESC;


-- 16. ESTIMATED MONTHLY AND DAILY FOOD WASTE

SELECT
    country,
    study_area,
    food_waste_kg_capita_year,

    ROUND(
        food_waste_kg_capita_year / 12,
        2
    ) AS estimated_monthly_waste,

    ROUND(
        food_waste_kg_capita_year / 365,
        3
    ) AS estimated_daily_waste

FROM UNEPFoodWaste
WHERE food_waste_kg_capita_year IS NOT NULL
ORDER BY food_waste_kg_capita_year DESC;


-- 17. FOOD-WASTE HOTSPOT RANKING


SELECT
    country,
    study_area,
    food_waste_kg_capita_year,
    data_confidence,
    latitude,
    longitude,

    RANK() OVER (
        ORDER BY food_waste_kg_capita_year DESC
    ) AS waste_rank

FROM UNEPFoodWaste
WHERE food_waste_kg_capita_year IS NOT NULL
ORDER BY waste_rank;

