# World Layoffs Analysis (2020–2026) — MySQL

**Tool:** MySQL (MySQL Workbench)  
**Dataset:** World Layoffs 2020–2026 — 4,342 records across global companies  
**Domain:** Business / Workforce Analytics  
**SQL Concepts:** SELECT · GROUP BY · JOIN · Subqueries · CTEs · Window Functions (DENSE_RANK, SUM OVER)  
**Status:** Completed

---

## Project Overview

This project analyzes global corporate layoffs from March 2020 to March 2026 — covering the COVID-19 period, the post-funding-boom correction of 2022–2023, and continued workforce restructuring through 2025. Using pure SQL in MySQL Workbench, the analysis covers data cleaning, exploratory queries, trend analysis, and advanced window function techniques across 12 structured business questions.

The project demonstrates a complete analyst workflow in SQL alone: raw data → staging → cleaning → structured analysis → actionable insights.

---

## Dataset Description

| Column | Description |
|---|---|
| `company` | Company name |
| `location` | City |
| `industry` | Business sector |
| `total_laid_off` | Employees laid off in the event |
| `percentage_laid_off` | Proportion of total workforce cut |
| `date` | Date of layoff event |
| `stage` | Funding stage (Series A–H, Post-IPO, etc.) |
| `country` | Country |
| `funds_raised` | Total funding raised (USD millions) |

**Source:** Kaggle — World Layoffs Dataset  
**Raw records:** 4,342 | **Records after cleaning:** ~2,842 (null-only rows removed)

---

## SQL Techniques Demonstrated

| Level | Technique | Query |
|---|---|---|
| Basic | SELECT, WHERE, ORDER BY, LIMIT | Q1, Q2, Q3 |
| Intermediate | GROUP BY, SUM, AVG, COUNT, ROUND | Q4, Q5, Q6, Q7 |
| Date functions | DATE_FORMAT, YEAR, MIN, MAX | Q8, Q9 |
| Advanced | CTE + Window SUM OVER (rolling total) | Q10 |
| Advanced | CTE + DENSE_RANK + PARTITION BY (yearly ranking) | Q11 |
| Advanced | JOIN with inline subquery (industry benchmark) | Q12 |

---

## Key Findings and Actionable Insights

### 1. Scale: 874,980 employees laid off globally
Nearly **875,000 jobs** were eliminated across 4,342 recorded events from March 2020 to March 2026. This is not a rounding error — it represents a structural shift in how companies manage headcount during periods of economic uncertainty.

### 2. The layoff wave peaked in 2023, not 2022
| Year | Total Layoffs | Events |
|---|---|---|
| 2020 | 29,190 | 201 |
| 2021 | 9,631 | 13 |
| 2022 | 82,211 | 350 |
| 2023 | 93,807 | 362 |
| 2024 | 67,618 | 186 |
| 2025 | 45,296 | 106 |
| 2026 | 5,250 | 24 (partial year) |

**Insight:** 2021 was deceptively calm — only 13 recorded events. Companies were still riding pandemic-era digital spending. The correction hit hard in 2022 and peaked in 2023. The trend is tapering but has not stopped — 2024 and 2025 still show tens of thousands of job cuts.

### 3. Amazon, Intel, Oracle dominate individual company layoffs
| Rank | Company | Total Laid Off |
|---|---|---|
| 1 | Amazon | 58,124 |
| 2 | Intel | 43,115 |
| 3 | Oracle | 31,294 |
| 4 | Microsoft | 30,055 |
| 5 | Meta | 27,500 |
| 6 | Salesforce | 16,525 |
| 7 | Cisco | 14,521 |
| 8 | Tesla | 14,500 |
| 9 | Google | 13,697 |
| 10 | Dell | 12,650 |

**Insight:** These are not struggling companies — they are among the most profitable corporations in the world. The layoffs reflect over-hiring during the 2020–2021 zero-interest-rate boom, not business failure. The top 10 companies alone account for ~262,000 layoffs — 30% of the global total.

### 4. Retail and Hardware were hit hardest in absolute volume; Food and Healthcare cut deepest proportionally
- **Retail:** 106,076 total laid off | 23.7% avg workforce cut
- **Hardware:** 94,957 total laid off | only 9.9% avg — large absolute numbers from big companies, relatively contained proportionally
- **Food:** 51,998 total laid off | **28.8% avg** — highest proportional cuts after Healthcare
- **Healthcare:** 38,904 total laid off | **28.6% avg** — deep cuts relative to workforce size

