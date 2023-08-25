# COVID-19 Data Exploration SQL Queries

This repository contains a collection of SQL queries that explore COVID-19 data, utilizing various SQL skills such as joins, Common Table Expressions (CTEs), temporary tables, window functions, aggregate functions, creating views, and converting data types.

## Queries

### Query 1: Basic Data Exploration
The initial query retrieves all available data from the 'CovidDeaths' table, filtering records with non-null continents and ordering by specified columns.

### Query 2: Selecting Relevant Data
This query selects specific columns (Location, date, total_cases, new_cases, total_deaths, population) from the 'CovidDeaths' table for analysis, excluding null continents and ordering the results.

### Query 3: Case Fatality Percentage Calculation
Calculates the death percentage for a specific location (Bangladesh) in terms of reported cases.

### Query 4: COVID-19 Infection Percentage Calculation
Calculates the percentage of people infected with COVID-19 in a specific location (Bangladesh) based on reported cases and population.

### Query 5: Countries with Highest Infection Rate
Identifies countries with the highest COVID-19 infection rates based on reported cases and population, presenting both the total cases and the calculated case percentage.

### Query 6: Countries with Highest Death Count
Lists countries with the highest COVID-19 death counts, presenting the maximum death count for each country.

### Query 7: Continent with Highest Death Count
Displays the continent with the highest COVID-19 death count, showing the maximum death count for each continent.

### Query 8: Global COVID-19 Overview
Provides a global overview of new cases, total deaths, and the death percentage by summing up data from all continents.

### Query 9: Population vs Vaccination Analysis
Compares population data with new vaccination data for different locations and continents, using window functions to calculate rolling vaccinated people.

### Query 10: Using CTE (Common Table Expression)
Demonstrates the use of a CTE to calculate the rolling vaccinated people and vaccination percentage for different locations and continents.

### Query 11: Using Temporary Table
Utilizes a temporary table to store and calculate data related to population, new vaccinations, and rolling vaccinated people for various locations and continents.

### Query 12: Creating a View
Creates a view named 'pop_vac' that encapsulates the logic of joining 'CovidDeaths' and 'CovidVaccine' tables, calculating rolling vaccinated people and vaccination percentages for different locations and continents.

---

 
