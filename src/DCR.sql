
set hive.msck.path.validation=ignore;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls_hs;

DROP TABLE IF EXISTS dcr_mix_csrequest_map_hist;
-- 
-- TABLE: dcr_mix_csrequest_map_hist 
--

CREATE EXTERNAL TABLE dcr_mix_csrequest_map_hist(
    daas_load_id       VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts        TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id    STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Data Collect Repository - Collects data from Stores SPOS, FedFil & RDS.  Puts data to MQ Series queue for Sales Bridge Application,  
Puts data to Tibco queues for other applications.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mix/highly_sensitive/raw/sls/dcr/dcr_mix_csrequest_map_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY','avro.schema.url' = '${env:BASE_DATA_DIR}/mix/highly_sensitive/raw/sls/metadata/dcr/CSRequest_Map_v1.avsc')
;
MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls_hs.dcr_mix_csrequest_map_hist;

