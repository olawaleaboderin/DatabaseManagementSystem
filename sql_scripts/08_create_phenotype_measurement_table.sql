/*
====================================================================================
File: create_phenotype_measurement_table.sql
Purpose: Create and populate the "phenotype_measurement" fact table.

Description:
- This table stores all measured trait values for crop varieties in specific trials.
- Columns:
    - measurement_id: Primary key, auto-incremented.
    - trial_id: Foreign key referencing the trial table, which contains information on 	  	  when and where the trial was conducted.
    - variety_id: Foreign key referencing the variety table, which contains information   
      about the specific crop variety measured.
    - trait_id: Foreign key referencing the trait table, which defines the trait being 
      measured.
    - value: The actual measured value for the trait (numeric).

Steps Performed:
- Data is inserted from the master_crop_table, one trait at a time.
- UNION ALL is used when inserting multiple traits in a single statement
- Only non-NULL measurements are inserted to maintain data integrity.

Notes:
- This is the main fact table linking trials, varieties, and traits.
- Each row represents a single measurement of a single trait for a specific variety in a trial.
- Ensure that the 'trait', 'variety', and 'trial' tables are populated prior to running this script.

====================================================================================
*/

CREATE TABLE phenotype_measurement (
    measurement_id INT AUTO_INCREMENT PRIMARY KEY,
    trial_id INT NOT NULL,
    variety_id INT NOT NULL,
    trait_id INT NOT NULL,
    value DECIMAL(12,2),  -- or appropriate type depending on the trait
    FOREIGN KEY (trial_id) REFERENCES trial(trial_id),
    FOREIGN KEY (variety_id) REFERENCES variety(variety_id),
    FOREIGN KEY (trait_id) REFERENCES trait(trait_id)
);

# Populate the Phenotype_measurement table trait by trait from the master_crop_table
-- Insert days_to_anthesis, days_to_silking, anthesis_silking_interval

INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT v.variety_id, t.trial_id, (SELECT trait_id FROM trait WHERE trait_name='days_to_anthesis'), m.days_to_anthesis
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.days_to_anthesis IS NOT NULL

UNION ALL

SELECT v.variety_id, t.trial_id, (SELECT trait_id FROM trait WHERE trait_name='days_to_silking'), m.days_to_silking
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.days_to_silking IS NOT NULL

UNION ALL

SELECT v.variety_id, t.trial_id, (SELECT trait_id FROM trait WHERE trait_name='anthesis_silking_interval'), m.anthesis_silking_interval
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.anthesis_silking_interval IS NOT NULL;

-- Insert plant_height
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='plant_height'),
    m.plant_height
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.plant_height IS NOT NULL;

-- Insert ear_height
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='ear_height'),
    m.ear_height
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.ear_height IS NOT NULL;

-- Insert husk_cover
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='husk_cover'),
    m.husk_cover
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.husk_cover IS NOT NULL;

-- Insert plant_aspect
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='plant_aspect'),
    m.plant_aspect
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.plant_aspect IS NOT NULL;

-- Insert field_weight
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='field_weight'),
    m.field_weight
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.field_weight IS NOT NULL;

-- Insert ear_harvested
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='ear_harvested'),
    m.ear_harvested
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.ear_harvested IS NOT NULL;

-- Insert ear_per_plant
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='ear_per_plant'),
    m.ear_per_plant
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.ear_per_plant IS NOT NULL;

-- Insert ear_aspect
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='ear_aspect'),
    m.ear_aspect
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.ear_aspect IS NOT NULL;

-- Insert grain_moisture
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='grain_moisture'),
    m.grain_moisture
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.grain_moisture IS NOT NULL;

-- Insert grain_yield
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='grain_yield'),
    m.grain_yield
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.grain_yield IS NOT NULL;

-- Insert staygreen
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='staygreen'),
    m.staygreen
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.staygreen IS NOT NULL;

-- Insert canopy_height
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='canopy_height'),
    m.canopy_height
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.canopy_height IS NOT NULL;

-- Insert branches_per_plant
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='branches_per_plant'),
    m.branches_per_plant
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.branches_per_plant IS NOT NULL;

-- Insert peduncles_per_plant
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='peduncles_per_plant'),
    m.peduncles_per_plant
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.peduncles_per_plant IS NOT NULL;

