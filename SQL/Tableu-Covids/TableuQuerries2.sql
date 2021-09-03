/*
Tableu Querries for 2nd Dashboard
*/

--1. Compare doses given
select dea.continent, dea.location,dea.date,dea.population,
max(cast(vac.total_vaccinations as bigint)) as DosesGiven 
from PortfolioProjects..CovidDeaths dea
join PortfolioProjects..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
group by dea.continent,dea.location,dea.date,dea.population
order by 1,2,3

--2. Compare Total Cases and Deaths through the time
Select Location, date, population, total_cases, total_deaths
From PortfolioProjects..CovidDeaths
where continent is not null 
order by 1,2

--3 Vaccinated Rates
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProjects..CovidDeaths dea
Join PortfolioProjects..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100 as PercentPeopleVaccinated
From PopvsVac
order by RollingPeopleVaccinated desc