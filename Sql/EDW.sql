
set hive.msck.path.validation=ignore;

DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_oc_returns_prod_loc_day_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_oc_returns_prod_loc_day_v 
--

CREATE EXTERNAL TABLE edw_mix_oc_returns_prod_loc_day_v(
    prod_dim_id                     DECIMAL(18, 0)    COMMENT 'Product Dimension Id The PROD_DIM_ID is an 18 digit number created from the timestamp when the PROD_DIM row was created, it uniquely identifies each product in each division of the company. Source: SALES_TRAN_LINE.PROD_DIM_ID for the Financial Location.',
    greg_date                       STRING            COMMENT 'Gregorian Transaction Date The financial business date of this row. The format for date selection is ccyy-mm-dd.',
    loc_dim_id                      INT               COMMENT 'Location Dimension Id The number assigned to the financial location in the EDW Location Dimension table. Reference the LOCN_DIM table.  Source: SALES_TRAN_LINE.LOC_DIM_ID for Financial Location.',
    fil_loc_dim_id                  INT               COMMENT 'Filling Location Dimension Id The number assigned to the filling location in the EDW Location Dimension table. Source: SALES_TRAN_FIL_RESV . FIL_LOC_DIM_ID for the Fulfilling Location. If no Fulfilling Location then Default to LOC_DIM_ID for the<Truncated>',
    ocd_cd                          SMALLINT          COMMENT 'Omni Channel Dimension Code A number initially assigned to each item sold to identify how the customer purchased merchandise and how the merchandise was fulfilled. This is the OCD_CD for the Sales Transaction.  Source: OC_SALES_PROD_LOC_DAY for <Truncated>',
    orig_loc_dim_id                 INT               COMMENT 'Original Location Dimension Id This is the location dimension id (LOC_DIM_ID) for the Original Financial Location for the Original Sale.',
    orig_fil_loc_dim_id             INT               COMMENT 'Original FIL Location Dimension Id This is the FIL_LOC_DIM_ID (Fulfilling Location Dimension ID) for the Original Fulfilling Location for the Original Sale. If no Original Fulfilling Location is present, the default is to the ORIG_LOC_DIM_ID for<Truncated>',
    orig_ocd_cd                     SMALLINT          COMMENT 'Original Omni Channel Dimension Code This is the OCD_CD for the Original Sale.',
    congruency_value                SMALLINT          COMMENT 'Congruency Value Code A value applied as of the most current day for the current week or the week ending date for completed weeks, to indicate the congruency of this PROD_DIM_ID for the location that received financial credit.  This value does n<Truncated>',
    price_loc_nbr                   INT               COMMENT 'Price Location Number The division or the pricing region assigned to this row. Source: DEPT_LOC_PRC_LOC . PRICE_LOC_NBR for the Dept/Financial Loc as of the GREG_AMC_WEEK_END_DT. Defaulted to DIVN_NBR if not found on DLPL as of GREG_AMC_WEEK_END_DT',
    ticketed_retail                 DECIMAL(11, 2)    COMMENT 'Ticketed Retail Price The ticketed retail unit price of this PROD_DIM_ID. Source: PROD_PRICE .TICKETED_RETAIL as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE. FOR COMPLETED WEEKS / Use Current TICKETED_RETAIL If Not Found as <Truncated>',
    owned_retail                    DECIMAL(11, 2)    COMMENT 'Owned Retail Price The owned retail unit price of this PROD_DIM_ID. Source: PROD_PRICE.OWNED_RETAIL as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE. FOR COMPLETED WEEKS / Use Current OWNED_RETAIL If Not Found as of the THE MO<Truncated>',
    zl_stat_nbr                     SMALLINT          COMMENT 'Status Number A code used to indicate a products standing in the merchandising cycle, such as active, first markdown, etc.',
    fil_price_loc_nbr               INT               COMMENT 'FIL Price Location Number The price loc number for the location that fufilled the product for this PROD_DIM_ID. Source: DEPT_LOC_PRC_LOC .  PRICE_LOC_NBR for the Dept/Filling Location for the Dept/Filling Loc as of the GREG_AMC_WEEK_END_DT. Defa<Truncated>',
    fil_ticketed_retail             DECIMAL(11, 2)    COMMENT 'FIL Ticketed Retail The Ticketed Retail price for this product at its FIL_PRICE_LOC_NBR. Source: PROD_PRICE. TICKETED_RETAIL for the Product/Filling Price_Loc_Nbr as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE FOR COMPLETED <Truncated>',
    fil_owned_retail                DECIMAL(11, 2)    COMMENT 'FIL Owned Retail The owned retail price of this product at its FIL_PRICE_LOC_NBR. Source: PROD_PRICE. OWNED_RETAIL for the Product/Filling Price_Loc_Nbr as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE FOR COMPLETED WEEKS / Us<Truncated>',
    fil_zl_stat_nbr                 SMALLINT          COMMENT 'FIL Legacy Status Number The Item Status number of this product at its FIL_PRICE_LOC_NBR. A code used to indicate a products standing in the merchandising cycle, such as active, first markdown, etc.',
    ocd_loc_typ                     VARCHAR(10)       COMMENT 'Omni Channel Dimension Code Location Type A code used to determine the type of location, such as STR, WED (Wedding Channel, etc. for financial credit. Source: LOCN_DIM_ATTR/ LOCN_DIM_ATTR_TYP.ATTR_ABBR for PROF_TYP_NBR = 385',
    fil_ocd_loc_typ                 VARCHAR(10)       COMMENT 'Fulfilling Omni Channel Dimension Code Location Type The Omni Channel Dimension location type, such as STR to determine the location fulfilling the transaction. Note: there are several different OCD_LOC_TYP values in this table. Source: LOCN_DIM<Truncated>',
    rtrn_mdse_amt                   DECIMAL(15, 2)    COMMENT 'Return Merchandise Amount The extended (quantity x price) line item returned amount before point-of-sale discounts are applied, except for dotcom /RDS items that are net. The formula to calculate what the customer was credited for this item on t<Truncated>',
    rtrn_adj                        DECIMAL(15, 2)    COMMENT 'Return Adjustment The return adjustment dollars tied to an original sale. Source: RETURN_TRANS_LINE.MERCH_AMT for TRANS_TYPE_CD = (1,21). NOTE: TRANS_TYPE_CD = 1 should not be included.',
    rtrn_units                      INT               COMMENT 'Return Units The returned units tied to the original sale. Source: RETURN_TRANS_LINE.UPC_QTY for TRANS_TYPE_CD = 33',
    rtrn_mdse_disc                  DECIMAL(15, 2)    COMMENT 'Return Merchandise Discount The original line item discount amount being reversed. The formula to calculate what the customer was credited for this item on the point-of-sale receipt is: (RTRN_MDSE_AMT + RTRN_MDSE_DISC). SOURCE: TRANS_LINE_DISCOU<Truncated>',
    rtrn_asso_disc                  DECIMAL(15, 2)    COMMENT 'Return Associate Discount The amount of employee / associate discounts applied to this returned item in the Back Office tied to an original sale. Source: TRANS_LINE_DISCOUNT DISCOUNT_AMT for TRANS_TYPE_CD in (3,4,5,33,35) and DISCOUNT_TYPE_CD in (90,93)',
    rtrn_bomd_loyal_disc            DECIMAL(15, 2)    COMMENT 'Return Back Office Markdown Loyalty Discount The returned amount of Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. New charge accounts ar<Truncated>',
    rtrn_sbomd_loyal_disc           DECIMAL(15, 2)    COMMENT 'Return Special Back Office Markdown Loyalty Discount The returned amount of Special Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. Accrua<Truncated>',
    rtrn_pos_mdse_md_amt            DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Merchandise Markdown Amount The returns merchandise markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ RETURN_TRANS_LINE/RESERVE<Truncated>',
    rtrn_pos_v2c_md_amt             DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Direct Ship (Vendor to Customer) Markdown Amount The Vendor to Customer returns markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LIN<Truncated>',
    rtrn_pos_loyalty_md_amt         DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Loyalty Markdown Amount The Loyalty markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ RETURN_TRANS_LINE/RESERVED_RE<Truncated>',
    rtrn_pos_tfs_md_amt             DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Thanks For Sharing Markdown Amount The Thanks For Sharing markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ RETURN_<Truncated>',
    rtrn_pos_bridal_md_amt          DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Bridal Markdown Amount The Bridal Markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ RETURN_TRANS_LINE/ RESERVED_REG<Truncated>',
    rtrn_pos_bomd_newacct_md_amt    DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Back Office Markdown -New Account Markdown Amount The Back Office Markdown amount on returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ <Truncated>',
    rtrn_pos_mdse_mu_amt            DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Merchandise Markup Amount The Merchandise MarkUp amount on sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE (DISCOUNT_AMT * -1 for STK_PC<Truncated>',
    rtrn_fee_amt                    DECIMAL(15, 2)    COMMENT 'Return Fee Amount The amount of certain returned sales fees. Source: SALES_FEES. FEE_AMT LT 0. Also see OCD_FEES_BUSINESS_RULES. Note: some fee amounts from the base tables are intentionally excluded, as requested by the Divisional Accounting Office.',
    rtrn_loyal_disc                 DECIMAL(16, 2)    COMMENT 'Return Loyalty Discount The combined Return Loyalty Back Office Markdowns and Return Special Back Office Markdowns, representing the total loyalty discounts returned. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~RTRN_BOMD_LOYAL_DISC + RTRN_SBOMD_LOYAL_DISC',
    gross_returns_amt               DECIMAL(18, 2)    COMMENT 'Gross Returns Amount Return dollars, net of return discounts and adjustments, in dollars / cents for this level of product. Sales are not used in this calculation. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY  RTRN_MDSE_AMT + RTRN_MDSE_DISC + RTR<Truncated>',
    gross_returns_units             INT               COMMENT 'Gross Returns Units See definition of RTRN_UNITS in this table. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY RTRN_UNITS',
    congruency_flg                  VARCHAR(1)        COMMENT 'Congruency Flag A flag used to indicate whether a product is congruent in a location, based on financial credit. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~IF CONGRUENCY_VALUE IN (1,3) THEN Y ELSE N',
    cs_congruency_flg               VARCHAR(1)        COMMENT 'Dotcom Fulfilled In Store Congruency Flag This value will always be a N (no) except for non-SVI CS (dotcom fulfilled in store) transactions. If there is a congruent row in the dotcom, then this flag becomes a Y. In VIEW ONLY. Source: OC_SALES_PR<Truncated>',
    rtrn_promo_mkdn_amt             DECIMAL(18, 2)    COMMENT 'Return Promotion Markdown Amount The combined amount of return promotional markdowns. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~RTRN_POS_MDSE_MD_AMT + RTRN_POS_V2C_MD_AMT + RTRN_POS_LOYALTY_MD_AMT + RTRN_POS_TFS_MD_AMT + RTRN_POS_BRIDAL_MD_AMT<Truncated>',
    rplnsh_flg                      VARCHAR(1)        COMMENT 'Replenishment Flag Source A flag used when the UPC in a location is to be replenished. If the product is Inforem then the RPLNSH_FLG = N if the FORECAST_TYPE = X or NULL or the END_DT <> 3000-01-01.  RPLNSH_FLG = Y if the FORECAST_TYPE <> X or N<Truncated>',
    rplnsh_rplcmnt_sku_flg          VARCHAR(1)        COMMENT 'Replenishment Replacement SKU Flag A flag used to indicate whether the UPC in the row is replenished. ~Where: Y = The UPC is currently being replenished.. N = The UPC is currently NOT being replenished and there are no other UPCs within the same<Truncated>',
    rplnsh_flg_src                  VARCHAR(1)        COMMENT 'Replenishment Flag Source The detail value of the RPLNSH_FLG before logic was applied. Values are R, N, or Y.  In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~RPLNSH_FLG',
    fil_rplnsh_flg                  VARCHAR(1)        COMMENT 'FIL Replenishment Flag A value based upon the FIL_RPLNSH_FLG_SRC. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ IF FIL_RPLNSH_FLG = N OR R THEN N ELSE Y',
    fil_rplnsh_rplcmnt_sku_flg      VARCHAR(1)        COMMENT 'FIL Replenishment Replacement SKU Flag A flag used to represent the UPC that fulfilled the item. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ IF FIL_RPLNSH_FLG = Y OR R THEN Y ELSE N',
    fil_rplnsh_flg_src              VARCHAR(1)        COMMENT 'FIL Replenishment Flag Source The detail value of the FIL_RPLNSH_FLG before logic was applied. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ FIL_RPLNSH_FLG',
    ocd_error_cd                    SMALLINT          COMMENT 'Omni Channel Dimension Error Code The true value of the OCD code without the default logic. See the OCD_CD metadata in this table. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~Represents the Original Value of OCD_CD without the Default of Untagge<Truncated>',
    orig_ocd_error_cd               SMALLINT          COMMENT 'Original Omni Channel Dimension Error Code In the original Sale item row, this is the true value of the OCD code without the default logic. See the OCD_CD metadata in this table. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~Represents the Origina<Truncated>',
    divn_nbr                        INT               COMMENT 'Division Number The division number of the LOC_DIM_ID in this row. Source: LOCN_DIM DIVN_NBR of LOC_DIM_ID',
    dept_nbr                        SMALLINT          COMMENT 'Department Number The department number of the Product Dimension Id. Source: PROD_DIM~DEPT_NBR of PROD_DIM_ID',
    daas_load_id                    VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                     TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                     TIMESTAMP         COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id                 STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Omni Channel Returns by Product Dimension, Location and Day - This table holds the  returns of a Product Dimension at the location level for a given day. This view is better suited for returns analysis than OC_SALES_PROD_LOC_DAY_V because it has several additional columns of information and processes faster.  Financial information is  carried at dollars / cents and  units are whole numbers.| Offset = greg_date| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_oc_returns_prod_loc_day_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_oc_returns_prod_loc_wk_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_oc_returns_prod_loc_wk_v 
--

CREATE EXTERNAL TABLE edw_mix_oc_returns_prod_loc_wk_v(
    prod_dim_id                     DECIMAL(18, 0)    COMMENT 'Product Dimension Id The PROD_DIM_ID is an 18 digit number created from the timestamp when the PROD_DIM row was created, it uniquely identifies each product in each division of the company. Source: SALES_TRAN_LINE.PROD_DIM_ID for the Financial Location.',
    greg_amc_week_end_dt            STRING            COMMENT 'Week ending date The date in CCYY-MM-DD format for the fiscal week ending (a Saturday) for this row. The format for date selection is ccyy-mm-dd.',
    loc_dim_id                      INT               COMMENT 'Location Dimension Id The number assigned to the financial location in the EDW Location Dimension table. Reference the LOCN_DIM table.  Source: SALES_TRAN_LINE.LOC_DIM_ID for Financial Location.',
    fil_loc_dim_id                  INT               COMMENT 'Filling Location Dimension Id The number assigned to the filling location in the EDW Location Dimension table. Source: SALES_TRAN_FIL_RESV . FIL_LOC_DIM_ID for the Fulfilling Location. If no Fulfilling Location then Default to LOC_DIM_ID for the<Truncated>',
    ocd_cd                          SMALLINT          COMMENT 'Omni Channel Dimension Code A number initially assigned to each item sold to identify how the customer purchased merchandise and how the merchandise was fulfilled. This is the OCD_CD for the Sales Transaction.  Source: OC_SALES_PROD_LOC_DAY for <Truncated>',
    orig_loc_dim_id                 INT               COMMENT 'Original Location Dimension Id This is the location dimension id (LOC_DIM_ID) for the Original Financial Location for the Original Sale.',
    orig_fil_loc_dim_id             INT               COMMENT 'Original FIL Location Dimension Id This is the FIL_LOC_DIM_ID (Fulfilling Location Dimension ID) for the Original Fulfilling Location for the Original Sale. If no Original Fulfilling Location is present, the default is to the ORIG_LOC_DIM_ID for<Truncated>',
    orig_ocd_cd                     SMALLINT          COMMENT 'Original Omni Channel Dimension Code This is the OCD_CD for the Original Sale.',
    congruency_value                SMALLINT          COMMENT 'Congruency Value Code A value applied as of the most current day for the current week or the week ending date for completed weeks, to indicate the congruency of this PROD_DIM_ID for the location that received financial credit.  This value does n<Truncated>',
    price_loc_nbr                   INT               COMMENT 'Price Location Number The division or the pricing region assigned to this row. Source: DEPT_LOC_PRC_LOC . PRICE_LOC_NBR for the Dept/Financial Loc as of the GREG_AMC_WEEK_END_DT. Defaulted to DIVN_NBR if not found on DLPL as of GREG_AMC_WEEK_END_DT',
    ticketed_retail                 DECIMAL(11, 2)    COMMENT 'Ticketed Retail Price The ticketed retail unit price of this PROD_DIM_ID. Source: PROD_PRICE .TICKETED_RETAIL as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE. FOR COMPLETED WEEKS / Use Current TICKETED_RETAIL If Not Found as <Truncated>',
    owned_retail                    DECIMAL(11, 2)    COMMENT 'Owned Retail Price The owned retail unit price of this PROD_DIM_ID. Source: PROD_PRICE.OWNED_RETAIL as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE. FOR COMPLETED WEEKS / Use Current OWNED_RETAIL If Not Found as of the THE MO<Truncated>',
    zl_stat_nbr                     SMALLINT          COMMENT 'Status Number A code used to indicate a products standing in the merchandising cycle, such as active, first markdown, etc.',
    fil_price_loc_nbr               INT               COMMENT 'FIL Price Location Number The price loc number for the location that fufilled the product for this PROD_DIM_ID. Source: DEPT_LOC_PRC_LOC .  PRICE_LOC_NBR for the Dept/Filling Location for the Dept/Filling Loc as of the GREG_AMC_WEEK_END_DT. Defa<Truncated>',
    fil_ticketed_retail             DECIMAL(11, 2)    COMMENT 'FIL Ticketed Retail The Ticketed Retail price for this product at its FIL_PRICE_LOC_NBR. Source: PROD_PRICE. TICKETED_RETAIL for the Product/Filling Price_Loc_Nbr as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE FOR COMPLETED <Truncated>',
    fil_owned_retail                DECIMAL(11, 2)    COMMENT 'FIL Owned Retail The owned retail price of this product at its FIL_PRICE_LOC_NBR. Source: PROD_PRICE. OWNED_RETAIL for the Product/Filling Price_Loc_Nbr as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE FOR COMPLETED WEEKS / Us<Truncated>',
    fil_zl_stat_nbr                 SMALLINT          COMMENT 'FIL Legacy Status Number The Item Status number of this product at its FIL_PRICE_LOC_NBR. A code used to indicate a products standing in the merchandising cycle, such as active, first markdown, etc.',
    ocd_loc_typ                     VARCHAR(10)       COMMENT 'Omni Channel Dimension Code Location Type A code used to determine the type of location, such as STR, WED (Wedding Channel, etc. for financial credit. Source: LOCN_DIM_ATTR/ LOCN_DIM_ATTR_TYP.ATTR_ABBR for PROF_TYP_NBR = 385',
    fil_ocd_loc_typ                 VARCHAR(10)       COMMENT 'Fulfilling Omni Channel Dimension Code Location Type The Omni Channel Dimension location type, such as STR to determine the location fulfilling the transaction. Note: there are several different OCD_LOC_TYP values in this table. Source: LOCN_DIM<Truncated>',
    rtrn_mdse_amt                   DECIMAL(15, 2)    COMMENT 'Return Merchandise Amount The extended (quantity x price) line item returned amount before point-of-sale discounts are applied, except for dotcom /RDS items that are net. The formula to calculate what the customer was credited for this item on t<Truncated>',
    rtrn_adj                        DECIMAL(15, 2)    COMMENT 'Return Adjustment The return adjustment dollars tied to an original sale. Source: sum of daily OC_RETURNS_PROD_LOC_DAY values for this week. NOTE: TRANS_TYPE_CD = 1 should not be included in this total.',
    rtrn_units                      INT               COMMENT 'Return Units The returned units tied to the original sale. Source: sum of daily OC_RETURNS_PROD_LOC_DAY values for this week.',
    rtrn_mdse_disc                  DECIMAL(15, 2)    COMMENT 'Return Merchandise Discount The original line item discount amount being reversed. The formula to calculate what the customer was credited for this item on the point-of-sale receipt is: (RTRN_MDSE_AMT + RTRN_MDSE_DISC). Source: sum of daily OC_R<Truncated>',
    rtrn_asso_disc                  DECIMAL(15, 2)    COMMENT 'Return Associate Discount The amount of employee / associate discounts applied to this returned item in the Back Office tied to an original sale. Source: sum of daily OC_RETURNS_PROD_LOC_DAY values for this week.',
    rtrn_bomd_loyal_disc            DECIMAL(15, 2)    COMMENT 'Return Back Office Markdown Loyalty Discount The returned amount of Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. New charge accounts ar<Truncated>',
    rtrn_sbomd_loyal_disc           DECIMAL(15, 2)    COMMENT 'Return Special Back Office Markdown Loyalty Discount The returned amount of Special Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. Accrua<Truncated>',
    rtrn_pos_mdse_md_amt            DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Merchandise Markdown Amount The returns merchandise markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_RETURNS_PROD_LOC_DAY val<Truncated>',
    rtrn_pos_v2c_md_amt             DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Direct Ship (Vendor to Customer) Markdown Amount The Vendor to Customer returns markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily<Truncated>',
    rtrn_pos_loyalty_md_amt         DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Loyalty Markdown Amount The Loyalty markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_RETURNS_PROD_LOC_DAY values <Truncated>',
    rtrn_pos_tfs_md_amt             DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Thanks For Sharing Markdown Amount The Thanks For Sharing markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_RETURN<Truncated>',
    rtrn_pos_bridal_md_amt          DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Bridal Markdown Amount The Bridal Markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_RETURNS_PROD_LOC_DAY values fo<Truncated>',
    rtrn_pos_bomd_newacct_md_amt    DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Back Office Markdown -New Account Markdown Amount The Back Office Markdown amount on returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC<Truncated>',
    rtrn_pos_mdse_mu_amt            DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Merchandise Markup Amount The Merchandise MarkUp amount on sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_RETURNS_PROD_LOC_DAY values<Truncated>',
    rtrn_fee_amt                    DECIMAL(15, 2)    COMMENT 'Return Fee Amount The amount of certain returned sales fees. Source: SALES_FEES. FEE_AMT LT 0. Also see OCD_FEES_BUSINESS_RULES. Note: some fee amounts from the base tables are intentionally excluded, as requested by the Divisional Accounting Office.',
    rtrn_product_cost               DECIMAL(15, 2)    COMMENT 'Return Product Cost The product cost of this returned PROD_DIM. Sources: OC_RETURNS_PROD_LOC_DAY/ CVN_FACTS_LOC_DVN_WK/ ROS_FACTS_DIV_DPT_PTD_BY_WK/ PROD_DIM_HIST RTRN_PRODUCT_COST = RTRN_UNITS * (ITEM_LAST_COST + (ITEM_LAST_COST * Freight %) - <Truncated>',
    adj_cost_basis                  SMALLINT          COMMENT 'Adjusted Cost Basis A code that indicates the method of calculation used to determine product margin. Where: 1 = ITEM_LAST_COST value 2 = CVN default cumulative markup 3 = cumulative ROS markup percent 4 = Use keystone markup (50%)',
    rtrn_product_margin             DECIMAL(18, 2)    COMMENT 'Return Product Margin The return product margin for this PROD_DIM_ID in this financial location in this operating division. VIEW ONLY:  OC_SALES_PROD_LOC_WK:  GROSS_RETURNS_AMT - RTRN_PRODUCT_COST',
    rtrn_loyal_disc                 DECIMAL(16, 2)    COMMENT 'Return Loyalty Discount The combined Return Loyalty Back Office Markdowns and Return Special Back Office Markdowns, representing the total loyalty discounts returned. In VIEW ONLY. Source: sum of OC_SALES_PROD_LOC_DAY~RTRN_BOMD_LOYAL_DISC + RTRN<Truncated>',
    gross_returns_amt               DECIMAL(18, 2)    COMMENT 'Gross Returns Amount Return dollars, net of return discounts and adjustments, in dollars / cents for this level of product. Sales are not used in this calculation. IN VIEW ONLY: Source: sum of daily OC_RETURNS_PROD_LOC_DAY values for this week.',
    gross_returns_units             INT               COMMENT 'Gross Returns Units See definition of RTRN_UNITS in this table. IN VIEW ONLY: Source: sum of daily OC_RETURNS_PROD_LOC_DAY values for this week.',
    congruency_flg                  VARCHAR(1)        COMMENT 'Congruency Flag A flag used to indicate whether a product is congruent in a location, based on financial credit. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~IF CONGRUENCY_VALUE IN (1,3) THEN Y ELSE N',
    cs_congruency_flg               VARCHAR(1)        COMMENT 'Dotcom Fulfilled In Store Congruency Flag This value will always be a N (no) except for non-SVI CS (dotcom fulfilled in store) transactions. If there is a congruent row in the dotcom, then this flag becomes a Y. In VIEW ONLY. Source: OC_SALES_PR<Truncated>',
    rtrn_promo_mkdn_amt             DECIMAL(18, 2)    COMMENT 'Return Promotional Markdown Amount The combined amount of return promotional markdowns. In VIEW ONLY. Source: sum of daily OC_RETURNS_PROD_LOC_DAY  RTRN_PROMO_MKDN_AMT =  RTRN_POS_MDSE_MD_AMT + RTRN_POS_V2C_MD_AMT + RTRN_POS_LOYALTY_MD_AMT + RTR<Truncated>',
    rplnsh_flg                      VARCHAR(1)        COMMENT 'Replenishment Flag A flag used when the UPC in a location is to be replenished. If the product is Inforem then the RPLNSH_FLG = N if the FORECAST_TYPE = X or NULL or the END_DT <> 3000-01-01.  RPLNSH_FLG = Y if the FORECAST_TYPE <> X or NULL and<Truncated>',
    rplnsh_rplcmnt_sku_flg          VARCHAR(1)        COMMENT 'Replenishment Replacement SKU Flag A flag used to indicate whether the UPC in the row is replenished. ~Where: Y = The UPC is currently being replenished.. N = The UPC is currently NOT being replenished and there are no other UPCs within the same<Truncated>',
    rplnsh_flg_src                  VARCHAR(1)        COMMENT 'Replenishment Flag Source The detail value of the RPLNSH_FLG before logic was applied. Values are R, N, or Y.  In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~RPLNSH_FLG',
    fil_rplnsh_flg                  VARCHAR(1)        COMMENT 'FIL Replenishment Flag A value based upon the FIL_RPLNSH_FLG_SRC. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ IF FIL_RPLNSH_FLG = N OR R THEN N ELSE Y',
    fil_rplnsh_rplcmnt_sku_flg      VARCHAR(1)        COMMENT 'FIL Replenishment Replacement SKU Flag A flag used to represent the UPC that fulfilled the item. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ IF FIL_RPLNSH_FLG = Y OR R THEN Y ELSE N',
    fil_rplnsh_flg_src              VARCHAR(1)        COMMENT 'FIL Replenishment Flag Source The detail value of the FIL_RPLNSH_FLG before logic was applied. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ FIL_RPLNSH_FLG',
    ocd_error_cd                    SMALLINT          COMMENT 'Omni Channel Dimension Error Code The true value of the OCD code without the default logic. See the OCD_CD metadata in this table. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~Represents the Original Value of OCD_CD without the Default of Untagge<Truncated>',
    orig_ocd_error_cd               SMALLINT          COMMENT 'Original Omni Channel Dimension Error Code In the original Sale item row, this is the true value of the OCD code without the default logic. See the OCD_CD metadata in this table. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~Represents the Origina<Truncated>',
    divn_nbr                        INT               COMMENT 'Division Number The division number of the LOC_DIM_ID in this row. Source: LOCN_DIM DIVN_NBR of LOC_DIM_ID',
    dept_nbr                        SMALLINT          COMMENT 'Department Number The department number of the Product Dimension Id. Source: PROD_DIM~DEPT_NBR of PROD_DIM_ID',
    daas_load_id                    VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                     TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                     TIMESTAMP         COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id                 STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Omni Channel Returns by Product Dimension, Location and Week - This table holds the  returns  of a Product Dimension at the location level, summarized for a given week. This view is better suited for returns analysis than OC_SALES_PROD_LOC_WK_V  because it should process faster and has 3 additional columns of information: ORIG_LOC_DIM_ID, ORIG_FIL_LOC_DIM_ID, and ORIG_OCD_CD.  Financial information is  carried at dollars / cents and  units  are whole numbers.| Offset = greg_amc_week_end_dt | Partition Date = greg_amc_week_end_dt dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_oc_returns_prod_loc_wk_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_oc_sales_prod_loc_day_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_oc_sales_prod_loc_day_v 
--

CREATE EXTERNAL TABLE edw_mix_oc_sales_prod_loc_day_v(
    prod_dim_id                     DECIMAL(18, 0)    COMMENT 'Product Dimension Id The PROD_DIM_ID is an 18 digit number created from the timestamp when the PROD_DIM row was created, it uniquely identifies each product in each division of the company. Source: SALES_TRAN_LINE.PROD_DIM_ID for the Financial Location.',
    greg_date                       STRING            COMMENT 'Gregorian Transaction Date The financial business date of this row. The format for date selection is ccyy-mm-dd.',
    loc_dim_id                      INT               COMMENT 'Location Dimension Id The number assigned to the financial location in the EDW Location Dimension table. Reference the LOCN_DIM table.  Source: SALES_TRAN_LINE.LOC_DIM_ID for Financial Location.',
    fil_loc_dim_id                  INT               COMMENT 'Filling Location Dimension Id The number assigned to the filling location in the EDW Location Dimension table. Source: SALES_TRAN_FIL_RESV . FIL_LOC_DIM_ID for the Fulfilling Location. If no Fulfilling Location then Default to LOC_DIM_ID for the<Truncated>',
    ocd_cd                          SMALLINT          COMMENT 'Omni Channel Dimension Code A number initially assigned to each item sold to identify how the customer purchased merchandise and how the merchandise was fulfilled.  Source: OC_SALES_PROD_LOC_DAY for the Sales Transaction.   Also reference the OC<Truncated>',
    congruency_value                SMALLINT          COMMENT 'Congruency Value Code A value applied as of the most current day for the current week or the week ending date for completed weeks, to indicate the congruency of this PROD_DIM_ID for the location that received financial credit.  This value does n<Truncated>',
    price_loc_nbr                   INT               COMMENT 'Price Location Number The division or the pricing region assigned to this row. Source: DEPT_LOC_PRC_LOC .PRICE_LOC_NBR for the Dept/Loc as of the GREG_AMC_WEEK_END_DT. Defaulted to DIVN_NBR if not found on DLPL as of GREG_AMC_WEEK_END_DT',
    ticketed_retail                 DECIMAL(11, 2)    COMMENT 'Ticketed Retail Price The ticketed retail unit price of this PROD_DIM_ID. Source: PROD_PRICE .TICKETED_RETAIL as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE. FOR COMPLETED WEEKS / Use Current TICKETED_RETAIL If Not Found as <Truncated>',
    owned_retail                    DECIMAL(11, 2)    COMMENT 'Owned Retail Price The owned retail unit price of this PROD_DIM_ID. Source: PROD_PRICE.OWNED_RETAIL as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE. FOR COMPLETED WEEKS / Use Current OWNED_RETAIL If Not Found as of the THE MO<Truncated>',
    zl_stat_nbr                     SMALLINT          COMMENT 'Status Number A code used to indicate a products standing in the merchandising cycle, such as active, first markdown, etc.',
    fil_price_loc_nbr               INT               COMMENT 'FIL Price Location Number The price loc number for the location that fufilled the product for this PROD_DIM_ID. Source: DEPT_LOC_PRC_LOC .  PRICE_LOC_NBR for the Dept/Filling Location for the Dept/Filling Loc as of the GREG_AMC_WEEK_END_DT. Defa<Truncated>',
    fil_ticketed_retail             DECIMAL(11, 2)    COMMENT 'FIL Ticketed Retail The Ticketed Retail price for this product at its FIL_PRICE_LOC_NBR. Source: PROD_PRICE. TICKETED_RETAIL for the Product/Filling Price_Loc_Nbr as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE FOR COMPLETED <Truncated>',
    fil_owned_retail                DECIMAL(11, 2)    COMMENT 'FIL Owned Retail The owned retail price of this product at its FIL_PRICE_LOC_NBR. Source: PROD_PRICE. OWNED_RETAIL for the Product/Filling Price_Loc_Nbr as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE FOR COMPLETED WEEKS / Us<Truncated>',
    fil_zl_stat_nbr                 SMALLINT          COMMENT 'FIL Legacy Status Number The Item Status number of this product at its FIL_PRICE_LOC_NBR. A code used to indicate a products standing in the merchandising cycle, such as active, first markdown, etc.',
    ocd_loc_typ                     VARCHAR(10)       COMMENT 'Omni Channel Dimension Code Location Type A code used to determine the type of location, such as STR, WED (Wedding Channel, etc. for financial credit. Source: LOCN_DIM_ATTR/ LOCN_DIM_ATTR_TYP.ATTR_ABBR for PROF_TYP_NBR = 385',
    fil_ocd_loc_typ                 VARCHAR(10)       COMMENT 'Fulfilling Omni Channel Dimension Code Location Type The Omni Channel Dimension location type, such as STR to determine the location fulfilling the transaction. Note: there are several different OCD_LOC_TYP values in this table. Source: LOCN_DIM<Truncated>',
    sls_mdse_amt                    DECIMAL(15, 2)    COMMENT 'Sales Merchandise Amount The extended (quantity x price) line item sold amount before point-of-sale discounts are applied, except for dotcom / RDS items that are net.  The formula to calculate what the customer paid for this item on the point-of<Truncated>',
    sls_adj                         DECIMAL(15, 2)    COMMENT 'Sales Adjustments The dollar amount of sales adjustments for this level of product. Source: SALES_TRAN_LINE~MERCH_AMT for TRANS_TYPE_CD in (1,21). Note: TRANS_TYPE_CD = 21 should not be found in SALES_TRAN_LINE.',
    sls_units                       INT               COMMENT 'Sales Units The units sold at this level of product. This is a whole number that includes rows where the SLS_MDSE_AMT is zero, such as Deals. Source: SALES_TRAN_LINE~UPC_QTY for TRANS_TYPE_CD in (3,4,5,33,35). Note: TRANS_TYPE_CD 5 & 35 are not <Truncated>',
    sls_mdse_disc                   DECIMAL(15, 2)    COMMENT 'Sales Merchandise Discount The amount of point-of-sale discounts applied to this item.  The formula to calculate what the customer paid for this item on the point-of-sale receipt is: (SLS_MDSE_AMT + SLS_MDSE_DISC ). Source: TRANS_LINE_DISCOUNT~D<Truncated>',
    sls_asso_disc                   DECIMAL(15, 2)    COMMENT 'Sales Associate Discount The amount of employee / associate discounts applied to this item in the Back Office. Source: TRANS_LINE_DISCOUNT~DISCOUNT_AMT for TRANS_TYPE_CD in (3,4,5,33,35) and DISCOUNT_TYPE_CD in (90,93) and DISCOUNT_AMT LT 0. Not<Truncated>',
    sls_bomd_loyal_disc             DECIMAL(15, 2)    COMMENT 'Sales Back Office Markdown Loyalty Discount The amount of Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product. New charge accounts are a source of this discount. Source<Truncated>',
    sls_sbomd_loyal_disc            DECIMAL(15, 2)    COMMENT 'Sales Special Back Office Markdown Loyalty Discount The amount of Special Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product. Accruals for loyalty Reward programs are <Truncated>',
    sls_pos_mdse_md_amt             DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Merchandise Markdown Amount The sales merchandise markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ SALES_TRAN_LINE/ RESERVED_RE<Truncated>',
    sls_pos_v2c_md_amt              DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Drop Ship (Vendor to Customer) Markdown Amount The Vendor to Customer sales markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially.Calculation is based on OC<Truncated>',
    sls_pos_loyalty_md_amt          DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Loyalty Markdown Amount The Loyalty markdown amount for sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ SALES_TRAN_LINE/RESERVED_REGISTE<Truncated>',
    sls_pos_tfs_md_amt              DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Thanks For Sharing Markdown Amount The Thanks For Sharing markdown amount for sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Sources: PSD_TRAN_LINE/ SALES_TRA<Truncated>',
    sls_pos_bridal_md_amt           DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Bridal Markdown Amount The Bridal Markdown amount for sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Sources: PSD_TRAN_LINE/ SALES_TRAN_LINE/ RESERVED_REGISTE<Truncated>',
    sls_pos_bomd_newacct_md_amt     DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Back Office Markdown New Account Markdown Amount The Back Office Markdown amount on sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: OC_SALES_PROD_LOC_D<Truncated>',
    sls_pos_mdse_mu_amt             DECIMAL(15, 2)    COMMENT 'Sales Point of Sale (PSD) - Merchandise Markup Amount The Merchandise MarkUp amount on sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE~(DISCOUNT_AMT * -1 for STK_PC_TYPE_COD<Truncated>',
    sls_fee_amt                     DECIMAL(15, 2)    COMMENT 'Sales Fee Amount The amount of certain sales fees, before any returns. Source: SALES_FEES / FEE_AMT GT 0. Also see OCD_FEES_BUSINESS_RULES. Note: some fee amounts from the base tables are intentionally excluded, as requested by the Divisional Ac<Truncated>',
    rtrn_mdse_amt                   DECIMAL(15, 2)    COMMENT 'Return Merchandise Amount The extended (quantity x price) line item returned amount before point-of-sale discounts are applied, except for dotcom /RDS items that are net. The formula to calculate what the customer was credited for this item on t<Truncated>',
    rtrn_adj                        DECIMAL(15, 2)    COMMENT 'Return Adjustment The return adjustment dollars tied to an original sale. Source: RETURN_TRANS_LINE.MERCH_AMT for TRANS_TYPE_CD = (1,21). NOTE: TRANS_TYPE_CD = 1 should not be included.',
    rtrn_units                      INT               COMMENT 'Return Units The returned units tied to the original sale. Source: RETURN_TRANS_LINE.UPC_QTY for TRANS_TYPE_CD = 33',
    rtrn_mdse_disc                  DECIMAL(15, 2)    COMMENT 'Return Merchandise Discount The original line item discount amount being reversed. The formula to calculate what the customer was credited for this item on the point-of-sale receipt is: (RTRN_MDSE_AMT + RTRN_MDSE_DISC). SOURCE: TRANS_LINE_DISCOU<Truncated>',
    rtrn_asso_disc                  DECIMAL(15, 2)    COMMENT 'Return Associate Discount The amount of employee / associate discounts applied to this returned item in the Back Office tied to an original sale. Source: TRANS_LINE_DISCOUNT DISCOUNT_AMT for TRANS_TYPE_CD in (3,4,5,33,35) and DISCOUNT_TYPE_CD in (90,93)',
    rtrn_bomd_loyal_disc            DECIMAL(15, 2)    COMMENT 'Return Back Office Markdown Loyalty Discount The returned amount of Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. New charge accounts ar<Truncated>',
    rtrn_sbomd_loyal_disc           DECIMAL(15, 2)    COMMENT 'Return Special Back Office Markdown Loyalty Discount The returned amount of Special Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. Accrua<Truncated>',
    rtrn_pos_mdse_md_amt            DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Merchandise Markdown Amount The returns merchandise markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ RETURN_TRANS_LINE/RESERVE<Truncated>',
    rtrn_pos_v2c_md_amt             DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Direct Ship (Vendor to Customer) Markdown Amount The Vendor to Customer returns markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LIN<Truncated>',
    rtrn_pos_loyalty_md_amt         DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Loyalty Markdown Amount The Loyalty markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ RETURN_TRANS_LINE/RESERVED_RE<Truncated>',
    rtrn_pos_tfs_md_amt             DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Thanks For Sharing Markdown Amount The Thanks For Sharing markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ RETURN_<Truncated>',
    rtrn_pos_bridal_md_amt          DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Bridal Markdown Amount The Bridal Markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ RETURN_TRANS_LINE/ RESERVED_REG<Truncated>',
    rtrn_pos_bomd_newacct_md_amt    DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Back Office Markdown -New Account Markdown Amount The Back Office Markdown amount on returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE/ <Truncated>',
    rtrn_pos_mdse_mu_amt            DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Merchandise Markup Amount The Merchandise MarkUp amount on sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: PSD_TRAN_LINE (DISCOUNT_AMT * -1 for STK_PC<Truncated>',
    rtrn_fee_amt                    DECIMAL(15, 2)    COMMENT 'Return Fee Amount The amount of certain returned sales fees. Source: SALES_FEES. FEE_AMT LT 0. Also see OCD_FEES_BUSINESS_RULES. Note: some fee amounts from the base tables are intentionally excluded, as requested by the Divisional Accounting Office.',
    rtrn_loyal_disc                 DECIMAL(16, 2)    COMMENT 'Return Loyalty Discount The combined Return Loyalty Back Office Markdowns and Return Special Back Office Markdowns, representing the total loyalty discounts returned. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~RTRN_BOMD_LOYAL_DISC + RTRN_SBOMD_LOYAL_DISC',
    gross_returns_amt               DECIMAL(18, 2)    COMMENT 'Gross Returns Amount Return dollars, net of return discounts and adjustments, in dollars / cents for this level of product. Sales are not used in this calculation. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY  RTRN_MDSE_AMT + RTRN_MDSE_DISC + RTR<Truncated>',
    gross_returns_units             INT               COMMENT 'Gross Returns Units See definition of RTRN_UNITS in this table. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY RTRN_UNITS',
    sls_loyal_disc                  DECIMAL(16, 2)    COMMENT 'Sales Loyalty Discount The combined Sale Loyalty Back Office Markdowns and Sale Special Back Office Markdowns. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~SLS_BOMD_LOYAL_DISC + SLS_SBOMD_LOYAL_DISC',
    gross_sales_amt                 DECIMAL(18, 2)    COMMENT 'Gross Sales Amount Sales dollars, net of sales discounts and adjustments, in dollars / cents for this level of product. Returns are not used in this calculation. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY  SLS_MDSE_AMT + SLS_MDSE_DISC + SLS_ASS<Truncated>',
    gross_sales_units               INT               COMMENT 'Gross Sales Units See definition of SLS_UNITS in this table. In VIEW ONLY.   Source: OC_SALES_PROD_LOC_DAY  SLS_UNITS',
    congruency_flg                  VARCHAR(1)        COMMENT 'Congruency Flag A flag used to indicate whether a product is congruent in a location, based on financial credit. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~IF CONGRUENCY_VALUE IN (1,3) THEN Y ELSE N',
    cs_congruency_flg               VARCHAR(1)        COMMENT 'Dotcom Fulfilled In Store Congruency Flag This value will always be a N (no) except for non-SVI CS (dotcom fulfilled in store) transactions. If there is a congruent row in the dotcom, then this flag becomes a Y. In VIEW ONLY. Source: OC_SALES_PR<Truncated>',
    rtrn_promo_mkdn_amt             DECIMAL(18, 2)    COMMENT 'Return Promotion Markdown Amount The combined amount of return promotional markdowns. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~RTRN_POS_MDSE_MD_AMT + RTRN_POS_V2C_MD_AMT + RTRN_POS_LOYALTY_MD_AMT + RTRN_POS_TFS_MD_AMT + RTRN_POS_BRIDAL_MD_AMT<Truncated>',
    sls_promo_mkdn_amt              DECIMAL(18, 2)    COMMENT 'Sales Promotion Markdown Amount The combined amount of sale promotional markdowns. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~SLS_POS_MDSE_MD_AMT + SLS_POS_V2C_MD_AMT + SLS_POS_LOYALTY_MD_AMT + SLS_POS_TFS_MD_AMT + SLS_POS_BRIDAL_MD_AMT + SLS_P<Truncated>',
    net_sales_amt                   DECIMAL(18, 2)    COMMENT 'Net Sales Amount The net of Gross Sales and Gross Returns in dollars. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~GROSS_SALES_AMT + GROSS_RETURNS_AMT',
    net_sales_units                 INT               COMMENT 'Net Sales Units The net of Gross Sales and Gross Returns in units. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~GROSS_SALES_UNITS + GROSS_RETURNS_UNITS',
    rplnsh_flg                      VARCHAR(1)        COMMENT 'Replenishment Flag A flag used when the UPC in a location is to be replenished. If the product is Inforem then the RPLNSH_FLG = N if the FORECAST_TYPE = X or NULL or the END_DT <> 3000-01-01.  RPLNSH_FLG = Y if the FORECAST_TYPE <> X or NULL and<Truncated>',
    rplnsh_rplcmnt_sku_flg          VARCHAR(1)        COMMENT 'Replenishment Replacement SKU Flag A flag used to indicate whether the UPC in the row is replenished. ~Where: Y = The UPC is currently being replenished.. N = The UPC is currently NOT being replenished and there are no other UPCs within the same<Truncated>',
    rplnsh_flg_src                  VARCHAR(1)        COMMENT 'Replenishment Flag Source The detail value of the RPLNSH_FLG before logic was applied. Values are R, N, or Y.  In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~RPLNSH_FLG',
    fil_rplnsh_flg                  VARCHAR(1)        COMMENT 'FIL Replenishment Flag A value based upon the FIL_RPLNSH_FLG_SRC. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ IF FIL_RPLNSH_FLG = N OR R THEN N ELSE Y',
    fil_rplnsh_rplcmnt_sku_flg      VARCHAR(1)        COMMENT 'FIL Replenishment Replacement SKU Flag A flag used to represent the UPC that fulfilled the item. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ IF FIL_RPLNSH_FLG = Y OR R THEN Y ELSE N',
    fil_rplnsh_flg_src              VARCHAR(1)        COMMENT 'FIL Replenishment Flag Source The detail value of the FIL_RPLNSH_FLG before logic was applied. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ FIL_RPLNSH_FLG',
    ocd_error_cd                    SMALLINT          COMMENT 'Omni Channel Dimension Error Code The true value of the OCD code without the default logic. See the OCD_CD metadata in this table. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~Represents the Original Value of OCD_CD without the Default of Untagge<Truncated>',
    divn_nbr                        INT               COMMENT 'Division Number The division number of the LOC_DIM_ID in this row. Source: LOCN_DIM DIVN_NBR of LOC_DIM_ID',
    dept_nbr                        SMALLINT          COMMENT 'Department Number The department number of the Product Dimension Id. Source: PROD_DIM~DEPT_NBR of PROD_DIM_ID',
    daas_load_id                    VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                     TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                     TIMESTAMP         COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id                 STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Omni Channel Sales by Product Dimension, Location and Day - This table holds the sales & returns of a Product Dimension at the location level for a given day. This table was developed to help support cross divisional transfers. Financial information is  carried at dollars / cents and  units  are whole numbers.| Offset = greg_date| Partition Date = greg_dt dd/MM/yyyy
'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_oc_sales_prod_loc_day_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_oc_sales_prod_loc_wk_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_oc_sales_prod_loc_wk_v 
--

CREATE EXTERNAL TABLE edw_mix_oc_sales_prod_loc_wk_v(
    prod_dim_id                     DECIMAL(18, 0)    COMMENT 'Product Dimension Id The PROD_DIM_ID is an 18 digit number created from the timestamp when the PROD_DIM row was created, it uniquely identifies each product in each division of the company.',
    greg_amc_week_end_dt            STRING            COMMENT 'The week ending date. The date in CCYY-MM-DD format for the fiscal week ending (a Saturday) for this row. The format for date selection is ccyy-mm-dd.',
    loc_dim_id                      INT               COMMENT 'Location Dimension Id The number assigned to the financial location in the EDW Location Dimension table. Source: OC_SALES_PROD_LOC_DAY',
    fil_loc_dim_id                  INT               COMMENT 'Filling Location Dimension Id The number assigned to the filling location in the EDW Location Dimension table. Source: OC_SALES_PROD_LOC_DAY',
    ocd_cd                          SMALLINT          COMMENT 'Omni Channel Dimension Code A number initially assigned to each item sold to identify how the customer purchased merchandise and how the merchandise was fulfilled.  Source: OC_SALES_PROD_LOC_DAY for the Sales Transaction.   Also reference the OC<Truncated>',
    congruency_value                SMALLINT          COMMENT 'Congruency Value Code A value applied as of the most current day for the current week or the week ending date for completed weeks, to indicate the congruency of this PROD_DIM_ID for the location that received financial credit.  This value does n<Truncated>',
    price_loc_nbr                   INT               COMMENT 'Price Location Number The division or the pricing region assigned to this row. Source: DEPT_LOC_PRC_LOC .PRICE_LOC_NBR for the Dept/Loc as of the GREG_AMC_WEEK_END_DT. Defaulted to DIVN_NBR if not found on DLPL as of GREG_AMC_WEEK_END_DT',
    ticketed_retail                 DECIMAL(11, 2)    COMMENT 'Ticketed Retail Price The ticketed retail unit price of this PROD_DIM_ID. Source: PROD_PRICE .TICKETED_RETAIL as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE. FOR COMPLETED WEEKS / Use Current TICKETED_RETAIL If Not Found as <Truncated>',
    owned_retail                    DECIMAL(11, 2)    COMMENT 'Owned Retail Price The owned retail unit price of this PROD_DIM_ID. Source: PROD_PRICE.OWNED_RETAIL as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE. FOR COMPLETED WEEKS / Use Current OWNED_RETAIL If Not Found as of the THE MO<Truncated>',
    zl_stat_nbr                     SMALLINT          COMMENT 'Status Number A code used to indicate a products standing in the merchandising cycle, such as active, first markdown, etc.',
    fil_price_loc_nbr               INT               COMMENT 'FIL Price Location Number The price loc number for the location that fufilled the product for this PROD_DIM_ID. Source: DEPT_LOC_PRC_LOC (DLPL) PRICE_LOC_NBR for the Dept/Filling Location for the Dept/Filling Loc as of the GREG_AMC_WEEK_END_DT. <Truncated>',
    fil_ticketed_retail             DECIMAL(11, 2)    COMMENT 'FIL Ticketed Retail The Ticketed Retail price for this product at its FIL_PRICE_LOC_NBR. Source: PROD_PRICE. TICKETED_RETAIL for the Product/Filling Price_Loc_Nbr as of the WEEK ENDING DATE FOR COMPLETED WEEKS / Use Current TICKETED_RETAIL If No<Truncated>',
    fil_owned_retail                DECIMAL(11, 2)    COMMENT 'FIL Owned Retail The owned retail price of this product at its FIL_PRICE_LOC_NBR. Source: PROD_PRICE. OWNED_RETAIL for the Product/Filling Price_Loc_Nbr as of THE MOST CURRENT DAY FOR THE CURRENT WEEK or WEEK ENDING DATE FOR COMPLETED WEEKS / Us<Truncated>',
    fil_zl_stat_nbr                 SMALLINT          COMMENT 'FIL Legacy Status Number The Item (legacy system) Status number of this product at its FIL_PRICE_LOC_NBR. This code is used to indicate a products standing in the merchandising cycle, such as active, first markdown, etc.  ZL_STAT_NBR for the Pro<Truncated>',
    ocd_loc_typ                     VARCHAR(10)       COMMENT 'Omni Channel Dimension Code Location Type A code used to determine the type of location, such as STR, WED (Wedding Channel, etc. for financial credit. Source: LOCN_DIM_ATTR/ LOCN_DIM_ATTR_TYP.ATTR_ABBR for PROF_TYP_NBR = 385',
    fil_ocd_loc_typ                 VARCHAR(10)       COMMENT 'Fulfilling Omni Channel Dimension Code Location Type The Omni Channel Dimension location type, such as STR to determine the location fulfilling the transaction. Note: there are several different OCD_LOC_TYP values in this table. Source: LOCN_DIM<Truncated>',
    sls_mdse_amt                    DECIMAL(15, 2)    COMMENT 'Sales Merchandise Amount The extended (quantity x price) line item sold amount before point-of-sale discounts are applied, except for dotcom / RDS items that are net.  The formula to calculate what the customer paid for this item on the point-of<Truncated>',
    sls_adj                         DECIMAL(15, 2)    COMMENT 'Sales Adjustments The dollar amount of sales adjustments for this level of product. Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week. NOTE: TRANS_TYPE_CD = 21 is included and should not be.',
    sls_units                       INT               COMMENT 'Sales Units The units sold at this level of product. This is a whole number that includes rows where the SLS_MDSE_AMT is zero, such as Deals. Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    sls_mdse_disc                   DECIMAL(15, 2)    COMMENT 'Sales Merchandise Discount The amount of point-of-sale discounts applied to this item.  The formula to calculate what the customer paid for this item on the point-of-sale receipt is: (SLS_MDSE_AMT + SLS_MDSE_DISC ). Source: sum of daily OC_SALES<Truncated>',
    sls_asso_disc                   DECIMAL(15, 2)    COMMENT 'Sales Associate Discount The amount of employee / associate discounts applied to this item in the Back Office. Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    sls_bomd_loyal_disc             DECIMAL(15, 2)    COMMENT 'Sales Back Office Markdown Loyalty Discount The amount of Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product. New charge accounts are a source of this discount. Source<Truncated>',
    sls_sbomd_loyal_disc            DECIMAL(15, 2)    COMMENT 'Sales Special Back Office Markdown Loyalty Discount The amount of Special Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product. Accruals for loyalty Reward programs are <Truncated>',
    sls_pos_mdse_md_amt             DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Merchandise Markdown Amount The sales merchandise markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_SALES_PROD_LOC_DAY values f<Truncated>',
    sls_pos_v2c_md_amt              DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Drop Ship (Vendor to Customer) Markdown Amount The Vendor to Customer sales markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_S<Truncated>',
    sls_pos_loyalty_md_amt          DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Loyalty Markdown Amount The Loyalty markdown amount for sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    sls_pos_tfs_md_amt              DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Thanks For Sharing Markdown Amount The Thanks For Sharing markdown amount for sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_SALES_PRO<Truncated>',
    sls_pos_bridal_md_amt           DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Bridal Markdown Amount The Bridal Markdown amount for sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    sls_pos_bomd_newacct_md_amt     DECIMAL(15, 2)    COMMENT 'Sales Point of Sale Discount (PSD)- Back Office Markdown New Account Markdown Amount The Back Office Markdown amount on sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_SAL<Truncated>',
    sls_pos_mdse_mu_amt             DECIMAL(15, 2)    COMMENT 'Sales Point of Sale (PSD) - Merchandise Markup Amount The Merchandise MarkUp amount on sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially. Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    sls_fee_amt                     DECIMAL(15, 2)    COMMENT 'Sales Fee Amount The amount of certain sales fees, before any returns. Source: SALES_FEES / FEE_AMT GT 0. Also see OCD_FEES_BUSINESS_RULES. Note: some fee amounts from the base tables are intentionally excluded, as requested by the Divisional Ac<Truncated>',
    sls_product_cost                DECIMAL(15, 2)    COMMENT 'Sales Product Cost The calculated product cost of this PROD_DIM_ID sold in this operating division. Sources: OC_SALES_PROD_LOC_DAY / CVN_FACTS_LOC_DVN_WK / ROS_FACTS_DIV_DPT_PTD_BY_WK / PROD_DIM_HIST  Formula: SLS_PRODUCT_COST = SLS_UNITS * (ITE<Truncated>',
    sls_product_margin              DECIMAL(18, 2)    COMMENT 'Sales Product Margin The gross sales product margin for this PROD_DIM_ID. View ONLY Source: OC_SALES_PROD_LOC_WK GROSS_SALES_AMT - SLS_PRODUCT_COST',
    sls_loyal_disc                  DECIMAL(16, 2)    COMMENT 'Sales Loyalty Discounts The combined Sale Loyalty Back Office Markdowns and Sale Special Back Office Markdowns. View ONLY Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    gross_sales_amt                 DECIMAL(18, 2)    COMMENT 'Gross Sales Amount Sales dollars, net of sales discounts and adjustments, in dollars / cents for this level of product. Returns are not used in this calculation. In VIEW ONLY. Source: OC_SALES_PROD_LOC_WK  SLS_MDSE_AMT + SLS_MDSE_DISC + SLS_ASSO<Truncated>',
    gross_sales_units               INT               COMMENT 'Gross Sales Units See definition of SLS_UNITS in this table. In VIEW ONLY. Source: OC_SALES_PROD_LOC_WK  SLS_UNITS',
    rtrn_mdse_amt                   DECIMAL(15, 2)    COMMENT 'Return Merchandise Amount The extended (quantity x price) line item returned amount before point-of-sale discounts are applied, except for dotcom /RDS items that are net.   The formula to calculate what the customer was credited for this item on<Truncated>',
    rtrn_adj                        DECIMAL(15, 2)    COMMENT 'Return Adjustment The return adjustment dollars tied to the original sale.  Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week. NOTE: TRANS_TYPE_CD = 1 should not be included.',
    rtrn_units                      INT               COMMENT 'Return Units The returned units tied to the original sale.  Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    rtrn_mdse_disc                  DECIMAL(15, 2)    COMMENT 'Return Merchandise Discount The original line item discount amount being reversed. The formula to calculate what the customer was credited for this item on the point-of-sale receipt is: (RTRN_MDSE_AMT + RTRN_MDSE_DISC).  Source: sum of daily OC_<Truncated>',
    rtrn_asso_disc                  DECIMAL(15, 2)    COMMENT 'Return Associate Discount The amount of employee / associate discounts applied to this returned item in the Back Office tied to an original sale.  Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    rtrn_bomd_loyal_disc            DECIMAL(15, 2)    COMMENT 'Return Back Office Markdown Loyalty Discount The returned amount of Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. New charge accounts ar<Truncated>',
    rtrn_sbomd_loyal_disc           DECIMAL(15, 2)    COMMENT 'Return Special Back Office Markdown Loyalty Discount The returned amount of Special Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. Accrua<Truncated>',
    rtrn_pos_mdse_md_amt            DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Merchandise Markdown Amount The returns merchandise markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially.  Source: sum of daily OC_SALES_PROD_LOC_DAY valu<Truncated>',
    rtrn_pos_v2c_md_amt             DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Direct Ship (Vendor to Customer) Markdown Amount The Vendor to Customer returns markdown amount, as determined by the PSD (Point of Sale Discount) system, that will be booked financially.  Source: sum of dail<Truncated>',
    rtrn_pos_loyalty_md_amt         DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Loyalty Markdown Amount The Loyalty markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially.  Source: sum of daily OC_SALES_PROD_LOC_DAY values f<Truncated>',
    rtrn_pos_tfs_md_amt             DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Thanks For Sharing Markdown Amount The Thanks For Sharing markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially.  Source: sum of daily OC_SALES<Truncated>',
    rtrn_pos_bridal_md_amt          DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Bridal Markdown Amount The Bridal Markdown amount for returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially.  Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    rtrn_pos_bomd_newacct_md_amt    DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Back Office Markdown -New Account Markdown Amount The Back Office Markdown amount on returns, as determined by the PSD (Point of Sale Discount) system, that will be booked financially.  Source: sum of daily O<Truncated>',
    rtrn_pos_mdse_mu_amt            DECIMAL(15, 2)    COMMENT 'Return Point of Sale Discount (PSD)- Merchandise Markup Amount The Merchandise MarkUp amount on sales, as determined by the PSD (Point of Sale Discount) system, that will be booked financially.  Source: sum of daily OC_SALES_PROD_LOC_DAY values <Truncated>',
    rtrn_fee_amt                    DECIMAL(15, 2)    COMMENT 'Return Fee Amount The amount of certain returned sales fees. Source: SALES_FEES. FEE_AMT LT 0. Also see OCD_FEES_BUSINESS_RULES. Note: some fee amounts from the base tables are intentionally excluded, as requested by the Divisional Accounting Office.',
    rtrn_product_cost               DECIMAL(15, 2)    COMMENT 'Return Product Cost The calculated product cost of this PROD_DIM_ID returned in this operating division. Sources: OC_SALES_PROD_LOC_DAY / CVN_FACTS_LOC_DVN_WK / ROS_FACTS_DIV_DPT_PTD_BY_WK / PROD_DIM_HIST  Formula: RTRN_PRODUCT_COST = RTRN_UNITS<Truncated>',
    rtrn_product_margin             DECIMAL(18, 2)    COMMENT 'Return Product Margin The return product margin for this PROD_DIM_ID in this financial location in this operating division. VIEW ONLY:  OC_SALES_PROD_LOC_WK:  GROSS_RETURNS_AMT - RTRN_PRODUCT_COST',
    rtrn_loyal_disc                 DECIMAL(16, 2)    COMMENT 'Return Loyalty Discount The combined Return Loyalty Back Office Markdowns and Return Special Back Office Markdowns, representing the total loyalty discounts returned. VIEW ONLY.  Source: Sum of OC_SALES_PROD_LOC_DAY values for this week.',
    gross_returns_amt               DECIMAL(15, 2)    COMMENT 'Gross Returns Amount The calculated amount of gross returns. Sales are not used in this calculation. View ONLY OC_SALES_PROD_LOC_WK   GROSS_RETURNS_AMT = RTRN_MDSE_AMT + RTRN_MDSE_DISC + RTRN_ASSO_DISC + RTRN_BOMD_LOYAL_DISC + RTRN_SBOMD_LOYAL_D<Truncated>',
    gross_returns_units             DECIMAL(18, 2)    COMMENT 'Gross Returns Units The units of gross returns. View ONLY OC_SALES_PROD_LOC_WK RTRN_UNITS',
    adj_cost_basis                  SMALLINT          COMMENT 'Adjusted Cost Basis A code that indicates the method of calculation used to determine product margin. Where: 1 = ITEM_LAST_COST value 2 = CVN default cumulative markup 3 = cumulative ROS markup percent 4 = Use keystone markup (50%)',
    congruency_flg                  VARCHAR(1)        COMMENT 'Congruency Flag A flag used to indicate whether a product is congruent in a location, based on financial credit. View ONLY Where: Y = Product is congruent in this location N = Product is not congruent in this location.',
    cs_congruency_flg               VARCHAR(1)        COMMENT 'Dotcom Fulfilled In Store Congruency Flag This value will always be a N (no) except for non-SVI CS (dotcom fulfilled in store) transactions. If there is a congruent row in the dotcom, then this flag becomes a Y. View ONLY Where: Y = Product is c<Truncated>',
    sls_promo_mkdn_amt              DECIMAL(18, 2)    COMMENT 'Sales Promotional Markdown Amount The combined amount of sale promotional markdowns. In VIEW ONLY.   Source: OC_SALES_PROD_LOC_WK:  SLS_POS_MDSE_MD_AMT + SLS_POS_V2C_MD_AMT + SLS_POS_LOYALTY_MD_AMT + SLS_POS_TFS_MD_AMT + SLS_POS_BRIDAL_MD_AMT + <Truncated>',
    rtrn_promo_mkdn_amt             DECIMAL(18, 2)    COMMENT 'Returns Promotional Markdown Amount The combined amount of return promotional markdowns. In VIEW ONLY.  Source: OC_SALES_PROD_LOC_WK:  RTRN_POS_MDSE_MD_AMT + RTRN_POS_V2C_MD_AMT + RTRN_POS_LOYALTY_MD_AMT + RTRN_POS_TFS_MD_AMT + RTRN_POS_BRIDAL_M<Truncated>',
    rplnsh_flg                      VARCHAR(1)        COMMENT 'Replenishment Flag A flag used when the UPC in a location is to be replenished. If the product is Inforem then the RPLNSH_FLG = N if the FORECAST_TYPE = X or NULL or the END_DT <> 3000-01-01.  RPLNSH_FLG = Y if the FORECAST_TYPE <> X or NULL and<Truncated>',
    rplnsh_rplcmnt_sku_flg          VARCHAR(1)        COMMENT 'Replenishment Replacment SKU Flag A flag used to indicate whether the UPC in the row is replenished. ~Where: Y = The UPC is currently being replenished.. N = The UPC is currently NOT being replenished and there are no other UPCs within the same <Truncated>',
    rplnsh_flg_src                  VARCHAR(1)        COMMENT 'Replenishment Flag Source The detail value of the RPLNSH_FLG before logic was applied.  In VIEW ONLY.  Source: OC_SALES_PROD_LOC_WK  Values are R, N, or Y.  RPLNSH_FLG',
    fil_rplnsh_flg                  VARCHAR(1)        COMMENT 'FIL Replenishment Flag A value based upon the FIL_RPLNSH_FLG_SRC. Source: OC_SALES_PROD_LOC_DAY~ IF FIL_RPLNSH_FLG = N OR R THEN N ELSE Y',
    fil_rplnsh_rplcmnt_sku_flg      VARCHAR(1)        COMMENT 'FIL Replenishment Replacement SKU Flag A flag used to represent the UPC that fulfilled the item. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ IF FIL_RPLNSH_FLG = Y OR R THEN Y ELSE N',
    fil_rplnsh_flg_src              VARCHAR(1)        COMMENT 'FIL Replenishment Flag Source The detail value of the FIL_RPLNSH_FLG before logic was applied. In VIEW ONLY. Source: OC_SALES_PROD_LOC_DAY~ FIL_RPLNSH_FLG',
    ocd_error_cd                    SMALLINT          COMMENT 'Omni Channel Dimension - Error Code The true value of the OCD code without the default logic. See the OCD_CD metadata in this table. In VIEW ONLY.  Source: OC_SALES_PROD_LOC_WK  Represents the Original Value of OCD_CD without the Default of Unta<Truncated>',
    net_sales_amt                   DECIMAL(18, 2)    COMMENT 'Net Sales Amount The net of Gross Sales and Gross Returns in dollars. In VIEW ONLY.  Source: OC_SALES_PROD_LOC_WK  GROSS_SALES_AMT + GROSS_RETURNS_AMT',
    net_sales_units                 INT               COMMENT 'Net Sales Units The net of Gross Sales and Gross Returns in units. In VIEW ONLY.  Source: OC_SALES_PROD_LOC_WK GROSS_SALES_UNITS + GROSS_RETURNS_UNITS',
    divn_nbr                        INT               COMMENT 'Division Number The division number of the LOC_DIM_ID in this row. Source: LOCN_DIM DIVN_NBR of LOC_DIM_ID',
    dept_nbr                        SMALLINT          COMMENT 'Department Number The department number of the Product Dimension Id. Source: PROD_DIM~DEPT_NBR of PROD_DIM_ID',
    week_end_dt                     STRING            COMMENT 'Week ending date The date in CCYY-MM-DD format for the fiscal week ending (a Saturday) for this row. The format for date selection is ccyy-mm-dd.',
    daas_load_id                    VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                     TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts                     TIMESTAMP         COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id                 STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Omni Channel Sales by Product Dimension, Location and Week - This table holds the sales & returns  of a Product Dimension at the location level, summarized for a given week. Financial information is  carried at dollars / cents and  units  are whole numbers.  This table was developed to help support cross divisional transfers.| Offset = greg_amc_week_end_dt | Partition Date = greg_amc_week_end_dt dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_oc_sales_prod_loc_wk_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_psd_tran_line_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_psd_tran_line_v 
--

CREATE EXTERNAL TABLE edw_mix_psd_tran_line_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID - A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_REG_LOC_DIM_ID represents the ringing location.',
    greg_date              STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate where this transaction originated in this division, location, register number, and day.',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id, on this day in this division, location, register number , transaction number, and day .',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction in the source system (RPS).',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    tl_seq_nbr             SMALLINT          COMMENT 'Original Sequence Number - The original sequence number of this line item, as assigned in the point of sale system.',
    stt_divn_nbr           INT               COMMENT 'Division Number - The operating division / company for this transaction.',
    corr_seq_nbr           SMALLINT          COMMENT 'Corrected Sequence Number - Purpose is unknown.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number Where Rung - The store number for this row indicating where the sales was rung. In legacy format.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Store to Receive Credit - The store number to receive credit for this transaction. In legacy format.',
    stt_loc_dim_id         INT               COMMENT 'Store Register Transaction and Location Dimension id - A dimension of STT and LOC_DIM_ID.',
    loc_dim_id             INT               COMMENT 'Location Dimension Id - A dimension of the LOC_ID.',
    divn_nbr               INT               COMMENT 'Division Number - The operating division / company for this transaction.',
    zl_store_nbr           INT               COMMENT 'Legacy Store Number - The store number where the transaction originated. Will receive credit for the sale, unless overriden by CR_ZL_STORE_NBR. In legacy format.',
    cr_zl_store_nbr        INT               COMMENT 'Store Number to Receive Credit - If other than zero, this is the store number to receive credit for this transaction. In legacy format.',
    central_cd             VARCHAR(1)        COMMENT 'Central Code - Not populated.',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.',
    prod_dim_id            DECIMAL(18, 0)    COMMENT 'Product Dimension Id - The PROD_DIM_ID is an 18 digit number created from the timestamp when the PROD_DIM row was created, it uniquely identifies each product in each division of the company.',
    dept_nbr               SMALLINT          COMMENT 'Department Number - The department number for this UPC at the time of the sale transaction.',
    vnd_numeric_desc       SMALLINT          COMMENT 'Vendor Number - The vendor number for this UPC at the time of the sale transaction',
    mkst                   INT               COMMENT 'Markstyle Number - A number used to identify a product within a department / vendor within an operating division.',
    clr_nbr                SMALLINT          COMMENT 'Color Number - A number used to identify color within a department / vendor / markstyle, within an operating division.',
    sz_nbr                 SMALLINT          COMMENT 'Size Number - A number used to identify size within a department / vendor / markstyle / color.',
    sku_upc_nbr            DECIMAL(18, 0)    COMMENT 'SKU or UPC Number - A 12 to 13-digit number that a manufacturer assigned to each color and size. A UPC (or GTIN) represents a single color and size combination of an item. Also known as the ''short sku''.',
    zl_class_nbr           SMALLINT          COMMENT 'Legacy Class Number - The class number assigned to this department for this UPC.',
    owned_retail           DECIMAL(9, 2)     COMMENT 'Owned Retail - The current owned retail price for this item.',
    item_1st_own_rtl       DECIMAL(9, 2)     COMMENT 'Item First Owned Retail - The first owned retail price for this item.',
    discount_amt           DECIMAL(9, 2)     COMMENT 'Discount Amount - The calculated amount of discount to be applied as a markdown, markup, or cancellation.',
    selling_price_amt      DECIMAL(9, 2)     COMMENT 'Selling Price Amount - The price the customer paid for this item, before any back office discounts.',
    pos_status             SMALLINT          COMMENT 'Point Of Sale Status - A number indicating markdown status.',
    upc_qty                INT               COMMENT 'UPC Quantity - Represents the number of units of this specific UPC on this row.',
    disc_calc_type_cd      SMALLINT          COMMENT 'Discount Calculation Type Code - A numeric code used to identify the base price used to calculate discount.',
    sale_rtn_cd            SMALLINT          COMMENT 'Sale or Return Code - A numeric code used to identify whether a row represents a sale or return.',
    stk_pc_type_cd         SMALLINT          COMMENT 'Stock Price Change Type Code - A numeric code used to identify the type of price change.',
    basic_stock_flg        VARCHAR(1)        COMMENT 'Basic Stock Flag - A flag used to indicate UPC''s that are on the Basics Replenishment system.',
    pc_category_type_cd    VARCHAR(1)        COMMENT 'Price Change Category Type Code - An alphanumeric code applied to this price change to indicate the category of price change.',
    batch_set_nbr          INT               COMMENT 'Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW.',
    last_upd_nbr           INT               COMMENT 'Last Update Number - The last date / time a row was updated.',
    source_purge_flg       VARCHAR(1)        COMMENT 'Source Purge Flag - Originally intended to mean the row had been purged from the source (DB2 PSD now).',
    load_2b_nbr            INT               COMMENT 'Load To Base Number - A numeric cross-reference to the exact time the base table was updated.',
    pcs_trans_nbr          INT               COMMENT 'Price Change System Transaction Number - A Price Change transaction number that matches the point-of-sale TRANS_NBR, up to 4 digits.',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Update User Id - The user id or program that last updated a row, used for auditing.',
    pcs_version_nbr        SMALLINT          COMMENT 'Price Change System Version Number - The version number applied to this row by the Price Change System.',
    pcs_run_cntl_u         SMALLINT          COMMENT 'Price Change System Run Control - Unaudited - Price Change System Run Control Indicator - Unaudited data',
    pcs_run_cntl_a         SMALLINT          COMMENT 'Price Change System Run Control - Audited - Price Change System Run Control Indicator - Audited data',
    amc_book_week          INT               COMMENT 'Fiscal (AMC) Book Week - The fiscal accounting year, period, and week pertaining to this row.',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag - A flag applied by EDW to indicate whether the row will be purged.',
    year                   INT               COMMENT 'Year Number',
    month                  INT               COMMENT 'Month Number',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_upd_ts            TIMESTAMP         COMMENT 'Timestamp that the record is last updated by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Point of Sale Discounts - Transaction Line - This fact table provides detail Price Change markdown / markup / cancellation information at the UPC and product dimension level. This includes references back to its header''s date, division, store, register, and transaction level for point-of-sale and Back Office transactions that involved a markdown, markup, and cancellations. The MERCH_AMT (what the customer paid) of all sale/return transactions is compared to the owned retail. When different , this detail record is created. NOTE: all versions of a transaction are in this table.|Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, tl_seq_nbr, corr_seq_nbr|Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_psd_tran_line_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_psd_tran_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_psd_tran_v 
--

CREATE EXTERNAL TABLE edw_mix_psd_tran_v(
    stt_reg_loc_dim_id     INT            COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID.',
    greg_date              STRING         COMMENT 'Gregorian Date The date the transaction was billed to the customer. The format for date selection is ccyy-mm-dd.',
    register_nbr           SMALLINT       COMMENT 'Register Number A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate where this transaction originated in this division, location, register number, and day. Reg<Truncated>',
    trans_nbr              INT            COMMENT 'Transaction Number A unique number assigned to this transaction from this POS or back office reserved id, on this day in this division, location, register number , transaction number, and day .',
    version_nbr            SMALLINT       COMMENT 'Version Number The initial or decremented version number assigned to this transaction. The initial version number is 99. It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.). NOTE: all versions of a transaction are in this table.',
    version_adj_nbr        SMALLINT       COMMENT 'Version Adjusted Number A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)     COMMENT 'Action Flag A code assigned to indicate whether the transaction required Sales Audit intervention.',
    void_type_cd           VARCHAR(1)     COMMENT 'Void Type Code An alphanumeric code used to identify different types of voids. To view all, refer to VOID_TYPE_V.',
    trans_type_cd          SMALLINT       COMMENT 'Transaction Type Code RPS transaction type, the identifying code or description of the transaction, as defined by the company. Where:  1 = Sales adjustment  3 = Sale  4 = Send  21 = Return Adjustment  33 = Exchange / Return  Valid transaction ty<Truncated>',
    stt_divn_nbr           INT            COMMENT 'Division Number The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT            COMMENT 'Store Number Where Rung The store number for this row indicating where the sales was rung. In legacy format.',
    stt_loc_dim_id         INT            COMMENT 'A dimension of STT and LOC_DIM_ID. A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physical lo<Truncated>',
    stt_cr_zl_store_nbr    INT            COMMENT 'Store to Receive Credit The store number to receive credit for this transaction. In legacy format.',
    src_nbr                SMALLINT       COMMENT 'Source Number A code assigned to indicate the source system of the data. Valid source number values may be viewed on the table SOURCE_SYSTEM_V.',
    ring_spsn_nbr          INT            COMMENT 'Ringing Salesperson Number The id of the salesperson ringing this transaction.',
    audit_flg              VARCHAR(1)     COMMENT 'Audit Flag A flag used to indicate a sales or return adjustment, such as Back Office Markdowns. Where:  2 = Adjustment',
    batch_set_nbr          INT            COMMENT 'Batch Set Number A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for PRICE CHANGES is DWQ.',
    last_upd_nbr           INT            COMMENT 'Last Update Number The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT            COMMENT 'Load To Base Number A numeric cross-reference to the exact time the base table was updated. The value is zero unless a manual fix occurred. Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent. The subject are<Truncated>',
    last_upd_user_id       VARCHAR(12)    COMMENT 'Last Update User Id The user id or program that last updated a row, used for auditing. If added manually, the value will be the initials and associate number of the person who added it.',
    purge_flg              VARCHAR(1)     COMMENT 'Purge Flag A flag applied by EDW to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    daas_load_id           VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Point of Sale Discounts -  Transaction Header - This fact table provides Price Change header information  at the date, division, store, register, and transaction level for point-of-sale and Back Office transactions that involved a markdown, markup, and cancellations. The MERCH_AMT (what the customer paid) of all sale/return transactions is compared to the owned retail.  When different , this header is created.   NOTE:  all versions of a transaction are in this table.|Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg|Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_psd_tran_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_return_trans_line_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_return_trans_line_v 
--

CREATE EXTERNAL TABLE edw_mix_return_trans_line_v(
    stt_reg_loc_dim_id         INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location. The intersection where prod<Truncated>',
    greg_date                  STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer. The format for date selection is  ccyy-mm-dd.',
    register_nbr               INT               COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr                  INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location and register number.',
    version_nbr                SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99.  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr            SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg              VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    sales_ret_seq_nbr          SMALLINT          COMMENT 'Transaction Line Sequence Number - A number used to identify the detail sequence of this line item, within this return transaction. Assigned by the RPS source system.',
    stt_divn_nbr               INT               COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr           INT               COMMENT 'Store Number - The store number for this row indicating where the return was rung.',
    stt_cr_zl_store_nbr        INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id             INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    loc_dim_id                 INT               COMMENT 'Location Dimension Identification number - The ID number assigned to the location in the EDW Location Dimension.  Reference the LOCN_DIM table.',
    divn_nbr                   INT               COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    zl_store_nbr               INT               COMMENT 'Legacy Store Number - The store number for this row indicating where the sales was rung.',
    cr_zl_store_nbr            INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    central_cd                 VARCHAR(1)        COMMENT 'Central Code - Not populated. Do not use.',
    prod_dim_id                DECIMAL(18, 0)    COMMENT 'Product Dimension Identification number - The PROD_DIM_ID is an 18 digit number created from the timestamp when the  PROD_DIM row was created, it uniquely identifies each product in each division of the company.  Multiple SKU_UPC_NBRs can and do<Truncated>',
    current_ind                SMALLINT          COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0) This is automatically provided w<Truncated>',
    orig_stt_divn_nbr          INT               COMMENT 'Original Division Number - The division number of the original sale transaction. Cross division returns (e.g. an original  BLM purchase returned at BOS) are not captured.  This DIVN_NBR is in LOCN format.',
    orig_stt_zl_store_nbr      INT               COMMENT 'Original Store Terminal Transaction Legacy Store Number',
    orig_greg_date             STRING            COMMENT 'Original Gregorian Date - The financial date of the original sale transaction. The format for date selection is  ccyy-mm-dd.',
    orig_stt_reg_loc_dim_id    INT               COMMENT 'Original Store Terminal Transaction Register Location Dimension ID',
    orig_register_nbr          INT               COMMENT 'Original Register Number - The register number of the original sale transaction. Register numbers may be duplicated between locations and divisions.',
    orig_trans_nbr             INT               COMMENT 'Original Transaction Number - The transaction number of the original sale transaction.',
    orig_sales_tl_seq_nbr      SMALLINT          COMMENT 'Original Sequence Number of the Sale transaction - The number assigned in the original sale to identify the original detail sequence of the sale line item row, now being returned.   This data is not always accurate.',
    orig_ring_spsn_nbr         INT               COMMENT 'Original Ringing Salesperson Number - The salesperson who rang up the original sale. Sourced from the RPS RPE record type 50, subtype 7 and the RPE50-DOCUMENT-NUM field.',
    orig_loc_flg               VARCHAR(1)        COMMENT 'Original Location Flag - Not used. Default is blank.',
    src_nbr                    SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table SOURCE_SYSTEM_V.',
    upc_qty                    INT               COMMENT 'UPC Quantity - Represents the number of units of this specific UPC returned on this transaction.    Expressed as a negative whole number.',
    merch_amt                  DECIMAL(11, 2)    COMMENT 'Merchandise Amount - The merchandise amount for a row that may be before or net of  point-of-sale discounts.  The amount  is always before any back office discounts are applied.',
    return_reason_cd           SMALLINT          COMMENT 'Return Reason Code - Not used. Defaults to 99.  Reasons listed in the RETURN_REASON table are not actively used in the business.',
    batch_set_nbr              INT               COMMENT 'EDW Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr                INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr               INT               COMMENT 'Last Updated Number - The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr                INT               COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id           VARCHAR(12)       COMMENT 'Last Updated User Id - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    zl_class_nbr               SMALLINT          COMMENT 'Class Number - The merchandise class number for this UPC at the time of the sale transaction.',
    dept_nbr                   SMALLINT          COMMENT 'Department Number - The department number for this UPC at the time of the sale transaction.',
    vnd_numeric_desc           SMALLINT          COMMENT 'Vendor Number - The vendor number for this UPC at the time of the sale transaction',
    sku_upc_nbr                DECIMAL(18, 0)    COMMENT 'UPC Number - A 12 to 13-digit number that a manufacturer assigned to each color and size. A UPC (or GTIN) represents a single color and size combination of an item.  Also known as the short sku. Sourced as a vendor UPC, an In-House UPC, or an RDS SKU.',
    mkst                       INT               COMMENT 'Markstyle - A number used to identify a markstyle within a department / vendor.',
    clr_nbr                    SMALLINT          COMMENT 'Color Number - A number used to identify color within a department / vendor / markstyle.',
    sz_nbr                     SMALLINT          COMMENT 'Size Number - A number used to identify size within a department / vendor / markstyle / color.',
    trans_type_cd              SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.  Valid transaction type codes may be viewed on the table TRANS_TYPE_V. A value of 33 represents the return portion f<Truncated>',
    register_id                VARCHAR(2)        COMMENT 'Register Identification - A value applied to a sales transaction to indicate its origin.  Common values include: SP = SmartPOS FP = Pre-Sell  FF = FedFIL transactions will no longer use this code if processed through the central server. Valid re<Truncated>',
    pos_status                 SMALLINT          COMMENT 'Point-of-Sale status - Do not use Inactive - defaults to zero',
    promo_price_flg            VARCHAR(1)        COMMENT 'Promotional Price Flag - Do not use Inactive - defaults to blank',
    commssn_spsn_nbr           INT               COMMENT 'Commission Salesperson Number When this value is different from the RING_SPSN_NBR value, this is the identifying employee number of the salesperson earning commission on the sale.',
    purge_flg                  VARCHAR(1)        COMMENT 'Purge Flag - A flag applied by EDW  to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    ocd_cd                     SMALLINT          COMMENT 'Omni Channel Dimension Code - A number assigned to each item returned to identify how the customer returned the merchandise and how the merchandise was fulfilled, such as exchanges.   Note:  except coincidentally, this number will not be the sam<Truncated>',
    pos_seq_nbr                SMALLINT          COMMENT 'Point-of-Sale (POS) Sequence Number - A sequential number assigned to a sale or return merchandise line item amount in a transaction.  Values will not be in sequential order, except coincidentally.',
    orig_pos_seq_nbr           SMALLINT          COMMENT 'ORIGINAL Point-of-Sale (POS) Sequence Number - The sequential number (POS_SEQ_NBR) originally assigned to a sale merchandise or gift card line item amount in a transaction.  Only recorded when an item is returned.',
    acct_loc_dim_id            INT               COMMENT 'Accounting Store Number - LOCN - The financial location in LOCN format, to receive credit for the sale. VIEW ONLY.  This column is only available in the view.  Not in the base table.',
    locn_nbr                   INT               COMMENT 'Store number in LOCN format  - Store Number in LOCN format VIEW ONLY.   This column is only available in the view.  Not in the base table. Provided for Sales table joins only.  Do not use this LOCN_NBR to join to LOCN_DIM',
    daas_load_id               VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts                TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id            STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'A fact table used to provide the detail return line item information within a financial return, or the return portion of a  financial exchange transaction. The RPS RPE05 record with a negative amount  is the source of this information.| Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_return_trans_line_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_fees_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_fees_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_fees_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location.',
    greg_date              STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer. The format for date selection is  ccyy-mm-dd.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location, register number , transaction number, and day.',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99.  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    fee_seq_nbr            SMALLINT          COMMENT 'Fee Sequence Number - A number used to identify the detail sequence of the fee amount row, within this transaction. Assigned by the RPS source system',
    stt_divn_nbr           INT               COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number - The store number for this row indicating where the sale or return was rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table SOURCE_SYSTEM_V.',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.  Valid transaction type codes may be viewed on the table TRANS_TYPE_V.',
    register_id            VARCHAR(2)        COMMENT 'Register Identification - A value applied to a sales transaction to indicate its origin.  Common values include: SP = SmartPOS FP = Pre-Sell  FF = FedFIL transactions will no longer use this code if processed through the central server. Valid re<Truncated>',
    current_ind            SMALLINT          COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0).  Use of the View (_V) tables wi<Truncated>',
    batch_set_nbr          INT               COMMENT 'EDW Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS',
    trickle_nbr            INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr           INT               COMMENT 'Last Updated Number - A system generated number or associate RACF id that can be cross-referenced to the date / time a row was last updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User Id - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    rec_type_cd            SMALLINT          COMMENT 'Record Type Code - A code used to identify the detail record type for fees  in the RPS source system. Value is 08.',
    sub_type_cd            SMALLINT          COMMENT 'Sub Type Code - A sub-code used to identify the  fee as determined by General Accounting.  The source is the RPS detail field, RPE08-FEE-TYPE.  Known values are:  1 = Standard delivery 2 = Cosmetics delivery  2 = Furniture delivery  4 = Next Day<Truncated>',
    fee_amt                DECIMAL(11, 2)    COMMENT 'Fee Amount - The amount of delivery and/or other fees.  May be zero. Additional tables must be utilized to achieve a comprehensive analysis of fees.',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag - A flag applied by EDW  to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Sales Fees - A fact table of fees, such as send delivery and  gift wrap, on a transaction.  This table  includes financial sales and exchange transactions with refunded fees.| Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, fee_seq_nbr|Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy
'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_fees_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_info_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_info_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_info_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location. The intersection where prod<Truncated>',
    greg_date              STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer. The format for date selection is  ccyy-mm-dd.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location, register number , transaction number, and day .',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99.  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    info_seq_nbr           SMALLINT          COMMENT 'Information Sequence Number - The position of this information in the original salescheck.   This is the position of the RPE90 subtype 26 record in the RPS source record.',
    stt_divn_nbr           INT               COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number - The store number for this row indicating where the sale was rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table  .SOURCE_SYSTEM_V.',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.  Valid transaction type codes may be viewed on the table TRANS_TYPE_V.',
    register_id            VARCHAR(2)        COMMENT 'Register Id - A value applied to a sales transaction to indicate its origin.  Common values include: SP = SmartPOS FP = Pre-Sell  FF = FedFIL transactions will no longer use this code if processed through the central server. Valid register ID co<Truncated>',
    current_ind            SMALLINT          COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0).  Use of the View (_V) tables wi<Truncated>',
    batch_set_nbr          INT               COMMENT 'Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr            INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr           INT               COMMENT 'Last Update number - The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User ID - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    document_nbr           DECIMAL(18, 0)    COMMENT 'Document Number - The Rewards Card id  number. Source:  RPE 90 / subtype 26 record passed by XRPS800.  RPE90-REWARD-CARD-NUM.',
    effective_dt           STRING            COMMENT 'Effective Date - The Rewards Card Earn Start Date.  This is the first day of the program when a customer begins to earn Rewards Gift Cards CCYY-MM-DD format. Source:  RPE 90 / subtype 26 record passed by XRPS800. RPE90-REWARD-EARN-START-DATE.',
    event_cd               VARCHAR(6)        COMMENT 'Event Code - Not used.',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag  - A flag applied by EDW  to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    rec_type_cd            SMALLINT          COMMENT 'Record Type Code - The Gift Type Code. XRPS800 will provide 12, the code for gift cards.',
    sub_type_cd            SMALLINT          COMMENT 'Sub Type Code - The Rewards Card Type Code. Where: 1 = Macys Money 2 = b-money XRPS800 will provide these values based on the issuing division id.',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Sales Information - This table is inactive. | Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, info_seq_nbr| Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy
'
PARTITIONED BY( daas_part_dt VARCHAR(10) COMMENT 'Date used for partitioning in the format of YYYY-MM')
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_info_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_line_disc_barcd_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_line_disc_barcd_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_line_disc_barcd_v(
    stt_reg_loc_dim_id     INT            COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location.',
    greg_date              STRING         COMMENT 'Gregorian Date - The date the transaction was billed to the customer. The format for date selection is  ccyy-mm-dd.',
    register_nbr           SMALLINT       COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr              INT            COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location, register number , transaction number, and day .',
    version_nbr            SMALLINT       COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99.  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr        SMALLINT       COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)     COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    sales_tl_seq_nbr       SMALLINT       COMMENT 'Transaction Line Sequence Number - A number used to identify the sequence of the merchandise line item row, within this transaction.  It is this sequence number to which the  primary / secondary bar codes are applied.  Assigned by the RPS source<Truncated>',
    seq_nbr                SMALLINT       COMMENT 'Sequence Number - A number assigned to identify the original detail sequence of this discount line item row, within this transaction in the RPS source system. Sourced from the RPS RPE21 discount line item, assigned by the RPS source system.',
    line_bar_seq_nbr       SMALLINT       COMMENT 'Line Bar Sequence Number - A number assigned to identify the original detail sequence of this coupon and Shop Kick  line item row, within this transaction in the RPS source system. Sourced from the RPS RPE90 subtype 91 coupon and Shop Kick line <Truncated>',
    stt_divn_nbr           INT            COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT            COMMENT 'Store Number - The store number for this row indicating where the sale or return was rung.',
    stt_cr_zl_store_nbr    INT            COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT            COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    src_nbr                SMALLINT       COMMENT 'Source Number - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table SOURCE_SYSTEM_V.',
    trans_type_cd          SMALLINT       COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.  Valid transaction type codes may be viewed on the table TRANS_TYPE_V.',
    register_id            VARCHAR(2)     COMMENT 'Register Identification - A value applied to a sales transaction to indicate its origin.  Common values include: SP = SmartPOS FP = Pre-Sell  FF = FedFIL transactions will no longer use this code if processed through the central server. Valid re<Truncated>',
    current_ind            SMALLINT       COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0).  Use of the View (_V) tables wi<Truncated>',
    batch_set_nbr          INT            COMMENT 'EDW Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr            INT            COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr           INT            COMMENT 'Last Updated Number - A system generated number or associate RACF id that can be cross-referenced to the date / time a row was last updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT            COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id       VARCHAR(12)    COMMENT 'Last Updated User Id - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    sub_type_cd            SMALLINT       COMMENT 'Sub Type Code - The number 91, assigned by the Register Processing System (RPS) for as a sub-type for transaction type 90 detail.  Used for alphanumeric information. Sourced from RPE01-TYPE  of 90.',
    rec_type_cd            SMALLINT       COMMENT 'Record Type Code - The number 90, assigned by the Register Processing System (RPS) for transaction file detail.  Used for alphanumeric information. Sourced from RPE01-TYPE  of 90.',
    primary_bar_cd         VARCHAR(30)    COMMENT 'Primary Bar Code - This column reflects the promotional coupon or bar code applied in the transaction.   Sourced from RPE record type 90, subtype 91, and the RPE90-ALPHA field.',
    secondary_bar_cd       VARCHAR(30)    COMMENT 'Secondary Promotional Information - The  number of the secondary promotional  bar code used at point-of-sale, or the name of a promotional event, such as FRIEND for Friends & Family).   May identify a Shop Kick item.  This column is not always p<Truncated>',
    purge_flg              VARCHAR(1)     COMMENT 'Purge Flag - A flag applied by EDW  to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    daas_load_id           VARCHAR(36)    COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP      COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING         COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Sales Line Discount Barcodes - This table provides coupon bar codes and the associated Shop Kick information for discounts applied at the line item level on sale transactions and the sale portion of an exchange only. Sourced from RPS RPE 05, 21, and 90 subtype-91 records.   Coupon bar codes on returns  are not on this table. | Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr ,trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, sales_tl_seq_nbr ,seq_nbr ,line_bar_seq_nbr| Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_line_disc_barcd_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_line_plu_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_line_plu_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_line_plu_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location. The intersection where prod<Truncated>',
    greg_date              STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer. The format for date selection is  ccyy-mm-dd.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location, register number , transaction number, and day .',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99.  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    sales_tl_seq_nbr       SMALLINT          COMMENT 'Transaction Line Sequence Number - A number assigned to identify the detail sequence of the merchandise line item row, within this transaction. Assigned by the RPS source system to the 05 detail record.',
    line_plu_seq_nbr       SMALLINT          COMMENT 'Line Sequence Number - A number assigned to identify the  detail sequence of the price override  row, within this transaction. Typically, the value of this number is one greater than the SALES_TL_SEQ_NBR that it pertains to.  It is assigned by t<Truncated>',
    stt_divn_nbr           INT               COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number - The store number for this row indicating where the sale was rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table  .SOURCE_SYSTEM_V.',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.  Valid transaction type codes may be viewed on the table TRANS_TYPE_V.',
    register_id            VARCHAR(2)        COMMENT 'Register Id - A value applied to a sales transaction to indicate its origin.  Common values include: SP = SmartPOS FP = Pre-Sell  FF = FedFIL transactions will no longer use this code if processed through the central server. Valid register ID co<Truncated>',
    current_ind            SMALLINT          COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0).  Use of the View (_V) tables wi<Truncated>',
    batch_set_nbr          INT               COMMENT 'Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr            INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr           INT               COMMENT 'Last Update number - The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User ID - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    plu_type_cd            SMALLINT          COMMENT 'Price Lookup Override Type Code - A number assigned to identify the type of price lookup override. Where: 9 = Presale 45 = Zero price that prompted for price 2 = everything that wasnt a 9 or 45 (e.g. Price Overrides by Salesperson)',
    plu_sub_type_cd        SMALLINT          COMMENT 'Price Lookup Sub-type Code - N/A Not provided in the RPS source system.',
    ticketed_retail        DECIMAL(11, 2)    COMMENT 'Ticketed Retail - PLU price of the item.',
    document_nbr           DECIMAL(18, 0)    COMMENT 'Document Number - Not populated in the RPS source system.',
    mpgroup_nbr            INT               COMMENT 'Merchandise Pricing Group Number - A number identifying a unique pricing group or deal. Not provided in the RPS source system.',
    xpanded_reason_cd      INT               COMMENT 'Expanded Reason Code - Not used.',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag - A flag applied by EDW  to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Sales Line Price Look Up Overrides - This table provides price lookup override information, such as Buy One / Get One Free. Sourced from RPS RPE 51 records  (only from SmartPOS, not RDS or FEDFIL). The RPE51 record is created at an item level. This record is created when SmartPOS turns on a flag that is described as override key used - set when ticket price is altered via price change.This is when the sales associate hits a key to do a price override. Note: The final price is in the SALES_TRAN_LINE_V and TRANS_LINE_DISCOUNT tables. | Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, sales_tl_seq_nbr, line_plu_seq_nbr| Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_line_plu_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_prod_loc_day_trans_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_prod_loc_day_trans_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_prod_loc_day_trans_v(
    stt_reg_loc_dim_id       INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID. For more information A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_REG_LOC_DIM_ID represents the ringing location. The interse<Truncated>',
    register_nbr             SMALLINT          COMMENT 'Register Number A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate where this transaction originated in this division, location, register number, and day. Reg<Truncated>',
    trans_nbr                INT               COMMENT 'Transaction Number A unique number assigned to this transaction from this POS or back office reserved id, on this day in this division, location, register number , transaction number, and day .',
    prod_dim_id              DECIMAL(18, 0)    COMMENT 'Product Dimension Identifier - An ID number in the EDW Product Dimension that uniquely identifies each product (UPC, style/color/size and style) in each division of Macys Inc..',
    stt_divn_nbr             INT               COMMENT 'Division Number The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr         INT               COMMENT 'Store Number Where Rung The store number for this row indicating where the sales was rung. In legacy format.',
    stt_cr_zl_store_nbr      INT               COMMENT 'Store to Receive Credit The store number to receive credit for this transaction. In legacy format.',
    stt_loc_dim_id           INT               COMMENT 'Store Register Transaction and Location Dimension id - A dimension of STT and LOC_DIM_ID.',
    loc_dim_id               INT               COMMENT 'Location Dimension Identifier - The ID number assigned to the location in the EDW Location Dimension.',
    divn_nbr                 INT               COMMENT 'The LOCN division number',
    zl_store_nbr             INT               COMMENT 'Store Number - The location in the division where the UPC is located.',
    cr_zl_store_nbr          INT               COMMENT 'Store Number to Receive Credit - If other than zero, this is the store number to receive credit for this transaction. In legacy format.',
    dept_nbr                 SMALLINT          COMMENT 'Department Number The department number to which this Product is assigned. Source: PROD_DIM Note: as Was',
    sls_mdse_amt             DECIMAL(12, 2)    COMMENT 'Sales Merchandise Amount The extended (quantity x price) line item sold amount before point-of-sale discounts are applied, except for dotcom / RDS items that are net. 
The formula to calculate what the customer paid for this item on the point-of<Truncated>',
    sls_mdse_disc            DECIMAL(12, 2)    COMMENT 'Sales Merchandise Discount The amount of sale discounts taken at point of sale for this level of product. Not all such discounts are sourced to EDW. Source: TRANS_LINE_DISCOUNT DISCOUNT_AMT for TRANS_TYPE_CD in (3,4,33) and DISCOUNT_TYPE_CD < 90',
    sls_asso_disc            DECIMAL(12, 2)    COMMENT 'Sales Associate Discount The amount of employee / associate discounts applied to this item in the Back Office. Source: TRANS_LINE_DISCOUNT~DISCOUNT_AMT for TRANS_TYPE_CD in (3,4,5,33,35) and DISCOUNT_TYPE_CD in (90,93) and DISCOUNT_AMT LT 0. Not<Truncated>',
    sls_bomd_loyal_disc      DECIMAL(12, 2)    COMMENT 'Sales Back Office Markdowns Loyalty Discount The amount of Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product. Source: TRANS_LINE_DISCOUNT DISCOUNT_AMT for TRANS_TYPE_<Truncated>',
    sls_sbomd_loyal_disc     DECIMAL(12, 2)    COMMENT 'Sales Special Back Office Markdowns Loyalty Discount The amount of Special Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product. Source: TRANS_LINE_DISCOUNT DISCOUNT_AMT<Truncated>',
    sls_adj                  DECIMAL(12, 2)    COMMENT 'Sales Adjustments The dollar amount of sales adjustments for this level of product. Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week. NOTE: TRANS_TYPE_CD = 21 is included and should not be.',
    sls_units                INT               COMMENT 'Sales Units The units sold at this level of product. This is a whole number. Source: SALES_TRAN_LINE UPC_QTY for TRANS_TYPE_CD in (3,4,33)',
    rtrn_mdse_amt            DECIMAL(12, 2)    COMMENT 'Return Merchandise Amount The extended (quantity x price) line item returned amount before point-of-sale discounts are applied, except for dotcom /RDS items that are net. The formula to calculate what the customer was credited for this item on t<Truncated>',
    rtrn_mdse_disc           DECIMAL(12, 2)    COMMENT 'Return Merchandise Discount The original line item discount amount being reversed. The formula to calculate what the customer was credited for this item on the point-of-sale receipt is: (RTRN_MDSE_AMT + RTRN_MDSE_DISC). SOURCE: TRANS_LINE_DISCOU<Truncated>',
    rtrn_asso_disc           DECIMAL(12, 2)    COMMENT 'Return Associate Discount The amount of returned associate (employee) discount in dollars / cents. Source: TRANS_LINE_DISCOUNT DISCOUNT_AMT for TRANS_TYPE_CD in (3,4,33) and DISCOUNT_TYPE_CD in (90,93)',
    rtrn_bomd_loyal_disc     DECIMAL(12, 2)    COMMENT 'Return Back Office Markdown Loyalty Discount The returned amount of Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. New charge accounts ar<Truncated>',
    rtrn_sbomd_loyal_disc    DECIMAL(12, 2)    COMMENT 'Return Special Back Office Markdown Loyalty Discount The returned amount of Special Back Office Markdown Loyalty Discounts as calculated by the back office systems, in dollars and cents, for this level of product tied to an original sale. Accrua<Truncated>',
    rtrn_adj                 DECIMAL(12, 2)    COMMENT 'Returns Adjustment The dollar amount of return adjustments for this level of product. Source: RETURN_TRANS_LINE  MERCH_AMT for TRANS_TYPE_CD in (1,21)',
    rtrn_units               INT               COMMENT 'Return Units The units returned for this level of product. This is a whole number. Source: RETURN_TRANS_LINE UPC_QTY for TRANS_TYPE_CD in (3,4,33)',
    item_last_cost           DECIMAL(9, 2)     COMMENT 'Item Last Cost The items most recent cost.',
    last_upd_nbr             INT               COMMENT 'Last Updated Number - The last date / time a row was updated. The value is zero unless the row was updated.',
    register_id              VARCHAR(2)        COMMENT 'Register Identification - A value applied to a sales transaction to indicate it''s origin. Common values include:
SP = SmartPOS
FP = Pre-Sell
FF = FedFIL transactions will no longer use this code if processed through the central server.',
    acct_loc_dim_id          INT               COMMENT 'Accounting Store Number - LOCN The financial location in LOCN format, to receive credit for the sale. This column is only available in the view. Not in the base table.',
    sls_loyal_disc           DECIMAL(13, 2)    COMMENT 'Sales Loyalty Discounts The combined Sale Loyalty Back Office Markdowns and Sale Special Back Office Markdowns. View ONLY
Source: sum of daily OC_SALES_PROD_LOC_DAY values for this week.',
    rtrn_loyal_disc          DECIMAL(13, 2)    COMMENT 'Return Loyalty Discount The combined Return Loyalty Back Office Markdowns and Return Special Back Office Markdowns, representing the total loyalty discounts returned. VIEW ONLY. 
Source: Sum of OC_SALES_PROD_LOC_DAY values for this week.',
    net_sales                DECIMAL(18, 2)    COMMENT 'Net Sales',
    net_units                INT               COMMENT 'Net Units',
    greg_date                STRING            COMMENT 'Gregorian Transaction Date The financial business date of this row. The format for date selection is ccyy-mm-dd.',
    daas_load_id             VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts              TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id          STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Sales Summarized by Product by Location by Day and Transaction | Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_prod_loc_day_trans_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_rewards_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_rewards_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_rewards_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID. - A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_REG_LOC_DIM_ID represents the ringing location.',
    greg_date              STRING            COMMENT 'Greg Date - The date Macys Money /b-money was issued to the customer.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS_physical terminal ID on the selling floor, or to a Back Office reserved ID, to indicate where this transaction originated in this division, location, register number, and day.',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id, on this day in this division, location, register number, transaction number, and day.',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction.',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          STRING            COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    seq_nbr                SMALLINT          COMMENT 'Sequence Number - A number assigned by RPS to indicate the placement of this information within the sale or return transaction.',
    stt_divn_nbr           INT               COMMENT 'Division Number - The division number for this row indicating where the transaction was rung.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number - The store number for this row indicating where the sales were rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Credit to Store Number - The central ring location number, this indicates what location gets the sale/return credit. If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID. - A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physical <Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.',
    register_id            VARCHAR(2)        COMMENT 'Register Id - A value applied to a sales transaction to indicate its origin.',
    current_ind            SMALLINT          COMMENT 'Current Indicator - A value applied to a sales transaction to indicate its status, used primarily to build views.',
    reward_card_nbr        BIGINT            COMMENT 'Reward Card Number - The reward card number issued in this transaction.',
    reward_card_value      DECIMAL(11, 2)    COMMENT 'Reward Card Value - The value of the reward card.',
    earn_start_date        STRING            COMMENT 'Earn Start date - The first day to shop and earn.',
    earn_end_date          STRING            COMMENT 'Earn End date - The last day to shop and earn.',
    redeem_start_date      STRING            COMMENT 'Redeem Start Date - The first day to redeem the reward card.',
    redeem_end_date        STRING            COMMENT 'Redeem End Date - The last day to redeem the reward card.',
    rec_type_cd            SMALLINT          COMMENT 'Record Type Code - The RPS detail transaction type that contains this information.',
    sub_type_cd            SMALLINT          COMMENT 'Sub Type Code - The RPS sub-transaction type that contains this information within the REC_TYPE_CD.',
    batch_set_nbr          INT               COMMENT 'Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that first updated this row in the EDW.',
    trickle_nbr            INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as to the date and time when the EDW last subscribed to Sales data on the mainframe.',
    last_upd_nbr           INT               COMMENT 'Last Updated Number - A system generated number or associate RACF ID that can be cross-referenced to that date/time a row was last updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number - A numeric cross-reference to the exact time the base table was updated.',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User Id - The user ID or program that last updated a row, used for auditing.',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag - A value applied to a row to indicate whether the row is to be purged.',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Sales Rewards - This table provides detailed information about the rewards cards issued by financial transactions in a promotional program. Applies to both Macys (Macys Money) and Bloomingdales (b-money) issuances from financial transaction types such as 3, 4, and 33 (sale portion). Redemption information is carried in the TENDER table. Information about virtual rewards cards issued by the dotcoms is currently not sourced to RPS and therefore is unavailable in EDW. Dotcom redemptions of their own virtual reward cards are in the TENDER tale. | Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy
'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_rewards_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_fil_resv_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_tran_fil_resv_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_tran_fil_resv_v(
    stt_reg_loc_dim_id        INT              COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location. The intersection where prod<Truncated>',
    greg_date                 STRING           COMMENT 'Gregorian Date - The date the transaction was billed to the customer for this reservation and suffix. The format for date selection is  ccyy-mm-dd.',
    register_nbr              SMALLINT         COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr                 INT              COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location, register number , transaction number, and day .',
    version_nbr               SMALLINT         COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99 .  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr           SMALLINT         COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg             VARCHAR(1)       COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    seq_nbr                   SMALLINT         COMMENT 'Sequence Number - Do not use. NOTE:  this is not the POS_SEQ_NBR.',
    stt_divn_nbr              INT              COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr          INT              COMMENT 'Store Number - The store number for this row indicating where the sales was rung.',
    stt_cr_zl_store_nbr       INT              COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id            INT              COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    fil_divn_nbr              INT              COMMENT 'FedFIL Division Number - The fulfilling division from where merchandise was shipped to the customer. Legacy (not LOCN)  dimensions were utilized.  Macys = 71.',
    fil_store_nbr             INT              COMMENT 'FedFIL Store Number - The fulfilling store from where merchandise was shipped to the customer. Legacy (not LOCN)  dimensions were utilized.  Macys = 71.',
    fil_reservation_nbr       DECIMAL(9, 0)    COMMENT 'FedFIL Reservation Number - A unique number assigned to a merchandise reservation request or a non-POS  gift card transaction. If  two distinct reservations (i.e. different reservation numbers) were made for the same customer, FedFIL would never<Truncated>',
    fil_reservation_suffix    SMALLINT         COMMENT 'FedFIL Reservation Suffix - A sequence number assigned to indicate the activity on a reservation. The suffix indicated on all reservations  initially contained a value of 01.  If two or more  separate shipments were  for the same reservation num<Truncated>',
    fil_loc_dim_id            INT              COMMENT 'FedFIL Location Dimension Id - The combined division, corporate location,  and legacy location entity.  by which fact data may be summed. This is the equivalent of the LOC_DIM_ID in the LOCN_DIM dimension  table for  the fulfilling division / lo<Truncated>',
    src_nbr                   SMALLINT         COMMENT 'Source Number  - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table  SOURCE_SYSTEM_V.',
    current_ind               SMALLINT         COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0).  Use of a View should provide t<Truncated>',
    batch_set_nbr             INT              COMMENT 'EDW Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr               INT              COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr              INT              COMMENT 'Last Updated Number - The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr               INT              COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id          VARCHAR(12)      COMMENT 'Last Updated User Id - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    purge_flg                 VARCHAR(1)       COMMENT 'Purge Flag - A flag applied by EDW  to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    fulfillment_code          SMALLINT         COMMENT 'Fulfillment Code - A number used to identify the fulfillment method or reason for origin of merchandise. Values are: 1 =  BOPS (Buy Online Pickup in Store) 2 = Via dotcom 3 = Via Store from dotcom 4 = Via Store from Store 5 = Via Bcom from Mcom <Truncated>',
    added_by_app              SMALLINT         COMMENT 'Added by Application - A number used to identify the main application that initiated the transaction / order. Values are: 1= POS (Point of Sale) 2 = MCOM 3 = BCOM 4 = FIL 5 = MM (More at Macys) Source:  RPE90 / subtype16 record.  See ESSGROUPS\ <Truncated>',
    added_by_device           SMALLINT         COMMENT 'Added by Device - A number used to identify the specific selling channel device that initiated the transaction / order. Values are: 0 = Application did not set this  field 1= REG (Register) 2 = MPOS  (MPOS device) 3 = IPOD    (IPOD device) 4 = I<Truncated>',
    future_field4             SMALLINT         COMMENT 'Future use - Future use',
    future_field5             SMALLINT         COMMENT 'Future use - Future use',
    future_field6             SMALLINT         COMMENT 'Future use - Future use',
    future_field7             SMALLINT         COMMENT 'Future use - Future use',
    future_field8             SMALLINT         COMMENT 'Future use - Future use',
    future_field9             SMALLINT         COMMENT 'Future use - Future use',
    future_field10            SMALLINT         COMMENT 'Future use - Future use',
    future_field11            SMALLINT         COMMENT 'Future use - Future use',
    future_field12            SMALLINT         COMMENT 'Future use - Future use',
    future_field13            SMALLINT         COMMENT 'Future use - Future use',
    future_field14            SMALLINT         COMMENT 'Future use - Future use',
    future_field15            SMALLINT         COMMENT 'Future use - Future use',
    acct_loc_dim_id           INT              COMMENT 'Accounting Store Number - LOCN - The financial location in LOCN format, to receive credit for the sale. This column is only available in the view.  Not in the base table.',
    locn_nbr                  INT              COMMENT 'Store Number - LOCN  - Store Number in LOCN format This column is only available in the view.  Not in the base table. Provided for Sales table joins only.  Do not use this LOCN_NBR to join to LOCN_DIM',
    daas_corrltn_id           STRING           COMMENT 'This is the correlation id sent with the source file.',
    daas_crt_ts               TIMESTAMP        COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id              VARCHAR(36)      COMMENT 'System Generated uuid associated with the ETL load job.'
)
COMMENT 'FedFIL reservation numbers and fulfillment locations - This fact table contains FedFIL reservation numbers and fulfillment divisions & locations passed through RPS on sales and returns. RPS is the source of this information. | Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg| Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_tran_fil_resv_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_line_tax_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_tran_line_tax_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_tran_line_tax_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location.',
    greg_date              STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer. The format for date selection is  ccyy-mm-dd.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location, register number , transaction number, and day .',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99.  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    seq_nbr                SMALLINT          COMMENT 'Sequence Number - A number assigned by the source sytem, to identify the detail sequence of this sales tax line item row, within this transaction. RPS and Credit are  the source systems.  Back Office Credit transactions are identified by a SEQ_N<Truncated>',
    sales_tl_seq_nbr       SMALLINT          COMMENT 'Sequence Number of the merchandise line item in this transaction to which this SALES_TRAN_LINE_TAX row applies. - A number assigned by EDW, to identify the detail sequence number, as assigned by the source system, of the merchandise line item, t<Truncated>',
    stt_divn_nbr           INT               COMMENT 'Division Number - The company / operating division number for this row, indicating the division where the transaction was rung. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number - The store number for this row indicating where the transaction was rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    current_ind            SMALLINT          COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0).  Use of the View (_V) tables wi<Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table  .SOURCE_SYSTEM_V.',
    batch_set_nbr          INT               COMMENT 'Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr            INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr           INT               COMMENT 'Last Update number - The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User ID - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    orig_tax_rate          INT               COMMENT 'Original Tax Rate - The tax rate and mantissa, expressed as a whole number, on sales and returns. Format is RRRRR00M, where: R = the sales tax rate 0 = not used 1 = Mantissa   FedFIL (REGISTER_ID = FF) transaction types do not report this inform<Truncated>',
    state_cd               VARCHAR(2)        COMMENT 'State Code',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.  Valid transaction type codes may be viewed on the table TRANS_TYPE_V.',
    register_id            VARCHAR(2)        COMMENT 'Register Id   - A value applied to a sales transaction to indicate its origin.  Common values include: SP = SmartPOS FP = Pre-Sell  FF = FedFIL transactions will no longer use this code if processed through the central server. Valid register ID <Truncated>',
    tax_rate               DECIMAL(9, 5)     COMMENT 'Tax Rate  - The tax rate applied to a line item in a transaction.      Expressed as I.ddddd where: I = the integer rate d = 5 decimal places A rate of 7 3/4% is expressed as 7.75000 in EDW. The rate may be zero on some transactions.',
    extended_tax_amt       DECIMAL(18, 4)    COMMENT 'Extended Tax Amount - If a separate local or special tax, this is the   tax amount of this line item in this transaction.  Otherwise, the amount is zero. Expressed in dollars & cents.',
    county_cd              INT               COMMENT 'County Code - Not used Default is zero',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag - A flag applied by EDW  to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Sales Transaction Line Tax - A fact table used to provide the detail of sales tax on a line item in a financial sale or exchange transaction. Sourced from the RPS RPE 28 records. | Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, seq_nbr, sales_tl_seq_nbr| Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_tran_line_tax_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_line_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_tran_line_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_tran_line_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID. A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_REG_LOC_DIM_ID represents the ringing location. The intersection where product o<Truncated>',
    greg_date              STRING            COMMENT 'Gregorian Date The date the transaction was billed to the customer. The format for date selection is ccyy-mm-dd.',
    register_nbr           SMALLINT          COMMENT 'Register Number A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate where this transaction originated in this division, location, register number, and day. Reg<Truncated>',
    trans_nbr              INT               COMMENT 'Transaction Number A unique number assigned to this transaction from this POS or back office reserved id, on this day in this division, location, register number , transaction number, and day .',
    version_nbr            SMALLINT          COMMENT 'Version Number The initial or decremented version number assigned to this transaction. The initial version number is 99. It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag A code assigned to indicate whether the transaction required Sales Audit intervention.',
    sales_tl_seq_nbr       SMALLINT          COMMENT 'Transaction Line Sequence Number A number assigned to identify the original detail sequence of this line item row, within this transaction. The represents the merchandise line item (05 detail record) and is assigned by the RPS source system.',
    stt_divn_nbr           INT               COMMENT 'Division Number The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number The store number for this row indicating where the sale was rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Central Ring Store Number The central ring location number, this indicates what location gets the sale/return credit. If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID. A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physical lo<Truncated>',
    loc_dim_id             INT               COMMENT 'Location Dimension Identification number The ID number assigned to the location in the EDW Location Dimension.  Reference the LOCN_DIM table.',
    divn_nbr               INT               COMMENT 'Division Number The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    zl_store_nbr           INT               COMMENT 'Legacy Store Number The store number for this row indicating where the sales was rung.',
    cr_zl_store_nbr        INT               COMMENT 'Central Ring Store Number The central ring location number, this indicates what location gets the sale/return credit. If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    central_cd             VARCHAR(1)        COMMENT 'Central Code Not populated. Do not use.',
    prod_dim_id            DECIMAL(18, 0)    COMMENT 'Product Dimension Identification number The PROD_DIM_ID is an 18 digit number created from the timestamp when the PROD_DIM row was created, it uniquely identifies each product in each division of the company. Multiple SKU_UPC_NBRs can and do exi<Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number A code assigned to indicate the source system of the data. Valid source number values may be viewed on the table SOURCE_SYSTEM_V.',
    sz_nbr                 SMALLINT          COMMENT 'Size Number A number used to identify size within a department / vendor / markstyle / color.',
    current_ind            SMALLINT          COMMENT 'Current Indicator A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0). Use of the View (_V) tables will <Truncated>',
    upc_qty                INT               COMMENT 'UPC Quantity Represents the number of units of this specific UPC sold on this sales transaction.  Expressed as a whole number.',
    merch_amt              DECIMAL(11, 2)    COMMENT 'Merchandise Amount The merchandise amount for a row that may be before or net of point-of-sale discounts. The amount is always before any back office discounts are applied.',
    selling_price_amt      DECIMAL(11, 2)    COMMENT 'Selling Price Amount - Not populated. To figure out the selling price amount, start with the Merch_Amt on Sales_Tran_Line (STL), then reduce it by any line item discounts found in the Tran_line_Discount (TLD) table, where the STT / Sales_Tl_Seq_<Truncated>',
    zl_class_nbr           SMALLINT          COMMENT 'Class Number The merchandise class number for this UPC at the time of the sale transaction.',
    dept_nbr               SMALLINT          COMMENT 'Department Number The department number for this UPC at the time of the sale transaction.',
    vnd_numeric_desc       SMALLINT          COMMENT 'Vendor Number The vendor number for this UPC at the time of the sale transaction',
    sku_upc_nbr            DECIMAL(18, 0)    COMMENT 'UPC Number A 12 to 13-digit number that a manufacturer assigned to each color and size. A UPC (or GTIN) represents a single color and size combination of an item. Also known as the short sku. Sourced as a vendor UPC, an In-House UPC, or an RDS SKU.',
    mkst                   INT               COMMENT 'Markstyle A number used to identify a product within a department / vendor within an operating division.',
    clr_nbr                SMALLINT          COMMENT 'Color Number A number used to identify color within a department / vendor / markstyle, within an operating division.',
    batch_set_nbr          INT               COMMENT 'Batch Set Number A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr            INT               COMMENT 'Trickle Number A numeric cross reference generated by the EDW as to the date and time when the EDW last subscribed to Sales data on the mainframe.',
    last_upd_nbr           INT               COMMENT 'Last Update number The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number A numeric cross-reference to the exact time the base table was updated. The value is zero unless a manual fix occurred. Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent. The subject are<Truncated>',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User ID The user id or program that last updated a row, used for auditing. If added manually, the value will be the initials and associate number of the person who added it.',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code RPS transaction type, the identifying code or description of the transaction, as defined by the company. Valid transaction type codes may be viewed on the table TRANS_TYPE_V. A value of 33 represents the sales portion for an exchange.',
    register_id            VARCHAR(2)        COMMENT 'Register ID A value applied to a sales transaction to indicate its origin. Common values include: SP = SmartPOS FP = Pre-Sell FF = FedFIL transactions will no longer use this code if processed through the central server. Valid register ID codes <Truncated>',
    pos_status             SMALLINT          COMMENT 'Point-of-Sale Status Do not use Inactive - defaults to zero',
    promo_price_flg        VARCHAR(1)        COMMENT 'Promotional Price Flag Do not use Inactive - defaults to blank',
    commssn_spsn_nbr       INT               COMMENT 'Commission Salesperson Number When this value is different from the RING_SPSN_NBR value, this is the identifying employee number of the salesperson earning commission on the sale.',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag A flag applied by EDW to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    ocd_cd                 SMALLINT          COMMENT 'Omni Channel Dimension Code A number initially assigned to each item sold to identify how the customer purchased merchandise and how the merchandise was fulfilled. Also view the OCD_CODE_V lookup table.',
    pos_seq_nbr            SMALLINT          COMMENT 'Point-of-Sale (POS) Sequence Number A sequential number assigned to a sale or return merchandise line item amount in a transaction. Values will not be in sequential order, except coincidentally.',
    registry_nbr           INT               COMMENT 'Registry Number A unique number assigned to identify a customer enrolled in a gift registry program. Note: this is a unique 8-digit number. The common prefixes of 2800 or 2809 and the low-order check digit in the source system are not provided. <Truncated>',
    acct_loc_dim_id        INT               COMMENT 'Accounting Store Number - LOCN The financial location in LOCN format, to receive credit for the sale. This column is only available in the view. Not in the base table.',
    locn_nbr               INT               COMMENT 'Store Number - LOCN Store Number in LOCN format This column is only available in the view. Not in the base table. Provided for Sales table joins only. Do not use this LOCN_NBR to join to LOCN_DIM',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Sales transaction level detail - A fact table used to provide the detail sale line item information within a financial sale, or the financial sale portion of an exchange transaction.| Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_tran_line_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_tax_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_tran_tax_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_tran_tax_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location.',
    greg_date              STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer. The format for date selection is  ccyy-mm-dd.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location, register number , transaction number, and day .',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99.  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    seq_nbr                SMALLINT          COMMENT 'Transaction Line Sequence Number - A number assigned by the source sytem, to identify the detail sequence of this sales tax total line tem row, within this transaction. Assigned by the RPS source system.  Multiple SALES_TRAN_TAX rows may be pres<Truncated>',
    stt_divn_nbr           INT               COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number - The store number for this row indicating where the sale was rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table  .SOURCE_SYSTEM_V.',
    current_ind            SMALLINT          COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0).  Use of the View (_V) tables wi<Truncated>',
    tax_amt                DECIMAL(11, 2)    COMMENT 'Tax Amount - The net total tax amount of this transaction. Expressed in dollars & cents.',
    taxable_amt            DECIMAL(11, 2)    COMMENT 'Taxable Amount - The portion of this transaction, subject to sales tax. Expressed in dollars and cents.  RDS transactions (identified by their REGISTER_ID) incorrectly report this amount.',
    tax_exempt_amt         DECIMAL(11, 2)    COMMENT 'Tax Exempt Amount - The portion of this transaction, exempt from sales tax. Expressed in dollars and cents.  RDS transactions (identified by their REGISTER_ID) incorrectly report this amount.',
    batch_set_nbr          INT               COMMENT 'Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr            INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr           INT               COMMENT 'Last Update number - The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User ID - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    tax_cd                 SMALLINT          COMMENT 'Tax Code - Not used. Default is zero.',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.  Valid transaction type codes may be viewed on the table TRANS_TYPE_V.',
    register_id            VARCHAR(2)        COMMENT 'Register Id - A value applied to a sales transaction to indicate its origin.  Common values include: SP = SmartPOS FP = Pre-Sell  FF = FedFIL transactions will no longer use this code if processed through the central server. Valid register ID co<Truncated>',
    tax_rate               DECIMAL(9, 5)     COMMENT 'Tax Rate - The rate applied to some or all line items in a transaction.  A separate row is generated by the source system (RPS) for each unique tax rate. Expressed as I.ddddd where: I = the integer rate d = 5 decimal places A rate of 7 3/4% is e<Truncated>',
    state_cd               VARCHAR(2)        COMMENT 'State Code - An abbreviation of the taxing authority name.  This may be a U.S.A. state or  territory. Back Office discounts do not identify the state code.',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag - A flag applied by EDW  to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.'
)
COMMENT 'Sales Transaction Tax - A fact table used to provide the net total of sales tax on a financial sale or exchange transaction.  More than one row may be present for the same transaction. Sourced from the RPS RPE 29 records.| Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, seq_nbr| Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_tran_tax_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_sales_tran_v 
--

