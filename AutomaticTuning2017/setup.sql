USE [master]
GO
ALTER DATABASE [WideWorldImporters] SET QUERY_STORE = ON
GO
ALTER DATABASE [WideWorldImporters] SET QUERY_STORE (OPERATION_MODE = READ_WRITE)
GO
--Kept Defaults:
--dataflush interval (minutes) 50
--statistics colleciton interval 15 minutes
--max size (MB) 500
--query store capture mode Auto
--size based cleanup mode Auto
--stale query threshold (days) 30
go

use WideWorldImporters
go
DROP procedure if exists [dbo].[initialize]
go
CREATE   procedure [dbo].[initialize]
as begin
DBCC FREEPROCCACHE;
ALTER DATABASE current SET QUERY_STORE CLEAR ALL;
ALTER DATABASE current SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = OFF);
end
GO

DROP procedure if exists [dbo].[auto_tune]
go
CREATE   procedure [dbo].[auto_tune]
as begin
ALTER DATABASE current SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = ON); --THIS IS THE MAGIC!
DBCC FREEPROCCACHE;
ALTER DATABASE current SET QUERY_STORE CLEAR ALL;
end
GO

DROP PROCEDURE if exists [dbo].[report]
go
CREATE PROCEDURE [dbo].[report] ( @packagetypeid INT )
AS
    BEGIN

        SELECT  AVG([UnitPrice] * [Quantity] - [TaxRate])
        FROM    [Sales].[OrderLines]
        WHERE   [PackageTypeID] = @packagetypeid;

    END;
GO

DROP PROCEDURE if exists [dbo].[regression]
go
CREATE PROCEDURE [dbo].[regression]
AS
    BEGIN
        DBCC FREEPROCCACHE;
        BEGIN
            DECLARE @packagetypeid INT = 1;
            EXEC [report] @packagetypeid;
        END;
    END;
GO