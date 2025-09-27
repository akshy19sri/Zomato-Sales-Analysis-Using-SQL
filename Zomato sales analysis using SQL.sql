CREATE DATABASE ZomatoDB;
USE ZomatoDB;

CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY,
    RestaurantName VARCHAR(255),
    CountryCode INT,
    City VARCHAR(100),
    Address VARCHAR(255),
    Locality VARCHAR(100),
    LocalityVerbose VARCHAR(255),
    Cuisines VARCHAR(255),
    Currency VARCHAR(20),
    HasTablebooking ENUM('Yes','No'),
    HasOnlinedelivery ENUM('Yes','No'),
    Isdeliveringnow ENUM('Yes','No'),
    Switchtoordermenu ENUM('Yes','No'),
    Pricerange INT,
    Votes INT,
    AverageCostfortwo Int,
    Rating FLOAT
);

-- Check Table details
DESCRIBE Restaurants;

-- DUPLICATE CHECK
SELECT RestaurantID, COUNT(*) as count
FROM Restaurants
GROUP BY RestaurantID
HAVING count > 1;

-- COLUMN CHECK
ALTER TABLE Restaurants
DROP COLUMN Address,
DROP COLUMN LocalityVerbose;

-- TABLE MERGING WITH NEW COLUMN
CREATE TABLE Countries (
    CountryCode INT PRIMARY KEY,
    Country_Name VARCHAR(100)
);

-- Insert country mappings (example)
INSERT INTO Countries VALUES 
(1, 'India'), 
(14, 'Australia'),
(30, 'Brazil');

-- JOIN TO ADD COUNTRY NAME 
SELECT r.*, c.Country_Name 
FROM Restaurants r
LEFT JOIN Countries c ON r.CountryCode = c.CountryCode;

CREATE TABLE Restaurants_Enriched AS
SELECT r.*, c.Country_Name 
FROM Restaurants r
LEFT JOIN Countries c ON r.CountryCode = c.CountryCode;

-- CORRECT MISSPELLED CITY NAMES
SET SQL_SAFE_UPDATES = 0;
UPDATE Restaurants_Enriched
SET City = 'Delhi'
WHERE City IN ('New Deli', 'Delhii');

-- WINDOW FUNCTION TO COUNT RESTAURANTS
SELECT *,
       COUNT(*) OVER (PARTITION BY City ORDER BY RestaurantID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RollingCount
FROM Restaurants_Enriched;

-- STATISTICAL SUMMARY
SELECT 
    MIN(Votes) AS MinVotes, MAX(Votes) AS MaxVotes, AVG(Votes) AS AvgVotes,
    MIN(Rating) AS MinRating, MAX(Rating) AS MaxRating, AVG(Rating) AS AvgRating,
    MIN(AverageCostfortwo) AS MinCost, MAX(AverageCostfortwo) AS MaxCost, AVG(AverageCostfortwo) AS AvgCost
FROM Restaurants_Enriched;

-- RATING CATEGORY
ALTER TABLE Restaurants_Enriched ADD COLUMN Rating_Category VARCHAR(20);

UPDATE Restaurants_Enriched
SET Rating_Category = CASE
    WHEN Rating >= 4.5 THEN 'Excellent'
    WHEN Rating >= 4 THEN 'Very Good'
    WHEN Rating >= 3 THEN 'Good'
    ELSE 'Average or Below'
END;

-- COUNTRY DISTRIBUTION 
SELECT Country_Name, ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM Restaurants_Enriched), 2) AS Percentage
FROM Restaurants_Enriched
GROUP BY Country_Name;

-- PERCENTAGE  WITH ONLINE DELIVERY BY COUNTRY
SELECT Country_Name,
       ROUND(SUM(HasOnlinedelivery) * 100 / COUNT(*), 2) AS OnlineDeliveryPercent
FROM Restaurants_Enriched
GROUP BY Country_Name
ORDER BY OnlineDeliveryPercent DESC;

-- CITIES WITH HIGHEST NO OF RESTAURANTS
SELECT City, COUNT(*) AS NumRestaurants
FROM Restaurants_Enriched
GROUP BY City
ORDER BY NumRestaurants DESC
LIMIT 3;

-- MOST POPOULAR CUISINES
SELECT Cuisines, COUNT(*) AS Count
FROM Restaurants_Enriched
WHERE Locality = 'Connaught Place'
GROUP BY Cuisines
ORDER BY Count DESC;

-- TABLE BOOKING
SELECT HasTablebooking, COUNT(*) AS Count,
       AVG(Rating) AS AvgRating
FROM Restaurants_Enriched
WHERE Locality = 'Connaught Place'
GROUP BY HasTablebooking;

-- BEST MODERATELY PRICED 
SELECT RestaurantName, City, AverageCostfortwo, Rating, Votes
FROM Restaurants_Enriched
WHERE AverageCostfortwo BETWEEN 300 AND 700
  AND Rating > 4
  AND Votes > 100
  AND HasTablebooking = 1
ORDER BY Rating DESC, Votes DESC;

-- BEST RESTAURANT IN KOLKATA
SELECT RestaurantName, City, AverageCostfortwo, Rating, Votes
FROM Restaurants_Enriched
WHERE City = 'Kolkata'
  AND AverageCostfortwo BETWEEN 800 AND 2000
  AND Rating > 1
  AND Votes > 500
  AND HasTablebooking = 1
ORDER BY Rating DESC, Votes DESC
LIMIT 10;