CREATE EXTERNAL TABLE edw_mix_sales_tran_v(
    stt_reg_loc_dim_id      INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID. - A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_REG_LOC_DIM_ID represents the ringing location of the sale or return transaction.',
    greg_date               STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer.',
    register_nbr            SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate where this transaction originated in this division, location, register number, and day.',
    trans_nbr               INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id, on this day in this division, location, register number , transaction number, and day .',
    version_nbr             SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction.',
    version_adj_nbr         SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg           VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    stt_divn_nbr            INT               COMMENT 'Division Number - The operating division / company for this transaction.',
    stt_zl_store_nbr        INT               COMMENT 'Store Number - The store number for this row indicating where the sales was rung.',
    stt_cr_zl_store_nbr     INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit. If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id          INT               COMMENT 'A dimension of STT and LOC_DIM_ID. - A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physical <Truncated>',
    src_nbr                 SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.',
    current_ind             SMALLINT          COMMENT 'Current Indicator - A value applied to a sales transaction to indicate its status, used primarily to build views. Possible values:
1 = most current version
0 = older versions',
    tax_exempt_flg          VARCHAR(1)        COMMENT 'Tax Exempt Flag - A flag used to indicate whether the transaction was exempt from sales tax, as defined by the company.',
    trans_type_cd           SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.',
    register_tot_amt        DECIMAL(11, 2)    COMMENT 'Register Total Amount - Total dollar amount of the transaction, as calculated by the POS register. If the transaction total does not match the system-computed total, the transaction is out of balance.',
    computed_tot_amt        DECIMAL(11, 2)    COMMENT 'Computed Total Amount - The RPS-computed transaction total, the sum of non-tender detail amounts.',
    tender_tot_amt          DECIMAL(11, 2)    COMMENT 'Tender Total Amount - The transaction total sent to RPS on the tender record. If the tender total does not match the system-computed total, the transaction is out of balance.',
    trans_hhmm              SMALLINT          COMMENT 'Transaction Hour/Minute - The time when a transaction ended in a business location.',
    ring_spsn_nbr           INT               COMMENT 'Ringing Salesperson Number - The identifying employee number of the ringing salesperson.',
    rps_commssn_spsn_nbr    INT               COMMENT 'Commission Salesperson Number - When this value is different from the RING_SPSN_NBR value, this is the identifying employee number of the salesperson earning commission on the sale.',
    nbr_line_items          SMALLINT          COMMENT 'Number of Line Items - The number of detail lines in the transaction, includes non-tender and tender line items.',
    batch_set_nbr           INT               COMMENT 'EDW Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW.',
    trickle_nbr             INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as to the date and time when the EDW last subscribed to Sales data on the mainframe.',
    last_upd_nbr            INT               COMMENT 'Last Updated Number - A system generated number or associate RACF id that can be cross-referenced to the date / time a row was last updated.',
    load_2b_nbr             INT               COMMENT 'Load to Base Number - A numeric cross-reference to the exact time the base table was updated.',
    last_upd_user_id        VARCHAR(12)       COMMENT 'Last Updated User ID - The user id or program that last updated a row, used for auditing.',
    register_id             VARCHAR(2)        COMMENT 'Register Identification - A value applied to a sales transaction to indicate it''s origin. Common values include:
SP = SmartPOS
FP = Pre-Sell
FF = FedFIL transactions will no longer use this code if processed through the central server.',
    purge_flg               VARCHAR(1)        COMMENT 'Purge Flag - A value applied to a row to indicate whether the row is to be purged.',
    commssn_spsn_nbr        INT               COMMENT 'Commission Salesperson Number When this value is different from the RING_SPSN_NBR value, this is the identifying employee number of the salesperson earning commission on the sale.',
    daas_load_id            VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts             TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id         STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Sales header - A fact table used to provide transaction header data with summarized, general information about a financial sale, return, or gift instrument transaction. This includes fees and sales taxes.| Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg| Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy
'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_sales_tran_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_tender_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_tender_v 
--

CREATE EXTERNAL TABLE edw_mix_tender_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID. - A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_REG_LOC_DIM_ID represents the ringing location.',
    greg_date              STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate where this transaction originated in this division, location, register number, and day.',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id, on this day in this division, location, register number , transaction number, and day .',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction.',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    seq_nbr                SMALLINT          COMMENT 'Transaction Line Sequence Number - A number assigned to identify the original detail sequence of this line item row, within this transaction.',
    stt_divn_nbr           INT               COMMENT 'Division Number - The operating division / company for this transaction.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number - The store number for this row indicating where the sale was rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit. If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID. - A dimension assigned to provide part of a unique key, used to later join various detailed sales tables. The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physical <Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.',
    tndr_typ_id            SMALLINT          COMMENT 'Tender Type Id - A code assigned to indicate the detail method of payment on this transaction.',
    cmmn_tndr_typ_id       SMALLINT          COMMENT 'Common Tender Type Id - A code assigned to indicate the higher level method of payment on this transaction.',
    current_ind            SMALLINT          COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read.',
    charge_card_id         SMALLINT          COMMENT 'Charge Card Id - A number assigned to identify the third party vendor (e.g. American Express) of this charge card in this tender. Includes in-house divisions.',
    tender_amt             DECIMAL(11, 2)    COMMENT 'Tender Amount - An amount submitted in part or full payment of a purchase, a return credit, or a back office transaction.',
    batch_set_nbr          INT               COMMENT 'Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW.',
    trickle_nbr            INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as to the date and time when the EDW last subscribed to Sales data on the mainframe.',
    last_upd_nbr           INT               COMMENT 'Last Update number - The last date / time a row was updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number - A numeric cross-reference to the exact time the base table was updated.',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User ID - The user id or program that last updated a row, used for auditing.',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.',
    register_id            VARCHAR(2)        COMMENT 'Register Id - A value applied to a sales transaction to indicate it''s origin. Common values include:
SP = SmartPOS
FP = Pre-Sell
 FF = FedFIL transactions will no longer use this code if processed through the central server.',
    prop_acct_typ          SMALLINT          COMMENT 'Proprietary Account Type',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag - A flag applied by EDW to indicate whether the row will be purged.',
    year                   INT               COMMENT 'Year Number',
    month                  INT               COMMENT 'Month Number',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Tender - A fact table used to provide details of how a transaction total was paid. Multiple tenders may occur for the same transaction. The base table is MDCPMST.|Primary Key = trans_nbr|Offset = LOAD_2B_NBR| Partition Date = greg_date dd/MM/yyyy
'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_tender_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_tran_paymeth;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_tran_paymeth 
--

CREATE EXTERNAL TABLE edw_mix_tran_paymeth(
    tran_id               DECIMAL(18, 0)    COMMENT 'Transaction ID',
    cus_nbr               DECIMAL(12, 0)    COMMENT 'Customer Number',
    seq_nbr               SMALLINT          COMMENT 'Transaction Line Sequence Number - A number assigned to identify the original detail sequence of this line item row, within this transaction. Assigned by the RPS source system.',
    pay_amt               DECIMAL(18, 2)    COMMENT 'Payment Amount',
    check_nbr             DECIMAL(12, 0)    COMMENT 'Check Number',
    pay_plan              DECIMAL(12, 0)    COMMENT 'Payment Plan',
    micr_reader_sw        STRING,
    signature_captured    STRING            COMMENT 'Signature Captured',
    pay_typ_src           STRING            COMMENT 'Payment Type Source',
    pay_typ               STRING            COMMENT 'Payment Type',
    daas_load_id          VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts           TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id       STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Contains payment method information about bookings and shipped (FedFIL)| Primary Key = tran_id|Offset = tran_tran_item_v.tran_date'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_tran_paymeth'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_tran_tran_item_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_tran_tran_item_v 
--

CREATE EXTERNAL TABLE edw_mix_tran_tran_item_v(
    appl_xref            STRING            COMMENT 'Application Cross Reference',
    rgstry_dim_id        INT               COMMENT 'Registry Number - A unique number assigned to identify a customer enrolled in a gift registry program.',
    emp_dim_id           STRING            COMMENT 'Employee Dimension ID',
    event_id             INT               COMMENT 'Event ID',
    tran_id              DECIMAL(18, 0)    COMMENT 'Transaction ID',
    tran_typ             VARCHAR(1)        COMMENT 'Transaction Type. S  -shipping E - Exchange   C - Cancel (Void)  B  - Book X  - RPS provided value R - Return T - Take ( RPS transaction)',
    tran_date            STRING            COMMENT 'Transaction Date',
    tran_time            STRING            COMMENT 'Transaction Time',
    tran_reg_nbr         DECIMAL(9, 0)     COMMENT 'Transaction Register Number',
    tran_reg_trn         DECIMAL(9, 0)     COMMENT 'Register Transaction Number',
    tran_tot_amt         DECIMAL(9, 2)     COMMENT 'Transaction Total Amount',
    tran_ship_amt        DECIMAL(9, 2)     COMMENT 'Transaction Shipment Amount',
    sell_store_div       SMALLINT          COMMENT 'Selling Store Division',
    sell_store_loc       SMALLINT          COMMENT 'Selling Store Location',
    fill_store_div       SMALLINT,
    fill_store_loc       SMALLINT          COMMENT 'Fulfillment Store Location',
    soldto_cust_id       DECIMAL(18, 0)    COMMENT 'Sold to Customer ID',
    soldto_cust_seq      SMALLINT          COMMENT 'Sold to Customer Sequence Number',
    shipto_cust_id       DECIMAL(18, 0)    COMMENT 'Ship to customer ID',
    shipto_cust_seq      SMALLINT          COMMENT 'Ship to customer sequence number',
    ring_assoc           BIGINT            COMMENT 'Sales Register Associate',
    sell_assoc           DECIMAL(9, 2)     COMMENT 'Selling Associate',
    orig_assoc           DECIMAL(18, 0)    COMMENT 'Original Associate',
    login_id             STRING            COMMENT 'Login ID',
    rgstry_flg           VARCHAR(1)        COMMENT 'Registry Flag',
    appl_id              VARCHAR(10)       COMMENT 'Base Fee Amount',
    intr_xref            STRING,
    source_system        VARCHAR(10)       COMMENT 'Source System',
    intr_xref2           STRING,
    cat_source_cd        STRING            COMMENT 'Catalog Source Code',
    rgstry_id            DECIMAL(9, 0)     COMMENT 'Registry Number - A unique number assigned to identify a customer enrolled in a gift registry program.',
    eff_date             STRING            COMMENT 'Effective Date',
    ship_id              SMALLINT          COMMENT 'Shipment ID',
    sub_appl_id          VARCHAR(10)       COMMENT 'Sub Application ID',
    dlvr_typ             SMALLINT          COMMENT 'Delivery Type',
    npr_flg              VARCHAR(1)        COMMENT 'NPR Flag',
    multi_ship           VARCHAR(1)        COMMENT 'Multiple Shipments',
    gift_greet           VARCHAR(10)       COMMENT 'Gift Greeting',
    fab_typ              VARCHAR(1),
    wrap_fee             DECIMAL(9, 2)     COMMENT 'Gift Wrap Fee',
    base_fee             DECIMAL(9, 2)     COMMENT 'Base Fee Amount',
    addtnl_addr_fee      DECIMAL(9, 2)     COMMENT 'Additional Address Fee',
    rtrn_shp_lbl_fee     DECIMAL(9, 2)     COMMENT 'Return Shipment Label Fee',
    upcharge_fee         DECIMAL(9, 2)     COMMENT 'Upcharge Fee',
    lty_id_pref          VARCHAR(10)       COMMENT 'Loyalty ID Prefer',
    lty_id_nbr           BIGINT            COMMENT 'Loyalty ID Number',
    po_nbr               DECIMAL(9, 0)     COMMENT 'Purchase Order number.',
    gft_to_f             VARCHAR(1)        COMMENT 'Gift To Flag',
    esmt_deliv_dt        STRING            COMMENT 'Estimated Delivery Date',
    fd_ind               VARCHAR(1),
    lty_usl_id           BIGINT            COMMENT 'United States Loyalty (USL) ID',
    intl_flg             VARCHAR(1)        COMMENT 'International Flag',
    client_id            VARCHAR(10)       COMMENT 'Client ID',
    sub_client_id        VARCHAR(10)       COMMENT 'Sub Client ID',
    pfr_cust_pre         VARCHAR(1),
    pfr_cust_post        VARCHAR(1),
    tran_seq_nbr         SMALLINT          COMMENT 'Transaction Sequence Number',
    item_id              DECIMAL(18, 0)    COMMENT 'Item ID',
    itm_qty              DECIMAL(9, 0)     COMMENT 'Item Quantity',
    itm_cost             DECIMAL(9, 2)     COMMENT 'Item Cost',
    itm_price            DECIMAL(9, 2)     COMMENT 'Item Price. Itm_qty * itm_price at whole booking line will give the original price. For a discount, there is a new record with itm qty = 0 and discounted item price.',
    plu_price            DECIMAL(9, 2),
    modeled_sw           VARCHAR(1),
    blocked_sw           VARCHAR(1)        COMMENT 'Blocked',
    hotflag_sw           VARCHAR(1),
    mark_down_lev        STRING            COMMENT 'Markdown Level',
    ti_tran_date         STRING            COMMENT 'Transaction Item Transaction Date',
    ti_fill_store_div    SMALLINT          COMMENT 'Transaction Item Fulfillment Store Division',
    ti_fill_store_loc    INT               COMMENT 'Transaction Item Fulfillment Store Location',
    ti_appl_id           VARCHAR(10)       COMMENT 'Transaction Item Application ID',
    fill_meth            VARCHAR(10)       COMMENT 'Fill Method',
    line_nbr             DECIMAL(9, 0)     COMMENT 'Line Number',
    catlog_cd            STRING            COMMENT 'Catalog code',
    ti_eff_date          STRING            COMMENT 'Transaction Item Effective Date',
    cmf_event            STRING,
    surcharge_fee        DECIMAL(9, 2)     COMMENT 'Surcharge Fee',
    esend_origin_cd      SMALLINT          COMMENT 'eSend Origin Code',
    price_type_id        DECIMAL(9, 0)     COMMENT 'Price Type ID',
    qty_po_alloc         DECIMAL(9, 0),
    bo_ordd_f            VARCHAR(1),
    bo_spcl_f            VARCHAR(1),
    dept_id              SMALLINT          COMMENT 'Department ID',
    vend_id              INT               COMMENT 'Vendor ID',
    mkstyl               DECIMAL(9, 0)     COMMENT 'Markstyle - A number used to identify a markstyle within a department / vendor.',
    owned_retail         DECIMAL(9, 2)     COMMENT 'Owned Retail Unit Price The owned retail unit price as of the week ending date. Source: PROD_PRICE OWNED_RETAIL as of the GREG_AMC_WEEK_ENDING_DATE / Use Current OWNED_RETAIL If Not Found as of the GREG_AMC_WEEK_ENDING_DATE',
    ti_fd_ind            VARCHAR(1),
    ti_client_id         VARCHAR(10)       COMMENT 'Transaction Item Client ID',
    ti_sub_client_id     VARCHAR(10)       COMMENT 'Transaction Item Sub Client ID',
    ti_pfr_cust_pre      VARCHAR(1),
    ti_pfr_cust_post     VARCHAR(1),
    daas_corrltn_id      STRING            COMMENT 'This is the correlation id sent with the source file.',
    daas_crt_ts          TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id         VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.'
)
COMMENT 'Combined Transaction and Line Item Level Information| Primary Key = tt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, seq_nbr|Offset = tran_date| Partition Date = tran_date dd/MM/yyyy
'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_tran_tran_item_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_trans_discount_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_trans_discount_v 
--

CREATE EXTERNAL TABLE edw_mix_trans_discount_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location. The intersection where prod<Truncated>',
    greg_date              STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer. The format for date selection is  ccyy-mm-dd.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location, register number , transaction number, and day .',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99.  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    seq_nbr                SMALLINT          COMMENT 'Transaction Line Sequence Number - A number assigned to identify the  detail sequence of this line item row, within this transaction. Assigned by the RPS source system.',
    stt_divn_nbr           INT               COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number - The store number for this row indicating where the sale was rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table  .SOURCE_SYSTEM_V.',
    current_ind            SMALLINT          COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0).  Use of the View (_V) tables wi<Truncated>',
    discount_type_cd       SMALLINT          COMMENT 'Discount Type Code - The discount code applied to the transaction. Reference the DISCOUNT_TYPE_V table for all code values.',
    discount_amt           DECIMAL(11, 2)    COMMENT 'Discount Amount - Note:  there is no data from FIL transactions.',
    discount_pct           DECIMAL(11, 2)    COMMENT 'Discount Percent - The discount percent applied to the transaction.',
    batch_set_nbr          INT               COMMENT 'Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr            INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr           INT               COMMENT 'Last Update number - The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User ID - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    pos_discnt_type_cd     SMALLINT          COMMENT 'Point of Sale Discount Type Code - A code applied to identify Point of Sale discounts (only) by original reason code from the RPS source system.   The POS_DISCOUNT_TYPE table is being revised.',
    discount_method_cd     VARCHAR(1)        COMMENT 'Discount Method Code - A code applied to identify whether the discount resulted from dollars off or percent off. Where: D = dollars off P = percent off blank = unidentified.',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.  Valid transaction type codes may be viewed on the table TRANS_TYPE_V.',
    register_id            VARCHAR(2)        COMMENT 'Register Id - A value applied to a sales transaction to indicate its origin.  Common values include: SP = SmartPOS FP = Pre-Sell  FF = FedFIL transactions will no longer use this code if processed through the central server. Valid register ID co<Truncated>',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag - A flag applied by EDW  to indicate whether the row will be purged. Values are: Y = the row will be purged N = default',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.'
)
COMMENT 'Transaction Discount - This is a memo total of discounts in a financial sale or exchange transaction.  Note:  there is no data from FIL transactions and the data present appears to be understated. This table contains point-of-sale (POS) and Back Office discounts.| Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, seq_nbr|Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_trans_discount_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
DROP TABLE IF EXISTS ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_trans_line_discount_v;

