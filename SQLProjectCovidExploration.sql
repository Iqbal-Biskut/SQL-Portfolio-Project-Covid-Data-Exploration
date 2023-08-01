SELECT *
FROM CovidDeaths

SELECT *
FROM CovidVaccinations

UPDATE CovidDeaths
SET continent = NULLIF(continent, ''),
	location = NULLIF(location, ''),
	total_cases = NULLIF(total_cases, 0),
	new_cases = NULLIF(new_cases, 0),
	new_cases_smoothed = NULLIF(new_cases_smoothed, 0),
	total_deaths = NULLIF(total_deaths, 0),
	new_deaths = NULLIF(new_deaths, 0),
	new_deaths_smoothed = NULLIF(new_deaths_smoothed, 0),
	total_cases_per_million = NULLIF(total_cases_per_million, 0),
	new_cases_per_million = NULLIF(new_cases_per_million, 0),
	new_cases_smoothed_per_million = NULLIF(new_cases_smoothed_per_million, 0),
	total_deaths_per_million = NULLIF(total_deaths_per_million, 0),
	new_deaths_per_million = NULLIF(new_deaths_per_million, 0),
	new_deaths_smoothed_per_million = NULLIF(new_deaths_smoothed_per_million, 0),
	reproduction_rate = NULLIF(reproduction_rate, 0),
	icu_patients = NULLIF(icu_patients, 0),
	icu_patients_per_million = NULLIF(icu_patients_per_million, 0),
	hosp_patients = NULLIF(hosp_patients, 0),
	hosp_patients_per_million = NULLIF(hosp_patients_per_million, 0),
	weekly_icu_admissions = NULLIF(weekly_icu_admissions, 0),
	weekly_icu_admissions_per_million = NULLIF(weekly_icu_admissions_per_million, 0),
	weekly_hosp_admissions = NULLIF(weekly_hosp_admissions, 0),
	weekly_hosp_admissions_per_million = NULLIF(weekly_hosp_admissions_per_million, 0)

UPDATE CovidVaccinations
SET continent = NULLIF(continent, ''),
	location = NULLIF(location, ''),
	total_tests = NULLIF(total_tests, 0),
	new_tests = NULLIF(new_tests, 0),
	total_tests_per_thousand = NULLIF(total_tests_per_thousand, 0),
	new_tests_per_thousand = NULLIF(new_tests_per_thousand, 0),
	new_tests_smoothed = NULLIF(new_tests_smoothed, 0),
	new_tests_smoothed_per_thousand = NULLIF(new_tests_smoothed_per_thousand, 0),
	positive_rate = NULLIF(positive_rate, 0),
	tests_per_case = NULLIF(tests_per_case, 0),
	total_vaccinations = NULLIF(total_vaccinations, 0),
	people_vaccinated = NULLIF(people_vaccinated, 0),
	people_fully_vaccinated = NULLIF(people_fully_vaccinated, 0),
	total_boosters = NULLIF(total_boosters, 0),
	new_vaccinations = NULLIF(new_vaccinations, 0),
	new_vaccinations_smoothed = NULLIF(new_vaccinations_smoothed, 0),
	total_vaccinations_per_hundred = NULLIF(total_vaccinations_per_hundred, 0),
	people_vaccinated_per_hundred = NULLIF(people_vaccinated_per_hundred, 0),
	people_fully_vaccinated_per_hundred = NULLIF(people_fully_vaccinated_per_hundred, 0),
	total_boosters_per_hundred = NULLIF(total_boosters_per_hundred, 0),
	new_vaccinations_smoothed_per_million = NULLIF(new_vaccinations_smoothed_per_million, 0),
	new_people_vaccinated_smoothed = NULLIF(new_people_vaccinated_smoothed, 0),
	new_people_vaccinated_smoothed_per_hundred = NULLIF(new_people_vaccinated_smoothed_per_hundred, 0),
	stringency_index = NULLIF(stringency_index, 0),
	population_density = NULLIF(population_density, 0),
	median_age = NULLIF(median_age, 0),
	aged_65_older = NULLIF(aged_65_older, 0),
	aged_70_older = NULLIF(aged_70_older,0),
	gdp_per_capita = NULLIF(gdp_per_capita, 0),
	extreme_poverty = NULLIF(extreme_poverty, 0),
	cardiovasc_death_rate = NULLIF(cardiovasc_death_rate, 0),
	diabetes_prevalence = NULLIF(diabetes_prevalence, 0),
	female_smokers = NULLIF(female_smokers, 0),
	male_smokers = NULLIF(male_smokers, 0),
	handwashing_facilities = NULLIF(handwashing_facilities, 0),
	hospital_beds_per_thousand = NULLIF(hospital_beds_per_thousand, 0),
	life_expectancy = NULLIF(life_expectancy, 0),
	human_development_index = NULLIF(human_development_index, 0),
	excess_mortality_cumulative_absolute = NULLIF(excess_mortality_cumulative_absolute, 0),
	excess_mortality_cumulative = NULLIF(excess_mortality_cumulative, 0),
	excess_mortality = NULLIF(excess_mortality, 0),
	excess_mortality_cumulative_per_million = NULLIF(excess_mortality_cumulative_per_million, 0)

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1, 2

