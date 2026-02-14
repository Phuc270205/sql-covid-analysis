--Select *
--From SQL_Project..Covid19Death
--order by 3, 4

--Select *
--From SQL_Project..Covid19Vaccination
--order by 3,4

-- Select Data


--Select country, date, total_cases, new_cases, total_deaths, population
--From SQL_Project..Covid19Death
--order by 1,2



-- Checking Total Cases and Total Deaths and percentage of total deaths over total cases
-- Shows chances of dying if you having covid in specific country
Select country, date, total_cases, total_deaths, 
(CAST(total_deaths AS FLOAT)/NULLIF(total_cases, 0))*100 as DeathPercentage
From SQL_Project..Covid19Death
Where country like '%vietnam%'
order by 1,2


-- Checking total cases vs population
-- Shows percentage of population got Covid
Select country, date, total_cases, population, 
(CAST(total_cases AS FLOAT)/population)*100 as PercentPopulationInfected
From SQL_Project..Covid19Death
Where country like '%vietnam%'
order by 1,2


-- Checking at countries with highest infection rate compared to population

Select country, MAX(total_cases) as HighestInfectionCount, population, 
MAX((CAST(total_cases AS FLOAT)/population))*100 as PercentPopulationInfected
From SQL_Project..Covid19Death
Group by country, population
order by PercentPopulationInfected desc

-- Showing countries with highest deadth count per population


Select country, Max(total_deaths) as TotalDeathCount
From SQL_Project..Covid19Death
Where continent is not null
Group by country
order by TotalDeathCount desc

-- Showing continent with highest deadth count per population

Select country, Max(total_deaths) as TotalDeathCount
From SQL_Project..Covid19Death
Where continent is null
Group by country
order by TotalDeathCount desc

-- DeathPercentage in global by date

Select date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deadths, 

SUM(new_deaths)*1.0/SUM(NULLIF(new_cases, 0))*100 as DeathPercentage

From SQL_Project..Covid19Death
Where continent is not null
Group by date
order by 1,2


-- Looking at total population vs vaccinations

Select dea.continent, dea.country, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.country Order by dea.country, dea.date)
From SQL_Project..Covid19Death dea
Join SQL_Project..Covid19Vaccination vac
	On dea.country = vac.country
	and dea.date = vac.date
where dea.continent is not null
--where country like '%vietnam%'
order by 1,2,3

-- Use CTE to calculate % of people getting vaccination

With PopvsVac (Continent, country, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.country, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.country Order by dea.country, dea.date)
as RollingPeopleVaccinated
From SQL_Project..Covid19Death dea
Join SQL_Project..Covid19Vaccination vac
	On dea.country = vac.country
	and dea.date = vac.date
where dea.continent is not null
--where dea.country like '%vietnam%'
--order by 1,2,3
)
Select *, (RollingPeopleVaccinated/population)*100 as percent_vaccination
From PopvsVac

-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Country nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.country, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.country Order by dea.country, dea.date)
as RollingPeopleVaccinated
From SQL_Project..Covid19Death dea
Join SQL_Project..Covid19Vaccination vac
	On dea.country = vac.country
	and dea.date = vac.date
--where dea.continent is not null

Select *, (RollingPeopleVaccinated/population)*100 as percent_vaccination
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.country, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.country Order by dea.country, dea.date)
as RollingPeopleVaccinated
From SQL_Project..Covid19Death dea
Join SQL_Project..Covid19Vaccination vac
	On dea.country = vac.country
	and dea.date = vac.date
where dea.continent is not null

Select *
From PercentPopulationVaccinated
