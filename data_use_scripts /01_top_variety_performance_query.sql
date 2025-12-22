/*
---------------------------------------------------------------------------
Query: Identify the best-performing crop varieties for a given trait

PURPOSE:
    This query retrieves the top-performing crop varieties based on 
    a given trait in a particular country for a specific 
    year, season, and environmental condition. It is designed for use in 
    trial performance analysis, varietal ranking, and breeder decision-making.

Parameters:
    :trait_name             → Name of trait to analyze (e.g., 'grain_yield')
    :crop_name              → Crop name (e.g., 'Maize')
    :country                → Country (e.g., 'Ghana')
    :trial_year             → Trial year (e.g., 2022)
    :season                 → Season (e.g., 'rainy')
    :environment_condition  → Environment condition (e.g., 'Optimum')
    :limit_n                → Number of rows to return (e.g., 5)

NOTES:
    • This query supports multi-environment testing (MET) reporting.
    • The GROUP BY ensures one row per variety per region.
    • The AVG() aggregation handles repeated trials within the same filters.
    • Adjust LIMIT for more or fewer top varieties.
    • Can be adapted for other traits by changing :trait_name.
    • Ensure parameters passed in quotes: 'Maize', 'grain_yield', etc.

---------------------------------------------------------------------------
*/

SELECT 
    v.name AS variety_name,
    v.breeding_institution,
    l.country,
    l.region,
    c.crop_name,
    AVG(pm.value) AS average_trait_value
FROM phenotype_measurement pm
JOIN trait tr 
    ON pm.trait_id = tr.trait_id
JOIN variety v 
    ON pm.variety_id = v.variety_id
JOIN trial t 
    ON pm.trial_id = t.trial_id
JOIN location l 
    ON t.location_id = l.location_id
JOIN crop c 
    ON v.crop_id = c.crop_id
WHERE tr.trait_name = :trait_name
  AND c.crop_name = :crop_name
  AND l.country = :country
  AND t.year = :trial_year
  AND t.season = :season
  AND t.environment_condition = :environment_condition
GROUP BY 
    v.variety_id,
    v.name,
    v.breeding_institution,
    l.country,
    l.region,
    c.crop_name
ORDER BY average_trait_value DESC
LIMIT :limit_n;
