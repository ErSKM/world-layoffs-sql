# World Layoffs Analysis (2020–2026) — MySQL

A SQL analysis of company layoff records using data cleaning, aggregations, common table expressions, and window functions.

## Project at a glance

- **Database:** MySQL
- **Dataset:** 4,342 records in the included snapshot
- **Period represented:** March 2020–March 2026; 2026 is partial
- **Analysis:** 12 queries covering trends by year, company, industry, country, and funding stage

This is a descriptive analysis of the records in `layoffs.csv`. It does not establish why a company made a layoff decision, and the partial 2026 data should not be compared as a complete year.

## Repository contents

| File | Purpose |
|---|---|
| `01_create_database.sql` | Creates the database and raw table |
| `02_data_cleaning.sql` | Cleans the data and prepares the analysis table |
| `03_analysis_queries.sql` | Runs the 12 analysis queries |
| `layoffs.csv` | Dataset snapshot used in the project |
| `q10_rolling_total.png` | Rolling total query result |
| `q11_top5_per_year.png` | Yearly company ranking query result |

## Questions explored

- How do recorded layoffs change by month and year?
- Which companies and industries have the largest recorded totals?
- How do totals vary by country and company funding stage?
- Which companies rank highest within each year?
- How does the cumulative total change over time?

## SQL skills demonstrated

- Filtering, grouping, sorting, and aggregate functions
- Date extraction and formatting
- Subqueries and joins
- Common table expressions
- Window functions, including cumulative sums and `DENSE_RANK`

## Selected findings

The included snapshot records **874,980 layoffs across 4,342 events**. It records 93,807 layoffs in 2023, the highest annual total among the listed complete years. These figures describe this dataset snapshot; they should not be interpreted as a complete census of layoffs.

The project also compares totals by company, industry, country, and funding stage. Those descriptive comparisons do not by themselves show causes or business health.

## Run the analysis

1. Install MySQL Server and MySQL Workbench.
2. Run `01_create_database.sql`.
3. Import `layoffs.csv` into the raw table, following the column order in the SQL setup.
4. Run `02_data_cleaning.sql`.
5. Run `03_analysis_queries.sql`.

## Author

**Salahuddin K M** · [Portfolio](https://erskm.github.io) · [GitHub](https://github.com/ErSKM)
