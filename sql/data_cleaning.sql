-- =============================================================
-- QUANTIUM ChIP RETAIL ANALYSIS
-- DATA CLEANING & DATA QUALITY
-- =============================================================
--
-- Project Goal:
-- Clean, validate, and prepare transactional retail data
-- and customer purchase behaviour data for downstream
-- analytics and business intelligence reporting.
--
-- Dataset Tables:
-- 1. qvi_transaction_data
-- 2. qvi_purchase_behaviour
--
-- Key Cleaning Objectives:
-- 1. Understand raw data quality
-- 2. Detect missing values and inconsistencies
-- 3. Standardize datatypes and formatting
-- 4. Remove duplicate records
-- 5. Validate business logic
-- 6. Detect outliers and anomalies
-- 7. Prepare analytics-ready datasets
--
-- =============================================================
-- SECTION 1: TRANSACTION DATA CLEANING
-- =============================================================



-- =============================================================
-- STEP 1: UNDERSTAND AND PROFILE THE RAW DATA
-- =============================================================

-- View total number of transaction records.
-- This provides a baseline row count before cleaning.
SELECT COUNT(*) AS total_transactions
FROM qvi_transaction_data;


-- Inspect the schema and datatypes of the table.
-- This helps identify:
-- 1. Incorrect datatypes
-- 2. Numeric columns stored as text
-- 3. Date formatting issues
SELECT 
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'qvi_transaction_data';


-- Count the number of unique products sold.
-- Useful for understanding product diversity.
SELECT COUNT(DISTINCT prod_name) AS unique_products
FROM qvi_transaction_data;


-- Inspect all distinct product names.
-- This helps identify:
-- 1. Spelling inconsistencies
-- 2. Duplicate naming conventions
-- 3. Potential categorization issues
SELECT DISTINCT prod_name AS unique_product_names
FROM qvi_transaction_data
ORDER BY prod_name;


-- =============================================================
-- STEP 2: CHECK FOR NULL VALUES AND DATA QUALITY ISSUES
-- =============================================================

-- Audit missing values across critical columns.
-- Missing values can negatively affect:
-- 1. Aggregations
-- 2. Joins
-- 3. Reporting accuracy
SELECT
    SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN store_nbr IS NULL THEN 1 ELSE 0 END) AS null_store_nbr,
    SUM(CASE WHEN lylty_card IS NULL THEN 1 ELSE 0 END) AS null_lylty_card,
    SUM(CASE WHEN txn_id IS NULL THEN 1 ELSE 0 END) AS null_txn_id,
    SUM(CASE WHEN prod_nbr IS NULL THEN 1 ELSE 0 END) AS null_prod_nbr,
    SUM(CASE WHEN prod_name IS NULL THEN 1 ELSE 0 END) AS null_prod_name,
    SUM(CASE WHEN prod_qty IS NULL THEN 1 ELSE 0 END) AS null_prod_qty,
    SUM(CASE WHEN tot_sales IS NULL THEN 1 ELSE 0 END) AS null_tot_sales
FROM qvi_transaction_data;


-- =============================================================
-- STEP 3: CREATE A STAGING TABLE
-- =============================================================

-- Create a duplicate copy of the raw table.
-- All cleaning operations will occur in staging tables
-- to preserve the integrity of the original dataset.
CREATE TABLE qvi_transaction_data_staging (
    LIKE qvi_transaction_data
);


-- Copy raw transaction data into the staging table.
INSERT INTO qvi_transaction_data_staging
SELECT *
FROM qvi_transaction_data;


-- Verify copied records.
SELECT *
FROM qvi_transaction_data_staging;


-- =============================================================
-- STEP 4: STANDARDIZE DATA TYPES
-- =============================================================

-- The original date column is stored as an Excel serial number.
--
-- Excel stores dates as the number of days
-- since 1899-12-30.
--
-- This query converts the numeric date into a proper SQL DATE.
SELECT
    date,
    DATE '1899-12-30' + date AS converted_date
FROM qvi_transaction_data_staging
LIMIT 10;


-- Permanently convert the date column into SQL DATE datatype.
ALTER TABLE qvi_transaction_data_staging
ALTER COLUMN date TYPE DATE
USING DATE '1899-12-30' + date;


-- Optimize text datatype for better storage efficiency.
-- VARCHAR is generally preferable to TEXT for shorter strings.
ALTER TABLE qvi_transaction_data_staging
ALTER COLUMN prod_name TYPE VARCHAR(255);


-- =============================================================
-- STEP 5: REMOVE DUPLICATES
-- =============================================================

