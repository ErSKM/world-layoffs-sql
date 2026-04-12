CREATE DATABASE layoffs_analysis;
USE layoffs_analysis;

CREATE TABLE layoffs_raw (
    company               VARCHAR(200),
    location              VARCHAR(200),
    industry              VARCHAR(200),
    total_laid_off        INT,
    percentage_laid_off   DECIMAL(5,4),
    date                  DATE,
    stage                 VARCHAR(100),
    country               VARCHAR(200),
    funds_raised          DECIMAL(12,2)
);