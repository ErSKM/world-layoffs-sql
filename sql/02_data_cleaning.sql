-- Create staging table to preserve raw data
CREATE TABLE layoffs_staging AS
SELECT * FROM layoffs_raw;

-- Trim whitespace and fix "United States." entries
UPDATE layoffs_staging
SET
    company  = TRIM(company),
    location = TRIM(location),
    industry = TRIM(industry),
    country  = TRIM(TRAILING '.' FROM TRIM(country));

-- Fill missing industry using same company other rows
UPDATE layoffs_staging t1
JOIN layoffs_staging t2 ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL
  AND t2.industry != '';

-- Remove rows where both layoff columns are NULL
DELETE FROM layoffs_staging
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Verify final count
SELECT COUNT(*) FROM layoffs_staging;