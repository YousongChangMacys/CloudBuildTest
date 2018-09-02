

set hive.msck.path.validation=ignore;

DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.gft_mix_bridal_cust_occsn_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: gft_mix_bridal_cust_occsn_hist 
--

CREATE EXTERNAL TABLE gft_mix_bridal_cust_occsn_hist(
    rgstry_dim_id          BIGINT,
    rgstry_id              INT,
    store_loc              SMALLINT,
    name_first             VARCHAR(20),
    name_last              VARCHAR(30),
    addr_line_1            VARCHAR(40),
    addr_line_2            VARCHAR(40),
    addr_line_3            VARCHAR(40),
    city                   VARCHAR(25),
    state_cd               VARCHAR(7),
    postal_cd_aln          VARCHAR(10),
    email_addr             VARCHAR(150),
    cust_id                INT,
    occsn_dte              STRING,
    added_dte              VARCHAR(10),
    occsn_typ              VARCHAR(1),
    stat                   VARCHAR(1),
    mail_opt_out_flg       VARCHAR(1),
    e_mail_opt_out_flag    VARCHAR(1),
    inactive_flg           VARCHAR(1),
    rgstry_loy_flg         VARCHAR(1),
    appl_id                VARCHAR(1),
    emp_id                 INT,
    calculated_value_1     DECIMAL(10, 2),
    calculated_value_2     DECIMAL(10, 2),
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'bridal_cust_occsn_extract'
PARTITIONED BY( store_div STRING, daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/gft/gft_mix_bridal_cust_occsn_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.gft_mix_bridal_cust_occsn_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: gft_mix_bridal_cust_occsn_snap 
--

CREATE EXTERNAL TABLE gft_mix_bridal_cust_occsn_snap(
    rgstry_dim_id          BIGINT,
    rgstry_id              INT,
    store_loc              SMALLINT,
    name_first             VARCHAR(20),
    name_last              VARCHAR(30),
    addr_line_1            VARCHAR(40),
    addr_line_2            VARCHAR(40),
    addr_line_3            VARCHAR(40),
    city                   VARCHAR(25),
    state_cd               VARCHAR(7),
    postal_cd_aln          VARCHAR(10),
    email_addr             VARCHAR(150),
    cust_id                INT,
    occsn_dte              STRING,
    added_dte              VARCHAR(10)       COMMENT '* Date used in daas_part_dt',
    occsn_typ              VARCHAR(1),
    stat                   VARCHAR(1),
    mail_opt_out_flg       VARCHAR(1),
    e_mail_opt_out_flag    VARCHAR(1),
    inactive_flg           VARCHAR(1),
    rgstry_loy_flg         VARCHAR(1),
    appl_id                VARCHAR(1),
    emp_id                 INT,
    calculated_value_1     DECIMAL(10, 2),
    calculated_value_2     DECIMAL(10, 2),
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts            TIMESTAMP         COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'bridal_cust_occsn_extract | Primary Key = rgstry_dim_id| Offset = added_dte | Partition Date = added_dte yyyy-MM-dd'
PARTITIONED BY( store_div STRING, daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/gft/gft_mix_bridal_cust_occsn_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.gft_mix_bridal_cust_reg_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: gft_mix_bridal_cust_reg_hist 
--

CREATE EXTERNAL TABLE gft_mix_bridal_cust_reg_hist(
    rgstry_dim_id          BIGINT,
    rgstry_id              INT,
    store_loc              SMALLINT,
    name_first             VARCHAR(20),
    name_last              VARCHAR(30),
    addr_line_1            VARCHAR(40),
    addr_line_2            VARCHAR(40),
    addr_line_3            VARCHAR(40),
    city                   VARCHAR(25),
    state_cd               VARCHAR(7),
    postal_cd_aln          VARCHAR(10),
    email_addr             VARCHAR(150),
    cust_id                INT,
    occsn_dte              STRING,
    added_dte              VARCHAR(10),
    occsn_typ              VARCHAR(1),
    stat                   VARCHAR(1),
    mail_opt_out_flg       VARCHAR(1),
    e_mail_opt_out_flag    VARCHAR(1),
    inactive_flg           VARCHAR(1),
    rgstry_loy_flg         VARCHAR(1),
    appl_id                VARCHAR(1),
    emp_id                 VARCHAR(1),
    calculated_value_1     DECIMAL(10, 2),
    calculated_value_2     DECIMAL(10, 2),
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'bridal_cust_reg_extract'
PARTITIONED BY( store_div STRING, daas_part_dt VARCHAR(10) COMMENT 'Date created by the ETL process for partitioning in the format of YYYY-MM-DD')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/gft/gft_mix_bridal_cust_reg_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.gft_mix_bridal_cust_reg_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: gft_mix_bridal_cust_reg_snap 
--

CREATE EXTERNAL TABLE gft_mix_bridal_cust_reg_snap(
    rgstry_dim_id          BIGINT,
    rgstry_id              INT,
    store_loc              SMALLINT,
    name_first             VARCHAR(20),
    name_last              VARCHAR(30),
    addr_line_1            VARCHAR(40),
    addr_line_2            VARCHAR(40),
    addr_line_3            VARCHAR(40),
    city                   VARCHAR(25),
    state_cd               VARCHAR(7),
    postal_cd_aln          VARCHAR(10),
    email_addr             VARCHAR(150),
    cust_id                INT,
    occsn_dte              STRING,
    added_dte              VARCHAR(10)       COMMENT '* Date used in daas_part_dt',
    occsn_typ              VARCHAR(1),
    stat                   VARCHAR(1),
    mail_opt_out_flg       VARCHAR(1),
    e_mail_opt_out_flag    VARCHAR(1),
    inactive_flg           VARCHAR(1),
    rgstry_loy_flg         VARCHAR(1),
    appl_id                VARCHAR(1),
    emp_id                 VARCHAR(1),
    calculated_value_1     DECIMAL(10, 2),
    calculated_value_2     DECIMAL(10, 2),
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts            TIMESTAMP         COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'bridal_cust_reg_extract | Primary Key = rgstry_dim_id| Offset = added_dte | Partition Date = added_dte yyyy-MM-dd'
PARTITIONED BY( store_div STRING, daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/cust/gft/gft_mix_bridal_cust_reg_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_na_xgfta819_oregocc;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust;
-- 
-- TABLE: gft_mix_fapgft_na_xgfta819_oregocc 
--

CREATE EXTERNAL TABLE gft_mix_fapgft_na_xgfta819_oregocc(
    reg_id                   INT,
    dmltype                  VARCHAR(1),
    rgs_dte                  STRING           COMMENT '* Date used in daas_part_dt',
    last_upd_date            VARCHAR(10),
    app_id                   VARCHAR(1),
    occn_id                  VARCHAR(1),
    occn_date                STRING,
    registry_barcode         VARCHAR(13),
    registry_comp_barcode    VARCHAR(13),
    rgs_stat                 VARCHAR(1),
    rgs_stat_dte             STRING,
    rfrl_id                  VARCHAR(1),
    nbr_of_guest             SMALLINT,
    val_pot                  DECIMAL(7, 0),
    val_actl                 DECIMAL(7, 0),
    brlp_enrol_stat          VARCHAR(1),
    locn_cd                  SMALLINT,
    internet_f               VARCHAR(1),
    asoc_name_fst            VARCHAR(20),
    asoc_name_lst            VARCHAR(30),
    go_green                 VARCHAR(1),
    daas_load_id             VARCHAR(36)      COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts              TIMESTAMP        COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts              TIMESTAMP        COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id          STRING           COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'REGISTRY | Primary Key = reg_id,div_nbr| Offset = last_upd_date | Partition Date = rgs_dte MM/dd/yyyy'
PARTITIONED BY( div_nbr STRING, daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/cust/gft/gft_mix_fapgft_na_xgfta819_oregocc'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_na_xgfta819_oregreg;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust;
-- 
-- TABLE: gft_mix_fapgft_na_xgfta819_oregreg 
--

CREATE EXTERNAL TABLE gft_mix_fapgft_na_xgfta819_oregreg(
    reg_id             INT,
    dmltype            VARCHAR(1),
    rgs_dte            STRING          COMMENT '* Date used in daas_part_dt',
    last_upd_date      VARCHAR(10),
    role_id            TINYINT,
    role_desc          VARCHAR(21),
    name_pre           VARCHAR(5),
    name_fst           VARCHAR(30),
    name_mid           VARCHAR(30),
    name_lst           VARCHAR(30),
    name_suf           VARCHAR(5),
    attn               VARCHAR(35),
    addr_1             VARCHAR(40),
    addr_2             VARCHAR(40),
    city               VARCHAR(25),
    state              VARCHAR(2),
    zip                VARCHAR(9),
    country            VARCHAR(16),
    saddr_1            VARCHAR(40),
    saddr_2            VARCHAR(40),
    scity              VARCHAR(25),
    sstate             VARCHAR(2),
    szip               VARCHAR(9),
    scountry           VARCHAR(16),
    faddr_1            VARCHAR(40),
    faddr_2            VARCHAR(40),
    fcity              VARCHAR(25),
    fstate             VARCHAR(2),
    fzip               VARCHAR(9),
    fcountry           VARCHAR(16),
    fdate              STRING,
    dphn               VARCHAR(18),
    ephn               VARCHAR(18),
    email              VARCHAR(150),
    email_opt_in       VARCHAR(1),
    email_eff_dt       STRING,
    mail_opt_in        VARCHAR(1),
    phone_opt_in       VARCHAR(1),
    opt_in_ts          VARCHAR(26),
    daas_load_id       VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts        TIMESTAMP       COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts        TIMESTAMP       COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id    STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'REGISTRANT | Primary Key = div_nbr,reg_id| Offset = last_upd_date | Partition Date = rgs_dte MM/dd/yyyy'
PARTITIONED BY( div_nbr STRING, daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/cust/gft/gft_mix_fapgft_na_xgfta819_oregreg'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_na_xgfta820_oregdet;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust;
-- 
-- TABLE: gft_mix_fapgft_na_xgfta820_oregdet 
--

CREATE EXTERNAL TABLE gft_mix_fapgft_na_xgfta820_oregdet(
    reg_id             INT,
    dmltype            VARCHAR(1),
    itm_id             INT,
    rgs_dte            STRING            COMMENT '* Date used in daas_part_dt',
    last_update        VARCHAR(10),
    dept_nbr           SMALLINT,
    class_nbr          INT,
    lbl_id             INT,
    vendor_style       VARCHAR(10),
    upc                DECIMAL(18, 0),
    upc_desc           VARCHAR(30),
    pip_desc           VARCHAR(20),
    cat_desc           VARCHAR(30),
    lbl_name           VARCHAR(35),
    rtim_qty_rqst      SMALLINT,
    rtim_qty_open      SMALLINT,
    rtim_qty_rec       SMALLINT,
    daas_load_id       VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts        TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts        TIMESTAMP         COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id    STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'REGISTRY_DETAIL | Primary Key = div_nbr,reg_id,dmltype,itm_id| Offset = last_update | Partition Date = rgs_dte MM/dd/yyyy'
PARTITIONED BY( div_nbr STRING, daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/cust/gft/gft_mix_fapgft_na_xgfta820_oregdet'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_ul_prd_gftrsty_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust;
-- 
-- TABLE: gft_mix_fapgft_ul_prd_gftrsty_hist 
--

CREATE EXTERNAL TABLE gft_mix_fapgft_ul_prd_gftrsty_hist(
    out_registry_number    INT,
    out_occasion_date      STRING,
    out_creation_date      VARCHAR(10),
    out_actual_value       DECIMAL(10, 2),
    out_potential_value    DECIMAL(10, 2),
    out_retail_division    SMALLINT,
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'GFTRSTY'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date created by the ETL process for partitioning in the format of YYYY-MM-DD')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/cust/gft/gft_mix_fapgft_ul_prd_gftrsty_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_ul_prd_gftrsty_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust;
-- 
-- TABLE: gft_mix_fapgft_ul_prd_gftrsty_snap 
--

CREATE EXTERNAL TABLE gft_mix_fapgft_ul_prd_gftrsty_snap(
    out_registry_number    INT,
    out_occasion_date      STRING,
    out_creation_date      VARCHAR(10)       COMMENT '* Date used in daas_part_dt',
    out_actual_value       DECIMAL(10, 2),
    out_potential_value    DECIMAL(10, 2),
    out_retail_division    SMALLINT,
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts            TIMESTAMP         COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'GFTRSTY | Primary Key = out_registry_number| Offset = out_creation_date | Partition Date = out_creation_date MM/dd/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/cust/gft/gft_mix_fapgft_ul_prd_gftrsty_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.gft_mix_bridal_cust_occsn_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.gft_mix_bridal_cust_occsn_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.gft_mix_bridal_cust_reg_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.gft_mix_bridal_cust_reg_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_na_xgfta819_oregocc;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_na_xgfta819_oregreg;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_na_xgfta820_oregdet;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_ul_prd_gftrsty_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust.gft_mix_fapgft_ul_prd_gftrsty_snap;

