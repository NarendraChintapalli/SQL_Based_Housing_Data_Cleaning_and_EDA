# Nashville Housing Data Cleaning & Exploratory Analysis Using SQL

## Overview
In this project, I worked on cleaning, transforming, and analyzing raw housing sales data using SQL. The dataset contained multiple data quality issues such as missing values, duplicate records, inconsistent categorical values, and unstructured address fields.

Through this project, I demonstrated practical SQL concepts commonly used in real-world data analyst workflows, including:
- Data Cleaning
- Data Transformation
- Exploratory Data Analysis (EDA)
- Window Functions
- CTEs (Common Table Expressions)
- Aggregate Analysis
- String Manipulation Functions

I used SQL queries to clean the raw dataset, create structured analytical fields, remove duplicate records, handle missing values, and generate analytical insights from housing sales data.

---

# Objectives
The main objectives of this project were:
- Clean and preprocess raw housing sales data
- Handle missing property address values
- Detect and remove duplicate records
- Standardize inconsistent categorical values
- Split combined address columns into structured fields
- Create a cleaned analytical dataset
- Perform exploratory data analysis using SQL

---

# Dataset
The dataset contains housing/property sales records with columns such as:
- Parcel ID
- Property Address
- Owner Address
- Sale Price
- Sale Date
- Legal Reference
- Land Value
- Building Value
- Bedrooms
- Bathrooms
- SoldAsVacant
---

# Technologies Used
- SQL
- MySQL
- Window Functions
- CTEs (Common Table Expressions)
- Aggregate Functions
- String Functions
- Data Cleaning Techniques
- Exploratory Data Analysis (EDA)

---

# SQL Concepts Implemented

## Data Cleaning
In this project, I implemented:
- Handling missing values using `COALESCE()`
- Filling null property addresses using self joins
- Removing duplicate records using `ROW_NUMBER()`
- Standardizing `Y/N` values using `CASE`
- Splitting address columns using string functions

## Data Transformation
I transformed the raw housing dataset by:
- Creating structured address columns
- Creating cleaned analytical tables/views
- Converting raw data into analysis-ready datasets

## Exploratory Data Analysis (EDA)
I performed SQL-based analysis including:
- Average property sale price analysis
- City-wise property sales analysis
- Year-wise sales trend analysis
- Vacant vs non-vacant property analysis
- Top expensive property analysis

---

# Project Workflow

```text
Raw CSV Dataset
        ↓
Import into MySQL
        ↓
Data Cleaning
        ↓
Duplicate Detection & Removal
        ↓
Data Transformation
        ↓
Exploratory Data Analysis (EDA)
        ↓
Cleaned Analytical Dataset
```

---

# Key SQL Features Used
```sql
ROW_NUMBER()
CTEs
SELF JOIN
COALESCE()
CASE Statements
Aggregate Functions
Window Functions
SUBSTRING_INDEX()
GROUP BY
ORDER BY
```
---

# Example Analysis Performed
Using SQL queries, I:
- Identified duplicate housing records
- Filled missing property addresses using parcel IDs
- Generated city-wise average housing prices
- Analyzed yearly property sales trends
- Compared vacant vs non-vacant property sales
- Created cleaned datasets for downstream analytics

---

# Future Improvements
Possible future enhancements:
- Create Power BI/Tableau dashboards
- Add stored procedures and views
- Build automated ETL workflow
- Perform advanced statistical analysis
- Add indexing and query optimization

---

# Conclusion

This project helped me strengthen practical SQL skills by working with real-world style housing data involving data cleaning, transformation, duplicate handling, and exploratory data analysis workflows commonly used in data analyst roles.

