/*--------------------------------------------------------------------------
Query: Year-to-Year Yield Trend for a Crop

PURPOSE:
    This query analyzes yield trends over time by computing the average
    grain yield (or any trait) for each year. It helps determine whether
    productivity is increasing, stagnating, or declining across seasons,
    countries, and testing environments.

USE CASES:
    • Measuring genetic gain over time
    • National agricultural performance tracking
    • Breeding program impact assessment
    • Early-warning for declining productivity

PARAMETERS:
    :trait_name             → Trait to analyze (e.g., 'grain_yield')
    :crop_name              → Crop to filter (e.g., 'Maize')
    :country (optional)     → Country filter (NULL = include all)
    :environment_condition (optional) → e.g., 'Drought', 'Low-N', 'Optimum'

NOTES:
    • AVG() allows multi-environment yearly aggregation.
    • Produces one row per year for clear trend visualization.
    • Optional filters allow global, regional, or stress-specific trend analysis.
    • ORDER BY year ensures chronological trend interpretation.

---------------------------------------------------------------------------*/

SELECT
    t.year,
    c.crop_name,
    AVG(pm.value) AS avg_yield
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
  AND (:country IS NULL OR l.country = :country)
  AND (:environment_condition IS NULL OR t.environment_condition = :environment_condition)

GROUP BY 
    t.year,
    c.crop_name
ORDER BY 
    t.year ASC;
