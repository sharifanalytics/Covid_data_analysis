-- Data that we are going to be using

SELECT
	Location, date, total_cases, new_cases, total_deaths, population
FROM
	covid.coviddeath
ORDER BY 1,2	;

-- Looking at Total Cases vs Total Deaths

SELECT
	Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM
	covid.coviddeath
ORDER BY
	1.2;	
    
    
    
-- Population vs Total Cases

SELECT
	Location, date, total_cases, population, (total_cases/population)*100 AS DeathPercentage
FROM
	covid.coviddeath
WHERE
	Location like "%Bangladesh%";
    
 
-- Countries with highest infection rate 
SELECT
	Location, date, total_cases, population, MAX(total_cases) AS HighestInfection, MAX((total_cases/population))*100 AS InfectionPercentage
FROM covid.coviddeath
GROUP BY
	Location, date, total_cases, population
ORDER BY 
		InfectionPercentage DESC;	
        
 
 
-- Highest death count by country
SELECT
	Location, MAX(CAST(total_deaths AS UNSIGNED)) AS DeathCount
FROM covid.coviddeath
GROUP BY Location
ORDER BY DeathCount DESC   ;

-- Death percentage worldwide 
SELECT
	date, SUM(new_cases) AS total_case, SUM(new_deaths) AS total_death,  SUM(new_deaths) / SUM(new_cases)*100 AS Death_Percentage
FROM covid.coviddeath
GROUP BY date
;




-- total population vs vaccination

SELECT dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) AS Total_vaccination
FROM covid.coviddeath AS dea
INNER JOIN
 covid.covidvaccination AS vac
	ON
		dea.Location = vac.Location
        and dea.date = vac.date
   
GROUP BY 
	 dea.location, dea.date, dea.population, vac.new_vaccinations  ;
