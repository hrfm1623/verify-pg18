# PostgreSQL 17 vs 18 verification plan

This document highlights high-impact PostgreSQL 18 changes that can be exercised locally with the `docker-compose.yml` included in this repository. Each scenario parallels a folder under `scenarios/` with SQL scripts and walkthrough notes.

## Selected focus areas

| Theme | Scenario | Why it matters | Reference |
|-------|----------|----------------|-----------|
| Planner improvements | [`scenarios/skip-scan/`](../scenarios/skip-scan) | PostgreSQL 18 enables skip scans on multicolumn B-tree indexes, eliminating the need for redundant covering indexes when the leading column is unconstrained. | Release notes, "The planner can now perform skip scans on multicolumn B-tree indexes." |
| Built-in SQL features | [`scenarios/uuidv7/`](../scenarios/uuidv7) | Native `uuidv7()` provides monotonic UUIDs optimised for append-heavy tables and logical replication. | Release notes, "New functions `uuidv7()` and `uuidv8()`." |
| DML ergonomics | [`scenarios/returning-old-new/`](../scenarios/returning-old-new) | `RETURNING` can surface `OLD`/`NEW` records directly, removing the need for triggers to capture before/after values. | Release notes, "`INSERT`, `UPDATE`, and `DELETE` support `RETURNING OLD` and `RETURNING NEW`." |
| Storage subsystem | [`scenarios/async-io/`](../scenarios/async-io) | The asynchronous I/O subsystem reduces latency for sequential scans and vacuum operations; understanding configuration options is key for production rollout. | Release notes, "Add asynchronous I/O infrastructure." |
| Operational defaults | [`scenarios/data-checksums/`](../scenarios/data-checksums) | Data checksums are enabled by default in PostgreSQL 18, impacting upgrade planning and cross-version replication requirements. | Release notes, "Enable data checksums by default." |

## Suggested workflow
1. Launch both clusters with `docker compose up -d`.
2. Work through each scenario, following the README inside the scenario folder to run the SQL scripts on PostgreSQL 17 and PostgreSQL 18.
3. Capture findings in new markdown files (e.g., `scenarios/skip-scan/findings.md`) or open issues for deeper follow-up tests.
4. Use `pg_stat_statements`, `EXPLAIN (ANALYZE, BUFFERS)`, or benchmarking tools such as `pgbench` to quantify behavioural differences when relevant.

## Next candidates for expansion
- Benchmark asynchronous I/O with `pgbench` and record metrics under `perf/async-io/`.
- Explore temporal constraints (`PERIOD FOR`) once test data needs become clearer.
- Verify `pg_upgrade` statistics retention using an initialized PostgreSQL 17 cluster upgraded into PostgreSQL 18 with sample stats saved.