-- Create a second staging table that includes
-- duplicate row tracking.
--
-- ROW_NUMBER() assigns:
-- 1 = first occurrence
-- 2+ = duplicate records
CREATE TABLE qvi_transaction_data_staging2 (
    date DATE,
    store_nbr INT,
    lylty_card INT,
    txn_id INT,
    prod_nbr INT,
    prod_name VARCHAR(255),
    prod_qty INT,
    tot_sales DOUBLE PRECISION,
    row_num INT
);


-- Insert records while generating duplicate rankings.
INSERT INTO qvi_transaction_data_staging2
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY date,
                 store_nbr,
                 lylty_card,
                 txn_id,
                 prod_nbr,
                 prod_name,
                 prod_qty,
                 tot_sales
) AS row_num
FROM qvi_transaction_data_staging;


-- View duplicate records.
-- Any row with row_num > 1 is considered a duplicate.
SELECT *
FROM qvi_transaction_data_staging2
WHERE row_num > 1;


-- Example validation query for a specific transaction.
-- Useful for manually investigating duplicates.
SELECT *
FROM qvi_transaction_data_staging2
WHERE txn_id = 108462;


-- Remove duplicate records while keeping
-- the first occurrence.
DELETE
FROM qvi_transaction_data_staging2
WHERE row_num > 1;


-- Verify cleaned transaction dataset.
SELECT *
FROM qvi_transaction_data_staging2;


-- =============================================================
-- STEP 6: DATA VALIDATION CHECKS
-- =============================================================

-- Detect impossible negative product quantities.
--
-- Business Rule:
-- Product quantity sold should never be negative.
SELECT *
FROM qvi_transaction_data_staging2
WHERE prod_qty < 0;


-- Detect future transaction dates.
--
-- Business Rule:
-- Transaction dates should not exceed today's date.
SELECT *
FROM qvi_transaction_data_staging2
WHERE date > CURRENT_DATE;


-- Detect transactions with zero or negative sales.
--
-- Business Rule:
-- Total sales should always be positive.
SELECT *
FROM qvi_transaction_data_staging2
WHERE tot_sales <= 0;


-- =============================================================
-- STEP 7: OUTLIER DETECTION
-- =============================================================

-- Identify unusually large product purchases.
--
-- This helps detect:
-- 1. Bulk purchases
-- 2. Data entry errors
-- 3. Potential fraudulent activity
SELECT *
FROM qvi_transaction_data_staging2
ORDER BY prod_qty DESC;


-- Generate statistical summaries for transaction quantities.
SELECT
    AVG(prod_qty) AS avg_quantity,
    MAX(prod_qty) AS max_quantity,
    MIN(prod_qty) AS min_quantity,
    STDDEV(prod_qty) AS stddev_quantity
FROM qvi_transaction_data_staging2;


-- =============================================================
-- STEP 8: DATA PROFILING
-- =============================================================

-- Generate transaction-level summary metrics.
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT txn_id) AS unique_transactions,
    COUNT(DISTINCT lylty_card) AS unique_customers,
    COUNT(DISTINCT store_nbr) AS unique_stores,
    ROUND(SUM(tot_sales), 2) AS total_sales
FROM qvi_transaction_data_staging2;


-- =============================================================
-- STEP 9: PERFORMANCE OPTIMIZATION
-- =============================================================

-- Create indexes to improve query performance.
CREATE INDEX idx_transaction_customer
ON qvi_transaction_data_staging2(lylty_card);

CREATE INDEX idx_transaction_date
ON qvi_transaction_data_staging2(date);

CREATE INDEX idx_transaction_product
ON qvi_transaction_data_staging2(prod_nbr);


-- =============================================================
-- STEP 10: REMOVE TEMPORARY COLUMNS
-- =============================================================

-- Remove helper column used during duplicate detection.
ALTER TABLE qvi_transaction_data_staging2
DROP COLUMN row_num;



-- =============================================================
-- SECTION 2: PURCHASE BEHAVIOUR DATA CLEANING
-- =============================================================



-- =============================================================
-- STEP 1: UNDERSTAND AND PROFILE RAW DATA
-- =============================================================

-- Inspect the purchase behaviour dataset.
SELECT *
FROM qvi_purchase_behaviour;


-- Review schema and datatypes.
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'qvi_purchase_behaviour';


-- Count unique customer lifestage segments.
SELECT COUNT(DISTINCT lifestage) AS unique_lifestage
FROM qvi_purchase_behaviour;


-- View distinct lifestage values.
SELECT DISTINCT lifestage AS unique_lifestage_names
FROM qvi_purchase_behaviour
ORDER BY lifestage;


-- Count unique premium customer categories.
SELECT COUNT(DISTINCT premium_customer) AS unique_premium_customer
FROM qvi_purchase_behaviour;


