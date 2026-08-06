# Credit Card Transactions Fraud Detection Project

## Overview
An end-to-end data analytics project analyzing ~1.85 million credit card transactions to uncover fraud patterns across time, location, merchant category, and customer demographics. This project follows a complete pipeline from raw data to business intelligence dashboard, using **Excel → Python (Google Colab) → MySQL → Power BI**.

This is a companion project to my [Video Game Sales Analysis project](#) (link to be added), built to demonstrate the same end-to-end analytical workflow applied to a different industry — finance/fraud risk — using a different BI tool (Power BI instead of Tableau).

> **Note:** This dataset is synthetic, generated using a transaction simulator (Sparkov). It was chosen specifically because it mirrors a realistic transaction schema while being safe for public portfolio use with no privacy or licensing concerns.

## Dataset
- **Source:** [Credit Card Transactions Fraud Detection Dataset](https://www.kaggle.com/datasets/kartik2112/fraud-detection) (Kaggle, by Kartik Shenoy)
- **Original files:** `fraudTrain.csv` (1,296,675 rows) + `fraudTest.csv` (555,719 rows)
- **Combined dataset:** 1,852,394 transactions, 22 original columns
- **Fraud rate:** ~0.51% (highly imbalanced, as expected for real-world fraud data)
- **Time period:** Transactions spanning 2019 onward

## Project Status
🚧 **In progress** — currently at the MySQL import stage.

- [x] Excel-level initial exploration
- [x] Python cleaning & merging (Google Colab)
- [x] Feature engineering
- [x] Data validation checks
- [ ] MySQL import & schema setup
- [ ] SQL business analysis queries
- [ ] Power BI dashboard

## Pipeline

### 1. Excel
Initial structural review of the raw CSV files before deeper analysis — checking column headers, spot-checking for obvious data issues.

### 2. Python (Google Colab)
- Merged `fraudTrain.csv` and `fraudTest.csv` into a single dataset using `pandas.concat()`
- Dropped redundant index column (`Unnamed: 0`)
- Converted `trans_date_trans_time` and `dob` to proper datetime objects
- **Feature engineering:**
  - `hour`, `day_of_week`, `month`, `year` — extracted from transaction timestamp
  - `age` — calculated from `dob` and transaction date
  - `age_band` — categorical age buckets (18-25, 26-35, 36-45, 46-55, 56-65, 65+)
- **Validation checks performed:**
  - No nulls across any column
  - No duplicate transaction IDs (`trans_num`)
  - Age range sanity check (min: 13, max: 96 — no invalid values)
  - Hour range confirmed 0–23, all 7 weekdays present with no anomalies

**Key data quality issue resolved:** `cc_num` (credit card number) was initially misread by pandas as a numeric column, causing precision loss via scientific notation (e.g., `2.70319E+15`). Fixed by explicitly loading the column as a string type (`dtype={'cc_num': str}`) at the point of reading the CSV — before any merging or transformation occurs. This is documented here as a reminder that identifier-type fields (IDs, card numbers, zip codes) should always be treated as text, never numeric, regardless of how they appear.

### 3. MySQL
Importing the cleaned dataset into a relational database (`fraud_detection_db`) for structured business-question analysis using SQL (joins, window functions, aggregations).

Column types are explicitly defined (rather than auto-detected) to prevent the same precision-loss issues encountered during the Python stage — for example, `cc_num` and `trans_num` are stored as `VARCHAR`, not numeric types.

### 4. Power BI
*(Planned)* Interactive dashboard covering:
- Fraud rate KPI overview
- Fraud rate by merchant category
- Fraud patterns by hour of day / day of week
- Geographic distribution of fraud
- Fraud rate by customer age band

## Tech Stack
- **Excel** — initial data inspection
- **Python** (pandas) — data cleaning, merging, feature engineering
- **Google Colab** — notebook environment
- **MySQL** — relational database, business-question querying
- **Power BI** — dashboard & visualization

## Repository Structure
```
├── Credit_Card_Transactions_Fraud_Detection_Project.ipynb   # Python cleaning & feature engineering
├── fraud_detection_db.sql                                   # Database schema & import script
├── queries.sql                                               # Business analysis SQL queries (in progress)
├── README.md
```

## Key Learnings
- Reinforced the importance of explicitly setting data types for identifier columns (IDs, card numbers) rather than relying on auto-detection — both in pandas and in database import tools — to avoid silent precision loss.
- Practiced systematic data validation at each pipeline stage (row counts, dtype checks, range checks) rather than assuming a clean transformation succeeded.

---
*This README is a living document and will be updated as the project progresses through the MySQL and Power BI stages.*
