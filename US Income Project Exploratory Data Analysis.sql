# US Income Project Exploratory Data Analysis

SELECT * 
FROM US_Income_Project.US_Household_Income;

SELECT * 
FROM US_Income_Project.us_household_income_statistics;

SELECT State_Name,  SUM(ALand), SUM(AWater) 
FROM US_Income_Project.US_Household_Income
GROUP BY State_name
ORDER BY 3 DESC
LIMIT 10
;

#INNER JOIN on ID 
SELECT * 
FROM US_Income_Project.US_Household_Income u
JOIN US_Income_Project.us_household_income_statistics us
	ON u.id = us.id
;

# check fir missing data that should not be used
SELECT * 
FROM US_Income_Project.US_Household_Income u
RIGHT JOIN US_Income_Project.us_household_income_statistics us
	ON u.id = us.id
 WHERE u.id IS NULL   
;

# remove unreported values 
SELECT * 
FROM US_Income_Project.US_Household_Income u
INNER JOIN US_Income_Project.us_household_income_statistics us
	ON u.id = us.id
WHERE mean <> 0    
;

SELECT u.State_Name, County, Type, `Primary`, Mean , Median 
FROM US_Income_Project.US_Household_Income u
INNER JOIN US_Income_Project.us_household_income_statistics us
	ON u.id = us.id
WHERE mean <> 0    
;


#check highest and lowest income mean and medians by state 
SELECT u.State_Name, ROUND(AVG(Mean),1) , ROUND(AVG(Median),1) 
FROM US_Income_Project.US_Household_Income u
INNER JOIN US_Income_Project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0      
GROUP BY u.State_Name    
ORDER BY 3 ASC 
LIMIT 10 
;

#looking at income by area type
SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),1) , ROUND(AVG(Median),1) 
FROM US_Income_Project.US_Household_Income u
INNER JOIN US_Income_Project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0      
GROUP BY Type  
ORDER BY 4 DESC
;

#some dirty data with means of 0... filtered out

#where are communities from since the income is so low
SELECT * 
FROM US_Income_Project.US_Household_Income
WHERE Type = 'community'
;

#Filtering out some outliers for types
SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),1) , ROUND(AVG(Median),1) 
FROM US_Income_Project.US_Household_Income u
INNER JOIN US_Income_Project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0      
GROUP BY Type  
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
LIMIT 20
;

#look to see income avg by large city
SELECT u.State_Name, City, ROUND(AVG(Mean),1),ROUND(AVG(Median),1)  
FROM US_Income_Project.US_Household_Income u
INNER JOIN US_Income_Project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City 
ORDER BY 3 Desc   
LIMIT 20
;

#why is the highest median 300,000? Is there a cap, how was data captured. 

