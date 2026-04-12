# World Layoffs Analysis (2020–2026) — MySQL

**Tool:** MySQL (MySQL Workbench)
**Dataset:** World Layoffs 2020–2026 — 4,342 records
**Domain:** Business / Workforce Analytics
**Status:** Completed

---

## Files in this Repository

| File | What it contains |
|---|---|
| `01_create_database.sql` | Creates the database and table |
| `02_data_cleaning.sql` | All data cleaning steps |
| `03_analysis_queries.sql` | All 12 analysis queries (Q1–Q12) |
| `q10_rolling_total.png` | Screenshot — rolling cumulative layoffs (CTE + Window function) |
| `q11_top5_per_year.png` | Screenshot — top 5 companies per year (DENSE_RANK) |
| `layoffs.csv` | Raw dataset |

---

## Project Overview

This project analyzes global corporate layoffs from March 2020 to March 2026 using pure SQL. It covers the COVID-19 period, the post-funding-boom correction of 2022–2023, and continued workforce restructuring through 2025.

The workflow: raw data → staging table → cleaning → 12 analysis queries → business insights.

---

## SQL Concepts Used

- SELECT, WHERE, GROUP BY, ORDER BY, LIMIT
- SUM, AVG, COUNT, ROUND, MIN, MAX
- DATE_FORMAT, YEAR (date functions)
- JOIN with inline subquery
- CTE (WITH clause)
- Window functions — SUM OVER, DENSE_RANK, PARTITION BY

---

## Dataset Columns

| Column | Description |
|---|---|
| `company` | Company name |
| `location` | City |
| `industry` | Business sector |
| `total_laid_off` | Number of employees laid off |
| `percentage_laid_off` | Share of workforce cut |
| `date` | Date of layoff event |
| `stage` | Funding stage (Series A, Post-IPO, etc.) |
| `country` | Country |
| `funds_raised` | Total funding raised in USD millions |

---

## Key Findings

**874,980 employees** were laid off globally across 4,342 recorded events from 2020 to 2026.

### Layoffs by Year

| Year | Total Laid Off | Events |
|---|---|---|
| 2020 | 29,190 | 201 |
| 2021 | 9,631 | 13 |
| 2022 | 82,211 | 350 |
| 2023 | 93,807 | 362 |
| 2024 | 67,618 | 186 |
| 2025 | 45,296 | 106 |
| 2026 | 5,250 | 24 (partial) |

2023 was the worst year — not 2022. 2021 was deceptively calm with only 13 recorded events.

### Top 10 Companies by Total Layoffs

| Company | Total Laid Off |
|---|---|
| Amazon | 58,124 |
| Intel | 43,115 |
| Oracle | 31,294 |
| Microsoft | 30,055 |
| Meta | 27,500 |
| Salesforce | 16,525 |
| Cisco | 14,521 |
| Tesla | 14,500 |
| Google | 13,697 |
| Dell | 12,650 |

These are not struggling companies — they over-hired during the 2020–2021 boom and corrected hard.

### Industries Hit Hardest

| Industry | Total Laid Off | Avg % Cut |
|---|---|---|
| Retail | 106,076 | 23.7% |
| Hardware | 94,957 | 9.9% |
| Consumer | 86,870 | 23.1% |
| Transportation | 66,002 | 23.7% |
| Finance | 58,634 | 21.5% |
| Food | 51,998 | 28.8% |
| Healthcare | 38,904 | 28.6% |

Food and Healthcare cut deepest proportionally — structural distress, not just market adjustment.

### Layoffs by Country (Top 5)

| Country | Total Laid Off | Events |
|---|---|---|
| United States | 616,044 | 1,743 |
| India | 65,584 | 261 |
| Germany | 31,588 | 95 |
| United Kingdom | 23,264 | 84 |
| Netherlands | 21,575 | 19 |

The US accounts for 70% of all recorded layoffs.

### Layoffs by Funding Stage

| Stage | Total Laid Off |
|---|---|
| Post-IPO | 544,507 |
| Unknown | 78,588 |
| Acquired | 71,753 |
| Series B | 30,822 |
| Series C | 27,412 |

Post-IPO companies account for 62% of all layoffs — the correction hit public companies hardest.

### Well-Funded Companies That Still Shut Down

344 companies laid off 100% of their workforce. Top examples:
- Britishvolt (EV, UK) — $2.4B raised, complete shutdown
- Quibi (Media, US) — $1.8B raised, complete shutdown
- Fisker (EV, US) — $1.7B raised, complete shutdown

Funding does not guarantee survival.

---

## How to Run

1. Install MySQL Community Server and MySQL Workbench (free at dev.mysql.com)
2. Open Workbench and connect to your local instance
3. Run 01_create_database.sql to create the database and table
4. Import layoffs.csv into layoffs_raw
5. Run 02_data_cleaning.sql to clean the data
6. Run 03_analysis_queries.sql to see all 12 query results

---

## Author

**Salahuddin K M** — Data Analyst
Portfolio: erskm.github.io | GitHub: github.com/ErSKM
