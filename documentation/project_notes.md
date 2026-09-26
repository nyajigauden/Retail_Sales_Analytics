# Retail Sales Analytics Dashboard — Project Documentation

## 1. Project Overview

The Retail Sales Analytics Dashboard is a data analytics project designed to analyze retail sales performance using customer, product, regional, and sales transaction data.

The project demonstrates a complete data analytics workflow, starting from raw CSV files and progressing through database storage, SQL analysis, Python data analysis, and interactive Power BI visualization.

The main purpose of the project is to transform raw sales data into useful business insights that can support decision-making related to revenue, profitability, products, customers, and regional performance.

---

## 2. Project Objectives

The main objectives of this project are to:

* Analyze retail sales performance.
* Calculate total sales, costs, and profit.
* Identify high-performing products.
* Compare sales performance across regions.
* Analyze customer information.
* Analyze monthly sales trends.
* Practice relational database design.
* Perform SQL analysis using PostgreSQL, MySQL, and SQL Server.
* Use Python for data cleaning, analysis, and visualization.
* Build an interactive Power BI dashboard.
* Develop a complete data analytics portfolio project.

---

## 3. Business Problem

A retail business generates a large amount of transaction data. However, raw transaction data alone does not provide an easy way to understand business performance.

Management may need answers to questions such as:

* How much revenue was generated?
* How much profit was generated?
* Which products generate the most sales?
* Which regions generate the most revenue?
* How many orders were completed?
* How many customers made purchases?
* How are sales changing over time?
* Which product categories perform best?

This project addresses these questions by transforming raw transaction data into structured information and interactive visualizations.

---

## 4. Dataset Description

The project uses four CSV datasets.

### 4.1 Customers

File:

`data/customers.csv`

The customer dataset contains information about customers.

| Column       | Description                |
| ------------ | -------------------------- |
| CustomerKey  | Unique customer identifier |
| CustomerName | Customer name              |
| Gender       | Customer gender            |
| Age          | Customer age               |

---

### 4.2 Products

File:

`data/products.csv`

The product dataset contains product information and pricing.

| Column      | Description                  |
| ----------- | ---------------------------- |
| ProductKey  | Unique product identifier    |
| ProductName | Product name                 |
| Category    | Product category             |
| UnitCost    | Cost of one product          |
| UnitPrice   | Selling price of one product |

---

### 4.3 Regions

File:

`data/regions.csv`

The region dataset contains geographical information.

| Column    | Description              |
| --------- | ------------------------ |
| RegionKey | Unique region identifier |
| Region    | Region name              |
| Country   | Country                  |

---

### 4.4 Sales

File:

`data/sales.csv`

The sales dataset contains individual sales transactions.

| Column      | Description             |
| ----------- | ----------------------- |
| OrderID     | Unique order identifier |
| Date        | Transaction date        |
| CustomerKey | Customer identifier     |
| ProductKey  | Product identifier      |
| RegionKey   | Region identifier       |
| Quantity    | Quantity purchased      |

---

## 5. Database Design

The project uses a relational database structure.

The main tables are:

### Customers

```text
CustomerKey PK
CustomerName
Gender
Age
```

### Products

```text
ProductKey PK
ProductName
Category
UnitCost
UnitPrice
```

### Regions

```text
RegionKey PK
Region
Country
```

### Sales

```text
OrderID PK
Date
CustomerKey FK
ProductKey FK
RegionKey FK
Quantity
```

The sales table connects the other tables using foreign keys.

### Relationships

```text
Customers 1 ─────── * Sales
Products  1 ─────── * Sales
Regions   1 ─────── * Sales
```

This structure reduces duplication and allows sales transactions to be analyzed by customer, product, and region.

---

## 6. Data Processing

The raw CSV files were imported into the analytics environment and checked for:

* Correct column names
* Appropriate data types
* Missing values
* Duplicate records
* Valid keys
* Correct dates
* Correct numerical values

The sales data was then combined with product, customer, and regional information.

For example, sales revenue was calculated using:

```text
Sales Amount = Quantity × Unit Price
```

Total cost was calculated using:

```text
Total Cost = Quantity × Unit Cost
```

Profit was calculated using:

```text
Profit = Sales Amount − Total Cost
```

Profit margin was calculated using:

```text
Profit Margin = Profit ÷ Sales Amount × 100
```

---

## 7. SQL Database Analysis

The project is designed to perform SQL analysis using:

* PostgreSQL with pgAdmin 4
* MySQL
* Microsoft SQL Server

The same retail dataset can be loaded into each database system and analyzed using SQL queries.

Example business questions include:

* Total sales by product
* Total sales by region
* Sales by category
* Total quantity sold
* Monthly sales
* Total profit
* Average order value
* Top-performing products

Example SQL analysis:

```sql
SELECT
    p."ProductName",
    SUM(s."Quantity" * p."UnitPrice") AS total_sales
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey"
GROUP BY p."ProductName"
ORDER BY total_sales DESC;
```

This query joins the sales and products tables and calculates total sales for each product.

---

## 8. Python Analysis

Python was used for data loading, transformation, calculations, analysis, and visualization.

Main Python libraries used include:

* Pandas
* NumPy
* Matplotlib

The datasets were loaded using Pandas.

The four datasets were then merged to create a combined analytical dataset.

The project calculates:

* Sales Amount
* Total Cost
* Profit
* Profit Margin
* Sales by Region
* Sales by Product
* Sales by Category
* Monthly Sales
* Average Order Value

### Overall Results

The current analysis produced:

