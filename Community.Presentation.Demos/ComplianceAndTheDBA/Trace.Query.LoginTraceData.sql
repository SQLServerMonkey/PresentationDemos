USE [master];
GO

SELECT *
FROM sys.traces
;

SELECT TRC.NTDomainName, TRC.NTUserName, TRC.LoginName, TRC.HostName, TRC.ApplicationName, TRC.SPID,
	TRC.Success, TRC.ServerName, TRC.EventClass, TRC.State, TRC.Error, TRC.DatabaseName, TRC.StartTime,
	TRC.EndTime
FROM sys.fn_trace_gettable
(
	'C:\Program Files\Microsoft SQL Server\MSSQL11.KAPUCHIN_2012\MSSQL\Log\SecurityAudit.LoginActivity.trc',
	DEFAULT
) AS TRC
;