-- View distinct premium customer values.
SELECT DISTINCT premium_customer AS unique_premium_customer_name
FROM qvi_purchase_behaviour
ORDER BY premium_customer;


-- =============================================================
-- STEP 2: CHECK FOR NULL VALUES
-- =============================================================

-- Audit missing values across important customer columns.
SELECT
    SUM(CASE WHEN lylty_card IS NULL THEN 1 ELSE 0 END) AS null_lylty_card,
    SUM(CASE WHEN lifestage IS NULL OR lifestage = '' THEN 1 ELSE 0 END) AS null_lifestage,
    SUM(CASE WHEN premium_customer IS NULL OR premium_customer = '' THEN 1 ELSE 0 END) AS null_premium_customer
FROM qvi_purchase_behaviour;


-- =============================================================
-- STEP 3: CREATE STAGING TABLE
-- =============================================================

-- Create staging table for safe cleaning operations.
CREATE TABLE qvi_purchase_behaviour_staging (
    LIKE qvi_purchase_behaviour
);


-- Copy raw customer data into staging table.
INSERT INTO qvi_purchase_behaviour_staging
SELECT *
FROM qvi_purchase_behaviour;


-- Verify copied records.
SELECT *
FROM qvi_purchase_behaviour_staging;


-- =============================================================
-- STEP 4: STANDARDIZE DATA TYPES
-- =============================================================

-- Optimize text columns using VARCHAR.
ALTER TABLE qvi_purchase_behaviour_staging
ALTER COLUMN lifestage TYPE VARCHAR(255),
ALTER COLUMN premium_customer TYPE VARCHAR(255);


-- =============================================================
-- STEP 5: REMOVE DUPLICATES
-- =============================================================

-- Create duplicate-tracking staging table.
CREATE TABLE qvi_purchase_behaviour_staging2 (
    lylty_card INT,
    lifestage VARCHAR(255),
    premium_customer VARCHAR(255),
    row_num INT
);


-- Insert records while assigning duplicate rankings.
INSERT INTO qvi_purchase_behaviour_staging2
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY lylty_card,
                 lifestage,
                 premium_customer
) AS row_num
FROM qvi_purchase_behaviour_staging;


-- View duplicate customer records.
SELECT *
FROM qvi_purchase_behaviour_staging2
WHERE row_num > 1;


-- Remove duplicate customer records.
DELETE
FROM qvi_purchase_behaviour_staging2
WHERE row_num > 1;


-- =============================================================
-- STEP 6: DATA VALIDATION CHECKS
-- =============================================================

-- Detect invalid or blank lifestage values.
SELECT *
FROM qvi_purchase_behaviour_staging2
WHERE lifestage IS NULL
OR lifestage = '';


-- Detect invalid premium customer values.
SELECT *
FROM qvi_purchase_behaviour_staging2
WHERE premium_customer IS NULL
OR premium_customer = '';


-- =============================================================
-- STEP 7: REFERENTIAL INTEGRITY CHECKS
-- =============================================================

-- Ensure every customer in the transaction table
-- exists in the customer behaviour table.
SELECT DISTINCT t.lylty_card
FROM qvi_transaction_data_staging2 t
LEFT JOIN qvi_purchase_behaviour_staging2 p
    ON t.lylty_card = p.lylty_card
WHERE p.lylty_card IS NULL;


-- =============================================================
-- STEP 8: DATA PROFILING
-- =============================================================

-- Generate customer-level summary metrics.
SELECT
    COUNT(DISTINCT lylty_card) AS unique_customers,
    COUNT(DISTINCT lifestage) AS unique_lifestages,
    COUNT(DISTINCT premium_customer) AS unique_customer_types
FROM qvi_purchase_behaviour_staging2;


-- =============================================================
-- STEP 9: PERFORMANCE OPTIMIZATION
-- =============================================================

-- Create indexes for faster joins and filtering.
CREATE INDEX idx_customer_card
ON qvi_purchase_behaviour_staging2(lylty_card);

CREATE INDEX idx_customer_lifestage
ON qvi_purchase_behaviour_staging2(lifestage);


-- =============================================================
-- STEP 10: REMOVE TEMPORARY COLUMNS
-- =============================================================

-- Remove helper column used during duplicate detection.
ALTER TABLE qvi_purchase_behaviour_staging2
DROP COLUMN row_num;


-- =============================================================
-- FINAL CLEANED DATASETS
-- =============================================================

-- Final cleaned transaction dataset.
SELECT *
FROM qvi_transaction_data_staging2;


-- Final cleaned customer behaviour dataset.
SELECT *
FROM qvi_purchase_behaviour_staging2;
