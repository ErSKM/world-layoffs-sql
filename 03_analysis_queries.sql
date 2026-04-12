-- Q1: Global total layoffs
SELECT SUM(total_laid_off) AS global_total_layoffs
FROM layoffs_staging;

-- Q2: Time period covered
SELECT MIN(date) AS earliest_date,
       MAX(date) AS latest_date
FROM layoffs_staging;

-- Q3: Complete shutdowns ordered by funding raised
SELECT company, industry, country,
       funds_raised, date
FROM layoffs_staging
WHERE percentage_laid_off = 1
ORDER BY funds_raised DESC;

-- Q4: Companies with most total layoffs
SELECT company,
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL
GROUP BY company
ORDER BY total_layoffs DESC
LIMIT 10;

-- Q5: Industries hit hardest
SELECT industry,
       SUM(total_laid_off)                      AS total_layoffs,
       ROUND(AVG(percentage_laid_off) * 100, 1) AS avg_pct_laid_off
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY total_layoffs DESC;

-- Q6: Countries with most layoffs
SELECT country,
       SUM(total_laid_off) AS total_layoffs,
       COUNT(*)            AS layoff_events
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL
GROUP BY country
ORDER BY total_layoffs DESC;

-- Q7: Which funding stage was most affected?
SELECT stage,
       COUNT(*)            AS companies_affected,
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL
GROUP BY stage
ORDER BY total_layoffs DESC;

-- Q8: Monthly breakdown of layoffs
SELECT DATE_FORMAT(date, '%Y-%m') AS month,
       SUM(total_laid_off)        AS monthly_layoffs
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL
  AND date IS NOT NULL
GROUP BY month
ORDER BY month;

-- Q9: Which year had the most layoffs?
SELECT YEAR(date)          AS year,
       SUM(total_laid_off) AS total_layoffs,
       COUNT(*)            AS layoff_events
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL
  AND date IS NOT NULL
GROUP BY year
ORDER BY year;

-- Q10: Rolling total shows the full scale of the layoff wave over time
WITH monthly_totals AS (
    SELECT DATE_FORMAT(date, '%Y-%m') AS month,
           SUM(total_laid_off)        AS monthly_layoffs
    FROM layoffs_staging
    WHERE total_laid_off IS NOT NULL
      AND date IS NOT NULL
    GROUP BY month
)
SELECT month,
       monthly_layoffs,
       SUM(monthly_layoffs) OVER (ORDER BY month) AS rolling_total
FROM monthly_totals
ORDER BY month;

-- Q11: Year-by-year ranking of biggest layoff events
WITH yearly_totals AS (
    SELECT company,
           YEAR(date)          AS year,
           SUM(total_laid_off) AS total_layoffs
    FROM layoffs_staging
    WHERE total_laid_off IS NOT NULL
      AND date IS NOT NULL
    GROUP BY company, year
),
ranked AS (
    SELECT company, year, total_layoffs,
           DENSE_RANK() OVER (
               PARTITION BY year
               ORDER BY total_layoffs DESC
           ) AS ranking
    FROM yearly_totals
)
SELECT company, year, total_layoffs, ranking
FROM ranked
WHERE ranking <= 5
ORDER BY year, ranking;

-- Q12: Above-industry-average layoffs (JOIN + subquery)
SELECT s.company,
       s.industry,
       s.total_laid_off,
       ROUND(ind_avg.avg_layoffs, 0) AS industry_avg
FROM layoffs_staging s
JOIN (
    SELECT industry,
           AVG(total_laid_off) AS avg_layoffs
    FROM layoffs_staging
    WHERE total_laid_off IS NOT NULL
    GROUP BY industry
) ind_avg
    ON s.industry = ind_avg.industry
WHERE s.total_laid_off > ind_avg.avg_layoffs
  AND s.total_laid_off IS NOT NULL
ORDER BY s.industry, s.total_laid_off DESC;
