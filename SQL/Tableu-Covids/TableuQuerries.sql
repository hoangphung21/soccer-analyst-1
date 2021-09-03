/*
	Tableu Querries
*/

--1. Total cases around the world

select sum(new_cases) as totalCases, sum(cast(new_deaths as int)) as totalDeaths, sum(cast(new_deaths as int))/sum(new_cases ) * 100 as DeathPercentage
from PortfolioProjects..CovidDeaths
where continent is not null


--2. Total deaths around the world based on continents

select location, sum(cast(new_deaths as int)) as TotalDeathCount
from PortfolioProjects..CovidDeaths
where continent is  null
and location not in ('World','European Union','International') -- avoid repeated location
group by location
order by TotalDeathCount desc


--3 Comparing infection rates 
select location, population , Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProjects..CovidDeaths
where continent is not null
and location not in ('World','European Union','International') -- avoid repeated location
group by location, population
order by PercentPopulationInfected desc

--4 Comparing infection rates by time
select location, population,date , Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProjects..CovidDeaths
where continent is not null
and location not in ('World','European Union','International') -- avoid repeated location
group by location, population,date
order by PercentPopulationInfected desc

--5. Total deaths around the world 

select location, sum(cast(new_deaths as int)) as TotalDeathCount
from PortfolioProjects..CovidDeaths
where continent is not  null
and location not in ('World','European Union','International') -- avoid repeated location
group by location
order by TotalDeathCount desc