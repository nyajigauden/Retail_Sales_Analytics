# Retail Sales Analytics Dashboard

## Project Overview

This project analyzes retail sales data using SQL, Python, Pandas, Power BI, Power Query, and DAX.

The project demonstrates an end-to-end data analytics workflow, starting from raw sales data and progressing through data transformation, database analysis, Python analysis, and interactive business intelligence dashboards.

## Project Objectives

* Analyze total sales and revenue
* Calculate total cost and profit
* Calculate profit margin
* Analyze sales by region
* Analyze sales by product
* Analyze sales by category
* Analyze monthly sales trends
* Build an interactive Power BI dashboard
* Practice SQL database analysis
* Use Python for data analysis and visualization

## Technologies Used

* Python
* Pandas
* NumPy
* Matplotlib
* SQL
* PostgreSQL
* pgAdmin 4
* MySQL
* SQL Server
* Power BI
* Power Query
* DAX
* Git
* GitHub

## Dataset

The project uses four main datasets:

* Customers
* Products
* Regions
* Sales

The sales dataset contains transaction information including order date, customer, product, region, and quantity.

## Data Model

The project uses a relational/star-schema structure:

```text
DimCustomer ─────┐
                 │
DimProduct ──────┼── FactSales
                 │
DimRegion ───────┘

DimDate ───────────── FactSales
```

### Main Tables

**Customers**

* CustomerKey
* CustomerName
* Gender
* Age

**Products**

* ProductKey
* ProductName
* Category
* UnitCost
* UnitPrice

**Regions**

* RegionKey
* Region
* Country

**Sales**

* OrderID
* Date
* CustomerKey
* ProductKey
* RegionKey
* Quantity

## Python Analysis

Python was used to:

* Load CSV datasets
* Merge datasets using Pandas
* Calculate sales amount
* Calculate total cost
* Calculate profit
* Calculate profit margin
* Analyze sales by region
* Analyze sales by product
* Analyze sales by category
* Analyze monthly sales
* Create data visualizations using Matplotlib

## Current Analysis Results

Based on the current dataset:

| Metric        |          Value |
| ------------- | -------------: |
| Total Sales   | 35,340,000 TZS |
| Total Cost    | 25,040,000 TZS |
| Total Profit  | 10,300,000 TZS |
| Profit Margin |         29.15% |

### Sales by Region

| Region        |          Sales |
| ------------- | -------------: |
| Dar es Salaam | 13,900,000 TZS |
| Arusha        | 10,050,000 TZS |
| Dodoma        |  6,450,000 TZS |
| Mwanza        |  4,940,000 TZS |

### Sales by Product

| Product      |          Sales |
| ------------ | -------------: |
| Laptop       | 10,800,000 TZS |
| Smartphone   |  8,500,000 TZS |
| Tablet       |  3,900,000 TZS |
| Office Chair |  3,500,000 TZS |
| Monitor      |  3,150,000 TZS |
| Printer      |  2,750,000 TZS |
| Keyboard     |  1,840,000 TZS |
| Mouse        |    900,000 TZS |

## Power BI Dashboard

The Power BI dashboard includes:

* Total Sales KPI
* Total Profit KPI
* Total Orders KPI
* Total Customers KPI
* Monthly Sales Trend
* Sales by Region
* Sales by Product
* Interactive slicers
* Product drill-through
* DAX measures
* Star-schema data model

## SQL Database Analysis

The project will also include database implementations using:

* PostgreSQL
* MySQL
* SQL Server

SQL analysis will include:

* SELECT queries
* Filtering
* Sorting
* GROUP BY
* Aggregations
* JOINs
* CASE statements
* Subqueries
* CTEs
* Window functions

## Project Structure

```text
Retail_Sales_Analytics/
│
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── regions.csv
│   └── sales.csv
│
├── sql/
│   ├── postgresql/
│   ├── mysql/
│   └── sql_server/
│
├── python/
│   └── analysis.py
│
├── powerbi/
│   └── Retail_Sales_Analytics.pbix
│
├── documentation/
│   └── project_notes.md
│
└── README.md
```

## Learning Outcomes

Through this project, I am developing practical skills in:

* Data cleaning
* Data transformation
* Relational database design
* SQL querying
* Data analysis
* Data visualization
* Power BI
* DAX
* Python
* Pandas
* Git and GitHub

## Author

**Gaudencia Joel Nyaji**

B.E.CSE — Bachelor of Engineering in Computer Science and Engineering

St. Joseph University in Tanzania
