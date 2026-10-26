-- Creating Batch Table
CREATE TABLE IF NOT EXISTS rivadatapaltform.dataproduct.dim_batch (

batch_key	BIGINT,
batch_id	STRING,
batch_name	STRING,
start_date	DATE,
end_date	DATE,
status	STRING,
created_at	TIMESTAMP,

CONSTRAINT pk_dim_batch PRIMARY KEY (batch_key)

);

-- Inserting Data into Batch Table
INSERT INTO rivadatapaltform.dataproduct.dim_batch (

    batch_key,
    batch_id,
    batch_name,
    start_date,
    end_date,
    status,
    created_at	

)


SELECT 
        CAST(ROW_NUMBER() OVER (ORDER BY batch_id) AS BIGINT) AS student_key,
        CAST(batch_id AS STRING)  AS batch_id,
        CAST(batch_name AS STRING) AS batch_name,
        CAST(start_date AS DATE) AS start_date,
        CAST(end_date AS DATE) AS end_date,
        CAST(status AS STRING) AS status ,
        CAST(created_at AS TIMESTAMP) AS created_at

FROM rivadatapaltform.landing.batches;
