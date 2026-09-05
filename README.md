# NULL-Functions-In-SQL-Server


This repository contains my hands-on practice with **NULL Functions in SQL Server**.

NULL functions are commonly used by Data Analysts, SQL Developers, and Data Engineers for **handling missing values, preventing calculation errors, cleaning data, and improving data quality**.

## NULL Functions Covered

### 1. COALESCE

`COALESCE()` returns the first non-NULL value from a list of expressions.

**Applications:**

* Replacing missing scores with zero
* Providing default values
* Handling missing customer information
* Cleaning data before analysis

```sql
SELECT
    CustomerID,
    Score,
    COALESCE(Score, 0) AS Score2,
    AVG(Score) OVER () AS AvgScores,
    AVG(COALESCE(Score, 0)) OVER () AS AvgScore2
FROM Sales.Customers;
```

### 2. COALESCE with Mathematical Operations

`COALESCE()` can be used in calculations to prevent NULL values from producing NULL results.

**Applications:**

* Adding bonus points to customer scores
* Calculating totals
* Handling missing numerical values
* Preparing data for reporting

```sql
SELECT
    CustomerID,
    FirstName,
    LastName,
    FirstName + ' ' + COALESCE(LastName, '') AS FullName,
    Score,
    COALESCE(Score, 0) + 20 AS ScoreWithBonus
FROM Sales.Customers;
```

### 3. COALESCE with Sorting

NULL values can be handled while sorting data by using a `CASE` expression.

**Applications:**

* Sorting customers by score
* Displaying missing values at the end
* Improving report readability
* Creating consistent sorting rules

```sql
SELECT
    CustomerID,
    Score
FROM Sales.Customers
ORDER BY
    CASE WHEN Score IS NULL THEN 1 ELSE 0 END,
    Score;
```

### 4. NULLIF

`NULLIF()` returns NULL when two expressions are equal. It is useful for preventing division-by-zero errors.

**Applications:**

* Preventing calculation errors
* Calculating sales price
* Handling zero quantities
* Cleaning invalid numerical values

```sql
SELECT
    OrderID,
    Sales,
    Quantity,
    Sales / NULLIF(Quantity, 0) AS Price
FROM Sales.Orders;
```

### 5. IS NULL

`IS NULL` identifies records where a column contains a NULL value.

**Applications:**

* Finding missing customer scores
* Identifying incomplete records
* Data-quality analysis
* Preparing data for cleaning

```sql
SELECT *
FROM Sales.Customers
WHERE Score IS NULL;
```

### 6. IS NOT NULL

`IS NOT NULL` identifies records where a column contains a value.

**Applications:**

* Finding complete records
* Filtering valid values
* Excluding missing information
* Creating reliable reports

```sql
SELECT *
FROM Sales.Customers
WHERE Score IS NOT NULL;
```

### 7. IS NULL with LEFT JOIN

`IS NULL` can be used with a `LEFT JOIN` to identify records that do not have a matching record in another table.

**Applications:**

* Finding customers without orders
* Identifying missing relationships
* Detecting unmatched records
* Performing anti-join analysis

```sql
SELECT
    C.*,
    O.OrderID
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
    ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL;
```

### 8. NULL, Empty String, and Blank Space

NULL, an empty string, and blank spaces are different types of values.

* `NULL` means the value is missing or unknown.
* `''` means the value is an empty string.
* `'  '` means the value contains spaces.

```sql
WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category
    UNION
    SELECT 2, NULL
    UNION
    SELECT 3, ''
    UNION
    SELECT 4, '  '
)
SELECT
    *,
    TRIM(Category) AS TrimmedCategory,
    DATALENGTH(TRIM(Category)) AS CategoryLength
FROM Orders;
```

### 9. Handling NULL and Empty Values with Data Policies

`TRIM()`, `NULLIF()`, and `COALESCE()` can be combined to create a data-cleaning policy.

**Applications:**

* Removing unnecessary spaces
* Converting empty strings into NULL
* Replacing missing values with a default label
* Standardizing raw data

```sql
WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category
    UNION
    SELECT 2, NULL
    UNION
    SELECT 3, ''
    UNION
    SELECT 4, '  '
)
SELECT
    *,
    TRIM(Category) AS Policy1,
    NULLIF(TRIM(Category), '') AS Policy2,
    COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3
FROM Orders;
```

## Real-World Applications

NULL functions are heavily used in **Data Analytics, Business Intelligence, Data Engineering, and Reporting**.

### Data Cleaning

`COALESCE()`, `NULLIF()`, and `TRIM()` help clean missing, empty, and incorrectly formatted values.

### Preventing Calculation Errors

`NULLIF()` can prevent division-by-zero errors when calculating prices, ratios, or averages.

### Customer Analysis

`IS NULL` and `IS NOT NULL` help identify customers with missing or available information.

### Data Validation

NULL checks can identify incomplete records and improve data quality.

### Anti-Join Analysis

`IS NULL` with `LEFT JOIN` can find customers who have not placed orders or records without matching information.

### Report Preparation

`COALESCE()` can replace missing values with readable default values such as `0` or `'unknown'`.

### Data Standardization

Combining `TRIM()`, `NULLIF()`, and `COALESCE()` creates consistent values before loading data into reporting systems.

### ETL and Data Transformation

NULL functions are commonly used during ETL processes to transform raw data into analysis-ready data.

## Tools Used

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)

## Repository Structure

```text
sql-server-null-functions/
│
├── README.md
└── null_functions.sql
```

## Purpose

The purpose of this practice is to understand how SQL Server NULL functions can be used to **handle missing values, prevent calculation errors, validate data, and prepare clean data for analysis**.

These functions are important skills for anyone working in **SQL, Data Analytics, Data Engineering, or Business Intelligence**.
