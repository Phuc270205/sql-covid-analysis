# Nashville Housing Data Cleaning in SQL

## Overview
This project focuses on cleaning and transforming the **Nashville Housing** dataset using **SQL Server**.

The main goal of the project was to prepare raw housing data for analysis by improving data quality, standardizing formats, handling missing values, splitting combined fields into separate columns, removing duplicates, and dropping unnecessary columns.

This project demonstrates practical SQL data cleaning skills that are commonly used in real-world analytics workflows.

---

## Project Objectives
The main cleaning tasks completed in this project were:

- standardize the sale date format
- populate missing property addresses
- split address columns into separate fields
- convert coded values into clearer labels
- identify and remove duplicate records
- remove unused columns from the final table

---

## Tools Used
- **SQL Server** — data cleaning and transformation
- **SQL Server Management Studio (SSMS)** — query execution and validation

---

## Dataset
The dataset used in this project is:

- `SQL_Project.dbo.NashvilleHousing`

This dataset contains housing-related fields such as:
- parcel ID
- property address
- owner address
- sale date
- sale price
- legal reference
- sold as vacant
- tax district

---

## SQL Skills Demonstrated
This project highlights the following SQL skills:

- `SELECT`, `UPDATE`, `ALTER TABLE`, `DELETE`
- `CONVERT()` for date standardization
- `ISNULL()` for missing value handling
- `SUBSTRING()` and `CHARINDEX()` for string splitting
- `PARSENAME()` and `REPLACE()` for address parsing
- `CASE WHEN` for recoding values
- `ROW_NUMBER()` with CTE for duplicate removal
- self join for filling missing address values
- dropping unused columns after cleaning

---

## Cleaning Steps Performed

### 1. Standardized Date Format
The original `SaleDate` column was converted into a proper SQL `DATE` format.

Steps performed:
- checked the original date format
- created a new column: `SaleDateConverted`
- populated it using `CONVERT(Date, SaleDate)`

This made the date field easier to use in future analysis.

---

### 2. Populated Missing Property Address Values
Some rows had missing `PropertyAddress` values.

To fix this:
- the table was joined to itself using `ParcelID`
- matching records with the same parcel ID were used
- `ISNULL()` was used to fill missing property addresses from matching rows

This improved completeness of the address data.

---

### 3. Split Property Address into Separate Columns
The `PropertyAddress` field contained both address and city in one column.

It was split into:
- `PropertySplitAddess`
- `PropertySplitCity`

Functions used:
- `SUBSTRING()`
- `CHARINDEX()`

This created cleaner and more usable columns for later analysis.

---

### 4. Split Owner Address into Address, City, and State
The `OwnerAddress` field contained address, city, and state in one column.

It was split into:
- `OwnerSplitAddress`
- `OwnerSplitCity`
- `OwnerSplitState`

Functions used:
- `REPLACE()`
- `PARSENAME()`

This made the owner location information easier to work with.

---

### 5. Converted SoldAsVacant Values to Yes/No
The `SoldAsVacant` field used coded values such as `1` and `0`.

A new column called `NewSoldAsVacant` was created and populated using:

- `1 → Yes`
- `0 → No`

This was done using a `CASE WHEN` statement to improve readability.

---

### 6. Removed Duplicate Records
Duplicate rows were identified using a CTE with `ROW_NUMBER()`.

Rows were partitioned by:
- `ParcelID`
- `PropertyAddress`
- `SalePrice`
- `SaleDate`
- `LegalReference`

Then duplicate rows were deleted where:
- `row_num > 1`

This helped ensure the dataset was cleaner and more reliable.

---

### 7. Dropped Unused Columns
After creating cleaner replacement columns, the following original columns were removed:

- `OwnerAddress`
- `TaxDistrict`
- `PropertyAddress`
- `SaleDate`

This helped simplify the final cleaned table structure.

---

## Key SQL Operations Included
Main SQL tasks in this project include:

- converting raw date values
- filling missing values with self joins
- splitting text fields into multiple columns
- recoding binary/coded values into readable labels
- removing duplicate records with `ROW_NUMBER()`
- dropping redundant columns

---

## Key Outcomes
As a result of the cleaning process:

- date values were standardized
- missing property address values were populated
- combined address fields were separated into individual columns
- coded vacancy values became easier to interpret
- duplicate records were removed
- unnecessary columns were dropped

The final dataset is more structured and analysis-ready.
