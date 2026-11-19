#US Housegold Income Project DATA Cleaning


SELECT *
FROM US_Household_Income;

SELECT *
FROM us_household_income_statistics;

#Counting the number of records
SELECT count(id)
FROM US_Household_Income;

SELECT count(id)
FROM us_household_income_statistics;


#looking for dupes 
SELECT id, COUNT(id)
FROM US_Household_Income
GROUP BY id
HAVING COUNT(id) > 1
;

# finds the row ids of dupes
SELECT row_id
FROM (
	SELECT row_id,
	 id,
	 ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
	 FROM US_Household_Income
 ) AS duplicates
 WHERE row_num > 1
 ;


#adding the delete statement
DELETE FROM US_Household_Income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
		 id,
		 ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		 FROM US_Household_Income
		) AS duplicates
	WHERE row_num > 1)
 ;
 
 #checking the other table for dupes
 #looking for dupes 
SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;


#Checking for spelling errors
SELECT  DISTINCT State_Name
FROM US_Household_Income
ORDER BY 1
;

UPDATE US_Household_Income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

SELECT  DISTINCT State_ab
FROM US_Household_Income
ORDER BY 1
;


#Populating known missing data data 
SELECT *
FROM US_Household_Income
WHERE County = 'Autauga County' AND City = 'Vinemont'
ORDER BY 1
;

UPDATE US_Household_Income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County' 
AND City = 'Vinemont'
;

SELECT Type, COUNT(Type)
FROM US_Household_Income
GROUP BY Type
;

#Correct Boroughs 
UPDATE US_Household_Income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

#Would look for guidance regarding CDP and CPD Designations, is that erronious?


#Checking if there are errors with areas that have just land or just water
SELECT DISTINCT AWater
FROM US_Household_Income
WHERE AWater = 0 or AWater = '' OR AWater IS NULL
;

SELECT DISTINCT ALand
FROM US_Household_Income
WHERE ALand = 0 or ALand= '' OR ALand IS NULL
;

SELECT AWater
FROM US_Household_Income
WHERE(AWater = 0 or AWater = '' OR AWater IS NULL)
;

SELECT ALand
FROM US_Household_Income
WHERE ALand = 0 or ALand= '' OR ALand IS NULL
;


