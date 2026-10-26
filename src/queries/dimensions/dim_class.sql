CREATE OR REPLACE TABLE rivadatapaltform.dataproduct.dim_class(
    
 class_key BIGINT NOT NULL,
 class_id STRING NOT NULL,
 batch_id STRING NOT NULL,
 class_date DATE NOT NULL,
 class_day STRING,
 topic STRING NOT NULL,
 instructor STRING NOT NULL,
 status STRING NOT NULL,
 notes STRING,
    
    CONSTRAINT PK_DIM_CLASS
      PRIMARY KEY(class_key)
);


-- INSERTING DATA
INSERT INTO rivadatapaltform.dataproduct.dim_class (
    class_key,
    class_id,
    batch_id,
    class_date,
    class_day,
    topic,
    instructor,
    status,
    notes
)
SELECT
    ROW_NUMBER() OVER (
        ORDER BY CAST(class_id AS BIGINT)
    ) AS class_key,
    class_id,
    batch_id,
    CAST(class_date AS DATE),
    class_day,
    topic,
    instructor,
    status,
    notes
FROM rivadatapaltform.landing.classes;