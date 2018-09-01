
set hive.msck.path.validation=ignore;

DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_bcom_flpfil_na_xfil645_cim_extract_bl_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s;
-- 
-- TABLE: fil_bcom_flpfil_na_xfil645_cim_extract_bl_hist 
--

CREATE EXTERNAL TABLE fil_bcom_flpfil_na_xfil645_cim_extract_bl_hist(
    ws_cim_tran_id             DECIMAL(38, 0)    COMMENT 'TRANSACTION NUMBER FROM DDW',
    ws_cim_tran_ts             VARCHAR(19)       COMMENT 'TIMESTAMP FROM DDW',
    ws_cim_tran_typ            VARCHAR(1)        COMMENT 'TRANSACTION TYPE – SEE BELOW',
    ws_cim_sell_store_loc      DECIMAL(38, 0)    COMMENT 'SELLING LOCATION',
    ws_cim_fill_store_div      DECIMAL(38, 0)    COMMENT 'FULFILMENT DIVISION – 71 OR 72',
    ws_cim_fill_store_loc      DECIMAL(38, 0)    COMMENT 'FULFILLMENT LOCATION',
    ws_cim_internet_xref       VARCHAR(13)       COMMENT 'INTERNET ORDER NUMBER',
    ws_cim_ship_id             DECIMAL(38, 0)    COMMENT 'FEDFIL SHIPMENT NUMBER',
    ws_cim_appl_id             VARCHAR(8)        COMMENT 'ADDED-BY-APP – MCOM, BLCOM, ESEND',
    ws_cim_sub_appl_id         VARCHAR(8)        COMMENT 'SUB APPLICATION CODE – SEE BELOW',
    ws_cim_appl_xref           DECIMAL(10, 0)    COMMENT 'APPLICATION XREF – FEDFIL RESERVATION NUMBER',
    ws_cim_tran_seq_nbr        DECIMAL(38, 0)    COMMENT 'SEQUENCE NUMBER',
    ws_cim_item_id             VARCHAR(16)       COMMENT 'SPACES (NOT USED)',
    ws_cim_item_qty            VARCHAR(5)        COMMENT 'CURRENT QUANTITY',
    ws_cim_item_cost           VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_price          VARCHAR(11)       COMMENT 'CURRENT RETAIL',
    ws_cim_plu_price           VARCHAR(11)       COMMENT 'OWNED RETAIL FOR THE ITEM',
    ws_cim_item_date           VARCHAR(10)       COMMENT 'DATE ITEM WAS SHIPPED',
    ws_cim_item_appl_id        VARCHAR(8)        COMMENT 'ADDED-BY-APP – MCOM, BLCOM, ESEND',
    ws_cim_mark_down_lev       VARCHAR(1)        COMMENT 'SET TO ZERO',
    ws_cim_cancel_reason       VARCHAR(8)        COMMENT 'REASON CODE IF ITEM WAS CANCELLED, ELSE SPACE',
    ws_cim_discnt_seq_nbr      DECIMAL(38, 0)    COMMENT 'SEQUENCE NUMBER OF DISCOUNT',
    ws_cim_discnt_id           DECIMAL(38, 0)    COMMENT 'LINE DISCOUNT ID 1 = % OFF 2 = $ OFF',
    ws_cim_discnt_id_src       VARCHAR(4)        COMMENT 'LINE DISCOUNT SOURCE (SAME AS DISCNT-ID)',
    ws_cim_discnt_amt          VARCHAR(12)       COMMENT 'LINE DISCOUNT AMOUNT',
    ws_cim_exchange_reason     VARCHAR(1)        COMMENT 'REASON CODE FOR EXCHANGED ITEM',
    ws_cim_paymeth_cust_nbr    DECIMAL(38, 0)    COMMENT 'CUSTOMER ID NUMBER',
    ws_cim_paymeth_pay_typ     VARCHAR(1)        COMMENT 'TYPE OF PAYMENT – V = VISA, P = PROP, ETC',
    ws_cim_paymeth_payer_id    VARCHAR(18)       COMMENT 'CUSTOMER PAYER IDENTIFIER',
    ws_cim_soldto_zip          VARCHAR(5)        COMMENT 'BILL TO ZIP CODE',
    ws_cim_soldto_email        VARCHAR(50)       COMMENT 'BILL TO EMAIL ADDRESS',
    ws_cim_shipto_zip          VARCHAR(5)        COMMENT 'SHIP TO ZIP CODE',
    ws_cim_shipto_email        VARCHAR(50)       COMMENT 'SHIP TO EMAIL',
    ws_cim_item_upc            DECIMAL(38, 0)    COMMENT 'UPC NUMBER',
    ws_cim_item_owned          VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_selling        VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_msrp           VARCHAR(11)       COMMENT 'MSRP (EGC, VGC, CHARIT ARE ZEROS)',
    ws_cim_sku_opdiv_id        DECIMAL(38, 0)    COMMENT 'SELLING DIVISION – 71 OR 72',
    ws_cim_sku_vend_id         DECIMAL(38, 0)    COMMENT 'UPC VENDOR NUMBER',
    ws_cim_sku_mkstyl          DECIMAL(38, 0)    COMMENT 'UPC MARKSTYLE',
    ws_cim_sku_dept_id         DECIMAL(38, 0)    COMMENT 'UPC DEPARTMENT NUMBER',
    ws_cim_sku_class_id        DECIMAL(38, 0)    COMMENT 'UPC CLASS NUMBER',
    ws_cim_current_run_dte     VARCHAR(10)       COMMENT 'CURRENT RUN DATE',
    ws_cim_rgstry_nbr          DECIMAL(38, 0)    COMMENT 'REGISTRY NUMBER',
    ws_cim_login_id            VARCHAR(8)        COMMENT 'ID OR PROGRAM THAT CREATED THE ORDER',
    ws_cim_price_type_id       DECIMAL(38, 0)    COMMENT 'PRICE TYPE ID FROM STELLA',
    ws_cim_lty_id_pre          VARCHAR(1)        COMMENT 'LOYALTY ID PREFIX',
    ws_cim_lty_id_nbr          DECIMAL(12, 0)    COMMENT 'LOYCALTY ID NUMBER',
    ws_cim_lty_id_usl          DECIMAL(16, 0)    COMMENT 'LOYALTY ID USL',
    ws_cim_mkp_res_id          VARCHAR(20)       COMMENT 'PARTNER RESERVATION NUMBER',
    ws_cim_mkp_partner         VARCHAR(20)       COMMENT 'PARTNER NAME - EX ''MENS WEARHOUSE''',
    ws_cim_mkp_settlmnt_id     VARCHAR(20)       COMMENT 'PARTNER SETTLEMENT TRANSACTION ID.  THIS IS USED IN THE SETTLEMENT PROCESS BETWEEN MACYS AND THE EXTERNAL PARTNER.  FOR TMW, THIS IS THE UVTRANSACTIONID.',
    daas_load_id               VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_corrltn_id            STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'fedfil_bcom_.zip'
PARTITIONED BY( ws_cim_sell_store_div STRING COMMENT 'SELLING DIVISION – 71 OR 72', daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/blm/sensitive/raw/ful/fil/fil_bcom_flpfil_na_xfil645_cim_extract_bl_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_bcom_flpfil_na_xfil645_cim_extract_bl_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s;
-- 
-- TABLE: fil_bcom_flpfil_na_xfil645_cim_extract_bl_snap 
--

CREATE EXTERNAL TABLE fil_bcom_flpfil_na_xfil645_cim_extract_bl_snap(
    ws_cim_tran_id             DECIMAL(38, 0)    COMMENT 'TRANSACTION NUMBER FROM DDW',
    ws_cim_tran_seq_nbr        DECIMAL(38, 0)    COMMENT 'SEQUENCE NUMBER',
    ws_cim_paymeth_payer_id    VARCHAR(18)       COMMENT 'CUSTOMER PAYER IDENTIFIER',
    ws_cim_tran_ts             VARCHAR(19)       COMMENT 'TIMESTAMP FROM DDW * Used in daas_part_dt',
    ws_cim_tran_typ            VARCHAR(1)        COMMENT 'TRANSACTION TYPE – SEE BELOW',
    ws_cim_sell_store_loc      DECIMAL(38, 0)    COMMENT 'SELLING LOCATION',
    ws_cim_fill_store_div      DECIMAL(38, 0)    COMMENT 'FULFILMENT DIVISION – 71 OR 72',
    ws_cim_fill_store_loc      DECIMAL(38, 0)    COMMENT 'FULFILLMENT LOCATION',
    ws_cim_internet_xref       VARCHAR(13)       COMMENT 'INTERNET ORDER NUMBER',
    ws_cim_ship_id             DECIMAL(38, 0)    COMMENT 'FEDFIL SHIPMENT NUMBER',
    ws_cim_appl_id             VARCHAR(8)        COMMENT 'ADDED-BY-APP – MCOM, BLCOM, ESEND',
    ws_cim_sub_appl_id         VARCHAR(8)        COMMENT 'SUB APPLICATION CODE – SEE BELOW',
    ws_cim_appl_xref           DECIMAL(10, 0)    COMMENT 'APPLICATION XREF – FEDFIL RESERVATION NUMBER',
    ws_cim_item_id             VARCHAR(16)       COMMENT 'SPACES (NOT USED)',
    ws_cim_item_qty            VARCHAR(5)        COMMENT 'CURRENT QUANTITY',
    ws_cim_item_cost           VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_price          VARCHAR(11)       COMMENT 'CURRENT RETAIL',
    ws_cim_plu_price           VARCHAR(11)       COMMENT 'OWNED RETAIL FOR THE ITEM',
    ws_cim_item_date           VARCHAR(10)       COMMENT 'DATE ITEM WAS SHIPPED',
    ws_cim_item_appl_id        VARCHAR(8)        COMMENT 'ADDED-BY-APP – MCOM, BLCOM, ESEND',
    ws_cim_mark_down_lev       VARCHAR(1)        COMMENT 'SET TO ZERO',
    ws_cim_cancel_reason       VARCHAR(8)        COMMENT 'REASON CODE IF ITEM WAS CANCELLED, ELSE SPACE',
    ws_cim_discnt_seq_nbr      DECIMAL(38, 0)    COMMENT 'SEQUENCE NUMBER OF DISCOUNT',
    ws_cim_discnt_id           DECIMAL(38, 0)    COMMENT 'LINE DISCOUNT ID 1 = % OFF 2 = $ OFF',
    ws_cim_discnt_id_src       VARCHAR(4)        COMMENT 'LINE DISCOUNT SOURCE (SAME AS DISCNT-ID)',
    ws_cim_discnt_amt          VARCHAR(12)       COMMENT 'LINE DISCOUNT AMOUNT',
    ws_cim_exchange_reason     VARCHAR(1)        COMMENT 'REASON CODE FOR EXCHANGED ITEM',
    ws_cim_paymeth_cust_nbr    DECIMAL(38, 0)    COMMENT 'CUSTOMER ID NUMBER',
    ws_cim_paymeth_pay_typ     VARCHAR(1)        COMMENT 'TYPE OF PAYMENT – V = VISA, P = PROP, ETC',
    ws_cim_soldto_zip          VARCHAR(5)        COMMENT 'BILL TO ZIP CODE',
    ws_cim_soldto_email        VARCHAR(50)       COMMENT 'BILL TO EMAIL ADDRESS',
    ws_cim_shipto_zip          VARCHAR(5)        COMMENT 'SHIP TO ZIP CODE',
    ws_cim_shipto_email        VARCHAR(50)       COMMENT 'SHIP TO EMAIL',
    ws_cim_item_upc            DECIMAL(38, 0)    COMMENT 'UPC NUMBER',
    ws_cim_item_owned          VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_selling        VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_msrp           VARCHAR(11)       COMMENT 'MSRP (EGC, VGC, CHARIT ARE ZEROS)',
    ws_cim_sku_opdiv_id        DECIMAL(38, 0)    COMMENT 'SELLING DIVISION – 71 OR 72',
    ws_cim_sku_vend_id         DECIMAL(38, 0)    COMMENT 'UPC VENDOR NUMBER',
    ws_cim_sku_mkstyl          DECIMAL(38, 0)    COMMENT 'UPC MARKSTYLE',
    ws_cim_sku_dept_id         DECIMAL(38, 0)    COMMENT 'UPC DEPARTMENT NUMBER',
    ws_cim_sku_class_id        DECIMAL(38, 0)    COMMENT 'UPC CLASS NUMBER',
    ws_cim_current_run_dte     VARCHAR(10)       COMMENT 'CURRENT RUN DATE',
    ws_cim_rgstry_nbr          DECIMAL(38, 0)    COMMENT 'REGISTRY NUMBER',
    ws_cim_login_id            VARCHAR(8)        COMMENT 'ID OR PROGRAM THAT CREATED THE ORDER',
    ws_cim_price_type_id       DECIMAL(38, 0)    COMMENT 'PRICE TYPE ID FROM STELLA',
    ws_cim_lty_id_pre          VARCHAR(1)        COMMENT 'LOYALTY ID PREFIX',
    ws_cim_lty_id_nbr          DECIMAL(12, 0)    COMMENT 'LOYCALTY ID NUMBER',
    ws_cim_lty_id_usl          DECIMAL(16, 0)    COMMENT 'LOYALTY ID USL',
    ws_cim_mkp_res_id          VARCHAR(20)       COMMENT 'PARTNER RESERVATION NUMBER',
    ws_cim_mkp_partner         VARCHAR(20)       COMMENT 'PARTNER NAME - EX ''MENS WEARHOUSE''',
    ws_cim_mkp_settlmnt_id     VARCHAR(20)       COMMENT 'PARTNER SETTLEMENT TRANSACTION ID.  THIS IS USED IN THE SETTLEMENT PROCESS BETWEEN MACYS AND THE EXTERNAL PARTNER.  FOR TMW, THIS IS THE UVTRANSACTIONID.',
    daas_load_id               VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts                TIMESTAMP         COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id            STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'fedfil_bcom_.zip | Primary Key = ws_cim_tran_id, ws_cim_tran_seq_nbr,ws_cim_paymeth_payer_id | Partition Date = ws_cim_tran_ts MM/dd/yyyy-HH.mm.ss'
PARTITIONED BY( ws_cim_sell_store_div STRING COMMENT 'SELLING DIVISION – 71 OR 72', daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/blm/sensitive/raw/ful/fil/fil_bcom_flpfil_na_xfil645_cim_extract_bl_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_mcom_flpfil_na_xfil645_cim_extract_macys_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s;
-- 
-- TABLE: fil_mcom_flpfil_na_xfil645_cim_extract_macys_hist 
--

CREATE EXTERNAL TABLE fil_mcom_flpfil_na_xfil645_cim_extract_macys_hist(
    ws_cim_tran_id             DECIMAL(38, 0)    COMMENT 'TRANSACTION NUMBER FROM DDW',
    ws_cim_tran_ts             VARCHAR(19)       COMMENT 'TIMESTAMP FROM DDW',
    ws_cim_tran_typ            VARCHAR(1)        COMMENT 'TRANSACTION TYPE – SEE BELOW',
    ws_cim_sell_store_loc      DECIMAL(38, 0)    COMMENT 'SELLING LOCATION',
    ws_cim_fill_store_div      DECIMAL(38, 0)    COMMENT 'FULFILMENT DIVISION – 71 OR 72',
    ws_cim_fill_store_loc      DECIMAL(38, 0)    COMMENT 'FULFILLMENT LOCATION',
    ws_cim_internet_xref       VARCHAR(13)       COMMENT 'INTERNET ORDER NUMBER',
    ws_cim_ship_id             DECIMAL(38, 0)    COMMENT 'FEDFIL SHIPMENT NUMBER',
    ws_cim_appl_id             VARCHAR(8)        COMMENT 'ADDED-BY-APP – MCOM, BLCOM, ESEND',
    ws_cim_sub_appl_id         VARCHAR(8)        COMMENT 'SUB APPLICATION CODE – SEE BELOW',
    ws_cim_appl_xref           DECIMAL(10, 0)    COMMENT 'APPLICATION XREF – FEDFIL RESERVATION NUMBER',
    ws_cim_tran_seq_nbr        DECIMAL(38, 0)    COMMENT 'SEQUENCE NUMBER',
    ws_cim_item_id             VARCHAR(16)       COMMENT 'SPACES (NOT USED)',
    ws_cim_item_qty            VARCHAR(5)        COMMENT 'CURRENT QUANTITY',
    ws_cim_item_cost           VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_price          VARCHAR(11)       COMMENT 'CURRENT RETAIL',
    ws_cim_plu_price           VARCHAR(11)       COMMENT 'OWNED RETAIL FOR THE ITEM',
    ws_cim_item_date           VARCHAR(10)       COMMENT 'DATE ITEM WAS SHIPPED',
    ws_cim_item_appl_id        VARCHAR(8)        COMMENT 'ADDED-BY-APP – MCOM, BLCOM, ESEND',
    ws_cim_mark_down_lev       VARCHAR(1)        COMMENT 'SET TO ZERO',
    ws_cim_cancel_reason       VARCHAR(8)        COMMENT 'REASON CODE IF ITEM WAS CANCELLED, ELSE SPACE',
    ws_cim_discnt_seq_nbr      DECIMAL(38, 0)    COMMENT 'SEQUENCE NUMBER OF DISCOUNT',
    ws_cim_discnt_id           DECIMAL(38, 0)    COMMENT 'LINE DISCOUNT ID 1 = % OFF 2 = $ OFF',
    ws_cim_discnt_id_src       VARCHAR(4)        COMMENT 'LINE DISCOUNT SOURCE (SAME AS DISCNT-ID)',
    ws_cim_discnt_amt          VARCHAR(12)       COMMENT 'LINE DISCOUNT AMOUNT',
    ws_cim_exchange_reason     VARCHAR(1)        COMMENT 'REASON CODE FOR EXCHANGED ITEM',
    ws_cim_paymeth_cust_nbr    DECIMAL(38, 0)    COMMENT 'CUSTOMER ID NUMBER',
    ws_cim_paymeth_pay_typ     VARCHAR(1)        COMMENT 'TYPE OF PAYMENT – V = VISA, P = PROP, ETC',
    ws_cim_paymeth_payer_id    VARCHAR(18)       COMMENT 'CUSTOMER PAYER IDENTIFIER',
    ws_cim_soldto_zip          VARCHAR(5)        COMMENT 'BILL TO ZIP CODE',
    ws_cim_soldto_email        VARCHAR(50)       COMMENT 'BILL TO EMAIL ADDRESS',
    ws_cim_shipto_zip          VARCHAR(5)        COMMENT 'SHIP TO ZIP CODE',
    ws_cim_shipto_email        VARCHAR(50)       COMMENT 'SHIP TO EMAIL',
    ws_cim_item_upc            DECIMAL(38, 0)    COMMENT 'UPC NUMBER',
    ws_cim_item_owned          VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_selling        VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_msrp           VARCHAR(11)       COMMENT 'MSRP (EGC, VGC, CHARIT ARE ZEROS)',
    ws_cim_sku_opdiv_id        DECIMAL(38, 0)    COMMENT 'SELLING DIVISION – 71 OR 72',
    ws_cim_sku_vend_id         DECIMAL(38, 0)    COMMENT 'UPC VENDOR NUMBER',
    ws_cim_sku_mkstyl          DECIMAL(38, 0)    COMMENT 'UPC MARKSTYLE',
    ws_cim_sku_dept_id         DECIMAL(38, 0)    COMMENT 'UPC DEPARTMENT NUMBER',
    ws_cim_sku_class_id        DECIMAL(38, 0)    COMMENT 'UPC CLASS NUMBER',
    ws_cim_current_run_dte     VARCHAR(10)       COMMENT 'CURRENT RUN DATE',
    ws_cim_rgstry_nbr          DECIMAL(38, 0)    COMMENT 'REGISTRY NUMBER',
    ws_cim_login_id            VARCHAR(8)        COMMENT 'ID OR PROGRAM THAT CREATED THE ORDER',
    ws_cim_price_type_id       DECIMAL(38, 0)    COMMENT 'PRICE TYPE ID FROM STELLA',
    ws_cim_lty_id_pre          VARCHAR(1)        COMMENT 'LOYALTY ID PREFIX',
    ws_cim_lty_id_nbr          DECIMAL(12, 0)    COMMENT 'LOYCALTY ID NUMBER',
    ws_cim_lty_id_usl          DECIMAL(16, 0)    COMMENT 'LOYALTY ID USL',
    ws_cim_mkp_res_id          VARCHAR(20)       COMMENT 'PARTNER RESERVATION NUMBER',
    ws_cim_mkp_partner         VARCHAR(20)       COMMENT 'PARTNER NAME - EX ''MENS WEARHOUSE''',
    ws_cim_mkp_settlmnt_id     VARCHAR(20)       COMMENT 'PARTNER SETTLEMENT TRANSACTION ID.  THIS IS USED IN THE SETTLEMENT PROCESS BETWEEN MACYS AND THE EXTERNAL PARTNER.  FOR TMW, THIS IS THE UVTRANSACTIONID.',
    daas_load_id               VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_corrltn_id            STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'fedfil_mcom_.zip'
PARTITIONED BY( ws_cim_sell_store_div STRING COMMENT 'SELLING DIVISION – 71 OR 72', daas_part_dt VARCHAR(10) COMMENT 'Date created by the ETL process for partitioning in the format of YYYY-MM-DD')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/ful/fil/fil_mcom_flpfil_na_xfil645_cim_extract_macys_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_mcom_flpfil_na_xfil645_cim_extract_macys_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s;
-- 
-- TABLE: fil_mcom_flpfil_na_xfil645_cim_extract_macys_snap 
--

CREATE EXTERNAL TABLE fil_mcom_flpfil_na_xfil645_cim_extract_macys_snap(
    ws_cim_tran_id             DECIMAL(38, 0)    COMMENT 'TRANSACTION NUMBER FROM DDW',
    ws_cim_tran_seq_nbr        DECIMAL(38, 0)    COMMENT 'SEQUENCE NUMBER',
    ws_cim_paymeth_payer_id    VARCHAR(18)       COMMENT 'CUSTOMER PAYER IDENTIFIER',
    ws_cim_tran_ts             VARCHAR(19)       COMMENT 'TIMESTAMP FROM DDW * Used in daas_part_dt',
    ws_cim_tran_typ            VARCHAR(1)        COMMENT 'TRANSACTION TYPE – SEE BELOW',
    ws_cim_sell_store_loc      DECIMAL(38, 0)    COMMENT 'SELLING LOCATION',
    ws_cim_fill_store_div      DECIMAL(38, 0)    COMMENT 'FULFILMENT DIVISION – 71 OR 72',
    ws_cim_fill_store_loc      DECIMAL(38, 0)    COMMENT 'FULFILLMENT LOCATION',
    ws_cim_internet_xref       VARCHAR(13)       COMMENT 'INTERNET ORDER NUMBER',
    ws_cim_ship_id             DECIMAL(38, 0)    COMMENT 'FEDFIL SHIPMENT NUMBER',
    ws_cim_appl_id             VARCHAR(8)        COMMENT 'ADDED-BY-APP – MCOM, BLCOM, ESEND',
    ws_cim_sub_appl_id         VARCHAR(8)        COMMENT 'SUB APPLICATION CODE – SEE BELOW',
    ws_cim_appl_xref           DECIMAL(10, 0)    COMMENT 'APPLICATION XREF – FEDFIL RESERVATION NUMBER',
    ws_cim_item_id             VARCHAR(16)       COMMENT 'SPACES (NOT USED)',
    ws_cim_item_qty            VARCHAR(5)        COMMENT 'CURRENT QUANTITY',
    ws_cim_item_cost           VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_price          VARCHAR(11)       COMMENT 'CURRENT RETAIL',
    ws_cim_plu_price           VARCHAR(11)       COMMENT 'OWNED RETAIL FOR THE ITEM',
    ws_cim_item_date           VARCHAR(10)       COMMENT 'DATE ITEM WAS SHIPPED',
    ws_cim_item_appl_id        VARCHAR(8)        COMMENT 'ADDED-BY-APP – MCOM, BLCOM, ESEND',
    ws_cim_mark_down_lev       VARCHAR(1)        COMMENT 'SET TO ZERO',
    ws_cim_cancel_reason       VARCHAR(8)        COMMENT 'REASON CODE IF ITEM WAS CANCELLED, ELSE SPACE',
    ws_cim_discnt_seq_nbr      DECIMAL(38, 0)    COMMENT 'SEQUENCE NUMBER OF DISCOUNT',
    ws_cim_discnt_id           DECIMAL(38, 0)    COMMENT 'LINE DISCOUNT ID 1 = % OFF 2 = $ OFF',
    ws_cim_discnt_id_src       VARCHAR(4)        COMMENT 'LINE DISCOUNT SOURCE (SAME AS DISCNT-ID)',
    ws_cim_discnt_amt          VARCHAR(12)       COMMENT 'LINE DISCOUNT AMOUNT',
    ws_cim_exchange_reason     VARCHAR(1)        COMMENT 'REASON CODE FOR EXCHANGED ITEM',
    ws_cim_paymeth_cust_nbr    DECIMAL(38, 0)    COMMENT 'CUSTOMER ID NUMBER',
    ws_cim_paymeth_pay_typ     VARCHAR(1)        COMMENT 'TYPE OF PAYMENT – V = VISA, P = PROP, ETC',
    ws_cim_soldto_zip          VARCHAR(5)        COMMENT 'BILL TO ZIP CODE',
    ws_cim_soldto_email        VARCHAR(50)       COMMENT 'BILL TO EMAIL ADDRESS',
    ws_cim_shipto_zip          VARCHAR(5)        COMMENT 'SHIP TO ZIP CODE',
    ws_cim_shipto_email        VARCHAR(50)       COMMENT 'SHIP TO EMAIL',
    ws_cim_item_upc            DECIMAL(38, 0)    COMMENT 'UPC NUMBER',
    ws_cim_item_owned          VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_selling        VARCHAR(11)       COMMENT 'SET TO 0.00',
    ws_cim_item_msrp           VARCHAR(11)       COMMENT 'MSRP (EGC, VGC, CHARIT ARE ZEROS)',
    ws_cim_sku_opdiv_id        DECIMAL(38, 0)    COMMENT 'SELLING DIVISION – 71 OR 72',
    ws_cim_sku_vend_id         DECIMAL(38, 0)    COMMENT 'UPC VENDOR NUMBER',
    ws_cim_sku_mkstyl          DECIMAL(38, 0)    COMMENT 'UPC MARKSTYLE',
    ws_cim_sku_dept_id         DECIMAL(38, 0)    COMMENT 'UPC DEPARTMENT NUMBER',
    ws_cim_sku_class_id        DECIMAL(38, 0)    COMMENT 'UPC CLASS NUMBER',
    ws_cim_current_run_dte     VARCHAR(10)       COMMENT 'CURRENT RUN DATE',
    ws_cim_rgstry_nbr          DECIMAL(38, 0)    COMMENT 'REGISTRY NUMBER',
    ws_cim_login_id            VARCHAR(8)        COMMENT 'ID OR PROGRAM THAT CREATED THE ORDER',
    ws_cim_price_type_id       DECIMAL(38, 0)    COMMENT 'PRICE TYPE ID FROM STELLA',
    ws_cim_lty_id_pre          VARCHAR(1)        COMMENT 'LOYALTY ID PREFIX',
    ws_cim_lty_id_nbr          DECIMAL(12, 0)    COMMENT 'LOYCALTY ID NUMBER',
    ws_cim_lty_id_usl          DECIMAL(16, 0)    COMMENT 'LOYALTY ID USL',
    ws_cim_mkp_res_id          VARCHAR(20)       COMMENT 'PARTNER RESERVATION NUMBER',
    ws_cim_mkp_partner         VARCHAR(20)       COMMENT 'PARTNER NAME - EX ''MENS WEARHOUSE''',
    ws_cim_mkp_settlmnt_id     VARCHAR(20)       COMMENT 'PARTNER SETTLEMENT TRANSACTION ID.  THIS IS USED IN THE SETTLEMENT PROCESS BETWEEN MACYS AND THE EXTERNAL PARTNER.  FOR TMW, THIS IS THE UVTRANSACTIONID.',
    daas_load_id               VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts                TIMESTAMP         COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id            STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'fedfil_mcom_.zip | Primary Key = ws_cim_tran_id, ws_cim_tran_seq_nbr,ws_cim_paymeth_payer_id | Partition Date = ws_cim_tran_ts MM/dd/yyyy-HH.mm.ss'
PARTITIONED BY( ws_cim_sell_store_div STRING COMMENT 'SELLING DIVISION – 71 OR 72', daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/ful/fil/fil_mcom_flpfil_na_xfil645_cim_extract_macys_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.fil_mcy_flpfil_na_xfil686_cim_extract_cust;

USE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s;
-- 
-- TABLE: fil_mcy_flpfil_na_xfil686_cim_extract_cust 
--

CREATE EXTERNAL TABLE fil_mcy_flpfil_na_xfil686_cim_extract_cust(
    ws_cim_paymeth_pay_typ     VARCHAR(1),
    ws_cim_paymeth_acct_nbr    DECIMAL(26, 9),
    ws_cim_appl_id             VARCHAR(8)        COMMENT 'Added by application - MCOM, BLCOM, ESEND, FIL',
    ws_cim_soldto_na_pre       VARCHAR(5)        COMMENT 'NAME TITLE - ALSO REFERRED TO AS PREFIX',
    ws_cim_soldto_na_fir       VARCHAR(20)       COMMENT 'FIRST NAME',
    ws_cim_soldto_na_mid       VARCHAR(20)       COMMENT 'MIDDLE NAME OR INITIAL',
    ws_cim_soldto_na_las       VARCHAR(30)       COMMENT 'LAST NAME',
    ws_cim_soldto_na_suf       VARCHAR(5)        COMMENT 'NAME SUFFIX - JR, SR, ETC.',
    ws_cim_soldto_addr1        VARCHAR(40)       COMMENT 'FIRST ADDRESS LINE',
    ws_cim_soldto_addr2        VARCHAR(40)       COMMENT 'SECOND ADDRESS LINE',
    ws_cim_soldto_addr3        VARCHAR(40)       COMMENT 'THIRD ADDRESS LINE',
    ws_cim_soldto_city         VARCHAR(25)       COMMENT 'CITY',
    ws_cim_soldto_st           VARCHAR(7)        COMMENT 'STATE CODE',
    ws_cim_soldto_zip          VARCHAR(10)       COMMENT 'Zipcode',
    ws_cim_soldto_ctry         VARCHAR(16)       COMMENT 'Country',
    ws_cim_soldto_email        VARCHAR(50)       COMMENT 'Email address',
    ws_cim_soldto_ph_hm        DECIMAL(22, 9)    COMMENT 'Home phone',
    ws_cim_soldto_add_dte      VARCHAR(10)       COMMENT '* Date used in daas_part_dt',
    ws_cim_paymeth_payer_id    VARCHAR(18)       COMMENT 'REDEFINES WS-CIM-PAYMETH-ACCT-NBR',
    daas_load_id               VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                TIMESTAMP         COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts                TIMESTAMP         COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id            STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'MACYS.COM.NA.DELTA fedfil name addr file/ Daily Customer Feed to CIM | Primary Key = ws_cim_paymeth_pay_typ,ws_cim_paymeth_acct_nbr | Partition Date = ws_cim_soldto_add_dte MM/dd/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mcy/sensitive/raw/cust/fil/fil_mcy_flpfil_na_xfil686_cim_extract_cust'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_mix_flpfil_na_xfil765_data_shpps_hist;

USE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s;
-- 
-- TABLE: fil_mix_flpfil_na_xfil765_data_shpps_hist 
--

CREATE EXTERNAL TABLE fil_mix_flpfil_na_xfil765_data_shpps_hist(
    ws_shpps_res_nbr                 BIGINT         COMMENT 'Reservation number ',
    ws_shpps_shp_nbr                 SMALLINT       COMMENT 'Shipment number',
    ws_shpps_pkup_stat               VARCHAR(1)     COMMENT 'Status of the BOPS Pickup
N = Not Ready for Pickup (Not Picked)
R = Ready for Pickup (Pick Complete)
P = Picked up by Customer
C = Cancelled and Returned because merchandise not picked up
X = Customer returns have been posted to this shipment',
    ws_shpps_pkup_ready_target_ts    TIMESTAMP      COMMENT 'The date and time that the order needs to be ready for customer pickup in the store.  This is the target timestamp for the merchandise to be picked in the store and prepared for customer pickup.  This is typically 4 hours from order confirmation<Truncated>',
    ws_shpps_pkup_schd_cncl_dte      VARCHAR(10)    COMMENT 'The last date that the customer can come into the store to pick up the merchandise.  After this date, the order will be cancelled and all items will be processed as returns.',
    ws_shpps_pkup_act_cncl_dte       VARCHAR(10)    COMMENT 'The date that the store issued a return of all items because the customer did not pickup the merchandise.',
    ws_shpps_pkup_rdy_actual_ts      TIMESTAMP      COMMENT 'Date timestamp for when the store associate picked the merchandise in the store and notified FedFIL.  FedFIL performs a shipment confirmation from this event.',
    ws_shpps_actual_pickup_ts        TIMESTAMP      COMMENT 'Date timestamp for when the customer picked up the merchandise',
    ws_shpps_alt_pkup_person_f       VARCHAR(1)     COMMENT 'If Y, then the customer has identified an alternate person who can pick up the order',
    ws_shpps_pkup_up_by_ind          VARCHAR(1)     COMMENT 'An Indicator denoting who picked up the BOPS order
C = Customer 
A = Alternate Pickup Person',
    ws_shpps_cust_signature_f        VARCHAR(1)     COMMENT 'When ''Y'', the customer or alternate pickup person has signed the customer signature pad in th store',
    ws_shpps_pickup_store_nbr        SMALLINT       COMMENT 'Store Number used in the STT of the Memo transaction for the pickup event in DCR (This is NOT LOCN_NBR.)',
    ws_shpps_pickup_reg_nbr          BIGINT         COMMENT 'Register Number used in the STT of the Memo transaction for the pickup event in DCR',
    ws_shpps_pickup_tran_nbr         BIGINT         COMMENT 'Transaction Number used in the STT of the Memo transaction for the pickup event in DCR',
    ws_shpps_pickup_tran_dte         VARCHAR(10)    COMMENT 'Transaction Date used in the STT of the Memo transaction for the pickup event in DCR.',
    ws_shpps_assoc_nbr               INT            COMMENT 'Associate Number of the associate at the register that supported the customer pickup',
    ws_shpps_last_upd_ts             TIMESTAMP      COMMENT 'Last Update Timestamp',
    ws_shpps_last_upd_userid         VARCHAR(8)     COMMENT 'Last Update UserID or Program Name',
    daas_load_id                     VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                      TIMESTAMP      COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_corrltn_id                  STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DAILY.BOPS.DATA.csv.gz'
PARTITIONED BY( ws_reshdr_division STRING COMMENT 'Associate division (Either 71 or 72)', daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS AVRO
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/ful/fil/fil_mix_flpfil_na_xfil765_data_shpps_hist'
TBLPROPERTIES ('avro.output.codec'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_mix_flpfil_na_xfil765_data_shpps_snap;

USE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s;
-- 
-- TABLE: fil_mix_flpfil_na_xfil765_data_shpps_snap 
--

CREATE EXTERNAL TABLE fil_mix_flpfil_na_xfil765_data_shpps_snap(
    ws_shpps_res_nbr                 BIGINT         COMMENT 'Reservation number ',
    ws_shpps_shp_nbr                 SMALLINT       COMMENT 'Shipment number',
    ws_shpps_pkup_stat               VARCHAR(1)     COMMENT 'Status of the BOPS Pickup
N = Not Ready for Pickup (Not Picked)
R = Ready for Pickup (Pick Complete)
P = Picked up by Customer
C = Cancelled and Returned because merchandise not picked up
X = Customer returns have been posted to this shipment',
    ws_shpps_pkup_ready_target_ts    TIMESTAMP      COMMENT 'The date and time that the order needs to be ready for customer pickup in the store.  This is the target timestamp for the merchandise to be picked in the store and prepared for customer pickup.  This is typically 4 hours from order confirmation<Truncated>',
    ws_shpps_pkup_schd_cncl_dte      VARCHAR(10)    COMMENT 'The last date that the customer can come into the store to pick up the merchandise.  After this date, the order will be cancelled and all items will be processed as returns.',
    ws_shpps_pkup_act_cncl_dte       VARCHAR(10)    COMMENT 'The date that the store issued a return of all items because the customer did not pickup the merchandise.',
    ws_shpps_pkup_rdy_actual_ts      TIMESTAMP      COMMENT 'Date timestamp for when the store associate picked the merchandise in the store and notified FedFIL.  FedFIL performs a shipment confirmation from this event.',
    ws_shpps_actual_pickup_ts        TIMESTAMP      COMMENT 'Date timestamp for when the customer picked up the merchandise',
    ws_shpps_alt_pkup_person_f       VARCHAR(1)     COMMENT 'If Y, then the customer has identified an alternate person who can pick up the order',
    ws_shpps_pkup_up_by_ind          VARCHAR(1)     COMMENT 'An Indicator denoting who picked up the BOPS order
C = Customer 
A = Alternate Pickup Person',
    ws_shpps_cust_signature_f        VARCHAR(1)     COMMENT 'When ''Y'', the customer or alternate pickup person has signed the customer signature pad in th store',
    ws_shpps_pickup_store_nbr        SMALLINT       COMMENT 'Store Number used in the STT of the Memo transaction for the pickup event in DCR (This is NOT LOCN_NBR.)',
    ws_shpps_pickup_reg_nbr          BIGINT         COMMENT 'Register Number used in the STT of the Memo transaction for the pickup event in DCR',
    ws_shpps_pickup_tran_nbr         BIGINT         COMMENT 'Transaction Number used in the STT of the Memo transaction for the pickup event in DCR',
    ws_shpps_pickup_tran_dte         VARCHAR(10)    COMMENT 'Transaction Date used in the STT of the Memo transaction for the pickup event in DCR.',
    ws_shpps_assoc_nbr               INT            COMMENT 'Associate Number of the associate at the register that supported the customer pickup',
    ws_shpps_last_upd_ts             TIMESTAMP      COMMENT 'Last Update Timestamp',
    ws_shpps_last_upd_userid         VARCHAR(8)     COMMENT 'Last Update UserID or Program Name',
    daas_load_id                     VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                      TIMESTAMP      COMMENT 'Date and Timestamp that the record is created by the ETL process.',
    daas_upd_ts                      TIMESTAMP      COMMENT 'Date and Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id                  STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'DAILY.BOPS.DATA.csv.gz | Primary Key = ws_shpps_res_nbr,ws_shpps_shp_nbr,ws_reshdr_division | Partition Date = ws_shpps_pkup_ready_target_ts yyyy-MM-dd-HH.mm.ss.fff'
PARTITIONED BY( ws_reshdr_division STRING COMMENT 'Associate division (Either 71 or 72)', daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM-DD or YYYY-MM or YYYY.')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/sensitive/raw/ful/fil/fil_mix_flpfil_na_xfil765_data_shpps_snap'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_bcom_flpfil_na_xfil645_cim_extract_bl_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_bcom_flpfil_na_xfil645_cim_extract_bl_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_mcom_flpfil_na_xfil645_cim_extract_macys_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_mcom_flpfil_na_xfil645_cim_extract_macys_snap;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_cust_s.fil_mcy_flpfil_na_xfil686_cim_extract_cust;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_mix_flpfil_na_xfil765_data_shpps_hist;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_ful_s.fil_mix_flpfil_na_xfil765_data_shpps_snap;

