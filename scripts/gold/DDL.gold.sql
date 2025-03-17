/*
===================================================================================================================
DDL Script: Create Gold Views
===================================================================================================================
Script purpose:
    This script creates views for the gold layer in the Data Warehouse.
    The gold layer represents the final dimension and fact tables (Star Schema).

    Each view performs transformations and combines data from the silver layer to produce clean, enriched and
    business-ready dataset.
Usage:
    These views can be queried directly for analytics and reporting.
===================================================================================================================
*/

-- ================================================================================================================
-- Create Dimension: gold.dim_customers
-- ================================================================================================================

-- Dropping the "gold.dim_customers" view if it exists.
IF OBJECT_ID ('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
-- Creating the "gold.dim_customers" view
CREATE VIEW gold.dim_customers AS
	
	SELECT
		ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,
		ci.cst_id               AS customer_id,
		ci.cst_key              AS customer_number,
		ci.cst_firstname        AS first_name,
		ci.cst_lastname         AS last_name,
		CASE
			WHEN ci.cst_gndr != 'n/a'
        THEN ci.cst_gndr
			ELSE COALESCE(ca.gen, 'n/a')
		END                     AS gender,
		ca.bdate AS birthdate,
		ci.cst_marital_status   AS marital_status,
		la.cntry AS country,
		ci.cst_create_date      AS create_date
	FROM
		silver.crm_cust_info AS ci
	LEFT JOIN
		silver.erp_cust_az12 AS ca
			ON ci.cst_key = ca.cid
	LEFT JOIN
		silver.erp_loc_a101 AS la
			ON ci.cst_key = la.cid;

-- Checking the "gold.dim_customers" view
SELECT * FROM gold.dim_customers;

-- ================================================================================================================
-- Create Dimension: gold.dim_products
-- ================================================================================================================

-- Dropping the "gold.dim_products" view if it exists.
IF OBJECT_ID ('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
-- Creating the "gold.dim_products" view
CREATE VIEW gold.dim_products AS

	SELECT
		ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
		pn.prd_id           AS product_id,
		pn.prd_key          AS product_number,
		pn.prd_nm           AS product_name,
		pn.cat_id           AS category_id,
		pc.cat              AS category,
		pc.subcat           AS subcategory,
		pc.maintenance,
		pn.prd_cost         AS cost,
		pn.prd_line         AS product_line,
		pn.prd_start_dt     AS start_date
	FROM
		silver.crm_prd_info AS pn
	LEFT JOIN
		silver.erp_px_cat_g1v2 pc
			ON pn.cat_id = pc.id
	WHERE
		pn.prd_end_dt IS NULL; -- Filter out all historical data

-- Checking the "gold.dim_products" view
SELECT * FROM gold.dim_products;

-- ================================================================================================================
-- Create Dimension: gold.fact_sales
-- ================================================================================================================

-- Dropping the "gold.fact_sales" view if it exists.
IF OBJECT_ID ('gold.fact_sales', 'V') IS NOT NULL
	DROP VIEW gold.fact_sales;
-- Creating the "gold.fact_sales" view
CREATE VIEW gold.fact_sales AS

	SELECT
		sd.sls_ord_num       AS order_number,
		pr.product_key,
		cu.customer_key,
		sd.sls_order_dt      AS order_date,
		sd.sls_ship_dt       AS shipping_date,
		sd.sls_due_dt        AS due_date,
		sd.sls_sales         AS sales_amount,
		sd.sls_quantity      AS quantity,
		sd.sls_price         AS price
	FROM
		silver.crm_sales_details AS sd
	LEFT JOIN
		gold.dim_products AS pr
			ON sd.sls_prd_key = pr.product_number
	LEFT JOIN
		gold.dim_customers AS cu
			ON sd.sls_cust_id = cu.customer_id;

-- Checking the "gold.fact_sales" view
SELECT * FROM gold.fact_sales;
