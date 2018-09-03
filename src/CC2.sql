

set hive.msck.path.validation=ignore;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;

DROP TABLE IF EXISTS cc2_mix_customercanonical_internal_hist;
-- 
-- TABLE: cc2_mix_customercanonical_internal_hist 
--

CREATE EXTERNAL TABLE cc2_mix_customercanonical_internal_hist(
    daas_load_id       VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts        TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id    STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'CustomerCanonical_Internal'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/cc2/cc2_mix_customercanonical_internal_hist'
TBLPROPERTIES ('avro.output.codec' = 'SNAPPY', 'avro.schema.url' = '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/metadata/cc2/CustomerCanonical_v1.avsc')
;

MSCK REPAIR TABLE cc2_mix_customercanonical_internal_hist;
