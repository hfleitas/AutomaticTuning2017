--Going Autonomous!
--Must have SQL Server 2017+ 
--Set userdbs compat levels to 140, 150, etc...

use master
go
exec sp_msforeachdb N'use ? 
if db_id()>4 
begin 
	alter database ? set QUERY_STORE = ON; 
	alter database ? set QUERY_STORE(OPERATION_MODE = READ_WRITE); 
	alter database ? set AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = ON); -- this is the magic!
end';

--Get AT Actual State
exec sp_msforeachdb N'use ? 
if db_id()>4 
begin
	select	 db_name(db_id()) as db
			,name
			,desired_state_desc
			,actual_state_desc
			,reason_desc 
	from	sys.database_automatic_tuning_options;
end else begin select null end';
go

--Monitor
exec sp_msforeachdb N'use ? if db_id()>4 begin 
select		 db_name(db_id()) as db,
			 reason
			,score
			,CurrentState = json_value(state,''$.currentValue'') 
			,ReasonState = json_value(state,''$.reason'') 
			,script = JSON_VALUE(details, ''$.implementationDetails.script'')
			,planForceDetails.*
			,estimated_gain = (regressedPlanExecutionCount + recommendedPlanExecutionCount) * (regressedPlanCpuTimeAverage - recommendedPlanCpuTimeAverage) / 1000000
			,error_prone = IIF(regressedPlanErrorCount > recommendedPlanErrorCount, ''YES'', ''NO'')
from		sys.dm_db_tuning_recommendations
cross apply	OPENJSON(Details, ''$.planForceDetails'') with (
			 [query_id] int ''$.queryId''
			,[current plan_id] int ''$.regressedPlanId''
			,[recommended plan_id] int ''$.recommendedPlanId''
			,regressedPlanErrorCount int
			,recommendedPlanErrorCount int
			,regressedPlanExecutionCount int
			,regressedPlanCpuTimeAverage float
			,recommendedPlanExecutionCount int
			,recommendedPlanCpuTimeAverage float
			) as planForceDetails;
end
else begin select null end';
go
