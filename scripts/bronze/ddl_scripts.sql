/*
===============================================================================================
DDL Script: Create Bronze Tables
===============================================================================================
Script Purpose:
  This script creates tables in the "bronze" schema, dropping them if they already exist.
  Run this script to redefine the DDL structure of the "bronze" tables.
===============================================================================================
*/
-- Making sure that you are using the "DataWarehouse" database

USE DataWarehouse;
GO
-- Dropping the "bronze.crm_cust_info" table if it exists.
IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE IF EXISTS bronze.crm_cust_info;
GO

-- Creating the "bronze.crm_cust_info" table
CREATE TABLE bronze.crm_cust_info(
	cst_id			INT,
	cst_key			NVARCHAR(50),
	cst_firstname		NVARCHAR(50),
	cst_lastname		NVARCHAR(50),
	cst_marital_status	NVARCHAR(50),
	cst_gndr		NVARCHAR(50),
	cst_create_date		DATE
);
GO

-- Checking the "bronze.crm_cust_info" table
SELECT * FROM bronze.crm_cust_info;
GO

-- Dropping the "bronze.crm_prd_info" table if it exists.
IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE IF EXISTS bronze.crm_prd_info;
GO

-- Creating the "bronze.crm_prd_info" table
CREATE TABLE bronze.crm_prd_info(
	prd_id			INT,
	prd_key			NVARCHAR(50),
	prd_nm			NVARCHAR(50),
	prd_cost		INT,
	prd_line		NVARCHAR(50),
	prd_start_dt		DATETIME,
	prd_end_dt		DATETIME
);
GO

-- Checking the "bronze.crm_prd_info" table
SELECT * FROM bronze.crm_prd_info;
GO

-- Dropping the table "bronze.crm_sales_datails" if it exists
IF OBJECT_ID ('bronze.crm_sales_datails', 'U') IS NOT NULL
	DROP TABLE IF EXISTS bronze.crm_sales_datails;
GO

-- Creating the table "bronze.crm_sales_datails".

CREATE TABLE bronze.crm_sales_datails(
	sls_ord_num		NVARCHAR(50),
	sls_prd_key		NVARCHAR(50),
	sls_cust_id		INT,
	sls_order_dt		INT,
	sls_ship_dt		INT,
	sls_due_dt		INT,
	sls_sales		INT,
	sls_quantity		INT,
	sls_price		INT
);
GO

-- Checking the "bronze.crm_sales_datails" table.
SELECT * FROM bronze.crm_sales_datails;
GO

-- Dropping the "bronze.erp_cust_az12" table if it exists.
IF OBJECT_ID ('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE IF EXISTS bronze.erp_cust_az12;
GO

-- Creating the "bronze.erp_cust_az12" table
CREATE TABLE bronze.erp_cust_az12(
	cid			NVARCHAR(50),
	bdate			DATE,
	gen			NVARCHAR(50)
);
GO

--Checking the "bronze.erp_cust_az12" table
SELECT * FROM bronze.erp_cust_az12;
GO

-- Dropping the "bronze.erp_loc_a101" table if it exists.
IF OBJECT_ID ('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE IF EXISTS bronze.erp_loc_a101;
GO

-- Creating the "bronze.erp_loc_a101" table
CREATE TABLE bronze.erp_loc_a101(
	cid			NVARCHAR(50),
	cntry			NVARCHAR(50)
);
GO

-- Checking the "bronze.erp_loc_a101" table.
SELECT * FROM bronze.erp_loc_a101;
GO

-- Dropping the "bronze.erp_px_cat_g1v2" table if it exists.
IF OBJECT_ID ('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
GO

-- Creating the "bronze.erp_px_cat_g1v2" table.
CREATE TABLE bronze.erp_px_cat_g1v2(
	id			NVARCHAR(50),
	cat			NVARCHAR(50),
	subcat			NVARCHAR(50),
	maintenance		NVARCHAR(50)
);
GO

-- Checking the "bronze.erp_px_cat_g1v2" table
SELECT * FROM bronze.erp_px_cat_g1v2;
GO
