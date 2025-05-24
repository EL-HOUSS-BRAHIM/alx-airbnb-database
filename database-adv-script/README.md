# Advanced Database Scripts for ALX Airbnb Clone

This directory contains advanced SQL scripts and performance analysis documents for the ALX Airbnb Database Module.

## Directory Contents

### SQL Scripts
1. `joins_queries.sql`
   - Complex queries using INNER, LEFT, and FULL OUTER JOINs
   - Demonstrates relationship handling between tables

2. `subqueries.sql`
   - Examples of correlated and non-correlated subqueries
   - Advanced filtering techniques

3. `aggregations_and_window_functions.sql`
   - GROUP BY aggregations
   - Window functions like RANK and ROW_NUMBER

4. `perfomance.sql`
   - Complex query optimization examples
   - Before and after optimization comparisons

5. `partitioning.sql`
   - Table partitioning implementation
   - Date-based partition strategies

### Analysis Documents
1. `index_performance.md`
   - Index strategy documentation
   - Performance impact analysis

2. `optimization_report.md`
   - Query optimization techniques
   - Performance improvement metrics

3. `partition_performance.md`
   - Partitioning impact analysis
   - Performance comparisons

4. `performance_monitoring.md`
   - Database monitoring setup
   - Maintenance recommendations

## Usage

1. Ensure you have the base schema and data loaded:
   ```sql
   \i ../database-script-0x01/schema.sql
   \i ../database-script-0x02/seed.sql
   ```

2. Run optimization scripts in order:
   ```sql
   \i joins_queries.sql
   \i subqueries.sql
   \i aggregations_and_window_functions.sql
   ```

3. Review performance documents for analysis and recommendations.

## Performance Testing

Use EXPLAIN ANALYZE to test query performance:
```sql
EXPLAIN ANALYZE
SELECT * FROM [query];
```

## Maintenance

1. Regular index maintenance:
   ```sql
   VACUUM ANALYZE;
   ```

2. Update table statistics:
   ```sql
   ANALYZE [table_name];
   ```

3. Monitor query performance:
   ```sql
   SELECT * FROM pg_stat_statements;
   ```
