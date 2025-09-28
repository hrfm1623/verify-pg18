# RETURNING with OLD/NEW

PostgreSQL 18 allows DML statements to reference `OLD` and `NEW` in the `RETURNING` clause, exposing pre- and post-change values without writing triggers.

## How to run
1. Start containers: `docker compose up -d`.
2. Execute the script on both instances:
   - PostgreSQL 17: `docker compose exec pg17 psql -U postgres -d demo -f /workspace/scenarios/returning-old-new/check.sql`
   - PostgreSQL 18: `docker compose exec pg18 psql -U postgres -d demo -f /workspace/scenarios/returning-old-new/check.sql`

## Expected observation
- **PostgreSQL 17** stops with a syntax error near `OLD`, indicating the feature is unavailable.
- **PostgreSQL 18** returns rows showing `before_balance` and `after_balance`, demonstrating the built-in audit-style output.

You can adapt the script to run `DELETE ... RETURNING OLD.*` or `INSERT ... RETURNING NEW.*` to explore additional cases.
