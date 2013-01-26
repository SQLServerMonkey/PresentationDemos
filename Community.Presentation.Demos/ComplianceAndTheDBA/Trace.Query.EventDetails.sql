--// List Categories
SELECT name AS CategoryName
FROM sys.trace_categories
ORDER BY CategoryName
;

--// Querey to get details of ID values to construct traces
SELECT TCA.name AS CategoryName, TCA.type AS CategoryType, TCA.category_id AS CategoryID,
	TE.name AS EventName, TE.trace_event_id AS EventID,
	TCO.name AS ColumnName, TCO.type_name AS ColumnTypeName, TCO.trace_column_id AS ColumnID,
	TCO.is_filterable
FROM sys.trace_categories AS TCA
JOIN sys.trace_events AS TE
	ON TCA.category_id = TE.category_id
JOIN sys.trace_event_bindings AS TEB
	ON TE.trace_event_id = TEB.trace_event_id
JOIN sys.trace_columns AS TCO
	ON TEB.trace_column_id = TCO.trace_column_id
WHERE TCA.name = 'Security Audit'
;