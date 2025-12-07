--SQL Advance Case Study


--Q1--List all the states in which we have customers who have bought cellphones from 2005 till today.
SELECT DISTINCT State 
FROM (
SELECT L.State, SUM(T.Quantity) as Count_Qty, YEAR(T.DATE) as Year
FROM DIM_LOCATION L
JOIN FACT_TRANSACTIONS T
ON L.IDLocation = T.IDLocation
WHERE YEAR(T.DATE) >= 2005
GROUP BY L.State, YEAR(T.DATE)
) as A;

--Q2--What state in the US is buying the most'Samsung' cell phones?
SELECT TOP 1 L.State, COUNT(*) as Qty_cellphones
FROM DIM_LOCATION L
JOIN FACT_TRANSACTIONS T
ON L.IDLocation = T.IDLocation
JOIN DIM_MODEL MO
ON T.IDModel = MO.IDModel
JOIN DIM_MANUFACTURER M
ON MO.IDManufacturer = M.IDManufacturer
WHERE L.Country = 'US' AND M.Manufacturer_Name = 'Samsung'
GROUP BY L.State
ORDER BY Qty_cellphones DESC;

--Q3--Show the number of transactions for each model per zip code per state.
SELECT T.IDModel, L.State, L.ZipCode, COUNT(*) as Total_transactions
FROM FACT_TRANSACTIONS T
JOIN DIM_LOCATION L
ON T.IDLocation = L.IDLocation
GROUP BY T.IDModel, L.State, L.ZipCode;

--Q4--Show the cheapest cellphone(Output should contain the price also)
SELECT TOP 1 Model_Name, MIN(Unit_price) as Cheapest_Cell
FROM DIM_MODEL
GROUP BY Model_Name
ORDER BY Cheapest_Cell ASC;

--Q5--Find out the average price for each model in the top5 manufacturers in terms of sales quantity and order by average price.
SELECT M.Manufacturer_Name, MO.IDModel, AVG(TotalPrice) as Avg_price, SUM(Quantity) as Total_Qty 
FROM FACT_TRANSACTIONS T
JOIN DIM_MODEL MO
ON T.IDModel = MO.IDModel
JOIN DIM_MANUFACTURER M
ON MO.IDManufacturer = M.IDManufacturer
WHERE Manufacturer_Name IN ( SELECT TOP 5 M.Manufacturer_Name
							FROM FACT_TRANSACTIONS T
							JOIN DIM_MODEL MO
							ON T.IDModel = MO.IDModel
							JOIN DIM_MANUFACTURER M
							ON MO.IDManufacturer = M.IDManufacturer
							GROUP BY M.Manufacturer_Name
							ORDER BY SUM(T.TotalPrice) DESC
							)

GROUP BY MO.IDModel, M.Manufacturer_Name
ORDER BY Avg_price DESC;

--Q6--List the names of the customers and the average amount spent in 2009, where the average is higher than 500
SELECT C.Customer_Name, AVG(T.TotalPrice) as Avg_price
FROM DIM_CUSTOMER C
JOIN FACT_TRANSACTIONS T
ON C.IDCustomer = T.IDCustomer
WHERE YEAR(T.Date) = 2009 
GROUP BY C.Customer_Name
HAVING AVG(T.TotalPrice) > 500
ORDER BY Avg_price;

--Q7--List if there is any model that was in the top 5 in terms of quantity, simultaneously in 2008, 2009 and 2010
SELECT * FROM
(
SELECT TOP 5 IDModel
FROM FACT_TRANSACTIONS
WHERE YEAR(Date) = 2008
GROUP BY IDModel, YEAR(Date)
ORDER BY SUM(Quantity) DESC
) as A
INTERSECT
SELECT * FROM
(
SELECT TOP 5 IDModel
FROM FACT_TRANSACTIONS
WHERE YEAR(Date) = 2009
GROUP BY IDModel, YEAR(Date)
ORDER BY SUM(Quantity) DESC
) as B
INTERSECT
SELECT * FROM
(
SELECT TOP 5 IDModel
FROM FACT_TRANSACTIONS
WHERE YEAR(Date) = 2010
GROUP BY IDModel, YEAR(Date)
ORDER BY SUM(Quantity) DESC
) as C

--Q8--Show the manufacturer with the 2nd top sales in the year of 2009 and the manufacturer with the 2nd top sales in the year of 2010.  
SELECT * FROM
(
SELECT TOP 1* FROM
(
SELECT TOP 2 M.Manufacturer_Name, YEAR(T.Date) as Year, SUM(T.TotalPrice) as Sales
FROM FACT_TRANSACTIONS T
JOIN DIM_MODEL MO
ON T.IDModel = MO.IDModel
JOIN DIM_MANUFACTURER M
ON MO.IDManufacturer = M.IDManufacturer
WHERE YEAR(T.Date) = 2009
GROUP BY M.Manufacturer_Name, YEAR(T.Date)
ORDER BY Sales DESC
) as A
ORDER BY Sales
) as T1
UNION
SELECT * FROM
(
SELECT TOP 1* FROM
(
SELECT TOP 2 M.Manufacturer_Name, YEAR(T.Date) as Year, SUM(T.TotalPrice) as Sales
FROM FACT_TRANSACTIONS T
JOIN DIM_MODEL MO
ON T.IDModel = MO.IDModel
JOIN DIM_MANUFACTURER M
ON MO.IDManufacturer = M.IDManufacturer
WHERE YEAR(T.Date) = 2010
GROUP BY M.Manufacturer_Name, YEAR(T.Date)
ORDER BY Sales DESC
) as B
ORDER BY Sales
) as T2;

--Q9--Show the manufacturers that sold cellphones in 2010 but did not in 2009.
SELECT M.Manufacturer_Name
FROM FACT_TRANSACTIONS T
JOIN DIM_MODEL MO
ON T.IDModel = MO.IDModel
JOIN DIM_MANUFACTURER M
ON MO.IDManufacturer = M.IDManufacturer
WHERE YEAR(T.Date) = 2010
GROUP BY M.Manufacturer_Name
EXCEPT
SELECT M.Manufacturer_Name
FROM FACT_TRANSACTIONS T
JOIN DIM_MODEL MO
ON T.IDModel = MO.IDModel
JOIN DIM_MANUFACTURER M
ON MO.IDManufacturer = M.IDManufacturer
WHERE YEAR(T.Date) = 2009
GROUP BY M.Manufacturer_Name;

--Q10--Find top 100 customers and their average spend, average quantity by each year. Also find the percentage of change in their spend. 

SELECT * , (Avg_Spend - Lag_spend) as Percentage_Change FROM
(
SELECT *, LAG(Avg_Spend,1) OVER (PARTITION BY IDCustomer ORDER BY Year) as Lag_spend FROM
(
SELECT IDCustomer, YEAR(Date) as Year, AVG(TotalPrice) as Avg_Spend, SUM(Quantity) as Avg_Qty
FROM FACT_TRANSACTIONS
WHERE IDCustomer IN (SELECT TOP 100 C.IDCustomer
					FROM DIM_CUSTOMER C
					JOIN FACT_TRANSACTIONS T
					ON C.IDCustomer = T.IDCustomer
					GROUP BY C.IDCustomer
					ORDER BY SUM(TotalPrice) DESC
					)
GROUP BY IDCustomer, YEAR(Date) 
) as A
) as B