USE ${env:HIVE_SCHEMA_PREFIX}raw_sls;
-- 
-- TABLE: edw_mix_trans_line_discount_v 
--

CREATE EXTERNAL TABLE edw_mix_trans_line_discount_v(
    stt_reg_loc_dim_id     INT               COMMENT 'A dimension of STT, Register number, and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_REG_LOC_DIM_ID represents the ringing location. The intersection where prod<Truncated>',
    greg_date              STRING            COMMENT 'Gregorian Date - The date the transaction was billed to the customer. The format for date selection is  ccyy-mm-dd.',
    register_nbr           SMALLINT          COMMENT 'Register Number - A number assigned either to a point-of-sale (POS) physical terminal id on the selling floor, or to a Back Office reserved id, to indicate  where this transaction originated in this division, location,  register number,  and day<Truncated>',
    trans_nbr              INT               COMMENT 'Transaction Number - A unique number assigned to this transaction from this POS or back office reserved id,  on this day in this division,  location, register number , transaction number, and day .',
    version_nbr            SMALLINT          COMMENT 'Version Number - The initial or decremented version number assigned to this transaction. The initial version number  is 99.  It is decremented by 1 with Sales Audit activity (e.g. 98, then 97, etc.).',
    version_adj_nbr        SMALLINT          COMMENT 'Version Adjusted Number - A code reserved for future use, in the event EDW has to make adjustments to data passed to it by RPS.',
    sd_action_flg          VARCHAR(1)        COMMENT 'Action Flag - A code assigned to indicate whether the transaction required Sales Audit intervention.',
    seq_nbr                SMALLINT          COMMENT 'Sequence Number - A sequential number assigned to represent   a specific line discount within a transaction, and to identify its origin.  Two numeric ranges are used to denote the discount origin and both may be present in the same transaction: <Truncated>',
    sales_tl_seq_nbr       SMALLINT          COMMENT 'Applied Sequence Number - The merchandise line item’s  assigned sequence number in the original sale/return transaction, to which this discount row was applied.',
    stt_divn_nbr           INT               COMMENT 'Division Number - The operating division / company for this transaction. This DIVN_NBR is in LOCN format.',
    stt_zl_store_nbr       INT               COMMENT 'Store Number - The store number for this row indicating where the sales was rung.',
    stt_cr_zl_store_nbr    INT               COMMENT 'Central Ring Store Number - The central ring location number, this indicates what location gets the sale/return credit.  If this column is blank, the sales credit goes to the store number in the STT_ZL_STORE_NBR field.',
    stt_loc_dim_id         INT               COMMENT 'A dimension of STT and LOC_DIM_ID.  - A dimension assigned to provide part of a unique key, used to later  join various detailed sales tables.  The STT_LOC_DIM_ID represents the Central Ring location for a dot com sale, and represents the physic<Truncated>',
    src_nbr                SMALLINT          COMMENT 'Source Number - A code assigned to indicate the source system of the data.  Valid source number values may be viewed on the table SOURCE_SYSTEM_V.',
    current_ind            SMALLINT          COMMENT 'Current Indicator - A value assigned to a row to identify the salescheck version that should be read. The highest value (Example: 1) should be chosen when processing identical rows with lesser values (Example: 0).  Use of a View should provide t<Truncated>',
    discount_type_cd       SMALLINT          COMMENT 'Discount Type Code - A code assigned to identify POS, associate and back office discounts. Reference   DISCOUNT_TYPE_V  lookup for all valid values.',
    discount_amt           DECIMAL(11, 2)    COMMENT 'Discount Amount - The amount of POS or Back Office discount.   Note:  there is no data from FIL transactions.  POS Discounts The DISCOUNT_PCT is applied to the MERCH_AMT,  to calculate the discount amount for this item. Back Office Discounts The<Truncated>',
    discount_pct           DECIMAL(11, 2)    COMMENT 'Discount Percent - The percent of discount. Carried as a whole number with two decimals (e.g. 15% is carried as 15.00).  Note:  the percent  will be zero when Dollars Off coupons are used with an item.',
    batch_set_nbr          INT               COMMENT 'EDW Batch Set Number - A numeric cross reference to the date and time of the creation of the set of load ready files that last updated this row in the EDW. The subject area code for SALES is DWS.',
    trickle_nbr            INT               COMMENT 'Trickle Number - A numeric cross reference generated by the EDW as  to the date and time when the EDW last subscribed to Sales data on the mainframe. The subject area code for SALES is DWS.',
    last_upd_nbr           INT               COMMENT 'Last Updated Number - The last date / time a row was updated. The value is zero unless the row was updated.',
    load_2b_nbr            INT               COMMENT 'Load to Base Number - A numeric  cross-reference  to the exact time the base table was updated. The value is zero unless a manual fix occurred.    Requires a join to TRACK_DATA_FLOW by subject area code to obtain a Greg Date equivalent.    The s<Truncated>',
    last_upd_user_id       VARCHAR(12)       COMMENT 'Last Updated User Id - The user id or  program that last updated a row, used for auditing.  If added manually, the value will be the initials and associate number of the person who added it.',
    discount_method_cd     VARCHAR(1)        COMMENT 'Discount Method Code - A code applied to identify whether the discount resulted from dollars off or percent off. Where: D = dollars off P = percent off blank = unidentified.',
    pos_discnt_type_cd     SMALLINT          COMMENT 'POS Discount Type Code - A code applied to identify Point of Sale discounts (only) by original reason code from the RPS source system.   The POS_DISCOUNT_TYPE table is being revised.',
    trans_type_cd          SMALLINT          COMMENT 'Transaction Type Code - RPS transaction type, the identifying code or description of the transaction, as defined by the company.  Valid transaction type codes may be viewed on the table TRANS_TYPE_V.',
    register_id            VARCHAR(2)        COMMENT 'Register Identification - A value applied to a sales transaction to indicate its origin.  Common values include: SP = SmartPOS FP = Pre-Sell  FF = FedFIL transactions will no longer use this code if processed through the central server. Valid re<Truncated>',
    purge_flg              VARCHAR(1)        COMMENT 'Purge Flag -  A value applied to a row to indicate whether the row is to be purged. EDW internal.  A value of  N indicates the row is not to be purged.',
    acct_loc_dim_id        INT               COMMENT 'Accounting Store Number - LOCN The financial location in LOCN format, to receive credit for the sale. This column is only available in the view. Not in the base table.',
    divn_nbr               INT               COMMENT 'The LOCN division number',
    zl_store_nbr           INT               COMMENT 'Store Number - The location in the division where the UPC is located.',
    cr_zl_store_nbr        INT               COMMENT 'Store Number to Receive Credit - If other than zero, this is the store number to receive credit for this transaction. In legacy format.',
    locn_nbr               INT               COMMENT 'Store number in LOCN format  - Store Number in LOCN format VIEW ONLY.   This column is only available in the view.  Not in the base table. Provided for Sales table joins only.  Do not use this LOCN_NBR to join to LOCN_DIM',
    daas_corrltn_id        STRING            COMMENT 'This is the correlation id sent with the source file.',
    daas_crt_ts            TIMESTAMP         COMMENT 'Timestamp that the record is created by the ETL process.',
    daas_load_id           VARCHAR(36)       COMMENT 'System Generated uuid associated with the ETL load job.'
)
COMMENT 'Discount transaction level detail - A fact table used to provide the detail of line item discounts in a financial sale or exchange transaction.  Note:  there is no data from FIL transactions. This table contains point-of-sale (POS) and Back Office discounts.| Primary Key = stt_reg_loc_dim_id, greg_date, register_nbr, trans_nbr, version_nbr, version_adj_nbr, sd_action_flg, seq_nbr, sales_tl_seq_nbr|Offset = load_2b_nbr| Partition Date = greg_date dd/MM/yyyy'
PARTITIONED BY( daas_part_dt VARCHAR(10))
STORED AS ORC
LOCATION '${env:BASE_DATA_DIR}/mix/protected/raw/sls/edw/edw_mix_trans_line_discount_v'
TBLPROPERTIES ('orc.compress'='SNAPPY')
;
MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_oc_returns_prod_loc_day_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_oc_returns_prod_loc_wk_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_oc_sales_prod_loc_day_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_oc_sales_prod_loc_wk_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_psd_tran_line_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_psd_tran_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_return_trans_line_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_fees_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_info_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_line_disc_barcd_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_line_plu_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_prod_loc_day_trans_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_rewards_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_fil_resv_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_line_tax_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_line_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_tax_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_sales_tran_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_tender_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_tran_paymeth;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_tran_tran_item_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_trans_discount_v;

MSCK REPAIR TABLE ${env:HIVE_SCHEMA_PREFIX}raw_sls.edw_mix_trans_line_discount_v;

