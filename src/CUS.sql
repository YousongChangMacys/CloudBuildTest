
set hive.msck.path.validation=ignore;

DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_blm_fapcus_nb_xcusb042_blm_cimout_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_blm_fapcus_nb_xcusb042_blm_cimout_hist 
--

CREATE EXTERNAL TABLE cus_blm_fapcus_nb_xcusb042_blm_cimout_hist(
    blcim_lty_id_nbr            BIGINT,
    blcim_name_first            VARCHAR(15),
    blcim_name_midl             VARCHAR(1),
    blcim_name_last             VARCHAR(20),
    blcim_addr_line_1           VARCHAR(25),
    blcim_addr_line_2           VARCHAR(25),
    blcim_city                  VARCHAR(20),
    blcim_state_cd              VARCHAR(2),
    blcim_postal_cd_aln         VARCHAR(5),
    blcim_phn_nbr               VARCHAR(10),
    blcim_email_addr            VARCHAR(50),
    blcim_open_date             STRING,
    blcim_location              SMALLINT,
    blcim_status                VARCHAR(1),
    blcim_status_change_date    STRING,
    blcim_status_reason         VARCHAR(2),
    blcim_added_by_appln        VARCHAR(8),
    blcim_program_code          VARCHAR(10),
    blcim_last_update_date      STRING,
    blcim_brth_mmdd             VARCHAR(4),
    blcim_cobran_irn            BIGINT,
    blcim_prop                  BIGINT,
    blcim_tier_code             VARCHAR(10),
    blcim_tier_chg_dt           STRING,
    daas_load_id                VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                 TIMESTAMP      COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_corrltn_id             STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'UN.DAILY.LOYALTY.gz'
PARTITIONED BY( blcim_div_id STRING, daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/blm/sensitive/raw/cust/cus/cus_blm_fapcus_nb_xcusb042_blm_cimout_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_blm_fapcus_nb_xcusb042_blm_cimout_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_blm_fapcus_nb_xcusb042_blm_cimout_snap 
--

CREATE EXTERNAL TABLE cus_blm_fapcus_nb_xcusb042_blm_cimout_snap(
    blcim_lty_id_nbr            BIGINT,
    blcim_name_first            VARCHAR(15),
    blcim_name_midl             VARCHAR(1),
    blcim_name_last             VARCHAR(20),
    blcim_addr_line_1           VARCHAR(25),
    blcim_addr_line_2           VARCHAR(25),
    blcim_city                  VARCHAR(20),
    blcim_state_cd              VARCHAR(2),
    blcim_postal_cd_aln         VARCHAR(5),
    blcim_phn_nbr               VARCHAR(10),
    blcim_email_addr            VARCHAR(50),
    blcim_open_date             STRING         COMMENT '* Date used in daas_part_dt',
    blcim_location              SMALLINT,
    blcim_status                VARCHAR(1),
    blcim_status_change_date    STRING,
    blcim_status_reason         VARCHAR(2),
    blcim_added_by_appln        VARCHAR(8),
    blcim_program_code          VARCHAR(10),
    blcim_last_update_date      STRING,
    blcim_brth_mmdd             VARCHAR(4),
    blcim_cobran_irn            BIGINT,
    blcim_prop                  BIGINT,
    blcim_tier_code             VARCHAR(10),
    blcim_tier_chg_dt           STRING,
    daas_load_id                VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                 TIMESTAMP      COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts                 TIMESTAMP      COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id             STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'UN.DAILY.LOYALTY.gz | Primary Key = blcim_lty_id_nbr| Offset = blcim_last_update_date | Partition = LPAD(CAST(blcim_lty_id_nbr%100 as varchar(10)),2,''0'')'
PARTITIONED BY( blcim_div_id STRING, daas_part_idmod VARCHAR(10) COMMENT 'The last two digits of the Loyalty Id')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/blm/sensitive/raw/cust/cus/cus_blm_fapcus_nb_xcusb042_blm_cimout_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mcy_fapcus_nb_xcusb042_cimout_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_mcy_fapcus_nb_xcusb042_cimout_hist 
--

CREATE EXTERNAL TABLE cus_mcy_fapcus_nb_xcusb042_cimout_hist(
    cim_lty_id_nbr               BIGINT,
    cim_name_first               VARCHAR(15),
    cim_name_midl                VARCHAR(1),
    cim_name_last                VARCHAR(20),
    cim_addr_line_1              VARCHAR(25),
    cim_addr_line_2              VARCHAR(25),
    cim_city                     VARCHAR(20),
    cim_state_cd                 VARCHAR(2),
    cim_postal_cd_aln            VARCHAR(5),
    cim_phn_nbr                  VARCHAR(10),
    cim_email_addr               VARCHAR(50),
    cim_open_date                STRING,
    cim_location                 SMALLINT,
    cim_status                   VARCHAR(1),
    cim_status_change_date       STRING,
    cim_status_reason            VARCHAR(2),
    cim_added_by_appln           VARCHAR(8),
    cim_program_code             VARCHAR(10),
    cim_last_update_date         STRING,
    cim_brth_mmdd                VARCHAR(4),
    cim_cobran_irn               BIGINT,
    cim_prop                     BIGINT,
    cim_tfs_flg                  VARCHAR(1),
    cim_tfs_enroll_dt            STRING,
    cim_tfs_disenroll_dt         STRING,
    cim_tfs_enrl_added_by_app    VARCHAR(8),
    cim_tfs_enrl_assoc_nbr       INT,
    cim_tfs_enrl_store_nbr       INT,
    cim_bty_flg                  VARCHAR(1),
    cim_bty_enroll_dt            STRING,
    cim_bty_disenroll_dt         STRING,
    cim_bty_enrl_added_by_app    VARCHAR(8),
    cim_bty_enrl_assoc_nbr       INT,
    cim_bty_enrl_store_nbr       INT,
    cim_bty_card_reissue_cnt     INT,
    cim_usl_flg                  VARCHAR(1),
    cim_usl_enroll_dt            STRING,
    cim_usl_disenroll_dt         STRING,
    cim_usl_enrl_added_by_app    VARCHAR(8),
    cim_usl_enrl_assoc_nbr       INT,
    cim_usl_enrl_store_nbr       INT,
    cim_usl_id                   BIGINT,
    daas_load_id                 VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                  TIMESTAMP      COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_corrltn_id              STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DN.DAILY.LOYALTY.gz'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/cust/cus/cus_mcy_fapcus_nb_xcusb042_cimout_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mcy_fapcus_nb_xcusb042_cimout_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_mcy_fapcus_nb_xcusb042_cimout_snap 
--

CREATE EXTERNAL TABLE cus_mcy_fapcus_nb_xcusb042_cimout_snap(
    cim_lty_id_nbr               BIGINT,
    cim_name_first               VARCHAR(15),
    cim_name_midl                VARCHAR(1),
    cim_name_last                VARCHAR(20),
    cim_addr_line_1              VARCHAR(25),
    cim_addr_line_2              VARCHAR(25),
    cim_city                     VARCHAR(20),
    cim_state_cd                 VARCHAR(2),
    cim_postal_cd_aln            VARCHAR(5),
    cim_phn_nbr                  VARCHAR(10),
    cim_email_addr               VARCHAR(50),
    cim_open_date                STRING         COMMENT '* Date used in daas_part_dt',
    cim_location                 SMALLINT,
    cim_status                   VARCHAR(1),
    cim_status_change_date       STRING,
    cim_status_reason            VARCHAR(2),
    cim_added_by_appln           VARCHAR(8),
    cim_program_code             VARCHAR(10),
    cim_last_update_date         STRING,
    cim_brth_mmdd                VARCHAR(4),
    cim_cobran_irn               BIGINT,
    cim_prop                     BIGINT,
    cim_tfs_flg                  VARCHAR(1),
    cim_tfs_enroll_dt            STRING,
    cim_tfs_disenroll_dt         STRING,
    cim_tfs_enrl_added_by_app    VARCHAR(8),
    cim_tfs_enrl_assoc_nbr       INT,
    cim_tfs_enrl_store_nbr       INT,
    cim_bty_flg                  VARCHAR(1),
    cim_bty_enroll_dt            STRING,
    cim_bty_disenroll_dt         STRING,
    cim_bty_enrl_added_by_app    VARCHAR(8),
    cim_bty_enrl_assoc_nbr       INT,
    cim_bty_enrl_store_nbr       INT,
    cim_bty_card_reissue_cnt     INT,
    cim_usl_flg                  VARCHAR(1),
    cim_usl_enroll_dt            STRING,
    cim_usl_disenroll_dt         STRING,
    cim_usl_enrl_added_by_app    VARCHAR(8),
    cim_usl_enrl_assoc_nbr       INT,
    cim_usl_enrl_store_nbr       INT,
    cim_usl_id                   BIGINT,
    daas_load_id                 VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                  TIMESTAMP      COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts                  TIMESTAMP      COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id              STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DN.DAILY.LOYALTY.gz | Primary Key = cim_lty_id_nbr| Offset = cim_last_update_date | Partition = LPAD(CAST(cim_lty_id_nbr%100 as varchar(10)),2,''0'')'
PARTITIONED BY( daas_part_idmod VARCHAR(10) COMMENT 'The last two digits of the Loyalty Id')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/cust/cus/cus_mcy_fapcus_nb_xcusb042_cimout_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out1_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_mix_fapcus_na_xcuscil1_pref_out1_hist 
--

CREATE EXTERNAL TABLE cus_mix_fapcus_na_xcuscil1_pref_out1_hist(
    cus136c_cust_id             INT,
    out_rec_num                 SMALLINT,
    cusi136c_gender             VARCHAR(1),
    cusi136c_added_by_app       VARCHAR(8),
    cusi136c_birth_dt           STRING,
    cusi136c_exprtn_dt          STRING,
    cus136c_create_ts           TIMESTAMP,
    cus136c_last_upd_user_id    VARCHAR(32),
    cus136c_last_upd_ts         TIMESTAMP,
    cus136c_chng_origin         VARCHAR(20),
    cus136c_create_user_id      VARCHAR(32),
    cusi136c_name_first         VARCHAR(20),
    cusi136c_name_last          VARCHAR(30),
    cusi136c_name_title         VARCHAR(5),
    cusi136c_name_midl          VARCHAR(20),
    cusi136c_addr_line_1        VARCHAR(40),
    cusi136c_addr_line_2        VARCHAR(40),
    cusi136c_addr_type          VARCHAR(4),
    cusi136c_city               VARCHAR(25),
    cusi136c_state_cd           VARCHAR(2),
    cusi136c_postal_cd_aln      VARCHAR(10),
    cusi136c_iso_ctry_cd        VARCHAR(2),
    cusi136c_acct_seq_nbr       SMALLINT,
    cusi136c_acct_typ_id        VARCHAR(4),
    cusi136c_acct_nbr           BIGINT,
    cusi136c_acct_crd_locn      INT,
    cusi136c_acct_ind           VARCHAR(1),
    cusi136c_facs_div_nbr       SMALLINT,
    daas_load_id                VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                 TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id             STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DAILY_LOAD_CUST_COMB_D09112014.TXT Rec = 1'
PARTITIONED BY( cusi136c_retail_div_nbr SMALLINT, daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/cus/cus_mix_fapcus_na_xcuscil1_pref_out1_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out1_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_mix_fapcus_na_xcuscil1_pref_out1_snap 
--

CREATE EXTERNAL TABLE cus_mix_fapcus_na_xcuscil1_pref_out1_snap(
    cus136c_cust_id             INT,
    out_rec_num                 SMALLINT,
    cusi136c_gender             VARCHAR(1),
    cusi136c_added_by_app       VARCHAR(8),
    cusi136c_birth_dt           STRING,
    cusi136c_exprtn_dt          STRING,
    cus136c_create_ts           TIMESTAMP      COMMENT '* Date used in daas_part_dt',
    cus136c_last_upd_user_id    VARCHAR(32),
    cus136c_last_upd_ts         TIMESTAMP,
    cus136c_chng_origin         VARCHAR(20),
    cus136c_create_user_id      VARCHAR(32),
    cusi136c_name_first         VARCHAR(20),
    cusi136c_name_last          VARCHAR(30),
    cusi136c_name_title         VARCHAR(5),
    cusi136c_name_midl          VARCHAR(20),
    cusi136c_addr_line_1        VARCHAR(40),
    cusi136c_addr_line_2        VARCHAR(40),
    cusi136c_addr_type          VARCHAR(4),
    cusi136c_city               VARCHAR(25),
    cusi136c_state_cd           VARCHAR(2),
    cusi136c_postal_cd_aln      VARCHAR(10),
    cusi136c_iso_ctry_cd        VARCHAR(2),
    cusi136c_acct_seq_nbr       SMALLINT,
    cusi136c_acct_typ_id        VARCHAR(4),
    cusi136c_acct_nbr           BIGINT,
    cusi136c_acct_crd_locn      INT,
    cusi136c_acct_ind           VARCHAR(1),
    cusi136c_facs_div_nbr       SMALLINT,
    daas_load_id                VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                 TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                 TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id             STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DAILY_LOAD_CUST_COMB_D09112014.TXT Rec = 1 | Primary Key = cus136c_cust_id| Offset = cusi136_last_upd_ts | Partition = LPAD(CAST(cus136c_cust_id%100 as varchar(10)),2,''0'')'
PARTITIONED BY( cusi136c_retail_div_nbr SMALLINT, daas_part_idmod VARCHAR(10) COMMENT 'The last two digits of the Cust Id')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/cus/cus_mix_fapcus_na_xcuscil1_pref_out1_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out2_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_mix_fapcus_na_xcuscil1_pref_out2_hist 
--

CREATE EXTERNAL TABLE cus_mix_fapcus_na_xcuscil1_pref_out2_hist(
    cus136c_cust_id             INT,
    out_rec_num                 SMALLINT,
    cus136c_cntct_seq_nbr       SMALLINT,
    cus136c_iso_ctry_cd         VARCHAR(2),
    cus136c_cntct_nbr_aln       VARCHAR(20),
    cus136c_cntct_nbr_num       BIGINT,
    cus136c_email_addr          VARCHAR(150),
    cus136c_create_user_id      VARCHAR(32),
    cus136c_create_ts           TIMESTAMP,
    cus136c_last_upd_user_id    VARCHAR(32),
    cus136c_last_upd_ts         TIMESTAMP,
    cus136c_chng_origin         VARCHAR(20),
    cus136c_cntct_typ_id        VARCHAR(4),
    daas_load_id                VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                 TIMESTAMP       COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id             STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DAILY_LOAD_CUST_COMB_D09112014.TXT Rec = 2'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/cus/cus_mix_fapcus_na_xcuscil1_pref_out2_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out2_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_mix_fapcus_na_xcuscil1_pref_out2_snap 
--

CREATE EXTERNAL TABLE cus_mix_fapcus_na_xcuscil1_pref_out2_snap(
    cus136c_cust_id             INT,
    out_rec_num                 SMALLINT,
    cus136c_cntct_seq_nbr       SMALLINT,
    cus136c_iso_ctry_cd         VARCHAR(2),
    cus136c_cntct_nbr_aln       VARCHAR(20),
    cus136c_cntct_nbr_num       BIGINT,
    cus136c_email_addr          VARCHAR(150),
    cus136c_create_user_id      VARCHAR(32),
    cus136c_create_ts           TIMESTAMP       COMMENT '* Date used in daas_part_dt',
    cus136c_last_upd_user_id    VARCHAR(32),
    cus136c_last_upd_ts         TIMESTAMP,
    cus136c_chng_origin         VARCHAR(20),
    cus136c_cntct_typ_id        VARCHAR(4),
    daas_load_id                VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                 TIMESTAMP       COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                 TIMESTAMP       COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id             STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DAILY_LOAD_CUST_COMB_D09112014.TXT Rec = 2 | Primary Key = cus136c_cust_id| Offset = cusi136c_last_upd_ts | Partition = LPAD(CAST(cus136c_cust_id%100 as varchar(10)),2,''0'')'
PARTITIONED BY( division STRING COMMENT 'Division: Macys 71 or Bloomingdales 72', daas_part_idmod VARCHAR(10) COMMENT 'The last two digits of the Cust Id')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/cus/cus_mix_fapcus_na_xcuscil1_pref_out2_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out3_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_mix_fapcus_na_xcuscil1_pref_out3_hist 
--

CREATE EXTERNAL TABLE cus_mix_fapcus_na_xcuscil1_pref_out3_hist(
    out_rec_num                SMALLINT,
    cc2_cntct_typ_cd           VARCHAR(1),
    cc2_cntct_id               VARCHAR(50),
    cc2_pref_typ               SMALLINT,
    cc2_pref_value             VARCHAR(5),
    cc2_action_ind             VARCHAR(1),
    cc2_pref_chg_ts            TIMESTAMP,
    cc2_src_loc                SMALLINT,
    cc2_pref_seq_nbr           SMALLINT,
    cc2_exp_dt                 STRING,
    cc2_creation_src_system    VARCHAR(32),
    cc2_creation_src_ts        TIMESTAMP,
    cc2_last_upd_src_system    VARCHAR(32),
    cc2_last_upd_src_ts        TIMESTAMP,
    cc2_chg_program            VARCHAR(20),
    cc2_customer_type          VARCHAR(1),
    cc2_inq_src_code           VARCHAR(1),
    cc2_customer_note          VARCHAR(500),
    daas_load_id               VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                TIMESTAMP       COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id            STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DAILY_LOAD_CUST_COMB_D09112014.TXT Rec = 3'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/cus/cus_mix_fapcus_na_xcuscil1_pref_out3_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out3_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: cus_mix_fapcus_na_xcuscil1_pref_out3_snap 
--

CREATE EXTERNAL TABLE cus_mix_fapcus_na_xcuscil1_pref_out3_snap(
    cc2_cntct_typ_cd           VARCHAR(1),
    cc2_cntct_id               VARCHAR(50),
    cc2_pref_typ               SMALLINT,
    cc2_pref_value             VARCHAR(5),
    out_rec_num                SMALLINT,
    cc2_action_ind             VARCHAR(1),
    cc2_pref_chg_ts            TIMESTAMP,
    cc2_src_loc                SMALLINT,
    cc2_pref_seq_nbr           SMALLINT,
    cc2_exp_dt                 STRING,
    cc2_creation_src_system    VARCHAR(32),
    cc2_creation_src_ts        TIMESTAMP       COMMENT '* Date used in daas_part_dt',
    cc2_last_upd_src_system    VARCHAR(32),
    cc2_last_upd_src_ts        TIMESTAMP,
    cc2_chg_program            VARCHAR(20),
    cc2_customer_type          VARCHAR(1),
    cc2_inq_src_code           VARCHAR(1),
    cc2_customer_note          VARCHAR(500),
    daas_load_id               VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                TIMESTAMP       COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                TIMESTAMP       COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id            STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DAILY_LOAD_CUST_COMB_D09112014.TXT Rec=3|Primary Key=cc2_cntct_typ_cd,cc2_cntct_id,cc2_pref_typ,cc2_pref_value|Offset=cc2_last_upd_src_ts|Partition=substr(cc2_cntct_id, (length(cc2_cntct_id )-2+1), 2)'
PARTITIONED BY( division STRING COMMENT 'Division: Macys 71 or Bloomingdales 72', daas_part_idmod VARCHAR(10) COMMENT 'The last two digits of the Contact ID')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/cus/cus_mix_fapcus_na_xcuscil1_pref_out3_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_blm_fapcus_nb_xcusb042_blm_cimout_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_blm_fapcus_nb_xcusb042_blm_cimout_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mcy_fapcus_nb_xcusb042_cimout_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mcy_fapcus_nb_xcusb042_cimout_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out1_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out1_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out2_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out2_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out3_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.cus_mix_fapcus_na_xcuscil1_pref_out3_snap;

