# Automatic Tunning 2017

Pass Summit 2017 Summary Presentation - SQL Server 2017 Automatic Tuning

## Getting Started

This demo should work on any machine running SQL Server 2017.

It assumes you have restored the WideWorldImporters sample database on a SQL Server 2017 instance. 

2017 Automatic Tuning: (requirements: perfmon, sqlcmd, ostress.exe, sql2017, wwi db)

C:\Deployments\demo3_sqlserverkeepsyoufast\ 

wwi db (see latest release WideWorldImporters-Full.bak [121 MB]): https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers

### Prerequisites

Powershell/Cmd, Perfmon, sqlcmd, ostress.exe, SQL Server 2017, WideWorldImporters database.

### Installing

Install SQL Server 2017 on your local machine. I recommend choosing Developer Edition for the purpose of this demo:  https://www.microsoft.com/en-us/sql-server/sql-server-downloads

Install RML Utilities: https://support.microsoft.com/en-us/help/944837/description-of-the-replay-markup-language-rml-utilities-for-sql-server

```
Copy ostress.exe into C:\Deployments\demo3_sqlserverkeepsyoufast 
```

Download latest release WideWorldImporters-Full.bak [121 MB] and restore it. (If you already have you may skip this step)
https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers

```
--verify
restore filelistonly from disk = 'c:\downloads\wideworldimporters-full.bak'
go 
--set your own paths
restore database WideWordImporters from disk = 'c:\downloads\wideworldimporters-full.bak'
with move 'wwi_primary' to 'd:\data\wideworldimporters.mdf' 
,move 'wwi_userdata' to 'd:\data\wideworldimporters_userdata.ndf'
,move 'wwi_log' to 'd:\data\wideworldimporters.ldf'
,move 'wwi_inmemory_data_1' to 'd:\data\wideworldimporters_inmemory_data_1'
,stats = 25
go
```

End with state on FLGP is ON:

```
SELECT name, desired_state_desc, actual_state_desc, reason_desc FROM sys.database_automatic_tuning_options;
```

## Running the tests
 
PowerShell window 1:

```
.\report.cmd
```

PowerShell window 2:

```
perfom ## performance monitor, added SQLServer:SQL Statistics:Batch Requests/sec. 
.\repro_setup.cmd
.\initialize.cmd
.\auto_tune.cmd
.\regression.cmd
```

### Purpose

This test will illustrate a regression of batch requests per second due to a new compiled execution plan with parameter sniffing, and will force the last good plan by automatically tunning SQL Server to resolve the regression. The intention is to relieve the reactive emergency/oncall support model by aliviating a need for manual intervention. It's advisable to monitor the system for forced plans and revist why there occurred to prevent the issue if possible.

### Example

See screenshot file(s): 2017AutomaticTuningDemo.PNG or Perfmon3.PNG.

## Deployment

Place contents of https://github.com/hfleitas/AutomaticTunning2017/tree/master/AutomaticTunning2017 
in C:\Deployments\demo3_sqlserverkeepsyoufast 
Follow instructions.

## Built With

* [SQL Server 2017](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) - The #1 database engine in the world.
* [Ostress.exe](https://support.microsoft.com/en-us/help/944837/description-of-the-replay-markup-language-rml-utilities-for-sql-server) - The RML Utility executable to simulate the report execution load.
* [SQLCMD](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility) - The utility to invoke several script files from Powershell or command prompt. 

## Contributing

Please read [CONTRIBUTING.md](https://github.com/hfleitas/AutomaticTunning2017) for code of conduct, and the process for submitting pull requests.

## Versioning

I use [Github](http://github.com/) for versioning. For the versions available, see the [tags on this repository](https://github.com/hfleitas/AutomaticTunning2017/tags). 

## Authors

* **Hiram Fleitas** - *Repo - AutomaticTuning2017* - [Hiram Fleitas](https://github.com/hfleitas)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* [Bob Ward](https://github.com/rgward)
