select *
from Portfolio1..CovidDeaths$
order by 3,4

-- Select Data that we are going to be starting with

select Location, date, total_cases, new_cases, total_deaths, population
from Portfolio1..CovidDeaths$
where continent is not null
order by 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from Portfolio1..CovidDeaths$
where location  like '%States%'
and continent is not null
order by 1,2

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

select Location, date, total_cases, population , (total_cases/population)*100 as Infacted
from Portfolio1..CovidDeaths$
order by 1,2

-- Countries with Highest Infection Rate compared to Population

select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected 
from Portfolio1..CovidDeaths$
where continent is not null
group by location, population
order by PercentPopulationInfected desc

-- Countries with Highest Death Count per Population

select location , max (cast (total_deaths as int)) as TotalDeathCount
from Portfolio1..CovidDeaths$
where continent is not null
group by location
order by TotalDeathCount desc

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

select continent,population, max(cast(total_deaths as int)) as highestdeath
from Portfolio1..CovidDeaths$
where continent is not null
group by continent,population
order by highestdeath desc

-- GLOBAL NUMBERS

select sum(cast(new_cases as int))as total_cases, sum(cast(new_deaths as int))as total_deaths, (sum(cast(total_deaths as int))/sum(total_cases))*100 as Deathpercentage
from Portfolio1..CovidDeaths$
where continent is not null
order by 1,2

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(CONVERT(int, vac.new_vaccinations)) over(Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from Portfolio1..CovidDeaths$ as dea
join Portfolio1..CovidVaccinations$ as vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
order by 2,3

-- Using CTE to perform Calculation on Partition By in previous query

with PopulationvsVaccinations (continent, location,date, population,new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations, 
sum(CONVERT(int,vac.new_vaccinations)) over (Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from Portfolio1..CovidDeaths$ as dea
join Portfolio1..CovidVaccinations$ as vac
on dea.location= vac.location and dea.date= vac.date
where dea.continent is not null
)
select *, (RollingPeopleVaccinated/ population)*100 as Percentageofpeoplevaccinated
from PopulationvsVaccinations


-- Using Temp Table to perform Calculation on Partition By in previous query

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
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Portfolio1..CovidDeaths$ dea
Join Portfolio1..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations
DROP VIEW IF EXISTS PercentPopulationVaccinated;
GO
Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Portfolio1..CovidDeaths$ dea
Join Portfolio1..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

SELECT name, type_desc
FROM sys.objects
WHERE name = 'PercentPopulationVaccinated';













