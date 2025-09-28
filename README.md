# PostgreSQL 18 Change Review

This repository tracks notes and experiments for understanding what changed in PostgreSQL 18, released on 25 September 2025. It is centered around the official release notes and follow-up verification work to confirm or demonstrate new behaviour.

## How to use this repo
- Start in `docs/release-notes-summary.md` for a curated list of highlights from the PostgreSQL 18 release notes and suggested verification ideas.
- Capture experiments (SQL scripts, benchmarks, etc.) in new folders named after the feature area you are exploring (for example, `sql/uuidv7-demo/` or `performance/aio-checks/`).
- Record findings or gotchas alongside the experiments in short `README.md` files so future readers understand the results.

## Repository layout
- `docs/` – Documentation that summarizes upstream material and outlines follow-up tasks.
- `scenarios/` – Hands-on comparisons between PostgreSQL 17 and 18 for notable changes (see below).
- *(future)* Feature-specific folders under the project root that hold hands-on checks, scripts, and benchmarks.

## Local comparison environment
This repo ships a minimal Docker Compose file that launches side-by-side PostgreSQL 17 and PostgreSQL 18 clusters for manual verification. Requirements:

- Docker Engine 24+ with the Compose plugin, or Docker Desktop with Compose v2.
- Adequate disk space under `./data/` (each instance may allocate several hundred MB after loading sample data).

Basic usage:

```bash
docker compose up -d           # start both clusters
docker compose ps              # check status
docker compose logs pg18       # inspect server startup details
docker compose down            # stop and remove containers
```

The project directory is mounted read-only into each container at `/workspace` so you can run scripts such as `docker compose exec pg18 psql -U postgres -d demo -f /workspace/scenarios/skip-scan/setup.sql`.

## References
- [PostgreSQL Global Development Group, “PostgreSQL 18 Released.”](https://www.postgresql.org/about/news/postgresql-18-released-2930/)
- [PostgreSQL 18 Release Notes](https://www.postgresql.org/docs/release/18.0/)
