--Select *
--From SQL_Project..Covid19Death
--order by 3, 4

--Select *
--From SQL_Project..Covid19Vaccination
--order by 3,4

-- Select Data


Select country, date, total_cases, new_cases, total_deaths, population
From SQL_Project..Covid19Death
order by 1,2



-- Checking Total Cases and Total Deaths and percentage of total deaths over total cases
-- Shows chances of dying if you having covid in specific country
Select country, date, total_cases, total_deaths, 
(CAST(total_deaths AS FLOAT)/NULLIF(total_cases, 0))*100 as DeathPercentage
From SQL_Project..Covid19Death
Where country like '%states%'
order by 1,2


-- Checking total cases vs population
-- Shows percentage of population got Covid
Select country, date, total_cases, population, 
(total_cases/population)*100 as DeathPercentage
From SQL_Project..Covid19Death
Where country like '%states%'
order by 1,2
