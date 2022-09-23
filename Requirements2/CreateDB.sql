-- check if database exists.  if so, delete and recreate it

if db_id('ClientDB') is not null
BEGIN
print 'database ClientDB already exists.  Deleting database.'
USE master;
ALTER DATABASE ClientDB
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;
DROP DATABASE ClientDB;
END

BEGIN
print 'creating database ClientDB'
CREATE DATABASE ClientDB;
END