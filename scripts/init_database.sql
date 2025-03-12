/*
=========================================================================
Create Database and Schemas
=========================================================================
Purpose of this script:
The purpose of this script is to create a new database called "DataWarehouse". The script will check if the database exists,
if it doesn't exist it will create one, if it does exist already it will be dropped and be recreated. The script will also
create three schemas namely "bronze", "silver", and "gold" in the newly created database.

Warning:
Running this script will permanently drop (delete) the entire "DataWarehouse" database if it exists. Proceed with caution
and make sure you have proper backup.
*/

-- To log into the master (Default database) database

USE master;
GO

-- Dropping the database if it exists

DROP DATABASE IF EXISTS DataWarehouse;
GO
-- Creating a database called DataWareHouse

CREATE DATABASE DataWarehouse;
GO
  
-- Switching to the created database

USE DataWarehouse;
GO
  
/*
Creating the three schemas that will be used in this project. That is the
Bronze, Silver, and Gold Schemas
*/

CREATE SCHEMA bronze;	-- Creating the bronze schema
GO

CREATE SCHEMA silver;	-- Creating the silver schema
GO

CREATE SCHEMA gold;		-- Creating the gold schema
GO