**Insight:** Hardware companies cut large absolute numbers but retained most of their workforce. Food and Healthcare companies cut fewer people in total but proportionally gutted their teams — signaling deeper structural distress in those sectors.

### 5. The United States accounts for 70% of all recorded layoffs
- **United States:** 616,044 layoffs across 1,743 events
- **India:** 65,584 across 261 events (distant second)
- **Germany:** 31,588 | **UK:** 23,264 | **Netherlands:** 21,575

**Insight:** The US dominance reflects both the concentration of global tech companies and stronger layoff disclosure norms. India's position at #2 reflects the large offshore tech workforce reductions that accompanied US company downsizing.

### 6. Post-IPO companies account for 62% of all layoffs
- **Post-IPO:** 544,507 layoffs from 725 companies
- **Series B:** 30,822 | **Series C:** 27,412 | **Series D:** 27,054

**Insight:** The layoff crisis is predominantly a public company phenomenon. Post-IPO companies — which had the most capital raised and the most headcount added during the boom — made the largest absolute cuts. Series A companies (9,147 total) were the least affected, likely because they never over-hired to the same degree.

### 7. Well-funded companies still shut down completely
344 companies laid off 100% of their workforce. Top funded among complete shutdowns:
- **Britishvolt** (EV battery, UK) — $2.4B raised, total shutdown
- **Quibi** (Media, US) — $1.8B raised, shut down
- **Fisker** (EV, US) — $1.7B raised, shut down
- **Deliveroo Australia** — $1.7B raised, market exit
- **Lilium** (Aerospace, Germany) — $1.4B raised, shut down

**Insight:** Funding does not guarantee survival. These shutdowns demonstrate that even billion-dollar companies can fail when market conditions shift — a critical reminder for investors and employees alike.

### 8. The rolling total shows the layoff acceleration clearly (Q10)
The cumulative layoff count grew slowly through 2020 (reaching ~29K by year-end), stayed nearly flat through 2021, then accelerated sharply from early 2022 onward. By end of 2023 the rolling total had crossed 700,000 — the majority of the entire dataset accumulated in just two years.

### 9. Year-by-year leadership changes reveal who was over-hired (Q11)
- **2020:** Uber led (3,925) — pandemic travel collapse
- **2021:** Katerra (2,434), Zillow (2,000) — startup failures and market pivots
- **2022–2023:** Big Tech takes over — Amazon, Meta, Microsoft dominate rankings
- **Pattern:** Early years show startup failures; later years show deliberate Big Tech restructuring

### 10. Industry benchmarking reveals outliers within sectors (Q12)
Companies laying off significantly above their industry average signal deeper internal issues beyond sector-wide trends. Examples: Katerra laid off 2,434 against a Construction industry average of 331 — nearly 7× the benchmark, flagging structural business failure rather than market conditions.

---

## Data Cleaning Steps

All cleaning performed on `layoffs_staging` (raw table preserved):
1. Trimmed whitespace from all text columns using `TRIM()`
2. Fixed country name inconsistencies (`"United States."` → `"United States"`)
3. Filled missing industry values by matching same company's other rows using self-JOIN
4. Removed rows where both `total_laid_off` and `percentage_laid_off` are NULL — no analytical value

---

## File Structure

```
world-layoffs-sql/
├── layoffs.csv                        # Original dataset
├── sql/
│   ├── 01_create_database.sql         # DB + table creation
│   ├── 02_data_cleaning.sql           # All 4 cleaning steps
│   └── 03_analysis_queries.sql        # All 12 analysis queries (Q1–Q12)
├── screenshots/
│   ├── q10_rolling_total.png          # CTE + window function result
│   └── q11_top5_per_year.png          # DENSE_RANK + PARTITION BY result
└── README.md
```

---

## How to Run

1. Install MySQL Community Server and MySQL Workbench (free at dev.mysql.com)
2. Open Workbench and connect to your local MySQL instance
3. Run `01_create_database.sql` to create the database and raw table
4. Import `layoffs.csv` into `layoffs_raw` using the provided Python import script
5. Run `02_data_cleaning.sql` to create and clean the staging table
6. Run `03_analysis_queries.sql` to execute all 12 analysis queries

---

## Author

**Salahuddin K M** — Data Analyst  
Portfolio: [erskm.github.io](https://erskm.github.io) | GitHub: [github.com/ErSKM](https://github.com/ErSKM)

*Project 2 of 4 in the multi-tool Data Analytics Portfolio (Excel → MySQL → Power BI → Tableau)*
