/*
=====================================================================
Stored Procedure : Load Bronze Layer (Source -> Bronze)
=====================================================================
Scripts Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    Its perform the following actions:
    -Truncates the bronze table before loading data.
    -Uses the 'Bulk INSERT' command to load the data from csv files to beonze tables.

Parameters:
 None.
This stored procedure does not accept any parameters or retun any values.

Usage example:
  EXEC bronze.load_bronze
  ======================================================================
  */

  
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	 DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
		SET @batch_start_time = GETDATE();
    PRINT '===================================';
   PRINT 'Loading Bronze Layer';
   PRINT '========================================';

   PRINT '-------------------------------------------';
   PRINT 'Loading  CRM Tables'
   PRINT '-------------------------------------------';
		--step :build sql load scripts
		--PRINT'>> Truncating Table: bronze.crm_cust_info'
	--	TRUNCATE TABLE  bronze.crm_cust_info; --IF u have executed the tabel e times

	    SET @start_time = GETDATE();
	    PRINT'>> INSERTING DATA INTO: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Mohit\Downloads\sql datawarehouse project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR   = ',',           --FILE SEPRATOR
			TABLOCK
		);

		 SET @end_time = GETDATE();
		 PRINT '>> LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + 'seconds';
		 PRINT '----------------------------------------------------------------------------';
		

		--PRINT'>> Truncating Table: bronze.crm_prd_info'
		--TRUNCATE TABLE  bronze.crm_prd_info;
		SET @start_time = GETDATE();
		 PRINT'>> INSERTING DATA INTO:bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Mohit\Downloads\sql datawarehouse project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR   = ',',           --FILE SEPRATOR
			TABLOCK
		);
		
		 SET @end_time = GETDATE();
		 PRINT '>> LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + 'seconds';
		 PRINT '----------------------------------------------------------------------------';

		--PRINT'>> Truncating Table: bronze.crm_sales_details'
		--TRUNCATE TABLE  bronze.crm_sales_details;
		SET @start_time = GETDATE();
		 PRINT'>> INSERTING DATA INTO:crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Mohit\Downloads\sql datawarehouse project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR   = ',',           --FILE SEPRATOR
			TABLOCK
		);
		 SET @end_time = GETDATE();
		 PRINT '>> LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + 'seconds';
		 PRINT '----------------------------------------------------------------------------';

   PRINT '-------------------------------------------';
   PRINT 'Loading  ERP Tables'
   PRINT '-------------------------------------------';

       -- PRINT'>> Truncating Table: bronze.erp_loc_a101'
		--TRUNCATE TABLE  bronze.erp_loc_a101;
		 SET @end_time = GETDATE();
		 PRINT'>> INSERTING DATA INTO: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Mohit\Downloads\sql datawarehouse project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR   = ',',           --FILE SEPRATOR
			TABLOCK
		);
		 SET @end_time = GETDATE();
		 PRINT '>> LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + 'seconds';
		 PRINT '----------------------------------------------------------------------------';
		--PRINT'>> Truncating Table: bronze.erp_cust_az12'
		--TRUNCATE TABLE  bronze.erp_cust_az12;
		 SET @end_time = GETDATE();
		PRINT'>> INSERTING DATA INTO: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Mohit\Downloads\sql datawarehouse project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR   = ',',           --FILE SEPRATOR
			TABLOCK
		);
		 SET @end_time = GETDATE();
		 PRINT '>> LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + 'seconds';
		 PRINT '----------------------------------------------------------------------------';

		--PRINT'>> Truncating Table: bronze.erp_px_cat_g1v2'
		--TRUNCATE TABLE  bronze.erp_px_cat_g1v2;

		 SET @end_time = GETDATE();
		PRINT'>> INSERTING DATA INTO: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Mohit\Downloads\sql datawarehouse project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR   = ',',           --FILE SEPRATOR
			TABLOCK
		);

		 SET @end_time = GETDATE();
		 PRINT '>> LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + 'seconds';
		 PRINT '----------------------------------------------------------------------------';

		 SET @batch_end_time = GETDATE();
		 PRINT '========================================='
		 PRINT 'loading bronze layer is completed';
		 PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR ) + 'seconds';
		 PRINT '=========================================='


		END TRY
		BEGIN CATCH
		PRINT '================================'
		PRINT ' ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR );
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR );
		PRINT '================================'
		END CATCH
END