-- Total Cases vs Total Deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM CovidDeaths
ORDER BY 1, 2

-- Showing likelihood of dying if contracted Covid in Malaysia

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM CovidDeaths
WHERE location = 'Malaysia'
ORDER BY 1, 2

-- Total Cases vs Population
-- Showing percentage of Population infected with Covid in Malaysia

SELECT location, date, total_cases, population, (total_cases/population)*100 AS percentage_of_population_infected
FROM CovidDeaths
WHERE location = 'Malaysia'
ORDER BY 1, 2

-- Countries with Highest Infection Rate vs Population

SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/population))*100 AS percentage_of_population_infected
FROM CovidDeaths
GROUP BY location, population
ORDER BY 4 DESC

-- Countries with Highest Death Count vs Population

SELECT location, MAX(total_deaths) AS total_countries_death_count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 2 DESC

-- BREAKING THINGS DOWN BY CONTINENT

-- Continents with Highest Death Count vs Population

SELECT location, MAX(total_deaths) AS total_continental_death_count
FROM CovidDeaths
WHERE continent IS NULL
AND location NOT IN('World', 'High income', 'Upper middle income', 'Lower middle income', 'Low income', 'European Union')
GROUP BY location
ORDER BY 2 DESC

-- GLOBAL NUMBERS

SELECT SUM(new_cases) AS total_global_cases, SUM(new_deaths) AS total_global_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS global_death_percentage
FROM CovidDeaths
ORDER BY 1, 2

-- Total Population vs Vaccination
-- Showing Rolling Count of Population that have received at least one vaccine

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_population_vaccinated
FROM CovidDeaths AS dea
JOIN CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- Using CTE to perform calculation on Partition By in previous query
-- Showing Rolling Percentage of Population Vaccinated

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, Rolling_Population_Vaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_population_vaccinated
FROM CovidDeaths AS dea
JOIN CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (Rolling_Population_Vaccinated/Population)*100 AS Rolling_Percentage_Population_Vaccinated
FROM PopvsVac

-- Creating View to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_population_vaccinated
FROM CovidDeaths AS dea
JOIN CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

-- From this point I deviate from Alex's guidance and do my own data exploration comparing data between Southeast Asian countries
-- Southeast Asia Death Percentage (Total Cases vs Total Deaths)

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS southeast_asia_death_percentage
FROM CovidDeaths
WHERE location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
ORDER BY 1, 2

-- Southeast Asia Infected Percentage (Total Cases vs Population)

SELECT location, date, total_cases, population, (total_cases/population)*100 AS southeast_asia_infected_percentage
FROM CovidDeaths
WHERE location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
ORDER BY 1, 2

-- Highest Infection Rate Among Southeast Asian Countries

SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/population))*100 AS percentage_of_population_infected
FROM CovidDeaths
WHERE location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
GROUP BY location, population
ORDER BY 4 DESC

-- Highest Death Count Among Southeast Asian Countries

SELECT location, MAX(total_deaths) AS total_countries_death_count
FROM CovidDeaths
WHERE location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
GROUP BY location, population
ORDER BY 2 DESC

-- Highest Percentage of Population Infected With Covid Among Southeast Asian Countries

