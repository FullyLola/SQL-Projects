# World Lfe Expectancy Project (Exploratory Data Analysis)

SELECT * 
FROM world_life_expectancy
;

#Looking for changes in life expenctancy 
SELECT Country, 
MIN(Lifeexpectancy), 
MAX(Lifeexpectancy),
ROUND(MAX(Lifeexpectancy) - MIN(Lifeexpectancy),1) AS change_over_time
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(Lifeexpectancy) <> 0 #Removing countries that have 0s
AND MAX(Lifeexpectancy) <> 0
ORDER BY change_over_time ASC
;

#Life expectancy over time
SELECT Year, ROUND(AVG(Lifeexpectancy),1)
FROM world_life_expectancy
WHERE Lifeexpectancy <> 0 
GROUP BY Year
ORDER BY Year
;

SELECT * 
FROM world_life_expectancy
;

#Compare life expectency to GDP use country avg
SELECT Country, ROUND(AVG(Lifeexpectancy),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;

# Correlation of GDP to life expt
SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN Lifeexpectancy ELSE Null END) AS High_GDP_LiEx,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN Lifeexpectancy ELSE Null END) AS Low_GDP_LiEx
FROM world_life_expectancy
;

#Life Exp between Developing and Developed Countries 
SELECT status, ROUND(AVG(Lifeexpectancy),1)
FROM world_life_expectancy
GROUP BY Status
;

#32 developed vs 161 developing 
SELECT status, COUNT(DISTINCT Country) 
FROM world_life_expectancy
GROUP BY Status
;

SELECT status, COUNT(DISTINCT Country), ROUND(AVG(Lifeexpectancy),1)
FROM world_life_expectancy
GROUP BY Status
;

#BMI compared to Life Exp
SELECT Country, ROUND(AVG(Lifeexpectancy),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC
;

SELECT *
FROM world_life_expectancy
;

#Looking at mortality rates and expectancy 
SELECT Country,
Year,
Lifeexpectancy,
Adultmortality,
SUM(Adultmortality) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_total
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;




