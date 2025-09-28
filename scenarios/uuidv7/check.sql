\timing on
SELECT version();
\echo 'Checking for built-in uuidv7()'
SELECT uuidv7()
FROM generate_series(1, 5);

\echo 'Inspecting default ordering with uuidv7() values'
WITH sample AS (
    SELECT uuidv7() AS id
    FROM generate_series(1, 10)
)
SELECT id,
       lag(id) OVER (ORDER BY id) AS previous_id
FROM sample
ORDER BY id
LIMIT 5;
