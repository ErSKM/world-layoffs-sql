# World Layoffs Analysis (2020–2026) — MySQL

## Executive Summary

This SQL project examines reported layoff records using data cleaning, aggregations, common table expressions, and window functions. The included snapshot contains 4,342 records from March 2020 through March 2026; 2026 is partial.

The project is a supporting example of SQL analysis across company, industry, country, funding stage, and time. It is not a retail or e-commerce case study and does not explain why any company made a layoff decision.

## Business Problem

A reader looking at workforce-reduction reports needs a consistent way to summarize recorded events over time and compare the reported totals across companies and industries. The analysis helps identify patterns for further investigation, not assess company health or establish causes.

Questions explored:

- How do reported layoff totals change by month and year?
- Which companies, industries, countries, and funding stages have the largest reported totals?
- Which companies rank highest within each year?
- How does the cumulative reported total change over time?

## Methodology

1. Create the MySQL database and raw table.
2. Import the included CSV snapshot.
3. Clean and standardize records in the staging table.
4. Run 12 SQL queries using grouping, date functions, common table expressions, and window functions.

| Metric | Definition used |
|---|---|
| Total layoffs | Sum of non-null `total_laid_off` values in the included snapshot |
| Layoff events | Count of records with a non-null reported layoff total |
| Monthly/yearly totals | Sum of reported layoffs grouped by the record date |
| Company ranking | Company totals or year-company totals ranked with SQL window functions |

## Skills

- **MySQL:** data cleaning, filtering, joins, aggregations, CTEs, window functions
- **Data quality:** null handling, duplicate review, date parsing, staging-table workflow
- **Analysis:** monthly and yearly trends, company/industry/country comparisons
- **Communication:** separating reported patterns from causal explanation

## Results & Business Recommendation

| Evidence in the included snapshot | Practical follow-up |
|---|---|
| The snapshot records 874,980 layoffs across 4,342 events. | Treat this as the total in this snapshot, not a complete census of layoffs. |
| The listed complete years show 2023 as the highest annual total at 93,807. | Compare the coverage and reporting process across years before interpreting the difference. |
| Totals vary by company, industry, country, and funding stage. | Use the breakdown to frame additional questions; the project cannot attribute the totals to a specific cause. |

The partial 2026 data is not directly comparable with complete years. The dataset may also reflect reporting and coverage gaps.

## Next Steps

1. Document the source and update date for the dataset snapshot.
2. Add a missingness and duplicate audit with before-and-after counts.
3. Separate partial-year comparisons from complete-year comparisons in the charts.
4. Add context such as company size before comparing counts across organizations.
5. Keep the project as a secondary SQL example while prioritizing retail and e-commerce work in the portfolio.

### Run the analysis

1. Install MySQL Server and MySQL Workbench.
2. Run `01_create_database.sql`.
3. Import `layoffs.csv` following the column order in the SQL setup.
4. Run `02_data_cleaning.sql`.
5. Run `03_analysis_queries.sql`.

**Author:** Salahuddin K M · [Portfolio](https://erskm.github.io) · [GitHub](https://github.com/ErSKM)
