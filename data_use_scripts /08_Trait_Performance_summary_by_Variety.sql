/*---------------------------------------------------------------------------------------
SCRIPT NAME: Pivot Summary of Trait Performance by Variety

PURPOSE:
This script dynamically generates and executes a SQL query that returns the 
**mean performance of all varieties of a selected crop across all available 
locations, countries, years, and environmental conditions**.

It produces **one record per variety**, with each trait shown as a separate column.

OUTPUT FORMAT:
Each row represents a **single variety**, summarizing its **average performance**:

| crop_name | variety_id | variety_name | breeding_institution | GrainYield | PlantHeight | EarHeight | ... |
|-----------|-------------|--------------|-----------------------|------------|-------------|-----------|-----|

The number of trait columns adjusts automatically, depending on what exists in the `trait` table.

Notes
- `pm.value IS NOT NULL` ensures only valid trait measurements are aggregated.
- Output is automatically sorted by `variety_name`.
- To run for another crop, simply update:

SET @crop_name = 'Sorghum';
--------------------------------------------------------------------------------*/

SET @crop_name = 'Maize';
SET @sql = NULL;

SELECT
    GROUP_CONCAT(
        DISTINCT
        CONCAT(
            'AVG(CASE WHEN tr.trait_name = ''',
            trait_name,
            ''' THEN pm.value END) AS `',
            trait_name,
            '`'
        )
    ) INTO @trait_columns
FROM trait;

SET @sql = CONCAT(
'SELECT
    c.crop_name,
    v.variety_id,
    v.name AS variety_name,
    v.breeding_institution, ',
    @trait_columns,
' 
FROM phenotype_measurement pm
JOIN trait tr ON pm.trait_id = tr.trait_id
JOIN variety v ON pm.variety_id = v.variety_id
JOIN crop c ON v.crop_id = c.crop_id
WHERE pm.value IS NOT NULL
  AND c.crop_name = ''', @crop_name, '''
GROUP BY 
    c.crop_name,
    v.variety_id,
    v.name,
    v.breeding_institution
ORDER BY variety_name;'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
