
set hive.msck.path.validation=ignore;

DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.chm_mix_cc2subscriptions;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: chm_mix_cc2subscriptions 
--

CREATE EXTERNAL TABLE chm_mix_cc2subscriptions(
    email               VARCHAR(256)    COMMENT 'Email address',
    pid                 VARCHAR(300)    COMMENT 'The subscriber list values:  
Bloomingdale''s Master List	395365210
,Loyallist Master List	2088762653
,Outlet Program	2084673179
,Outlet Loyallist	2093457898
,Registered Brides	402416911
,Unregistered Brides	402416911
,International Marketing	208<Truncated>',
    action_id           VARCHAR(100)    COMMENT 'The action indicator indicator can be ''Y'' or  ''N''.  Value Y (Indicates Subscribers) and value N (Indicates Unsubscribers).',
    aid                 VARCHAR(100)    COMMENT 'Affiliate Identifier.',
    action_date         VARCHAR(50)     COMMENT 'Date of the Subscription/Unsubscription YYYYMMDDHHMISS *Date used in daas_part_dt',
    additional_email    VARCHAR(256)    COMMENT 'Additional Email Address',
    birth_date          VARCHAR(100)    COMMENT 'Date of Birth - YYYYMMDDHHMISS',
    fname               VARCHAR(100)    COMMENT 'First Name',
    gender              VARCHAR(100)    COMMENT 'Gender of account owner (M/F)',
    lname               VARCHAR(130)    COMMENT 'Last Name',
    opt_down            VARCHAR(100)    COMMENT 'Opt down value.',
    user_prof_id        VARCHAR(100)    COMMENT 'User profile Identifier',
    masked_id           VARCHAR(100)    COMMENT 'Masked Identifier.',
    zip                 VARCHAR(100)    COMMENT 'Zip Code of the address',
    loc_nbr             VARCHAR(100)    COMMENT 'The location number is populated based on the PID value',
    deliverability      VARCHAR(25)     COMMENT 'The Cheetahmail Unsubscribe Reason Code:
A | abuse complaint 
B | persistent bounces 
C | change-of-address (both source and target address were subscribers) these are rare, see the COA section below for details 
D | deleted via admin interface <Truncated>',
    daas_load_id        VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts         TIMESTAMP       COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts         TIMESTAMP       COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id     STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'This table contains data loaded directlry from a file received from CheetahMail.   | Primary Key = pid, email | Offset = action_date| Partition Date = action_date yyyyMMddHHmmss'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/chm/chm_mix_cc2subscriptions'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.chm_mix_cc2subscriptions;

