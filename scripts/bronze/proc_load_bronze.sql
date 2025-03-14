/*
========================================================================================================
Stored Procedure: Load bronze Layer (Source -> Bronze)
========================================================================================================
Script Purpose:
  This stored procedure loads data into "bronze" schema from the extrenal CSV files.
  It performs the following actions:
    1. Truncates the bronze tables before loading
    2. Uses the "BULK INSERT" command to load the CSV files in the bronze tables

Parameters:
    None.
  This stored procedure does not accept parameters or return any values.

Usage example:
    EXEC bronze.load_bronze;
=========================================================================================================
*/
-- Creating a procedure "bronze.load_bronze"
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time	DATETIME, @end_time	DATETIME, @batch_start_time	DATETIME, @batch_end_time	DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();

		PRINT'======================================================================';
		PRINT'Loading the bronze layer';
		PRINT'======================================================================';

		PRINT'----------------------------------------------------------------------';
		PRINT'Loading CRM Tables';
		PRINT'----------------------------------------------------------------------';
	
		-- Truncating and Bulk Inserting data in the "bronze.crm_cust_info" table
		
		SET @start_time = GETDATE();
		PRINT'>> Truncating table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		
		PRINT'>>Inserting data into table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\khuma\OneDrive\Documents\Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'--------------------';
		
		-- Truncating and Bulk Inserting data in the "bronze.crm_prd_info" table
		
		SET @start_time = GETDATE();
		PRINT'>> Truncating table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		
		PRINT'>>Inserting data into table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\khuma\OneDrive\Documents\Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'--------------------';

		-- Truncating and Bulk Inserting data in the "bronze.crm_sales_datails" table
		
		SET @start_time = GETDATE();
		PRINT'>> Truncating table: bronze.crm_sales_datails';
		TRUNCATE TABLE bronze.crm_sales_datails;
		
		PRINT'>>Inserting data into table: bronze.crm_sales_datails';
		BULK INSERT bronze.crm_sales_datails
		FROM 'C:\Users\khuma\OneDrive\Documents\Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'--------------------';

		PRINT'----------------------------------------------------------------------';
		PRINT'Loading ERP Tables';
		PRINT'----------------------------------------------------------------------';
		
		-- Truncating and Bulk Inserting data in the "bronze.erp_cust_az12" table
		
		SET @start_time = GETDATE();
		PRINT'>> Truncating table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		
		PRINT'>>Inserting data into table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\khuma\OneDrive\Documents\Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'--------------------';

		-- Truncating and Bulk Inserting data in the "bronze.erp_loc_a101" table
		
		SET @start_time = GETDATE();
		PRINT'>> Truncating table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
	
		PRINT'>>Inserting data into table: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\khuma\OneDrive\Documents\Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'--------------------';

		-- Truncating and Bulk Inserting data in the "bronze.erp_px_cat_g1v2" table
		
		SET @start_time = GETDATE();
		PRINT'>> Truncating table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	
		PRINT'>>Inserting data into table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\khuma\OneDrive\Documents\Projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'--------------------';

		SET @batch_end_time = GETDATE();
		PRINT'======================================================================';
		PRINT'Loading Bronze Layer is Complete';
		PRINT'	- Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT'======================================================================';

	END TRY
	BEGIN CATCH
		PRINT'======================================================================';
		PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT'Error message ' + ERROR_MESSAGE();
		PRINT'Error message ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT'Error message ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT'======================================================================';
	END CATCH
END
