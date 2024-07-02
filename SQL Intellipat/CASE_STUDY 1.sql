use CASE_STUDY1;
select * from fact;
select * from Location;
select * from Product;

--1. Display the number of states present in the LocationTable.
SELECT COUNT(DISTINCT(STATE)) AS 'NUMBER OF STATES' FROM LOCATION

--2. How many products are of regular type?
SELECT COUNT(DISTINCT(PRODUCT)) AS ' NUMBER OF REGULAR PRODUCTS' FROM PRODUCT
WHERE TYPE = 'Regular'

--3. How much spending has been done on marketing of product ID 1?
select ProductId,sum(Marketing) as 'MARKETING SPEND'
from fact
group by ProductId
having ProductId =1;


--4. What is the minimum sales of a product?
SELECT MIN(SALES) AS 'PRODUCT WITH MINIMUN SALES'
FROM FACT


--5. Display the max Cost of Good Sold (COGS).
SELECT MAX(COGS) AS 'max Cost of Good Sold '
FROM FACT

--6. Display the details of the product where product type is coffee.
SELECT * 
FROM PRODUCT
WHERE PRODUCT_TYPE = 'Coffee'

--7. Display the details where total expenses are greater than 40.
SELECT * 
FROM FACT
WHERE TOTAL_EXPENSES >40;


--8. What is the average sales in area code 719?
SELECT AREA_CODE,AVG(SALES) AS 'AVERAGE SALES'
FROM FACT
GROUP BY AREA_CODE
HAVING AREA_CODE = 719

--9. Find out the total profit generated by Colorado state.

WITH AREA AS (SELECT  STATE,AREA_CODE AS 'AREA_CODE' FROM LOCATION
              WHERE STATE = 'Colorado'),
TOTAL_PROFIT AS (SELECT F.AREA_CODE AS 'AREA_CODE',SUM(F.PROFIT) AS 'TOTAL_PROFIT'
                 FROM FACT F
				 GROUP BY F.AREA_CODE)
SELECT A.AREA_CODE, T.TOTAL_PROFIT 
FROM AREA A,TOTAL_PROFIT T
WHERE A.AREA_CODE = T.AREA_CODE;

WITH AREA AS (SELECT  STATE,AREA_CODE AS 'AREA_CODE' FROM LOCATION
              WHERE STATE = 'Colorado')
SELECT F.AREA_CODE AS 'AREA_CODE',SUM(F.PROFIT) AS 'TOTAL_PROFIT'
FROM FACT F
JOIN AREA A
ON F.AREA_CODE = A.AREA_CODE
GROUP BY F.AREA_CODE;

--10. Display the average inventory for each product ID.
SELECT PRODUCTID,AVG(INVENTORY) AS 'AVERAGE INVENTORY'
FROM FACT
GROUP BY PRODUCTID
ORDER BY PRODUCTID ASC;

SELECT PRODUCTID,
AVG(INVENTORY) OVER(PARTITION BY PRODUCTID) AS 'AVERAGE INVENTORY'
FROM FACT
ORDER BY PRODUCTID;

--11. Display state in a sequential order in a Location Table.
SELECT DISTINCT(STATE) 
FROM LOCATION
ORDER BY STATE ASC

--12. Display the average budget of the Product where the average budget margin should be greater than 100.
SELECT PRODUCTID, AVG(BUDGET_MARGIN) AS 'AVERAGE BUDGET MARGIN' 
FROM FACT
GROUP BY PRODUCTID
HAVING AVG(BUDGET_MARGIN)>100;

WITH T AS (SELECT PRODUCTID,
AVG(BUDGET_MARGIN) OVER(PARTITION BY PRODUCTID) AS 'AVERAGE_BUDGET_MARGIN'
FROM FACT)
SELECT * FROM T
WHERE T.AVERAGE_BUDGET_MARGIN>100;
--SOME VERSIONS OF SQL ARE NOT COMATIBLE WITH HAVING CLAUSE IN WINDOWS FUNCTION THUS WE NEED CTE

--13. What is the total sales done on date 2010-01-01?
SELECT DATE, SUM(SALES) AS ' TOTAL SALES'
FROM FACT
GROUP BY DATE
ORDER BY DATE ASC;

SELECT DATE, 
SUM(SALES) OVER(PARTITION BY DATE ORDER BY DATE ASC) AS ' TOTAL SALES'
FROM FACT;

--14. Display the average total expense of each product ID on an individual date.
SELECT DATE, PRODUCTID,AVG(TOTAL_EXPENSES) AS ' DAILY TOTAL EXP'
FROM FACT
GROUP BY DATE,PRODUCTID
ORDER BY DATE;

SELECT DATE,PRODUCTID,
AVG(TOTAL_EXPENSES) OVER(PARTITION BY DATE,PRODUCTID ORDER BY DATE)  AS ' DAILY TOTAL EXP'
FROM FACT;

--15. Display the table with the following attributes such as date, productID,product_type, product, sales, profit, state, area_code.
SELECT F.DATE,F.PRODUCTID,P.PRODUCT_TYPE,P.PRODUCT,F.SALES,F.PROFIT,L.STATE,F.AREA_CODE
FROM FACT F
INNER JOIN PRODUCT P
ON F.PRODUCTID = P.PRODUCTID
INNER JOIN LOCATION L
ON F.AREA_CODE = L.AREA_CODE;


