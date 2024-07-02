USE ADV_SQL;

--Tasks to be performed:

SELECT * FROM JOMATO;

--1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.

CREATE PROCEDURE GetRestaurantsWithTableBookingNotZero
AS
BEGIN
    SELECT RestaurantName, RestaurantType, CuisinesType
    FROM Jomato
    WHERE TableBooking <> 0;
END;
EXEC GetRestaurantsWithTableBookingNotZero;

--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.

BEGIN TRANSACTION;

UPDATE Jomato
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

SELECT * FROM Jomato;

ROLLBACK TRANSACTION; 

--3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.

WITH TOP_AREA AS (
SELECT AREA AS AREA,RATING,
ROW_NUMBER() OVER( ORDER BY RATING DESC) AS RNK
FROM JOMATO)
SELECT * 
FROM TOP_AREA
WHERE RNK<=5;

--4. Use the while loop to display the 1 to 50.

DECLARE @TopAreas TABLE (
    AREA NVARCHAR(20),
    RATING INT,
    RNK INT
);
INSERT INTO @TopAreas (AREA, RATING, RNK)
SELECT AREA, RATING, ROW_NUMBER() OVER (ORDER BY RATING DESC) AS RNK
FROM JOMATO;
DECLARE @Counter INT = 1;
WHILE @Counter <= 50
BEGIN
    SELECT AREA, RATING,RNK
    FROM @TopAreas
    WHERE RNK = @Counter;

    SET @Counter = @Counter + 1;
END;

--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.

CREATE VIEW TopRating AS
SELECT TOP 5
    RestaurantName,Rating
FROM
    Jomato
ORDER BY
    Rating DESC;

SELECT * FROM TopRating;

--6. Write a trigger that sends an email notification to the restaurant owner whenever a new record is inserted

CREATE TRIGGER SendEmailOnInsert
ON Jomato
AFTER INSERT
AS
BEGIN
    DECLARE @RestaurantName NVARCHAR(25);
    DECLARE @EmailAddress NVARCHAR(25);
    DECLARE @Subject NVARCHAR(25);
    DECLARE @Body NVARCHAR(MAX);

    -- Get the newly inserted values
    SELECT TOP 1
        @RestaurantName = i.RestaurantName,
        @EmailAddress = 'aniketranjan.ra@gmail.com',
        @Subject = 'New Record Inserted',
        @Body = 'A new record has been inserted for restaurant: ' + i.RestaurantName
    FROM
        inserted i;

    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'LAPTOP-TDIFK9GP\ANIKET1', 
        @recipients = @EmailAddress,
        @subject = @Subject,
        @body = @Body;

END;