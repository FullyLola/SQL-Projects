#World Life Expectancy Project (Data Cleaning)

SELECT * 
FROM world_life_expectancy;

# ID dupes by country and year first
SELECT Country, YEAR, CONCAT(Country, YEAR), COUNT(CONCAT(Country, YEAR))
FROM world_life_expectancy
GROUP BY Country, YEAR, CONCAT(Country, YEAR)
HAVING COUNT(CONCAT(Country, YEAR)) > 1
;

# Find the row numbers
SELECT *
FROM(
	SELECT Row_ID,
	CONCAT(Country, YEAR),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, YEAR) ORDER BY CONCAT(Country, YEAR)) AS row_num
	FROM world_life_expectancy
	) AS row_table
WHERE row_num > 1
;

# DELETE Duplicate Rows
DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
    SELECT Row_ID
	FROM(
		SELECT Row_ID,
		CONCAT(Country, YEAR),
		ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, YEAR) ORDER BY CONCAT(Country, YEAR)) AS row_num
		FROM world_life_expectancy
		) AS row_table
	WHERE row_num > 1
    )
;

#view status options
SELECT DISTINCT(status)
FROM world_life_expectancy
WHERE Status <> ''
;

SELECT DISTINCT(status)
FROM world_life_expectancy
WHERE Status = ''
;

#view all deveolping countries
SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;

#this did not work, look for workaround
UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN ( 
	SELECT DISTINCT(Country)
	FROM world_life_expectancy
	WHERE Status = 'Developing'
);

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;

SELECT Country
FROM world_life_expectancy
WHERE Status is Null
;

SELECT Country
FROM world_life_expectancy
WHERE Status = ''
;

SELECT *
FROM world_life_expectancy
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

#It makes sense to populate life expectancy as an avarage of the row before and the row after
SELECT *
FROM world_life_expectancy
#WHERE Lifeexpectancy = ''
;

SELECT Country, YEAR, Lifeexpectancy
FROM world_life_expectancy
WHERE Lifeexpectancy = ''
;

SELECT t1.Country, t1.YEAR, t1.Lifeexpectancy,
		t2.Country, t2.YEAR, t2.Lifeexpectancy,
        t3.Country, t3.YEAR, t3.Lifeexpectancy,
	ROUND((t2.Lifeexpectancy + t3.Lifeexpectancy)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON  t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON  t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.Lifeexpectancy = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON  t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON  t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET  t1.Lifeexpectancy = ROUND((t2.Lifeexpectancy + t3.Lifeexpectancy)/2,1)
WHERE t1.Lifeexpectancy = ''
;


SELECT *
FROM world_life_expectancy;

