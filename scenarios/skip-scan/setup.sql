\echo 'Creating multicolumn dataset for skip-scan comparison'
DROP TABLE IF EXISTS skip_scan_demo;
CREATE TABLE skip_scan_demo (
    region_id     integer NOT NULL,
    product_id    integer NOT NULL,
    quantity      integer NOT NULL,
    sales_amount  numeric(12,2) NOT NULL,
    last_sale_at  timestamp without time zone NOT NULL
);

INSERT INTO skip_scan_demo
SELECT r.region_id,
       p.product_id,
       (100 + (random() * 900))::integer,
       round((random() * 10000)::numeric, 2),
       now() - (random() * interval '365 days')
FROM generate_series(1, 200) AS r(region_id)
CROSS JOIN generate_series(1, 400) AS p(product_id);

ALTER TABLE skip_scan_demo
    ADD CONSTRAINT skip_scan_demo_pk PRIMARY KEY (region_id, product_id);

ANALYZE skip_scan_demo;
\echo 'Table and index ready.'
