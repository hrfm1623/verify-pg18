\timing on
\echo 'Inspecting async I/O configuration'
SHOW io_method;
SHOW io_combine_limit;
SHOW io_max_combine_limit;

\echo 'Reading from pg_aios view (only exists on PostgreSQL 18)'
SELECT *
FROM pg_aios
LIMIT 5;
