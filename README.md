# Food Waste Intelligence: Africa

![Food Loss and Waste](https://github.com/francisosedata-tech/Food-loss-waste-intelligence-africa/blob/2e0492130dd720db8b75111db8f0870dae89b990/screenshots/banner.png)
## From Food Loss to Food Rescue

An end-to-end data analytics project exploring food loss, household food waste, and potential food-rescue opportunities across Africa.

The project combines publicly available food loss and food waste data with an illustrative synthetic food-rescue dataset to demonstrate how data analytics can support better understanding of food waste hotspots and potential intervention opportunities.

---

## Table of Contents
## 1. Project Overview
## 2. How to Navigate This Repository
## 3. Project Objectives
## 4. Data Sources
## 5. Business Questions
## 6. Tools & Technologies
## 7. Data Model
## 8. Key Analytical Considerations
## 9. Dashboard Pages
## 10. Key Insight
## 11. Limitations
## 12. Future Improvements
## 13. Why This Project Matters
## 14. Author
## 15. Acknowledgements & Disclaimer

---

## Project Overview

Food loss and waste is both an environmental and economic challenge.

This project asks:

> Where are the major food loss and household food waste patterns being reported across Africa, and how could data help identify opportunities for food rescue and waste reduction?

The analysis brings together three perspectives:

1. Household food waste
2. Food loss across the supply chain
3. Food rescue and surplus-food redistribution

The final output is an interactive Power BI dashboard supported by SQL, Python, data cleaning, data modeling, and dashboard wireframing.

---

## Project Objectives

The project aims to:

- Explore reported household food waste across African study locations.
- Examine food loss across different stages of the food supply chain.
- Identify commodities, activities, and causes associated with reported food loss.
- Explore geographic patterns in available food-loss and food-waste evidence.
- Demonstrate how food-rescue data could be used to understand surplus food.
- Estimate potential rescued meals, recovered revenue, and avoided CO2e using synthetic data.
- Demonstrate how analytics can transform food-waste data into actionable insights.

---

# Data Sources

## 1. UNEP Food Waste Index

The household food-waste analysis uses observations from the UNEP Food Waste Index Report 2024.

Source:

UNEP Food Waste Index Report 2024

https://www.unep.org/resources/publication/food-waste-index-report-2024

The dataset contains study-level observations from African locations.

Important:

These observations represent reported study locations and should not automatically be interpreted as nationally representative estimates.

---

## 2. FAO Food Loss and Waste Database

The supply-chain food-loss analysis uses data from the FAO Food Loss and Waste Database.

Source:

https://www.fao.org/platform-food-loss-waste/flw-data/en

The database contains food-loss and food-waste observations across countries, commodities, supply-chain stages, activities, and causes.

Important analytical consideration:

Loss percentages from different stages of a supply chain should not simply be added together because the quantity of food changes as it moves through the supply chain.

---

## 3. Synthetic Food-Rescue Dataset

The food-rescue component uses a synthetic dataset created specifically for this portfolio project.

It is designed to simulate food-surplus rescue operations across selected African countries.

The synthetic dataset includes:

- Businesses
- Business types
- Cities
- Countries
- Food categories
- Surplus food
- Meals available
- Meals rescued
- Meals expired
- Rescue rates
- Revenue recovered
- Estimated CO2e avoided
- Latitude and longitude

### Important

The food-rescue dataset is:

**SYNTHETIC / ILLUSTRATIVE DATA**

It is not actual operational data from Too Good To Go or any other food-rescue organization.

---

# Business Questions

## Dashboard 1 — Africa Food Waste

- Which African countries and study locations have the highest reported household food waste?
- How does reported household food waste vary across study locations?
- Where is food-waste evidence geographically available?
- How does the evidence vary by confidence level?
- What does the available evidence tell us about household food waste across Africa?

---

## Dashboard 2 — Food Loss Across the African Supply Chain

- Which supply-chain stages have the highest reported food-loss levels?
- Which commodities show higher reported losses?
- What causes of food loss are most frequently reported?
- Which countries have the highest reported loss observations?
- Where are the major food-loss hotspots by commodity and supply-chain stage?

---

## Dashboard 3 — From Food Waste to Food Rescue

- How much surplus food is potentially available for rescue?
- How many meals could potentially be rescued?
- Which cities show the highest rescue activity?
- Which business types generate the most surplus food?
- Which food categories contribute most to surplus?
- What proportion of available meals are rescued versus expired?
- What potential revenue could be recovered?
- What is the estimated CO2e impact of food rescue?

---

# Tools & Technologies

### Power BI
- Data modeling
- Power Query
- DAX
- Interactive dashboards
- Geographic visualization
- KPI cards
- Slicers
- Conditional formatting
- Data storytelling

### SQL
- Data exploration
- Filtering
- Aggregation
- Grouping
- Data quality checks
- Business analysis

### Python
- Data cleaning
- Exploratory data analysis
- Statistical analysis
- Visualization
- Data preparation

### Excel
- Data inspection
- Data preparation
- Quality checks

---

# Data Model

The Power BI model follows a structured analytical approach using fact and dimension tables.

Key components include:

- Food Loss Fact Table
- Household Food Waste Fact Table
- Food Rescue Fact Table
- Country Dimension
- Commodity Dimension
- Supply Chain Stage Dimension
- Method Dimension
- Date/Year Dimension

The model is designed to support filtering and analysis across geography, commodity, supply-chain stage, year, and other analytical dimensions.

---

# Key Analytical Considerations

## Reported data vs national estimates

The UNEP observations are study-level data points.

Therefore, the analysis avoids presenting individual study observations as definitive national food-waste estimates.

## Food-loss percentages

Food-loss percentages across supply-chain stages are not summed.

Instead, the analysis uses metrics such as:

- Average reported loss
- Median reported loss
- Maximum reported loss
- Number of observations
- Number of commodities
- Number of countries

## Cross-country revenue

The synthetic food-rescue dataset contains multiple currencies.

For cross-country comparisons, revenue is converted into an illustrative USD field.

Local-currency revenue should not be directly aggregated across countries.

---

# Dashboard Pages

### Page 1 — Africa Food Waste

![Food Loss and Waste](https://github.com/francisosedata-tech/Food-loss-waste-intelligence-africa/blob/a90d20352f05c0b4fd4ae96134ca1fa630251680/screenshots/Africa%20food%20waste.png)

Focus:

**UNEP household food-waste evidence across Africa**

Key elements:

- KPI cards
- Country comparison
- Geographic distribution
- Evidence confidence
- Study-year distribution

---

### Page 2 — Africa Food Loss

![Africa Food Loss](https://github.com/francisosedata-tech/Food-loss-waste-intelligence-africa/blob/c1d03518f755c86b2c86058fc2aa75c785561cef/screenshots/Africa%20food%20loss.png)

Focus:

**Food loss across the African supply chain**

Key elements:

- Supply-chain stages
- Commodities
- Causes of loss
- Countries
- Food-loss hotspots

---

### Page 3 — Food Rescue

![Food Rescue](https://github.com/francisosedata-tech/Food-loss-waste-intelligence-africa/blob/e2e8910f3db93dec52f5db5f8bc2646e5537d5d6/screenshots/Food%20rescue.png)

Focus:

**Turning surplus food into potential rescue opportunities**

Key elements:

- Surplus food
- Meals available
- Meals rescued
- Rescue rate
- Revenue recovered
- Estimated CO2e avoided
- Geographic rescue opportunities

---

# Key Insight

The project demonstrates how combining food-loss and food-waste evidence with operational-style rescue data can help move the conversation from:

> "How much food is being wasted?"

towards:

> "Where is the problem, what is driving it, and where could intervention create measurable impact?"

---

# Limitations

This project has several limitations:

- UNEP observations are study-level and vary in methodology and geographic coverage.
- Not every African country has equivalent household food-waste evidence.
- FAO food-loss observations come from different studies and methodologies.
- Synthetic food-rescue data does not represent actual company operations.
- CO2e values in the synthetic dataset are illustrative estimates.
- Revenue recovery values in the synthetic dataset are illustrative.
- Geographic coordinates used for study locations may represent approximate locations rather than household-level coordinates.

---

# Future Improvements

Potential future developments include:

- Incorporating additional national food-waste datasets.
- Adding more African countries and cities.
- Integrating real food-rescue operational data.
- Building predictive models for surplus-food generation.
- Developing food-rescue demand forecasting.
- Identifying optimal locations for food-rescue hubs.
- Estimating potential social impact from rescued meals.
- Building an automated data pipeline.
- Deploying the dashboard as a web-based analytics application.

---

# Why This Project Matters

Food waste is not only a waste-management problem.

It intersects with:

- Food security
- Climate change
- Resource efficiency
- Supply-chain management
- Business profitability
- Circular economy
- Sustainable development

Data analytics can help make these problems more visible, measurable, and actionable.

---

# Author

**Francis Blessing Osewayeme**

Data Analyst | Power BI | SQL | Python | Excel

Interested in using data analytics to solve real-world problems across sustainability, business, and social impact.

---

# Acknowledgements & Data Sources

UNEP — Food Waste Index

https://www.unep.org/resources/publication/food-waste-index-report-2024

FAO — Food Loss and Waste Database

https://www.fao.org/platform-food-loss-waste/flw-data/en

Too Good To Go — Food Rescue / Surplus Food Inspiration

https://www.toogoodtogo.com/

---

## Disclaimer

This is an independent portfolio project.

The project is not affiliated with, sponsored by, or endorsed by UNEP, FAO, or Too Good To Go.

The food-rescue operational dataset is synthetic and was created solely for analytical and educational purposes.
