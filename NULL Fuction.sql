-- ISNULL AND COALESCE
-- Handling case in the Data Aggregations
-- Find the averege scores of the customers
SELECT
CustomerID,
Score,
COALESCE(Score,0) Score2,
AVG(Score) OVER () AvgScores,
AVG(COALESCE(Score,0)) OVER() AvgScore2
FROM Sales.Customers

-- Handling case in the Mathematic Opreations
-- Display the full name Customers in Single field
-- By Merging their first anf last names,
-- and add 20 bouns points to each customer ' s score.

SELECT
CustomerID,
FirstName,
LastName,
FirstName + ' ' + COALESCE(LastName,'') AS FullName,
Score,
COALESCE(Score, 0) + 20 AS ScoreWithBouns
FROM Sales.Customers


-- Handling case in the Sorting the Data
-- Sort the customers from lowest to highest scores,
-- with nulls appearing in last
SELECT
 CustomerID,
 Score
 FROM Sales.Customers
 ORDER BY  CASE WHEN Score IS NULL THEN 1 ELSE 0 END,Score

 -- NULLIF
 -- Dividing  by the zero  error
 -- Find the sales price for each order by  dividing the sales by the quantity
SELECT
OrderID,
Sales,
Quantity,
Sales/NULLIF(Quantity, 0) AS Price
FROM Sales.Orders

-- IS NULL AND NOT NULL
-- identify the customers who have the no scores
SELECT 
*
FROM Sales.Customers
WHERE Score IS NULL

-- identify the customers who have the Scores
SELECT 
*
FROM Sales.Customers
WHERE Score IS NOT NULL

--IS NULL USE CASE  IN
-- ANTI JOINS
-- List the all details for the customers who have not placed any orders
SELECT
C.*,
o.OrderID
FROM Sales.Customers C
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL

-- NULL VS EMPTY VS BLANK
WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  '
)
SELECT
*,
TRIM(Category),
DATALENGTH(TRIM(Category)) CategoryLen
FROM Orders


-- Data Policy
WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, '  '
)
SELECT
*,
TRIM(Category) Policy1,
NULLIF(TRIM(Category),'') Policy2,
COALESCE(NULLIF(TRIM(Category), ''),'unknown') Policy3
FROM Orders