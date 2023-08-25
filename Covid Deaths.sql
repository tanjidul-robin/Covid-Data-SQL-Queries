--covid 19 data exploration
--skill used: joins, cte, temp table, windows functions, aggregate functions, creating views, converting data types



SELECT *
FROM [Portfolio_Project].[dbo].[CovidDeaths]
WHERE continent is not null
ORDER BY 3,4

--select data we need
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM [Portfolio_Project].[dbo].[CovidDeaths]
WHERE continent is not null
ORDER BY 3,4


--total cases vs total deaths
--parcentage of dying in bangladesh in terms of cases
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Percentage
FROM [Portfolio_Project].[dbo].[CovidDeaths]
WHERE Location LIKE 'Bangladesh'
ORDER BY 1,2


--total cases vs total population
--parcentage of people infected with covid
SELECT Location, date, total_cases, population, (total_cases/population)*100 AS Case_Percentage
FROM [Portfolio_Project].[dbo].[CovidDeaths]
WHERE Location LIKE 'Bangladesh'
ORDER BY 1,2


--countries with highest case rate compared to population
SELECT Location, population, MAX(total_cases) AS highest_infect_count, MAX((total_cases/population))*100 AS Case_Percentage
FROM [Portfolio_Project].[dbo].[CovidDeaths]
GROUP BY Location, population
ORDER BY Case_Percentage DESC


--countries with highest death count per population
SELECT Location, MAX(CAST(total_deaths AS INT)) AS Death_Count
FROM [Portfolio_Project].[dbo].[CovidDeaths]
WHERE continent is not null
GROUP BY Location
ORDER BY Death_Count DESC

--continent with highest death count per population
SELECT continent, MAX(CAST(total_deaths AS INT)) AS Death_Count
FROM [Portfolio_Project].[dbo].[CovidDeaths]
WHERE continent is not null
GROUP BY continent
ORDER BY Death_Count DESC


--global
SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as INT)) as total_deaths, SUM(CAST(new_deaths as INT))/SUM(new_cases)*100 AS Death_Percentage
FROM [Portfolio_Project].[dbo].[CovidDeaths]
WHERE continent is not null
--GROUP BY date
ORDER BY 1,2

--population  vs vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(CAST(vac.new_vaccinations as INT)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
  FROM Portfolio_Project..CovidVaccine vac
   JOIN Portfolio_Project..CovidDeaths dea
     ON vac.location = dea.location
     AND vac.date = dea.date
  WHERE dea.continent is not null
  ORDER BY 2,3


--CTE
WITH pop_vac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(CAST(vac.new_vaccinations as INT)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
  FROM Portfolio_Project..CovidVaccine vac
   JOIN Portfolio_Project..CovidDeaths dea
     ON vac.location = dea.location
     AND vac.date = dea.date
  WHERE dea.continent is not null
)
SELECT *, (rolling_people_vaccinated/population)*100 vaccine_parcentage
FROM pop_vac


--temp table
DROP Table if exists #PercentPop_Vac
CREATE TABLE #PercentPop_Vac
(
Continent NVARCHAR(255),
Location NVARCHAR(255),
Date DATETIME,
Population NUMERIC,
New_vaccinations NUMERIC,
RollingPeopleVaccinated NUMERIC
)

INSERT INTO #PercentPop_Vac
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM Portfolio_Project..CovidDeaths dea
JOIN Portfolio_Project..CovidVaccine vac
	ON dea.location = vac.location
	AND dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPop_Vac

--view
CREATE VIEW pop_vac AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(CAST(vac.new_vaccinations as INT)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
  FROM Portfolio_Project..CovidVaccine vac
   JOIN Portfolio_Project..CovidDeaths dea
     ON vac.location = dea.location
     AND vac.date = dea.date
  WHERE dea.continent is not null