SELECT location, population, MAX(total_cases) AS total_countries_infected_count,
	MAX((total_cases/population))*100 AS percentage_of_population_infected_with_covid
FROM CovidDeaths
WHERE location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
GROUP BY location, population
ORDER BY 4 DESC


-- Highest Percentage of Population Died From Covid Among Southeast Asian Countries

SELECT location, population, MAX(total_deaths) AS total_countries_death_count,
	MAX((total_deaths/population))*100 AS percentage_of_population_died_from_covid
FROM CovidDeaths
WHERE location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
GROUP BY location, population
ORDER BY 4 DESC

-- Highest Percentage of Population Fully Vaccinated Among Southeast Asian Countries
-- Using people_fully_vaccinated instead of new_vaccinations since the former is a more distinct count leading to more accurate results

SELECT dea.location, dea.population, MAX(vac.people_fully_vaccinated) AS total_countries_vaccination_count, 
		MAX((vac.people_fully_vaccinated/dea.population))*100 AS [percentage_of_population_fully vaccinated]
FROM CovidDeaths AS dea
JOIN CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
GROUP BY dea.location, dea.population
ORDER BY 4 DESC

-- Overall Percentages of Infection, Death and Full Vaccinations Among Southeast Asian Countries Combined

SELECT dea.location, dea.population, 
		MAX(dea.total_cases) AS total_countries_infected_count,
		MAX((dea.total_cases/population))*100 AS percentage_of_population_infected_with_covid,
		MAX(dea.total_deaths) AS total_countries_death_count,
		MAX((dea.total_deaths/population))*100 AS percentage_of_population_died_from_covid,
		MAX(vac.people_fully_vaccinated) AS total_countries_vaccination_count, 
		MAX((vac.people_fully_vaccinated/dea.population))*100 AS [percentage_of_population_fully vaccinated]
FROM CovidDeaths AS dea
JOIN CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
GROUP BY dea.location, dea.population
ORDER BY dea.location

-- Rolling Count of Cases, Deaths and Vaccinations In Southeast Asia
-- People_Fully_Vaccinated column is already a rolling count

SELECT dea.location, dea.date, dea.population,
	dea.new_cases, SUM(dea.new_cases) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_new_cases,
	dea.new_deaths, SUM(dea.new_deaths) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_new_deaths,
	vac.people_fully_vaccinated
FROM CovidDeaths AS dea
JOIN CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
ORDER BY 1, 2

-- Using Common Table Expression (CTE) to see the percentages
-- To see whether full vaccinations have an effect on death count

With VacvsDeaSEA (Location, Date, Population, New_Deaths, Rolling_New_Deaths, People_Fully_Vaccinated)
AS
(
SELECT dea.location, dea.date, dea.population,
	dea.new_deaths, SUM(dea.new_deaths) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_new_deaths,
	vac.people_fully_vaccinated
FROM CovidDeaths AS dea
JOIN CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
)
SELECT location, date, population,
		new_deaths, rolling_new_deaths, (rolling_new_deaths/population)*100 AS rolling_percentage_new_deaths,
		people_fully_vaccinated, (people_fully_vaccinated/population)*100 AS rolling_percentage_population_fully_vaccinated
FROM VacvsDeaSEA

-- Creating View using the previous query for data visualization

CREATE VIEW VaccinationsVsDeathsSEA AS
With VacvsDeaSEA (Location, Date, Population, New_Deaths, Rolling_New_Deaths, People_Fully_Vaccinated)
AS
(
SELECT dea.location, dea.date, dea.population,
	dea.new_deaths, SUM(dea.new_deaths) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_new_deaths,
	vac.people_fully_vaccinated
FROM CovidDeaths AS dea
JOIN CovidVaccinations AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.location IN ('Malaysia', 'Brunei', 'Myanmar', 'Cambodia', 'Indonesia', 'Laos', 'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Timor')
)
SELECT location, date, population,
		new_deaths, rolling_new_deaths, (rolling_new_deaths/population)*100 AS rolling_percentage_new_deaths,
		people_fully_vaccinated, (people_fully_vaccinated/population)*100 AS rolling_percentage_population_fully_vaccinated
FROM VacvsDeaSEA


