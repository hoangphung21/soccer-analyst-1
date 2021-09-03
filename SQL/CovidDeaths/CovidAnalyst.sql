select * from PortfolioProjects.dbo.CovidDeaths
where continent is not null

-- Select data that we are going to use

select location, date, total_cases, new_cases, total_deaths,population
from PortfolioProjects.dbo.CovidDeaths
order by 1,2

-- Looking at total cases vs total deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases * 100) as 'Death ratio'
from PortfolioProjects.dbo.CovidDeaths
where location like '%Canada%'
order by 1,2


-- Looking at the total cases vs population
-- Show the percentage of people got covid

select location, date, total_cases, population, (total_cases/population * 100) as 'Covided ratio'
from PortfolioProjects.dbo.CovidDeaths
where location like '%Canada%'
and continent is not null
order by 1,2

-- Looking at countries with highest infection rate compared to population

select location, population, max(total_cases) as HighestIntectionCount, Max((total_cases/population * 100)) as 'Percentage of population infected'
from PortfolioProjects.dbo.CovidDeaths
group by location, population
order by 3 desc

-- Showing countries with the highest death count per population

select location, max(cast(total_deaths as int)) as totalDeathCount
from PortfolioProjects.dbo.CovidDeaths
where continent is not null -- Because the some continents showed up and I need to get rid of those
group by location
order by totalDeathCount desc

-- Showing continents with the highest death count per population
select continent as Continents, max(cast(total_deaths as int)) as totalDeathCount
from PortfolioProjects.dbo.CovidDeaths
where continent is not  null 
group by continent
order by totalDeathCount desc


-- Global numbers
select  sum(new_cases) as totalCases, sum(cast(new_deaths as int)) as totalDeath, sum(cast(new_deaths as int))/sum(new_cases) * 100 as DeathPercentage
from PortfolioProjects.dbo.CovidDeaths
where continent is not null
--group by date
order by 1,2

-- Looking at total population vs vaccination
-- USE CTE
with PopvsVac(Continent, Location, Date,Population,new_vaccinations, RollingPeopleVaccinated)
as(
select dea.continent,dea.location,  dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProjects.dbo.CovidDeaths as dea 
join PortfolioProjects.dbo.CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac

-- Using Temp Table to perform Calculation on Partition By in previous query
-- RollingPeopleVaccinated is the doses given

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(numeric,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProjects..CovidDeaths dea
Join PortfolioProjects..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3


-- Create view to store data for visualizations
Create view PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProjects.dbo.CovidDeaths dea
Join PortfolioProjects.dbo.CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3


select  dea.location, 
		max(dea.population) as population,
		max(CONVERT(numeric,vac.people_vaccinated))  as numberOfVaccinatedpeople
		
from PortfolioProjects..CovidVaccinations vac
join PortfolioProjects..CovidDeaths dea
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and vac.people_vaccinated is not null 
group by dea.location
order by numberOfVaccinatedpeople desc