USE [master];
GO

DECLARE @TraceID		INT
DECLARE @TraceOutput	NVARCHAR(256)
DECLARE @MaxFileSize	BIGINT
DECLARE @MaxFiles		INT
DECLARE @StopTrace		DATETIME
;

SET @TraceOutput = N'C:\Program Files\Microsoft SQL Server\MSSQL11.KAPUCHIN_2012\MSSQL\Log\SecurityAudit.LoginActivity'
SET @MaxFiles = 5
SET @MaxFileSize = 25
SET @StopTrace = NULL
;

--// Setup trace
EXEC sp_trace_create
	@TraceID OUTPUT,
	@options = 2,
	@tracefile = @TraceOutput,
	@maxfilesize = @MaxFileSize,
	@stoptime = @StopTrace,
	@filecount = @MaxFiles
;

--// Define events that are to be captured
--// Category: Security Audit
--// Event: Audit Login
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 8, @on = 1; --// HostName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 10, @on = 1; --// ApplicationName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 11, @on = 1; --// LoginName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 7, @on = 1; --// NTDomainName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 6, @on = 1; --// NTUserName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 64, @on = 1; --// SessionLoginName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 60, @on = 1; --// IsSystem
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 26, @on = 1; --// ServerName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 35, @on = 1; --// DatabaseName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 23, @on = 1; --// Success
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 14, @columnid = 14, @on = 1; --// StartTime

--// Category: Security Audit
--// Event: Audit Logout
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 8, @on = 1; --// HostName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 10, @on = 1; --// ApplicationName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 11, @on = 1; --// LoginName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 7, @on = 1; --// NTDomainName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 6, @on = 1; --// NTUserName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 64, @on = 1; --// SessionLoginName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 60, @on = 1; --// IsSystem
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 26, @on = 1; --// ServerName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 35, @on = 1; --// DatabaseName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 23, @on = 1; --// Success
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 14, @on = 1; --// StartTime
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 15, @columnid = 15, @on = 1; --// EndTIme

--// Category: Security Audit
--// Event: Audit Login Failed
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 8, @on = 1; --// HostName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 10, @on = 1; --// ApplicationName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 11, @on = 1; --// LoginName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 7, @on = 1; --// NTDomainName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 6, @on = 1; --// NTUserName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 64, @on = 1; --// SessionLoginName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 60, @on = 1; --// IsSystem
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 26, @on = 1; --// ServerName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 35, @on = 1; --// DatabaseName
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 23, @on = 1; --// Success
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 30, @on = 1; --// State
EXEC sp_trace_setevent @traceid = @TraceID, @eventid = 20, @columnid = 31, @on = 1; --// Error

--// Filters
--// Filter out system logins
EXEC sp_trace_setfilter @traceid = @TraceID, @columnid = 60, @logical_operator = 1, @comparison_operator = 0, @value = 0;


--// Start trace
EXEC sp_trace_setstatus @TraceID, 1;