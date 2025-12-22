/*
---------------------------------------------------------------------------
Query: Ranking Breeding Institutions by Variety Performance

PURPOSE:
    This query evaluates the performance of breeding institutions by calculating 
    the average trait value (commonly grain yield) of all varieties originating 
    from each institution. It helps identify institutions producing superior 
    germplasm across multiple testing environments.

USE CASES:
    • Breeding program benchmarking
    • Policy and donor reporting on genetic gains
    • Institution-level performance monitoring
    • Identifying high-performing breeding pipelines

PARAMETERS:
    :trait_name   → Name of the trait to evaluate (e.g., 'grain_yield')
    :crop_name    → Crop to filter (e.g., 'Maize')
    :year         → Optional filter for trial year
    :country      → Optional filter for country
    :environment_condition → Optional filter (e.g., 'Optimum', 'Drought', 'Low-N')

NOTES:
    • AVG() aggregates multiple observations across environments.
    • NULLable filters allow flexible reporting.
    • GROUP BY ensures one row per breeding institution.
    • Remove filters to compute institution performance across all data.

--------------------------------------------------------------------------- 
*/

SELECT
    v.breeding_institution,
    c.crop_name,
    COUNT(DISTINCT v.variety_id) AS number_of_varieties_tested,
    AVG(pm.value) AS avg_trait_value
FROM phenotype_measurement pm
JOIN trait tr 
    ON pm.trait_id = tr.trait_id
JOIN variety v 
    ON pm.variety_id = v.variety_id
JOIN crop c 
    ON v.crop_id = c.crop_id
JOIN trial t 
    ON pm.trial_id = t.trial_id
JOIN location l 
    ON t.location_id = l.location_id
WHERE tr.trait_name = :trait_name
  AND c.crop_name = :crop_name

  -- Optional filters
  AND (:year IS NULL OR t.year = :year)
  AND (:country IS NULL OR l.country = :country)
  AND (:environment_condition IS NULL OR t.environment_condition = :environment_condition)

GROUP BY 
    v.breeding_institution,
    c.crop_name

ORDER BY avg_trait_value DESC;
