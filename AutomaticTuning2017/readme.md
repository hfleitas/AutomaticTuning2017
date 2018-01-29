--  +----------------+
--  | Hiram's Readme |
--  +----------------+

2017 Automatic Tuning: (requirements: perfmon, sqlcmd, ostress.exe, sql2017, wwi db)
C:\Deployments\demo3_sqlserverkeepsyoufast\ 

wwi db (see latest release WideWorldImporters-Full.bak [121 MB]): 
https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers

- THANK YOU BOB WARD!

Copied ostress.exe into C:\Deployments\demo3_sqlserverkeepsyoufast 
I had previously installed RML Utilities: https://support.microsoft.com/en-us/help/944837/description-of-the-replay-markup-language-rml-utilities-for-sql-server

Replaced “.\sql2017” with “localhost” in files C:\Deployments\demo3_sqlserverkeepsyoufast\*.cmd (I had previously restored wwi on my local instance)
Edited setup.sql, replaced DROP procedure with DROP procedure if exists
 
PowerShell window 1:
PS ran .\report.cmd
 
PowerShell window 2:
PS perfom, performance monitor, added SQLServer:SQL Statistics:Batch Requests/sec. 
PS .\repro_setup.cmd
PS .\initialize.cmd
PS .\auto_tune.cmd
PS .\regression.cmd

--  +--------------+
--  | Bob's Readme |
--  +--------------+

This demo should work on any machine running SQL Server 2017 RTM.

It assumes you have restored the WideWorldImporters sample on a SQL Server 2017 instance. You can find this backup at: https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0

1. Run the script setup.sql to install some stored procedures in the WideWorldImporters database

2. Walk through the steps in demo-full.sql to show how Auto Plan Correction Works

3. Bring up the Query Store Reports for Queries with Forced Plans to see how the plan was changed and how we forced the faster one

