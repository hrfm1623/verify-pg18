\timing on
SELECT version();
\echo 'Checking multicolumn index usage on current server'
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM skip_scan_demo
WHERE product_id = 42;

\echo 'Checking execution with extra selectivity constraints'
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM skip_scan_demo
WHERE product_id = 42 AND quantity > 500;

\echo 'Execution time for baseline query'
SELECT count(*) FROM skip_scan_demo WHERE product_id = 42;