--16. Display the rank without any gap to show the sales wise rank.
SELECT SALES,
ROW_NUMBER() OVER(ORDER BY SALES DESC) AS SALES_RANK
FROM FACT;

SELECT SALES,
RANK() OVER(ORDER BY SALES DESC) AS SALES_RANK
FROM FACT;

--17. Find the state wise profit and sales.
SELECT L.STATE,SUM(F.PROFIT)AS PROFIT,SUM(F.SALES) AS SALES
FROM FACT F
JOIN LOCATION L
ON F.AREA_CODE = L.AREA_CODE
GROUP BY L.STATE
ORDER BY L.STATE;

SELECT L.STATE,
SUM(F.PROFIT) OVER W AS PROFIT,
SUM(F.SALES)OVER W AS SALES
FROM FACT F
JOIN LOCATION L
ON F.AREA_CODE = L.AREA_CODE
WINDOW w AS (ORDER BY L.STATE );


--18. Find the state wise profit and sales along with the product name.

SELECT L.STATE,SUM(F.PROFIT) AS 'PROFIT',SUM(F.SALES) AS 'SALES',P.PRODUCT
FROM FACT F
INNER JOIN LOCATION L
ON F.AREA_CODE = L.AREA_CODE
INNER JOIN PRODUCT P 
ON F.PRODUCTID = P.PRODUCTID
GROUP BY L.STATE,P.PRODUCT
ORDER BY L.STATE,P.PRODUCT

SELECT L.STATE,
SUM(F.PROFIT) OVER W AS PROFIT,
SUM(F.SALES) OVER W SALES
FROM FACT F
INNER JOIN LOCATION L
ON F.AREA_CODE = L.AREA_CODE
INNER JOIN PRODUCT P 
ON F.PRODUCTID = P.PRODUCTID
WINDOW W AS(PARTITION BY L.STATE,P.PRODUCT ORDER BY L.STATE,P.PRODUCT);

--19. If there is an increase in sales of 5%, calculate the increasedsales.
SELECT SALES, (SALES*1.05) AS INCREASED_SALES
FROM FACT

--20. Find the maximum profit along with the product ID and producttype.

SELECT F.PROFIT,P.PRODUCTID,P.PRODUCT_TYPE
FROM FACT F
INNER JOIN PRODUCT P
ON F.PRODUCTID = P.PRODUCTID
WHERE F.PROFIT =(SELECT MAX(F.PROFIT) AS MAX_PROFIT FROM FACT F);


--21. Create a stored procedure to fetch the result according to the product type from Product Table.


--22. Write a query by creating a condition in which if the total expenses is less than 60 then it is a profit or else loss
SELECT TOTAL_EXPENSES,
 CASE 
        WHEN total_expenses < 60 THEN 'Profit'
        ELSE 'Loss'
    END AS Result
FROM FACT;

--23. Give the total weekly sales value with the date and product ID details. Use roll-up to pull the data in hierarchical order.

SELECT DATEPART(WEEK,DATE) AS WEEKS,PRODUCTID,SUM(SALES) AS WEEKLY_SALES
FROM FACT
GROUP BY
ROLLUP( DATEPART(WEEK,DATE),PRODUCTID)

SELECT DATE,
DATEPART(WEEK,DATE) AS 'WEEK',
DATEPART(MONTH,DATE) AS 'MONTH',
DATEPART(YEAR,DATE) AS 'YEAR',
DATEPART(DAY,DATE) AS 'DAY',
DATENAME(MONTH,DATE) AS 'MONTH NAME',
DATENAME(WEEKDAY,DATE) AS 'DAY NAME'
FROM FACT



--24. Apply union and intersection operator on the tables which consist of attribute area code.

SELECT Area_Code FROM FACT
UNION ALL
SELECT Area_Code FROM LOCATION;

SELECT DISTINCT F.Area_Code
FROM FACT F
INNER JOIN LOCATION L ON F.Area_Code = L.Area_Code;

--25. Create a user-defined function for the product table to fetch a particular product type based upon the user�s preference.

CREATE FUNCTION dbo.GetProductsByType
(
    @UserPreference NVARCHAR(20) 
)
RETURNS TABLE
AS
RETURN
(
    SELECT ProductID, Product, Product_Type
    FROM Product
    WHERE Product_Type = @UserPreference
);
SELECT * FROM dbo.GetProductsByType('Espresso');

--26. Change the product type from coffee to tea where product ID is 1 and undo it.

UPDATE PRODUCT
SET Product_Type = 'Tea'
WHERE PRODUCTID=1;

SELECT * FROM PRODUCT;

--27. Display the date, product ID and sales where total expenses are between 100 to 200.

SELECT DATE,PRODUCTID, SALES
FROM FACT
WHERE Total_Expenses BETWEEN 100 AND 200


--28. Delete the records in the Product Table for regular type.

DELETE FROM PRODUCT
WHERE TYPE = 'Regular'

--29. Display the ASCII value of the fifth character from the column Product.

SELECT 
    CASE 
        WHEN LEN(Product) >= 5 THEN 
          CAST( ASCII(SUBSTRING(Product, 5, 1))AS VARCHAR)
        ELSE 
            'NO 5TH CHAR'
    END AS ASCII_Value
FROM Product;

