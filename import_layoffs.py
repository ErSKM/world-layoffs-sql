import pandas as pd
import numpy as np
import mysql.connector
from mysql.connector import Error
 
# ─────────────────────────────────────────────────────────
DB_PASSWORD = "password"        
# ─────────────────────────────────────────────────────────────────────────────
 
CSV_PATH = r"E:\Old Hdd Data ackup\Downloads\Layoff Dataset\layoffs.csv"
DB_HOST  = "127.0.0.1"
DB_PORT  = 3306
DB_USER  = "root"
 
# ── Load CSV — treat everything ambiguous as NaN from the start ───────────────
df = pd.read_csv(
    CSV_PATH,
    keep_default_na=True,
    na_values=['nan', 'NaN', 'NAN', 'NULL', 'null', 'None', 'none', '', ' ', 'N/A', 'n/a']
)
df.columns = [c.strip().lower().replace(' ', '_') for c in df.columns]
print(f"Columns in CSV : {df.columns.tolist()}")
print(f"Total rows     : {len(df)}")
 
# ── Keep only the 9 analysis columns ─────────────────────────────────────────
KEEP = ['company', 'location', 'industry', 'total_laid_off',
        'percentage_laid_off', 'date', 'stage', 'country', 'funds_raised']
KEEP = [c for c in KEEP if c in df.columns]
df   = df[KEEP].copy()
print(f"Columns kept   : {KEEP}")
 
# ── Clean each column explicitly — no applymap/map needed ─────────────────────
 
# Text columns: strip whitespace, empty string → None
for col in ['company', 'location', 'industry', 'stage', 'country']:
    if col in df.columns:
        df[col] = df[col].astype(str).str.strip()
        df[col] = df[col].where(~df[col].isin(['nan', 'None', 'NaN', 'NULL', '']), None)
 
# Numeric columns: force to numeric, invalid → None
for col in ['total_laid_off']:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors='coerce')
 
for col in ['percentage_laid_off', 'funds_raised']:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors='coerce')
 
# Date column: parse properly, invalid → None
if 'date' in df.columns:
    df['date'] = pd.to_datetime(df['date'], errors='coerce')
    # Replace NaT with None
    df['date'] = df['date'].where(df['date'].notna(), None)
    # Convert valid dates to python date objects
    df['date'] = df['date'].apply(lambda x: x.date() if pd.notna(x) and x is not None else None)
 
print(f"\nNull counts per column:")
print(df.isnull().sum())
 
# ── Convert entire dataframe rows to clean tuples for MySQL ───────────────────
# Replace all remaining NaN/NaT/None consistently
def to_mysql_val(v):
    if v is None:
        return None
    if isinstance(v, float) and np.isnan(v):
        return None
    return v
 
rows_to_insert = []
for _, row in df.iterrows():
    rows_to_insert.append(tuple(to_mysql_val(v) for v in row))
 
print(f"Rows prepared for insert: {len(rows_to_insert)}")
print(f"Sample row 0: {rows_to_insert[0]}")
 
# ── Connect and insert ────────────────────────────────────────────────────────
conn = None
try:
    conn = mysql.connector.connect(
        host=DB_HOST, port=DB_PORT,
        user=DB_USER, password=DB_PASSWORD
    )
    cursor = conn.cursor()
    print("\nConnected to MySQL successfully.")
 
    cursor.execute("CREATE DATABASE IF NOT EXISTS layoffs_analysis;")
    cursor.execute("USE layoffs_analysis;")
    cursor.execute("DROP TABLE IF EXISTS layoffs_raw;")
    cursor.execute("""
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
    """)
    print("Table created successfully.")
 
    cols         = ', '.join(f"`{c}`" for c in df.columns)
    placeholders = ', '.join(['%s'] * len(df.columns))
    insert_sql   = f"INSERT INTO layoffs_raw ({cols}) VALUES ({placeholders})"
 
    success, errors = 0, 0
    for i, row_tuple in enumerate(rows_to_insert):
        try:
            cursor.execute(insert_sql, row_tuple)
            success += 1
        except Error as e:
            errors += 1
            if errors <= 5:
                print(f"  Row {i} error: {e}")
                print(f"  Data: {row_tuple}")
 
    conn.commit()
    print(f"\nInserted : {success} rows")
    print(f"Errors   : {errors} rows")
 
    cursor.execute("SELECT COUNT(*) FROM layoffs_raw;")
    print(f"Records in MySQL : {cursor.fetchone()[0]}")
 
    cursor.execute("SELECT * FROM layoffs_raw LIMIT 3;")
    print("\nSample rows (first 3):")
    for r in cursor.fetchall():
        print(" ", r)
 
except Error as e:
    print(f"\nMySQL Error: {e}")
 
finally:
    if conn and conn.is_connected():
        cursor.close()
        conn.close()
        print("\nConnection closed.")