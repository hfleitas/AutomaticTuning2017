restore filelistonly from disk = 'c:\sql_sample_databases\wideworldimporters-full.bak'
go
restore database wideworldimporters from disk = 'c:\sql_sample_databases\wideworldimporters-full.bak'
with move 'wwi_primary' to 'd:\data\wideworldimporters.mdf',
move 'wwi_userdata' to 'd:\data\wideworldimporters_userdata.ndf',
move 'wwi_log' to 'd:\data\wideworldimporters.ldf',
move 'wwi_inmemory_data_1' to 'd:\data\wideworldimporters_inmemory_data_1'
go