-- Insert pods_per_plant
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='pods_per_plant'),
    m.pods_per_plant
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.pods_per_plant IS NOT NULL;

-- Insert seeds_per_plot
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='seeds_per_plot'),
    m.seeds_per_plot
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.seeds_per_plot IS NOT NULL;

-- Insert seed_100_weight
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='seed_100_weight'),
    m.seed_100_weight
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.seed_100_weight IS NOT NULL;

-- Insert dry_matter
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='dry_matter'),
    m.dry_matter
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.dry_matter IS NOT NULL;

-- Insert harvest_index
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='harvest_index'),
    m.harvest_index
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.harvest_index IS NOT NULL;

-- Insert fodder_yield
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='fodder_yield'),
    m.fodder_yield
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.fodder_yield IS NOT NULL;

-- Insert grains_per_panicle
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='grains_per_panicle'),
    m.grains_per_panicle
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.grains_per_panicle IS NOT NULL;

-- Insert panicle_width
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='panicle_width'),
    m.panicle_width
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.panicle_width IS NOT NULL;

-- Insert panicle_length
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='panicle_length'),
    m.panicle_length
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE location.country = m.country
          AND location.region = m.region
          AND location.agro_ecological_zone = m.agro_ecological_zone
          AND location.elevation = m.elevation
          AND location.soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.panicle_length IS NOT NULL;

-- Insert panicle_number
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='panicle_number'),
    m.panicle_number
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE country = m.country
          AND region = m.region
          AND agro_ecological_zone = m.agro_ecological_zone
          AND elevation = m.elevation
          AND soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.panicle_number IS NOT NULL;


-- Insert seed_1000_weight
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='seed_1000_weight'),
    m.seed_1000_weight
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE country = m.country
          AND region = m.region
          AND agro_ecological_zone = m.agro_ecological_zone
          AND elevation = m.elevation
          AND soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.seed_1000_weight IS NOT NULL;


-- Insert tillers_per_plant
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='tillers_per_plant'),
    m.tillers_per_plant
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE country = m.country
          AND region = m.region
          AND agro_ecological_zone = m.agro_ecological_zone
          AND elevation = m.elevation
          AND soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.tillers_per_plant IS NOT NULL;


-- Insert leaf_number
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='leaf_number'),
    m.leaf_number
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE country = m.country
          AND region = m.region
          AND agro_ecological_zone = m.agro_ecological_zone
          AND elevation = m.elevation
          AND soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.leaf_number IS NOT NULL;


-- Insert panicle_harvested
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='panicle_harvested'),
    m.panicle_harvested
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE country = m.country
          AND region = m.region
          AND agro_ecological_zone = m.agro_ecological_zone
          AND elevation = m.elevation
          AND soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.panicle_harvested IS NOT NULL;


-- Insert leaf_length
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='leaf_length'),
    m.leaf_length
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE country = m.country
          AND region = m.region
          AND agro_ecological_zone = m.agro_ecological_zone
          AND elevation = m.elevation
          AND soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.leaf_length IS NOT NULL;


-- Insert leaf_width
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='leaf_width'),
    m.leaf_width
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE country = m.country
          AND region = m.region
          AND agro_ecological_zone = m.agro_ecological_zone
          AND elevation = m.elevation
          AND soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.leaf_width IS NOT NULL;


-- Insert grain_covering
INSERT INTO phenotype_measurement (variety_id, trial_id, trait_id, value)
SELECT
    v.variety_id,
    t.trial_id,
    (SELECT trait_id FROM trait WHERE trait_name='grain_covering'),
    m.grain_covering
FROM master_crop_table m
JOIN variety v ON v.entry = m.entry
JOIN trial t 
    ON t.year = m.year
    AND t.season = m.season
    AND t.environment_condition = m.environment_condition
    AND t.crop_id = (SELECT crop_id FROM crop WHERE crop_name = m.crop)
    AND t.location_id = (
        SELECT location_id FROM location 
        WHERE country = m.country
          AND region = m.region
          AND agro_ecological_zone = m.agro_ecological_zone
          AND elevation = m.elevation
          AND soil_type = m.soil_type
        LIMIT 1
    )
WHERE m.grain_covering IS NOT NULL;
