\timing off
\echo 'Cluster checksum setting'
SELECT name, setting
FROM pg_settings
WHERE name IN ('data_checksums', 'data_directory');

\echo 'pg_control_system view (requires superuser)'
SELECT control."DataPageChecksum" AS checksums_enabled,
       control."CatalogVersionNo",
       control."LatestCheckpointTime"
FROM pg_control_system AS control;
