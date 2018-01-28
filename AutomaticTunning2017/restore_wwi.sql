--verify
restore filelistonly from disk = 'c:\users\hfleitas\downloads\wideworldimporters-full.bak'
go 
--set your own paths
restore database [WideWordImporters] from disk = 'c:\users\hfleitas\downloads\wideworldimporters-full.bak'
with move 'wwi_primary' to 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\wideworldimporters.mdf' 
,move 'wwi_userdata' to 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\wideworldimporters_userdata.ndf'
,move 'wwi_log' to 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\wideworldimporters.ldf'
,move 'wwi_inmemory_data_1' to 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\wideworldimporters_inmemory_data_1'
,stats = 25
go
--rollup compat to 2017
alter database [WideWordImporters] set compatibility_level = 140
go
--update stats
use [WideWordImporters]
go
EXEC sp_updatestats 