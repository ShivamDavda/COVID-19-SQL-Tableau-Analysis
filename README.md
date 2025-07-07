# 🦠 COVID-19 Global Impact Analysis (SQL + Tableau)

This project explores the global impact of COVID-19 using structured SQL queries and visual storytelling through Tableau dashboards. It analyzes infections, death rates, vaccination trends, and population-level insights using real-world datasets.

---

## 📊 Tools & Technologies
- Microsoft SQL Server
- Tableau Public
- Window Functions, CTEs, Temp Tables, Views
- Real-world COVID-19 data

---

## 🔍 Key Business Questions Answered

- What percentage of a country's population was infected?
- What was the likelihood of death after contracting COVID-19?
- Which countries and continents had the highest impact?
- How effectively did each region roll out vaccinations?
- What percentage of population was vaccinated over time?

---

## 🧠 Analytical Techniques Used
- Joins across deaths and vaccination datasets
- Aggregations and filtering by country/continent
- CTEs for better readability and partition-based metrics
- Rolling sums using `SUM() OVER (PARTITION BY...)`
- Temp tables for storing intermediate calculations
- Views created for future Tableau use

---

## 📈 SQL Query Highlights

- Total Cases vs. Total Deaths → Infection Fatality Rate
- Total Cases vs. Population → Infection Penetration Rate
- Population vs. Vaccination → Vaccination Progress by Region
- Highest Infection & Death Counts by Country and Continent
- Creating SQL Views and Temp Tables for Tableau integration

---

## 📊 Tableau Dashboard

-https://public.tableau.com/views/DashboardforCovidGlobaldata/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

## 🧩 Dataset Source

- [COVID-19 Deaths & Vaccination Dataset](https://ourworldindata.org/covid-deaths) via Our World in Data

---

## 💼 Use Case

This project demonstrates an end-to-end data pipeline for a real-world public health scenario — from raw SQL analysis to visual dashboards. It can be applied to similar analytics in healthcare, policy-making, and trend forecasting.

---

## 🤝 Connect With Me

- 📧 [Email Me]Shivamdavda9494@gmail.com
- 💼 [LinkedIn]www.linkedin.com/in/shivamdavda

