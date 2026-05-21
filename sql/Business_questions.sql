/*
================================================================================
BUSINESS PERFORMANCE ANALYSIS
================================================================================
This script answers key business questions across customer, store, and product
performance using transaction and customer behaviour data.
================================================================================
*/


-- ============================================================================
-- 1. HOW EFFECTIVE IS THE LOYALTY PROGRAM IN DRIVING REPEAT PURCHASES
-- AND HIGHER BASKET SIZES?
-- ============================================================================

SELECT
    c.lylty_card,
    COUNT(DISTINCT t.txn_id) AS total_transactions,
    ROUND(SUM(t.tot_sales)::NUMERIC, 2) AS total_revenue,
    ROUND(AVG(t.tot_sales)::NUMERIC, 2) AS avg_basket_size,
    ROUND(
        COUNT(DISTINCT t.txn_id)::NUMERIC /
        COUNT(DISTINCT c.lylty_card),
        2
    ) AS avg_purchase_frequency
FROM qvi_transaction_data_staging2 t
JOIN qvi_purchase_behaviour_staging c
    ON t.lylty_card = c.lylty_card
GROUP BY c.lylty_card
ORDER BY total_revenue DESC;


-- ============================================================================
-- 2. WHICH STORES CONSISTENTLY OUTPERFORM OTHERS,
-- AND WHAT CUSTOMER BEHAVIOURS DRIVE THEIR SUCCESS?
-- ============================================================================

SELECT
    t.store_nbr,
    COUNT(DISTINCT t.txn_id) AS transactions,
    ROUND(SUM(t.tot_sales)::NUMERIC, 2) AS total_sales,
    ROUND(AVG(t.tot_sales)::NUMERIC, 2) AS avg_transaction_value,
    ROUND(AVG(t.prod_qty)::NUMERIC, 2) AS avg_items_per_transaction
FROM qvi_transaction_data_staging2 t
GROUP BY t.store_nbr
ORDER BY total_sales DESC;


-- ============================================================================
-- 3. WHAT PRODUCTS GENERATE THE HIGHEST REVENUE VERSUS THE HIGHEST
-- TRANSACTION VOLUME?
-- ============================================================================

-- 3a. Revenue and volume contribution per product
SELECT
    prod_name,
    SUM(prod_qty) AS total_units_sold,
    ROUND(SUM(tot_sales)::NUMERIC, 2) AS total_revenue,
    COUNT(DISTINCT txn_id) AS transaction_volume
FROM qvi_transaction_data_staging2
GROUP BY prod_name
ORDER BY total_revenue DESC;


-- 3b. Product popularity based on transaction count
SELECT
    prod_name,
    COUNT(DISTINCT txn_id) AS transaction_volume
FROM qvi_transaction_data_staging2
GROUP BY prod_name
ORDER BY transaction_volume DESC;


-- ============================================================================
-- 4. WHICH CUSTOMER GROUPS SHOULD THE BUSINESS PRIORITISE FOR
-- LONG-TERM GROWTH?
-- ============================================================================

SELECT
    c.lifestage,
    c.primium_customer,
    COUNT(DISTINCT t.lylty_card) AS customers,
    ROUND(SUM(t.tot_sales)::NUMERIC, 2) AS total_revenue,
    ROUND(AVG(t.tot_sales)::NUMERIC, 2) AS avg_transaction_value,
    COUNT(DISTINCT t.txn_id) AS transactions
FROM qvi_transaction_data_staging2 t
JOIN qvi_purchase_behaviour_staging2 c
    ON t.lylty_card = c.lylty_card
GROUP BY c.lifestage, c.primium_customer
ORDER BY total_revenue DESC;


-- ============================================================================
-- 5. WHAT PURCHASING BEHAVIOURS DIFFERENTIATE PREMIUM CUSTOMERS
-- FROM MAINSTREAM CUSTOMERS?
-- ============================================================================

SELECT
    c.primium_customer,
    ROUND(AVG(t.tot_sales)::NUMERIC, 2) AS avg_transaction_value,
    ROUND(AVG(t.prod_qty)::NUMERIC, 2) AS avg_quantity_purchased,
    COUNT(DISTINCT t.txn_id) AS total_transactions,
    ROUND(SUM(t.tot_sales)::NUMERIC, 2) AS total_revenue
FROM qvi_transaction_data_staging2 t
JOIN qvi_purchase_behaviour_staging2 c
    ON t.lylty_card = c.lylty_card
GROUP BY c.primium_customer;


-- ============================================================================
-- 6. WHICH PRODUCTS AND CUSTOMER SEGMENTS DRIVE THE HIGHEST
-- AVERAGE TRANSACTION VALUE?
-- ============================================================================

SELECT
    c.lifestage,
    c.primium_customer,
    t.prod_name,
    ROUND(AVG(t.tot_sales)::NUMERIC, 2) AS avg_transaction_value
FROM qvi_transaction_data_staging2 t
JOIN qvi_purchase_behaviour_staging2 c
    ON t.lylty_card = c.lylty_card
GROUP BY
    c.lifestage,
    c.primium_customer,
    t.prod_name
ORDER BY avg_transaction_value DESC
LIMIT 20;


-- ============================================================================
-- 7. ARE THERE UNDERPERFORMING STORES THAT REQUIRE STRATEGIC INTERVENTION?
-- ============================================================================

SELECT
    store_nbr,
    ROUND(SUM(tot_sales)::NUMERIC, 2) AS total_sales,
    COUNT(DISTINCT txn_id) AS transactions,
    ROUND(AVG(tot_sales)::NUMERIC, 2) AS avg_transaction_value
FROM qvi_transaction_data_staging2
GROUP BY store_nbr
ORDER BY total_sales ASC;


-- ============================================================================
-- 8. ARE THERE UNDERPERFORMING PRODUCTS THAT REQUIRE STRATEGIC INTERVENTION?
-- ============================================================================

SELECT
    prod_name,
    ROUND(SUM(tot_sales)::NUMERIC, 2) AS total_revenue,
    SUM(prod_qty) AS units_sold,
    COUNT(DISTINCT txn_id) AS transactions
FROM qvi_transaction_data_staging2
GROUP BY prod_name
ORDER BY total_revenue ASC;