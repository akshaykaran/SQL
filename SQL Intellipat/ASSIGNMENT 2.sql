USE ADV_SQL;

--Tasks to be performed:


--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.

DROP FUNCTION IF EXISTS dbo.InsertChickenForQuickBites;
CREATE FUNCTION dbo.InsertChickenForQuickBites
(
    @OriginalRestaurantype NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @ModifiedRestaurantype NVARCHAR(MAX);

    IF CHARINDEX('Quick Bites', @OriginalRestaurantype) > 0
    BEGIN
        SET @ModifiedRestaurantype = REPLACE(@OriginalRestaurantype, 'Quick Bites', 'Quick Chicken Bites');
    END
    ELSE
    BEGIN
        SET @ModifiedRestaurantype = @OriginalRestaurantype;
    END

    RETURN @ModifiedRestaurantype;
END;

UPDATE Jomato
SET RestaurantType = dbo.InsertChickenForQuickBites('Quick Bites')
WHERE RestaurantType = 'Quick Bites';


--2. Use the function to display the restaurant name and cuisine type which has the maximum number of rating.

CREATE FUNCTION dbo.GetRestaurantWithMaxRating()
RETURNS TABLE
AS
RETURN (
    SELECT TOP 1 WITH TIES RestaurantName, CuisinesType
    FROM Jomato
    ORDER BY Rating DESC
);

SELECT *
FROM dbo.GetRestaurantWithMaxRating();


--3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4 start rating, 
--‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3 and below 3.5 and ‘Bad’ if it is below 3 star rating.

SELECT RestaurantName,RATING,
CASE
   WHEN RATING >=4.0 THEN 'EXCELLENT'
   WHEN RATING >=3.5 THEN 'GOOD'
   WHEN RATING >=3.0 THEN 'AVERAGE'
   ELSE 'BAD'
END
AS RATING_STATUS
FROM JOMATO;


--4. Find the Ceil, floor and absolute values of the rating column and display the current date and separately display the year, month_name and day.

SELECT CEILING(RATING) AS RATING_CEILING,RATING,FLOOR(RATING) AS RATING_FLOOR,GETDATE() AS DATE ,YEAR(GETDATE()) AS 'YEAR'
FROM JOMATO

--5. Display the restaurant type and total average cost using rollup.

SELECT
    RestaurantType,
    AVG(AverageCost) AS TotalAverageCost
FROM
    Jomato
GROUP BY
    ROLLUP (RestaurantType);