
set hive.msck.path.validation=ignore;

DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_chnl_typ_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_chnl_typ_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_chnl_typ_hist(
    chnl_typ           VARCHAR(10)     COMMENT 'Short alphanumeric code for type of channel.Valid values are STORE,ONLINE.',
    chnl_typ_desc      VARCHAR(100)    COMMENT 'Descriptive value for Channel Type e.g. Store, Web, Mobile, All',
    create_usr_id      VARCHAR(50)     COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP       COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id     VARCHAR(50)     COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts     TIMESTAMP       COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts        TIMESTAMP       COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id       VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'The channel for the offer.  This supports the different codes and behavior of offers issued for distinct selling channels. Valid values are STORE,ONLINE,MOBILE.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_chnl_typ_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_chnl_typ_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_chnl_typ_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_chnl_typ_snap(
    chnl_typ           VARCHAR(10)     COMMENT 'Short alphanumeric code for type of channel.Valid values are STORE,ONLINE.',
    chnl_typ_desc      VARCHAR(100)    COMMENT 'Descriptive value for Channel Type e.g. Store, Web, Mobile, All',
    create_usr_id      VARCHAR(50)     COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP       COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id     VARCHAR(50)     COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity *Date used in daas_part_dt',
    lst_upd_usr_ts     TIMESTAMP       COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts        TIMESTAMP       COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts        TIMESTAMP       COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id       VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'The channel for the offer.  This supports the different codes and behavior of offers issued for distinct selling channels. Valid values are STORE,ONLINE,MOBILE. | Primary Key = chnl_typ| Offset = lst_upd_usr_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_chnl_typ_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ext_iss_ofr_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ext_iss_ofr_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ext_iss_ofr_hist(
    ext_iss_ofr_sk     DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    eff_end_dt         STRING         COMMENT 'EFF_END_DATE will be used for monthly partitioning. All components will need to populate this column from the same column in EWH_OFR. After the EFF_END_DATE month has passed, an archive of the past month partitioned will be done (archiving strat<Truncated>',
    perm_id_sk         DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ofr_sk             DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    provisn_typ        VARCHAR(1)     COMMENT 'Indicates whether the issued offer is ''M''anually or ''A''uto provisioned.',
    rdmptn_cd          VARCHAR(20)    COMMENT 'The actual code used to redeem the offer. This attribute could hold a value of a SUPC, PromoCd or Barcode.',
    ofr_unused_qty     DECIMAL        COMMENT 'Used to track the number of offer uses left for the customer.',
    ofr_usg_strt_dt    STRING         COMMENT 'The timestamp for when the offer was first used.',
    ofr_usg_end_dt     STRING         COMMENT 'The last timestamp for which the offer can be used.  This is based on the offer effective date and validity period.',
    iss_ofr_del_ind    VARCHAR(1)     COMMENT 'Used to indicate that the offer has been soft deleted from the customer''s wallet.  This is also necessary to maintain referential data in the EWH Offer Usage table.',
    ofr_enbl_ind       VARCHAR(1)     COMMENT 'This indicator will be used in conjunction with the Manual enabling required indicator  in Offer table to handle the future requirements. The future requirement could be that the offers are set up ( both meta data and issued offer) in wallethub.<Truncated>',
    ofr_elg_ind        VARCHAR(1)     COMMENT 'The business need is for Star Passes to be eligible at POS or online only when the following conditions are met.

Star passes will be auto provisioned for Prop Accounts when a customer has 
a. A Site profile 
b. And added the prop card in to<Truncated>',
    create_usr_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts        TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id       VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores offers issued to the customer that fall outside the current maximum partitioning effective end date in the issued offer table.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ext_iss_ofr_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ext_iss_ofr_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ext_iss_ofr_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ext_iss_ofr_snap(
    ext_iss_ofr_sk     DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    eff_end_dt         STRING         COMMENT 'EFF_END_DATE will be used for monthly partitioning. All components will need to populate this column from the same column in EWH_OFR. After the EFF_END_DATE month has passed, an archive of the past month partitioned will be done (archiving strat<Truncated>',
    perm_id_sk         DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ofr_sk             DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    provisn_typ        VARCHAR(1)     COMMENT 'Indicates whether the issued offer is ''M''anually or ''A''uto provisioned.',
    rdmptn_cd          VARCHAR(20)    COMMENT 'The actual code used to redeem the offer. This attribute could hold a value of a SUPC, PromoCd or Barcode.',
    ofr_unused_qty     DECIMAL        COMMENT 'Used to track the number of offer uses left for the customer.',
    ofr_usg_strt_dt    STRING         COMMENT 'The timestamp for when the offer was first used.',
    ofr_usg_end_dt     STRING         COMMENT 'The last timestamp for which the offer can be used.  This is based on the offer effective date and validity period.',
    iss_ofr_del_ind    VARCHAR(1)     COMMENT 'Used to indicate that the offer has been soft deleted from the customer''s wallet.  This is also necessary to maintain referential data in the EWH Offer Usage table.',
    ofr_enbl_ind       VARCHAR(1)     COMMENT 'This indicator will be used in conjunction with the Manual enabling required indicator  in Offer table to handle the future requirements. The future requirement could be that the offers are set up ( both meta data and issued offer) in wallethub.<Truncated>',
    ofr_elg_ind        VARCHAR(1)     COMMENT 'The business need is for Star Passes to be eligible at POS or online only when the following conditions are met.

Star passes will be auto provisioned for Prop Accounts when a customer has 
a. A Site profile 
b. And added the prop card in to<Truncated>',
    create_usr_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated *Date used in daas_part_dt',
    daas_crt_ts        TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts        TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id       VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores offers issued to the customer that fall outside the current maximum partitioning effective end date in the issued offer table. | Primary Key = ext_iss_ofr_sk,eff_end_dt| Offset = lst_upd_src_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ext_iss_ofr_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ext_ofr_usg_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ext_ofr_usg_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ext_ofr_usg_hist(
    ext_ofr_usg_sk          DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    eff_end_dt              STRING         COMMENT 'EFF_END_DATE will be used for monthly partitioning. All components will need to populate this column from the same column in EWH_OFR. After the EFF_END_DATE month has passed, an archive of the past month partitioned will be done (archiving strat<Truncated>',
    perm_id_sk              DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ext_iss_ofr_sk          DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    chnl_typ                VARCHAR(10)    COMMENT 'Short alphanumeric code for type of channel.  Valid values are ONLINE or STORE',
    txn_cd                  VARCHAR(3)     COMMENT 'Captures the  retail transaction code.  Purchase(10), PreSale Purchase(73), PostVoid(81) are some examples.',
    rtl_divn_nbr            DECIMAL        COMMENT 'Retail division numbers valid for eWallet.',
    rgstr_nbr               DECIMAL        COMMENT 'Store register number where offer was used.',
    txn_nbr                 DECIMAL        COMMENT 'Store transaction number that is associated with offers redeemed at POS.  May be NULL is order if not redeemed by POS.',
    ord_nbr                 VARCHAR(30)    COMMENT 'Order Identifer number that is associated with offers redeemed by site.  NULL if not redeemed by site.',
    str_nbr                 DECIMAL        COMMENT 'Serial number for the store',
    actv_rdmptn_ind         VARCHAR(1)     COMMENT 'Active redemption indicator is used to handle SUPC redemption analytics. When a SUPC is redeemed with a PermId, it and the transaction are marked with an Active redemption ind. = Y and all Permids that had the same SUPC with an Active redemption ind. = N.',
    vld_rdmptn_ind          VARCHAR(1)     COMMENT 'The valid redemption indicator is used to track the double dipping( lock wallet functionality is not available) of an offer as well as handle the redemption of an offer after the offer expiry period.',
    txn_ts                  TIMESTAMP      COMMENT 'The timestamp associated with transaction.',
    create_usr_id           VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts           TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id           VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts           TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    perm_id                 VARCHAR(25),
    perm_id_typ             VARCHAR(5)     COMMENT 'Type of Permanent Identifier. P is for Prop card, W is for Website profile, L is for Loyalty.',
    perm_id_rtl_divn_nbr    DECIMAL        COMMENT 'Retail division numbers valid for eWallet.',
    daas_crt_ts             TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id            VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id         STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores customer offer usage information that is related to offers in the extended issue offer table.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ext_ofr_usg_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ext_ofr_usg_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ext_ofr_usg_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ext_ofr_usg_snap(
    ext_ofr_usg_sk          DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    eff_end_dt              STRING         COMMENT 'EFF_END_DATE will be used for monthly partitioning. All components will need to populate this column from the same column in EWH_OFR. After the EFF_END_DATE month has passed, an archive of the past month partitioned will be done (archiving strat<Truncated>',
    perm_id_sk              DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ext_iss_ofr_sk          DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    chnl_typ                VARCHAR(10)    COMMENT 'Short alphanumeric code for type of channel.  Valid values are ONLINE or STORE',
    txn_cd                  VARCHAR(3)     COMMENT 'Captures the  retail transaction code.  Purchase(10), PreSale Purchase(73), PostVoid(81) are some examples.',
    rtl_divn_nbr            DECIMAL        COMMENT 'Retail division numbers valid for eWallet.',
    rgstr_nbr               DECIMAL        COMMENT 'Store register number where offer was used.',
    txn_nbr                 DECIMAL        COMMENT 'Store transaction number that is associated with offers redeemed at POS.  May be NULL is order if not redeemed by POS.',
    ord_nbr                 VARCHAR(30)    COMMENT 'Order Identifer number that is associated with offers redeemed by site.  NULL if not redeemed by site.',
    str_nbr                 DECIMAL        COMMENT 'Serial number for the store',
    actv_rdmptn_ind         VARCHAR(1)     COMMENT 'Active redemption indicator is used to handle SUPC redemption analytics. When a SUPC is redeemed with a PermId, it and the transaction are marked with an Active redemption ind. = Y and all Permids that had the same SUPC with an Active redemption ind. = N.',
    vld_rdmptn_ind          VARCHAR(1)     COMMENT 'The valid redemption indicator is used to track the double dipping( lock wallet functionality is not available) of an offer as well as handle the redemption of an offer after the offer expiry period.',
    txn_ts                  TIMESTAMP      COMMENT 'The timestamp associated with transaction.',
    create_usr_id           VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts           TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id           VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts           TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated *Date used in daas_part_dt',
    perm_id                 VARCHAR(25),
    perm_id_typ             VARCHAR(5)     COMMENT 'Type of Permanent Identifier. P is for Prop card, W is for Website profile, L is for Loyalty.',
    perm_id_rtl_divn_nbr    DECIMAL        COMMENT 'Retail division numbers valid for eWallet.',
    daas_crt_ts             TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts             TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id            VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id         STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores customer offer usage information that is related to offers in the extended issue offer table. | Primary Key = ext_ofr_usg_sk,eff_end_dt| Offset = lst_upd_src_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ext_ofr_usg_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_iss_ofr_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_iss_ofr_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_iss_ofr_hist(
    iss_ofr_sk         DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    eff_end_dt         STRING         COMMENT 'EFF_END_DATE will be used for monthly partitioning. All components will need to populate this column from the same column in EWH_OFR. After the EFF_END_DATE month has passed, an archive of the past month partitioned will be done (archiving strat<Truncated>',
    perm_id_sk         DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ofr_sk             DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    provisn_typ        VARCHAR(1)     COMMENT 'Indicates whether the issued offer is ''M''anually or ''A''uto provisioned.',
    rdmptn_cd          VARCHAR(20)    COMMENT 'The actual code used to redeem the offer. This attribute could hold a value of a SUPC, PromoCd or Barcode.',
    ofr_unused_qty     DECIMAL        COMMENT 'Used to track the number of offer uses left for the customer.',
    ofr_usg_strt_dt    STRING         COMMENT 'The timestamp for when the offer was first used.',
    ofr_usg_end_dt     STRING         COMMENT 'The last timestamp for which the offer can be used.  This is based on the offer effective date and validity period.',
    iss_ofr_del_ind    VARCHAR(1)     COMMENT 'Used to indicate that the offer has been soft deleted from the customer''s wallet.  This is also necessary to maintain referential data in the EWH Offer Usage table.',
    ofr_enbl_ind       VARCHAR(1)     COMMENT 'This indicator will be used in conjunction with the Manual enabling required indicator  in Offer table to handle the future requirements. The future requirement could be that the offers are set up ( both meta data and issued offer) in wallethub.<Truncated>',
    ofr_elg_ind        VARCHAR(1)     COMMENT 'The business need is for Star Passes to be eligible at POS or online only when the following conditions are met.

Star passes will be auto provisioned for Prop Accounts when a customer has 
a. A Site profile 
b. And added the prop card in to<Truncated>',
    create_usr_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts        TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id       VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores offers issued to the customer that fall within the current maximum partitioning effective end date in the issued offer table.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_iss_ofr_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_iss_ofr_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_iss_ofr_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_iss_ofr_snap(
    iss_ofr_sk         DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    eff_end_dt         STRING         COMMENT 'EFF_END_DATE will be used for monthly partitioning. All components will need to populate this column from the same column in EWH_OFR. After the EFF_END_DATE month has passed, an archive of the past month partitioned will be done (archiving strat<Truncated>',
    perm_id_sk         DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ofr_sk             DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    provisn_typ        VARCHAR(1)     COMMENT 'Indicates whether the issued offer is ''M''anually or ''A''uto provisioned.',
    rdmptn_cd          VARCHAR(20)    COMMENT 'The actual code used to redeem the offer. This attribute could hold a value of a SUPC, PromoCd or Barcode.',
    ofr_unused_qty     DECIMAL        COMMENT 'Used to track the number of offer uses left for the customer.',
    ofr_usg_strt_dt    STRING         COMMENT 'The timestamp for when the offer was first used.',
    ofr_usg_end_dt     STRING         COMMENT 'The last timestamp for which the offer can be used.  This is based on the offer effective date and validity period.',
    iss_ofr_del_ind    VARCHAR(1)     COMMENT 'Used to indicate that the offer has been soft deleted from the customer''s wallet.  This is also necessary to maintain referential data in the EWH Offer Usage table.',
    ofr_enbl_ind       VARCHAR(1)     COMMENT 'This indicator will be used in conjunction with the Manual enabling required indicator  in Offer table to handle the future requirements. The future requirement could be that the offers are set up ( both meta data and issued offer) in wallethub.<Truncated>',
    ofr_elg_ind        VARCHAR(1)     COMMENT 'The business need is for Star Passes to be eligible at POS or online only when the following conditions are met.

Star passes will be auto provisioned for Prop Accounts when a customer has 
a. A Site profile 
b. And added the prop card in to<Truncated>',
    create_usr_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated *Date used in daas_part_dt',
    daas_crt_ts        TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts        TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id       VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores offers issued to the customer that fall within the current maximum partitioning effective end date in the issued offer table. | Primary Key = iss_ofr_sk,eff_end_dt| Offset = lst_upd_src_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_iss_ofr_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_assoctn_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ofr_assoctn_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ofr_assoctn_hist(
    ofr_assoctn_sk     DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ofr_1_sk           DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ofr_2_sk           DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    create_usr_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts        TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id       VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Reference that associates two different offer meta data entries.  The business scenario is for Star Passes.  The technical team will store the offer meta data for a Star Pass as two separate entries by Channel in the EWH Offer Table.  If there is a need to tie those entries as belonging to the same offer, an entry will be made in the EWH Offer Association.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ofr_assoctn_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_assoctn_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ofr_assoctn_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ofr_assoctn_snap(
    ofr_assoctn_sk     DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ofr_1_sk           DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    ofr_2_sk           DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    create_usr_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id     VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts     TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated *Date used in daas_part_dt',
    daas_crt_ts        TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts        TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id       VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Reference that associates two different offer meta data entries.  The business scenario is for Star Passes.  The technical team will store the offer meta data for a Star Pass as two separate entries by Channel in the EWH Offer Table.  If there is a need to tie those entries as belonging to the same offer, an entry will be made in the EWH Offer Association. | Primary Key = ofr_assoctn_sk| Offset = lst_upd_src_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ofr_assoctn_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ofr_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ofr_hist(
    ofr_sk                           DECIMAL          COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    src_sys_cd                       VARCHAR(20)      COMMENT 'Source system that has generated the offer. All offers will be picked up from Stella for WH. The source system code will be MCY for Macys offers and BLM for Bloomies offers. We will not be capturing MCCS or BCOM or MCOM as source system.',
    chnl_typ                         VARCHAR(10)      COMMENT 'Short alphanumeric code for type of channel.Valid values are STORE,ONLINE.',
    vldty_prd_typ                    VARCHAR(3)       COMMENT 'Short alphanumeric code for validity period.Valid values are DAY,WK,HR. MTH, YR',
    ofr_typ                          VARCHAR(20)      COMMENT 'Meant to identify the type of offer. Eg: Star pass, Happy Birthday Offer etc. For 1406, the offer generating systems are not providing this value. All offers will be set up as NA(Not available).',
    rdmptn_cd_typ                    VARCHAR(10)      COMMENT 'Valid values for redemption code type are BARCD, PROMOCD and SUPC.',
    rdmptn_cntl_typ                  VARCHAR(2)       COMMENT 'Descriptive value for Redemption Control Type.  Valid values are SS(Single Offer Single Perm),SA(Single Offer All Perms),SL(Single Offer Linked Perms),LS(Linked Offers Single Perm), LA(Linked Offers All Perms), LL(Linked Offers Linked Perms). SA<Truncated>',
    rtl_divn_nbr                     DECIMAL          COMMENT 'Retail division numbers valid for eWallet.  Valid values for Retail Division Number are 71,72 and 76.',
    hdr_1_txt                        VARCHAR(1000)    COMMENT 'Standard header text associated with the offer.',
    hdr_2_txt                        VARCHAR(1000)    COMMENT 'Standard header text associated with the offer.',
    eff_strt_dt                      STRING           COMMENT 'Specifies the period start date from which the Offer is effective.',
    eff_end_dt                       STRING           COMMENT 'Specifies the period end date till which the Offer is effective.',
    vldty_prd_qty                    DECIMAL          COMMENT 'The quantity of the Validity Period Type',
    max_usg_cnt                      DECIMAL          COMMENT 'The maximum number of times that the offer can be used.',
    gnrl_ofr_ind                     VARCHAR(1)       COMMENT 'Indicates whether the offer is a generic offer.  Generic offers are not issued to any specific permanent identifier, but instead are available to everyone.',
    manual_enbl_req_ind              VARCHAR(1)       COMMENT 'This indicator will be used in conjunction with the Offer enabled indicator to handle the future requirements. The future requirement could be that the offers are set up ( both meta data and issued offer) in wallethub. The offers could be shown <Truncated>',
    shr_ofr_ind                      VARCHAR(1)       COMMENT 'Indicates that the offer can be shared with another customer having a different Permanent Identifier.',
    manual_provisn_alw_ind           VARCHAR(1)       COMMENT 'to stop from customers manually adding an offer to the wallet.',
    src_sys_ofr_id                   VARCHAR(50)      COMMENT 'This attribute uniquely identifies an offer for a particular channel and division. The data in this attribute will hold the actual value of the Barcode when the redemption code is Barcode, the Promocode when the redemption code is Promocode and <Truncated>',
    create_usr_id                    VARCHAR(50)      COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts                    TIMESTAMP        COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id                   VARCHAR(50)      COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts                   TIMESTAMP        COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id                    VARCHAR(50)      COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts                    TIMESTAMP        COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id                   VARCHAR(50)      COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts                   TIMESTAMP        COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    rdmptn_cd                        VARCHAR(20)      COMMENT 'The actual code used to redeem the offer. This attribute could hold a value of a PromoCd or Barcode.',
    ext_issue_ofr_ind                VARCHAR(1)       COMMENT 'The Extended Issue Offer Indicator is used to reflect whether the issued offer is stored in the extended issue offer table.  Valid values are ''Y'' or ''N'' with a default of ''N''.',
    ofr_del_ind                      VARCHAR(1)       COMMENT 'Used to indicate that the offer has been soft deleted from the offer metadata.  This is also necessary to maintain referential data in the EWH Offer and dependent tables.  Valid values are ''Y'' and ''N'' with a default of ''N''.',
    epiphany_auto_provisn_alw_ind    VARCHAR(1)       COMMENT 'The Epiphany auto provision allowed indicator is used to indicate whether offers sourced from Epiphany are eligible for auto-provisioning. Valid values are ''Y'' and ''N'', with a default of ''Y''''.',
    auto_provisn_dt                  STRING           COMMENT 'The auto provisioning date indicates from what date the offer can be presented or made visible to the customer, before the official offer start date.',
    blacklist_test_mkt_ind           VARCHAR(1)       COMMENT 'Indicator used to reflect whether the offer is a Blacklisted for the cashback pilot.',
    disable_ind                      VARCHAR(1)       COMMENT 'Indicates wether the offer is disabled',
    daas_crt_ts                      TIMESTAMP        COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id                     VARCHAR(36)      COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id                  STRING           COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores offers that are available to be issued to the customer.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ofr_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ofr_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ofr_snap(
    ofr_sk                           DECIMAL          COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    src_sys_cd                       VARCHAR(20)      COMMENT 'Source system that has generated the offer. All offers will be picked up from Stella for WH. The source system code will be MCY for Macys offers and BLM for Bloomies offers. We will not be capturing MCCS or BCOM or MCOM as source system.',
    chnl_typ                         VARCHAR(10)      COMMENT 'Short alphanumeric code for type of channel.Valid values are STORE,ONLINE.',
    vldty_prd_typ                    VARCHAR(3)       COMMENT 'Short alphanumeric code for validity period.Valid values are DAY,WK,HR. MTH, YR',
    ofr_typ                          VARCHAR(20)      COMMENT 'Meant to identify the type of offer. Eg: Star pass, Happy Birthday Offer etc. For 1406, the offer generating systems are not providing this value. All offers will be set up as NA(Not available).',
    rdmptn_cd_typ                    VARCHAR(10)      COMMENT 'Valid values for redemption code type are BARCD, PROMOCD and SUPC.',
    rdmptn_cntl_typ                  VARCHAR(2)       COMMENT 'Descriptive value for Redemption Control Type.  Valid values are SS(Single Offer Single Perm),SA(Single Offer All Perms),SL(Single Offer Linked Perms),LS(Linked Offers Single Perm), LA(Linked Offers All Perms), LL(Linked Offers Linked Perms). SA<Truncated>',
    rtl_divn_nbr                     DECIMAL          COMMENT 'Retail division numbers valid for eWallet.  Valid values for Retail Division Number are 71,72 and 76.',
    hdr_1_txt                        VARCHAR(1000)    COMMENT 'Standard header text associated with the offer.',
    hdr_2_txt                        VARCHAR(1000)    COMMENT 'Standard header text associated with the offer.',
    eff_strt_dt                      STRING           COMMENT 'Specifies the period start date from which the Offer is effective.',
    eff_end_dt                       STRING           COMMENT 'Specifies the period end date till which the Offer is effective.',
    vldty_prd_qty                    DECIMAL          COMMENT 'The quantity of the Validity Period Type',
    max_usg_cnt                      DECIMAL          COMMENT 'The maximum number of times that the offer can be used.',
    gnrl_ofr_ind                     VARCHAR(1)       COMMENT 'Indicates whether the offer is a generic offer.  Generic offers are not issued to any specific permanent identifier, but instead are available to everyone.',
    manual_enbl_req_ind              VARCHAR(1)       COMMENT 'This indicator will be used in conjunction with the Offer enabled indicator to handle the future requirements. The future requirement could be that the offers are set up ( both meta data and issued offer) in wallethub. The offers could be shown <Truncated>',
    shr_ofr_ind                      VARCHAR(1)       COMMENT 'Indicates that the offer can be shared with another customer having a different Permanent Identifier.',
    manual_provisn_alw_ind           VARCHAR(1)       COMMENT 'to stop from customers manually adding an offer to the wallet.',
    src_sys_ofr_id                   VARCHAR(50)      COMMENT 'This attribute uniquely identifies an offer for a particular channel and division. The data in this attribute will hold the actual value of the Barcode when the redemption code is Barcode, the Promocode when the redemption code is Promocode and <Truncated>',
    create_usr_id                    VARCHAR(50)      COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts                    TIMESTAMP        COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id                   VARCHAR(50)      COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts                   TIMESTAMP        COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id                    VARCHAR(50)      COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts                    TIMESTAMP        COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_src_id                   VARCHAR(50)      COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts                   TIMESTAMP        COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated *Date used in daas_part_dt',
    rdmptn_cd                        VARCHAR(20)      COMMENT 'The actual code used to redeem the offer. This attribute could hold a value of a PromoCd or Barcode.',
    ext_issue_ofr_ind                VARCHAR(1)       COMMENT 'The Extended Issue Offer Indicator is used to reflect whether the issued offer is stored in the extended issue offer table.  Valid values are ''Y'' or ''N'' with a default of ''N''.',
    ofr_del_ind                      VARCHAR(1)       COMMENT 'Used to indicate that the offer has been soft deleted from the offer metadata.  This is also necessary to maintain referential data in the EWH Offer and dependent tables.  Valid values are ''Y'' and ''N'' with a default of ''N''.',
    epiphany_auto_provisn_alw_ind    VARCHAR(1)       COMMENT 'The Epiphany auto provision allowed indicator is used to indicate whether offers sourced from Epiphany are eligible for auto-provisioning. Valid values are ''Y'' and ''N'', with a default of ''Y''''.',
    auto_provisn_dt                  STRING           COMMENT 'The auto provisioning date indicates from what date the offer can be presented or made visible to the customer, before the official offer start date.',
    blacklist_test_mkt_ind           VARCHAR(1)       COMMENT 'Indicator used to reflect whether the offer is a Blacklisted for the cashback pilot.',
    disable_ind                      VARCHAR(1)       COMMENT 'Indicates wether the offer is disabled',
    daas_crt_ts                      TIMESTAMP        COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                      TIMESTAMP        COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id                     VARCHAR(36)      COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id                  STRING           COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores offers that are available to be issued to the customer. | Primary Key = ofr_sk| Offset = lst_upd_src_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ofr_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_typ_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ofr_typ_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ofr_typ_hist(
    ofr_typ            VARCHAR(20)     COMMENT 'Meant to identify the type of offer. Eg: Star pass, Happy Birthday Offer etc. For 1406, the offer generating systems are not providing this value. All offers will be set up as NA(Not available).',
    ofr_typ_desc       VARCHAR(100)    COMMENT 'Descriptive value for Usage Type e.g. Single, Limited, Unlimited',
    create_usr_id      VARCHAR(50)     COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP       COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id     VARCHAR(50)     COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts     TIMESTAMP       COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    rtl_divn_nbr       DECIMAL         COMMENT 'Retail division numbers valid for eWallet.  Valid Values are 71,72 and 76.',
    daas_crt_ts        TIMESTAMP       COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id       VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Reference for valid offer types.  Valid values for this phase are NA as EWH is not getting this value from any source.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ofr_typ_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_typ_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ofr_typ_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ofr_typ_snap(
    ofr_typ            VARCHAR(20)     COMMENT 'Meant to identify the type of offer. Eg: Star pass, Happy Birthday Offer etc. For 1406, the offer generating systems are not providing this value. All offers will be set up as NA(Not available).',
    ofr_typ_desc       VARCHAR(100)    COMMENT 'Descriptive value for Usage Type e.g. Single, Limited, Unlimited',
    create_usr_id      VARCHAR(50)     COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts      TIMESTAMP       COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id     VARCHAR(50)     COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity *Date used in daas_part_dt',
    lst_upd_usr_ts     TIMESTAMP       COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    rtl_divn_nbr       DECIMAL         COMMENT 'Retail division numbers valid for eWallet.  Valid Values are 71,72 and 76.',
    daas_crt_ts        TIMESTAMP       COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts        TIMESTAMP       COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id       VARCHAR(36)     COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id    STRING          COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Reference for valid offer types.  Valid values for this phase are NA as EWH is not getting this value from any source. | Primary Key = ofr_typ| Offset = lst_upd_usr_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ofr_typ_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_usg_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ofr_usg_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ofr_usg_hist(
    ofr_usg_sk              DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    eff_end_dt              STRING         COMMENT 'EFF_END_DATE will be used for monthly partitioning. All components will need to populate this column from the same column in EWH_OFR. After the EFF_END_DATE month has passed, an archive of the past month partitioned will be done (archiving strat<Truncated>',
    perm_id_sk              DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    iss_ofr_sk              DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    chnl_typ                VARCHAR(10)    COMMENT 'Short alphanumeric code for type of channel.  Valid values are ONLINE or STORE',
    txn_cd                  VARCHAR(3)     COMMENT 'Captures the  retail transaction code.  Purchase(10), PreSale Purchase(73), PostVoid(81) are some examples.',
    rtl_divn_nbr            DECIMAL        COMMENT 'Retail division numbers valid for eWallet.',
    rgstr_nbr               DECIMAL        COMMENT 'Store register number where offer was used.',
    txn_nbr                 DECIMAL        COMMENT 'Store transaction number that is associated with offers redeemed at POS.  May be NULL is order if not redeemed by POS.',
    ord_nbr                 VARCHAR(30)    COMMENT 'Order Identifer number that is associated with offers redeemed by site.  NULL if not redeemed by site.',
    str_nbr                 DECIMAL        COMMENT 'Serial number for the store',
    actv_rdmptn_ind         VARCHAR(1)     COMMENT 'Active redemption indicator is used to handle SUPC redemption analytics. When a SUPC is redeemed with a PermId, it and the transaction are marked with an Active redemption ind. = Y and all Permids that had the same SUPC with an Active redemption ind. = N.',
    vld_rdmptn_ind          VARCHAR(1)     COMMENT 'The valid redemption indicator is used to track the double dipping( lock wallet functionality is not available) of an offer as well as handle the redemption of an offer after the offer expiry period.',
    txn_ts                  TIMESTAMP      COMMENT 'The timestamp associated with transaction.',
    create_usr_id           VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts           TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id           VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts           TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    perm_id                 VARCHAR(25),
    perm_id_typ             VARCHAR(5)     COMMENT 'Type of Permanent Identifier. P is for Prop card, W is for Website profile, L is for Loyalty.',
    perm_id_rtl_divn_nbr    DECIMAL        COMMENT 'Retail division numbers valid for eWallet.',
    daas_crt_ts             TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id            VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id         STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores customer offer usage informatin for offers that fall within the current maximum partitioning effective end date in the issued offer table.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ofr_usg_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_usg_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_ofr_usg_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_ofr_usg_snap(
    ofr_usg_sk              DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    eff_end_dt              STRING         COMMENT 'EFF_END_DATE will be used for monthly partitioning. All components will need to populate this column from the same column in EWH_OFR. After the EFF_END_DATE month has passed, an archive of the past month partitioned will be done (archiving strat<Truncated>',
    perm_id_sk              DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    iss_ofr_sk              DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    chnl_typ                VARCHAR(10)    COMMENT 'Short alphanumeric code for type of channel.  Valid values are ONLINE or STORE',
    txn_cd                  VARCHAR(3)     COMMENT 'Captures the  retail transaction code.  Purchase(10), PreSale Purchase(73), PostVoid(81) are some examples.',
    rtl_divn_nbr            DECIMAL        COMMENT 'Retail division numbers valid for eWallet.',
    rgstr_nbr               DECIMAL        COMMENT 'Store register number where offer was used.',
    txn_nbr                 DECIMAL        COMMENT 'Store transaction number that is associated with offers redeemed at POS.  May be NULL is order if not redeemed by POS.',
    ord_nbr                 VARCHAR(30)    COMMENT 'Order Identifer number that is associated with offers redeemed by site.  NULL if not redeemed by site.',
    str_nbr                 DECIMAL        COMMENT 'Serial number for the store',
    actv_rdmptn_ind         VARCHAR(1)     COMMENT 'Active redemption indicator is used to handle SUPC redemption analytics. When a SUPC is redeemed with a PermId, it and the transaction are marked with an Active redemption ind. = Y and all Permids that had the same SUPC with an Active redemption ind. = N.',
    vld_rdmptn_ind          VARCHAR(1)     COMMENT 'The valid redemption indicator is used to track the double dipping( lock wallet functionality is not available) of an offer as well as handle the redemption of an offer after the offer expiry period.',
    txn_ts                  TIMESTAMP      COMMENT 'The timestamp associated with transaction.',
    create_usr_id           VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts           TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id           VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts           TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_src_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated *Date used in daas_part_dt',
    perm_id                 VARCHAR(25),
    perm_id_typ             VARCHAR(5)     COMMENT 'Type of Permanent Identifier. P is for Prop card, W is for Website profile, L is for Loyalty.',
    perm_id_rtl_divn_nbr    DECIMAL        COMMENT 'Retail division numbers valid for eWallet.',
    daas_crt_ts             TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts             TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id            VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id         STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores customer offer usage informatin for offers that fall within the current maximum partitioning effective end date in the issued offer table. | Primary Key = ofr_usg_sk,eff_end_dt| Offset = lst_upd_src_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_ofr_usg_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_alt_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_alt_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_alt_hist(
    perm_id_sk                DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    perm_id                   VARCHAR(25),
    perm_id_typ               VARCHAR(5)     COMMENT 'Type of Permanent Identifier. P is for Prop card, W is for Website profile, L is for Loyalty.',
    rtl_divn_nbr              DECIMAL        COMMENT 'This value will hold the Division from which the customer interacted with WalletHub. For example if the customer came in from Macys Division using an Amex card, there will be one entry. When the customer comes in from Bloomies division, there wi<Truncated>',
    prev_perm_id_sk           DECIMAL        COMMENT 'Surrogate Key for the previous perm Id value',
    blacklist_test_mkt_ind    VARCHAR(1)     COMMENT 'Indicator used to reflect that the prop account is in the Blacklist designated market area for cashback pilot.',
    lost_stln_ind             VARCHAR(1)     COMMENT 'Indicator used to reflect whether the Customer Card/Permanent Identifier has been Lost or Stolen.  The value is ''Y'' or ''N''.',
    create_usr_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id            VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts            TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id            VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts            TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts               TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id              VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id           STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores the previous values of the Permanent Identifiers that represent the same account. Records in the perm_id_alt table will have the same perm_id_sk as their parent recors in the ewh_perm_id table.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_alt_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_alt_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_alt_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_alt_snap(
    perm_id_sk                DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    perm_id                   VARCHAR(25),
    perm_id_typ               VARCHAR(5)     COMMENT 'Type of Permanent Identifier. P is for Prop card, W is for Website profile, L is for Loyalty.',
    rtl_divn_nbr              DECIMAL        COMMENT 'This value will hold the Division from which the customer interacted with WalletHub. For example if the customer came in from Macys Division using an Amex card, there will be one entry. When the customer comes in from Bloomies division, there wi<Truncated>',
    prev_perm_id_sk           DECIMAL        COMMENT 'Surrogate Key for the previous perm Id value',
    blacklist_test_mkt_ind    VARCHAR(1)     COMMENT 'Indicator used to reflect that the prop account is in the Blacklist designated market area for cashback pilot.',
    lost_stln_ind             VARCHAR(1)     COMMENT 'Indicator used to reflect whether the Customer Card/Permanent Identifier has been Lost or Stolen.  The value is ''Y'' or ''N''.',
    create_usr_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id            VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts            TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id            VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts            TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated *Date used in daas_part_dt',
    daas_crt_ts               TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts               TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id              VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id           STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores the previous values of the Permanent Identifiers that represent the same account. Records in the perm_id_alt table will have the same perm_id_sk as their parent recors in the ewh_perm_id table. | Primary Key = perm_id_sk,perm_id,perm_id_typ| Offset = lst_upd_src_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_alt_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_assoctn_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_assoctn_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_assoctn_hist(
    perm_id_assoctn_sk         DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    perm_id_1_sk               DECIMAL        COMMENT 'Account Identifer for a customer. The valid values could be a Proprietary Number, Site Identifier, Loyalty Identifier',
    perm_id_2_sk               DECIMAL        COMMENT 'Account Identifer for a customer. The valid values could be a Proprietary Number, Site Identifier, Loyalty Identifier',
    perm_id_assoctn_del_ind    VARCHAR(1)     COMMENT 'Used to ''soft'' delete a Permanent Identifier association.  Retains association so that the customer can easily add it back.',
    create_usr_id              VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts              TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id              VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts              TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    perm_id_assoctn_typ        VARCHAR(3)     COMMENT 'Type of Permanent Identifier Association.  Values = E, I, X where E=Explicity linked by the Customer, I=Implicitly linked based on cross reference values, X=Link received from a cross reference file',
    assoctn_cnt                DECIMAL        COMMENT 'Count of Permanent Identifier Associations',
    daas_crt_ts                TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id               VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id            STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stored linked Permanent Identifiers.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_assoctn_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_assoctn_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_assoctn_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_assoctn_snap(
    perm_id_assoctn_sk         DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    perm_id_1_sk               DECIMAL        COMMENT 'Account Identifer for a customer. The valid values could be a Proprietary Number, Site Identifier, Loyalty Identifier',
    perm_id_2_sk               DECIMAL        COMMENT 'Account Identifer for a customer. The valid values could be a Proprietary Number, Site Identifier, Loyalty Identifier',
    perm_id_assoctn_del_ind    VARCHAR(1)     COMMENT 'Used to ''soft'' delete a Permanent Identifier association.  Retains association so that the customer can easily add it back.',
    create_usr_id              VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts              TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id              VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts              TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated *Date used in daas_part_dt',
    perm_id_assoctn_typ        VARCHAR(3)     COMMENT 'Type of Permanent Identifier Association.  Values = E, I, X where E=Explicity linked by the Customer, I=Implicitly linked based on cross reference values, X=Link received from a cross reference file',
    assoctn_cnt                DECIMAL        COMMENT 'Count of Permanent Identifier Associations',
    daas_crt_ts                TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id               VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id            STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stored linked Permanent Identifiers. | Primary Key = perm_id_assoctn_sk| Offset = lst_upd_usr_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_assoctn_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_assoctn_typ_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_assoctn_typ_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_assoctn_typ_hist(
    perm_id_assoctn_typ         VARCHAR(3)     COMMENT 'Type of Permanent Identifier Association.  Values = E, I, X where E=Explicity linked by the Customer, I=Implicitly linked based on cross reference values, X=Link received from a cross reference file',
    perm_id_assoctn_typ_desc    VARCHAR(75)    COMMENT 'Description of the Permanent Identifier Association Type.  Eg.  E-Explicity linked by the Customer, I-Implicitly linked based on cross reference values, X-Link received from a cross reference file',
    create_usr_id               VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts               TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id              VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts              TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts                 TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id                VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id             STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores the types of Permanent Identifiers.  Valid values are P,W - in scope for 1406 Future L, A, D etc.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_assoctn_typ_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_assoctn_typ_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_assoctn_typ_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_assoctn_typ_snap(
    perm_id_assoctn_typ         VARCHAR(3)     COMMENT 'Type of Permanent Identifier Association.  Values = E, I, X where E=Explicity linked by the Customer, I=Implicitly linked based on cross reference values, X=Link received from a cross reference file',
    perm_id_assoctn_typ_desc    VARCHAR(75)    COMMENT 'Description of the Permanent Identifier Association Type.  Eg.  E-Explicity linked by the Customer, I-Implicitly linked based on cross reference values, X-Link received from a cross reference file',
    create_usr_id               VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts               TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id              VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity *Date used in daas_part_dt',
    lst_upd_usr_ts              TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts                 TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                 TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id                VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id             STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores the types of Permanent Identifiers.  Valid values are P,W - in scope for 1406 Future L, A, D etc. | Primary Key = perm_id_assoctn_typ| Offset = lst_upd_src_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_assoctn_typ_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls_s.ewh_mcy_ewh_perm_id_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls_s;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_hist(
    perm_id_sk                DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    perm_id                   VARCHAR(25),
    perm_id_typ               VARCHAR(5)     COMMENT 'Type of Permanent Identifier. P is for Prop card, W is for Website profile, L is for Loyalty.',
    rtl_divn_nbr              DECIMAL        COMMENT 'This value will hold the Division from which the customer interacted with WalletHub. For example if the customer came in from Macys Division using an Amex card, there will be one entry. When the customer comes in from Bloomies division, there wi<Truncated>',
    create_usr_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id            VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts            TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id            VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts            TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    blacklist_test_mkt_ind    VARCHAR(1)     COMMENT 'Indicator used to reflect that the prop account is in the Blacklist designated market area for cashback pilot.',
    daas_crt_ts               TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id              VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id           STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores customer Permanent Identifiers.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls_s.ewh_mcy_ewh_perm_id_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls_s;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_snap(
    perm_id_sk                DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    perm_id                   VARCHAR(25),
    perm_id_typ               VARCHAR(5)     COMMENT 'Type of Permanent Identifier. P is for Prop card, W is for Website profile, L is for Loyalty.',
    rtl_divn_nbr              DECIMAL        COMMENT 'This value will hold the Division from which the customer interacted with WalletHub. For example if the customer came in from Macys Division using an Amex card, there will be one entry. When the customer comes in from Bloomies division, there wi<Truncated>',
    create_usr_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id            VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts            TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    create_src_id             VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_src_ts             TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_src_id            VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_src_ts            TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated *Date used in daas_part_dt',
    blacklist_test_mkt_ind    VARCHAR(1)     COMMENT 'Indicator used to reflect that the prop account is in the Blacklist designated market area for cashback pilot.',
    daas_crt_ts               TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts               TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id              VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id           STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores customer Permanent Identifiers. | Primary Key = perm_id_sk| Offset = lst_upd_src_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_typ_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_typ_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_typ_hist(
    perm_id_typ         VARCHAR(5)     COMMENT 'Type of Permanent Identifier.  P is for Prop card, W is for Website profile, L is for Loyalty, A is for Amex IRN.',
    perm_id_typ_desc    VARCHAR(25)    COMMENT 'Description of the Permanent Identifier Type.',
    create_usr_id       VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts       TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts         TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id        VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id     STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores the types of Permanent Identifiers.  Valid values are P,W - in scope for 1406 Future L, A, D etc.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_typ_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_typ_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_typ_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_typ_snap(
    perm_id_typ         VARCHAR(5)     COMMENT 'Type of Permanent Identifier.  P is for Prop card, W is for Website profile, L is for Loyalty, A is for Amex IRN.',
    perm_id_typ_desc    VARCHAR(25)    COMMENT 'Description of the Permanent Identifier Type.',
    create_usr_id       VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts       TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id      VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity *Date used in daas_part_dt',
    lst_upd_usr_ts      TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts         TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts         TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id        VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id     STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores the types of Permanent Identifiers.  Valid values are P,W - in scope for 1406 Future L, A, D etc. | Primary Key = perm_id_typ| Offset = lst_upd_usr_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_typ_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_typ_xref_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_typ_xref_hist 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_typ_xref_hist(
    perm_id_typ_xref_sk    DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    src_sys_cd             VARCHAR(20)    COMMENT 'The code used for the source system. Valid values are MCY, BLM and SPOS.',
    src_perm_id_typ        VARCHAR(5)     COMMENT 'Type of Permanent Identifier.  P is for Prop card, W is for Website profile, L is for Loyalty, A is for Amex IRN, etc.,',
    src_rtl_divn_nbr       DECIMAL        COMMENT 'Retail division numbers valid for eWallet.  Valid Values are 71,72 and 76.',
    ewh_perm_id_typ        VARCHAR(5)     COMMENT 'Three character permanent identifier type',
    ewh_rtl_divn_nbr       DECIMAL        COMMENT 'Retail division numbers valid for eWallet.  Valid Values are 71,72 and 76.',
    create_usr_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    lst_upd_usr_id         VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    lst_upd_usr_ts         TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts            TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id           VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id        STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores cross reference data between 3 character and single character Permanent Identifiers Type.'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_typ_xref_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_typ_xref_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: ewh_mcy_ewh_perm_id_typ_xref_snap 
--

CREATE EXTERNAL TABLE ewh_mcy_ewh_perm_id_typ_xref_snap(
    perm_id_typ_xref_sk    DECIMAL        COMMENT 'Surrogate Key for the entity. The key value will be generated sequence number (possibly auto generated) and the value incremented each time a new row is added.',
    src_sys_cd             VARCHAR(20)    COMMENT 'The code used for the source system. Valid values are MCY, BLM and SPOS.',
    src_perm_id_typ        VARCHAR(5)     COMMENT 'Type of Permanent Identifier.  P is for Prop card, W is for Website profile, L is for Loyalty, A is for Amex IRN, etc.,',
    src_rtl_divn_nbr       DECIMAL        COMMENT 'Retail division numbers valid for eWallet.  Valid Values are 71,72 and 76.',
    ewh_perm_id_typ        VARCHAR(5)     COMMENT 'Three character permanent identifier type',
    ewh_rtl_divn_nbr       DECIMAL        COMMENT 'Retail division numbers valid for eWallet.  Valid Values are 71,72 and 76.',
    create_usr_id          VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity',
    create_usr_ts          TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated * Date used in daas_part_dt',
    lst_upd_usr_id         VARCHAR(50)    COMMENT 'To be used for auditing purposes that identifies the user/program that created or updated the respective entity *Date used in daas_part_dt',
    lst_upd_usr_ts         TIMESTAMP      COMMENT 'To be used for auditing purposes that identifies the timestamp that the record in respective entity got created or updated',
    daas_crt_ts            TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts            TIMESTAMP      COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_load_id           VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_corrltn_id        STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Stores cross reference data between 3 character and single character Permanent Identifiers Type. | Primary Key = perm_id_typ_xref_sk| Offset = lst_upd_usr_ts | Partition Date = create_usr_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/sls/ewh/ewh_mcy_ewh_perm_id_typ_xref_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_chnl_typ_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_chnl_typ_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ext_iss_ofr_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ext_iss_ofr_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ext_ofr_usg_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ext_ofr_usg_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_iss_ofr_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_iss_ofr_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_assoctn_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_assoctn_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_typ_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_typ_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_usg_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_ofr_usg_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_alt_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_alt_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_assoctn_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_assoctn_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_assoctn_typ_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_assoctn_typ_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls_s.ewh_mcy_ewh_perm_id_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls_s.ewh_mcy_ewh_perm_id_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_typ_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_typ_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_typ_xref_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.ewh_mcy_ewh_perm_id_typ_xref_snap;

