use housedata;

/*
====================================================
NASHVILLE HOUSING DATA CLEANING PROJECT
====================================================
*/

----------------------------------------------------
-- 1. VIEW RAW DATA
----------------------------------------------------
SELECT *
FROM raw_housing_data
LIMIT 1000;

SELECT COUNT(*) AS total_rows
FROM raw_housing_data;

----------------------------------------------------
-- 2. CHECK NULL PROPERTY ADDRESS VALUES
----------------------------------------------------
SELECT COUNT(*) AS missing_property_address
FROM raw_housing_data
WHERE propertyaddress IS NULL;

----------------------------------------------------
-- 3. FILL MISSING PROPERTY ADDRESS
----------------------------------------------------
UPDATE raw_housing_data a
JOIN raw_housing_data b
    ON a.parcelid = b.parcelid
    AND a.uniqueid <> b.uniqueid
SET a.propertyaddress =
    COALESCE(a.propertyaddress, b.propertyaddress)
WHERE a.propertyaddress IS NULL;

----------------------------------------------------
-- 4. SPLIT PROPERTY ADDRESS
----------------------------------------------------
ALTER TABLE raw_housing_data
ADD COLUMN propertysplitaddress VARCHAR(255),
ADD COLUMN propertysplitcity VARCHAR(255);

UPDATE raw_housing_data
SET propertysplitaddress =
    TRIM(SUBSTRING(propertyaddress,1,
    LOCATE(',',propertyaddress)-1));

UPDATE raw_housing_data
SET propertysplitcity =
    TRIM(SUBSTRING(propertyaddress,
    LOCATE(',',propertyaddress)+1,
    LENGTH(propertyaddress)));

----------------------------------------------------
-- 5. SPLIT OWNER ADDRESS
----------------------------------------------------
ALTER TABLE raw_housing_data
ADD COLUMN ownersteertaddress VARCHAR(255),
ADD COLUMN ownercity VARCHAR(255),
ADD COLUMN ownerstate VARCHAR(255);

UPDATE raw_housing_data
SET ownersteertaddress =
    TRIM(SUBSTRING_INDEX(owneraddress, ',', 1));

UPDATE raw_housing_data
SET ownercity =
    TRIM(SUBSTRING_INDEX(
        SUBSTRING_INDEX(owneraddress, ',', 2),
        ',',
        -1
    ));

UPDATE raw_housing_data
SET ownerstate =
    TRIM(SUBSTRING_INDEX(owneraddress, ',', -1));

----------------------------------------------------
-- 6. STANDARDIZE SOLDASVACANT COLUMN
----------------------------------------------------
UPDATE raw_housing_data
SET soldasvacant =
CASE
    WHEN soldasvacant = 'Y' THEN 'Yes'
    WHEN soldasvacant = 'N' THEN 'No'
    ELSE soldasvacant
END;

----------------------------------------------------
-- 7. CHECK DUPLICATES
----------------------------------------------------
WITH row_num_cte AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY
                   parcelid,
                   propertyaddress,
                   saleprice,
                   saledate,
                   legalreference
               ORDER BY uniqueid
           ) AS row_num
    FROM raw_housing_data
)
SELECT *
FROM row_num_cte
WHERE row_num > 1;

----------------------------------------------------
-- 8. CREATE CLEANED TABLE WITHOUT DUPLICATES
----------------------------------------------------
CREATE TABLE cleaned_data AS
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY
                   parcelid,
                   propertyaddress,
                   saleprice,
                   saledate,
                   legalreference
               ORDER BY uniqueid
           ) AS row_num
    FROM raw_housing_data
) temp
WHERE row_num = 1;

----------------------------------------------------
-- 9. REMOVE EXTRA COLUMN
----------------------------------------------------
ALTER TABLE cleaned_data
DROP COLUMN row_num;

----------------------------------------------------
-- 10. FINAL CLEAN DATASET
----------------------------------------------------
SELECT * FROM cleaned_data;

----------------------------------------------------
-- 11. EXPLORATORY DATA ANALYSIS (EDA)
----------------------------------------------------

-- Total Properties
SELECT COUNT(*) AS total_properties
FROM cleaned_data;

----------------------------------------------------

-- Average Sale Price
SELECT ROUND(AVG(saleprice),2) AS avg_sale_price
FROM cleaned_data;

----------------------------------------------------

-- Highest Sale Price
SELECT MAX(saleprice) AS highest_sale_price
FROM cleaned_data;

----------------------------------------------------

-- Property Sales by City
SELECT propertysplitcity,
       COUNT(*) AS total_sales,
       ROUND(AVG(saleprice),2) AS avg_sale_price
FROM cleaned_data GROUP BY propertysplitcity ORDER BY total_sales DESC;

----------------------------------------------------

-- Year-wise Sales Trend
SELECT YEAR(saledate) AS sale_year,
       COUNT(*) AS total_sales,
       ROUND(AVG(saleprice),2) AS avg_sale_price
FROM cleaned_data GROUP BY YEAR(saledate) ORDER BY sale_year;

----------------------------------------------------

-- Vacant vs Non-Vacant Analysis
SELECT soldasvacant,
       COUNT(*) AS total_properties,
       ROUND(AVG(saleprice),2) AS avg_sale_price
FROM cleaned_data GROUP BY soldasvacant;

----------------------------------------------------

-- Top 10 Most Expensive Properties
SELECT propertyaddress,
       saleprice,
       saledate
FROM cleaned_data ORDER BY saleprice DESC LIMIT 10;