| Metric        |         Result |
| ------------- | -------------: |
| Total Sales   | 35,340,000 TZS |
| Total Cost    | 25,040,000 TZS |
| Total Profit  | 10,300,000 TZS |
| Profit Margin |         29.15% |

---

## 9. Sales by Region

The analysis produced the following sales values:

| Region        |          Sales |
| ------------- | -------------: |
| Dar es Salaam | 13,900,000 TZS |
| Arusha        | 10,050,000 TZS |
| Dodoma        |  6,450,000 TZS |
| Mwanza        |  4,940,000 TZS |

These results allow regional sales performance to be compared.

---

## 10. Sales by Product

The product analysis produced:

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

These figures can be used to understand the contribution of individual products to total sales.

---

## 11. Sales by Category

The category analysis produced:

| Category         |          Sales |
| ---------------- | -------------: |
| Electronics      | 26,350,000 TZS |
| Furniture        |  3,500,000 TZS |
| Office Equipment |  2,750,000 TZS |
| Accessories      |  2,740,000 TZS |

---

## 12. Power BI Dashboard

Power BI was used to create an interactive sales analytics dashboard.

The Power BI model contains:

```text
DimCustomer
      |
      |
      v
  FactSales
      ^
      |
DimProduct

DimRegion
      |
      v
  FactSales

DimDate
      |
      v
  FactSales
```

The model follows a dimensional/star-schema approach.

### Main Dashboard Components

The Executive Dashboard contains:

* Total Sales
* Total Profit
* Total Orders
* Total Customers
* Average Order Value
* Monthly Sales Trend
* Sales by Region
* Sales by Product
* Region slicer
* Category slicer
* Product slicer
* Year slicer

---

## 13. Power BI Measures

Important DAX measures include:

```DAX
Total Sales =
SUM(FactSales[SalesAmount])
```

```DAX
Total Quantity =
SUM(FactSales[Quantity])
```

```DAX
Total Orders =
DISTINCTCOUNT(FactSales[OrderID])
```

```DAX
Total Customers =
DISTINCTCOUNT(FactSales[CustomerKey])
```

```DAX
Average Order Value =
DIVIDE(
    [Total Sales],
    [Total Orders]
)
```

```DAX
Total Cost =
SUMX(
    FactSales,
    FactSales[Quantity] *
    RELATED(DimProduct[UnitCost])
)
```

```DAX
Total Profit =
[Total Sales] - [Total Cost]
```

```DAX
Profit Margin % =
DIVIDE(
    [Total Profit],
    [Total Sales]
)
```

---

## 14. Project Workflow

The complete project workflow is:

```text
Raw CSV Data
     ↓
Data Cleaning
     ↓
Relational Database
     ↓
PostgreSQL / MySQL / SQL Server
     ↓
SQL Queries
     ↓
Python
     ↓
Pandas / NumPy / Matplotlib
     ↓
Power BI
     ↓
Power Query
     ↓
Data Model
     ↓
DAX Measures
     ↓
Interactive Dashboard
     ↓
Business Insights
     ↓
GitHub Portfolio
```

---

## 15. Tools and Technologies

### Programming and Analysis

* Python
* Pandas
* NumPy
* Matplotlib

### Databases

* PostgreSQL
* pgAdmin 4
* MySQL
* Microsoft SQL Server

### Business Intelligence

* Microsoft Power BI
* Power Query
* DAX

### Development Tools

* Visual Studio Code
* Git
* GitHub

### Data Format

* CSV

---

## 16. Project Structure

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
├── powerbi/
│   └── Retail_Sales_Analytics.pbix
│
├── python/
│   └── analysis.py
│
├── documentation/
│   └── project_notes.md
│
├── README.md
│
└── .gitignore
```

---

## 17. Challenges and Solutions

### Challenge 1: Combining multiple datasets

The sales dataset contained keys rather than descriptive information.

**Solution:**

The sales data was joined with the customer, product, and region datasets using their corresponding keys.

---

### Challenge 2: Calculating sales and profit

The raw sales data did not contain a direct sales amount or profit column.

**Solution:**

Calculated columns were created using quantity, unit price, and unit cost.

---

### Challenge 3: File path errors in Python

The Python script initially produced a `FileNotFoundError` when reading the CSV files.

**Solution:**

The project was changed to use Python's `pathlib` so that the script could reliably locate the project root and data directory regardless of the current working directory.

---

### Challenge 4: Building an analytical Power BI model

The raw CSV files needed to be organized into a useful analytical model.

**Solution:**

Dimension tables and a fact table were created in Power BI, followed by relationships and DAX measures.

---

## 18. Future Improvements

Future versions of the project may include:

* Customer segmentation
* Monthly and yearly growth analysis
* Sales forecasting
* Customer lifetime value analysis
* Inventory analysis
* More advanced Power BI DAX calculations
* Machine learning models
* Automated database loading
* Automated data refresh
* Deployment of the dashboard
* Interactive web-based reporting
* Additional business KPIs

---

## 19. Learning Outcomes

Through this project, I developed practical experience in:

* Data cleaning
* Data transformation
* Relational database design
* SQL querying
* PostgreSQL and pgAdmin 4
* MySQL
* SQL Server
* Python data analysis
* Pandas
* NumPy
* Matplotlib
* Power Query
* Power BI data modeling
* DAX
* Data visualization
* Git and GitHub
* Business-oriented data analysis

The project also demonstrates how different technologies can work together in a complete data analytics workflow.

---

## 20. Author

**Gaudencia Joel Nyaji**

Bachelor of Engineering in Computer Science and Engineering (B.E.CSE)

St. Joseph University in Tanzania

Dar es Salaam, Tanzania

GitHub: `nyajigauden`


