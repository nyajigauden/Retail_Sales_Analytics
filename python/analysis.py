import pandas as pd
from sqlalchemy import create_engine

engine = create_engine(
    "postgresql+psycopg2://postgres:Gauden%3F1450@localhost:5432/retail_sales"
)

df = pd.read_sql("SELECT * FROM sales", engine)

print(df.head())
print("\nNumber of rows:", len(df))

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

# Get the main project folder
BASE_DIR = Path(__file__).resolve().parent.parent

# Load the CSV files
customers = pd.read_csv(BASE_DIR / "data" / "customers.csv")
products = pd.read_csv(BASE_DIR / "data" / "products.csv")
regions = pd.read_csv(BASE_DIR / "data" / "regions.csv")
sales = pd.read_csv(BASE_DIR / "data" / "sales.csv")

print("Customers:")
print(customers.head())

print("\nProducts:")
print(products.head())

print("\nRegions:")
print(regions.head())

print("\nSales:")
print(sales.head())



sales_analysis = sales.merge(
    products,
    on="ProductKey",
    how="left"
)

print("\nAfter merging Products:")
print(sales_analysis.head())

sales_analysis = sales_analysis.merge(
    regions,
    on="RegionKey",
    how="left"
)

print("\nAfter merging Regions:")
print(sales_analysis.head())

sales_analysis = sales_analysis.merge(
    customers,
    on="CustomerKey",
    how="left"
)

print("\nAfter merging Customers:")
print(sales_analysis.head())

# Calculate Sales Amount
sales_analysis["SalesAmount"] = (
    sales_analysis["Quantity"] *
    sales_analysis["UnitPrice"]
)

print("\nSales Amount:")
print(
    sales_analysis[
        ["OrderID", "ProductName", "Quantity", "UnitPrice", "SalesAmount"]
    ].head()
)

# Calculate Total Cost
sales_analysis["TotalCost"] = (
    sales_analysis["Quantity"] *
    sales_analysis["UnitCost"]
)

print("\nTotal Cost:")
print(
    sales_analysis[
        ["OrderID", "ProductName", "Quantity", "UnitCost", "TotalCost"]
    ].head()
)


# Calculate Profit
sales_analysis["Profit"] = (
    sales_analysis["SalesAmount"] -
    sales_analysis["TotalCost"]
)

print("\nProfit:")
print(
    sales_analysis[
        ["OrderID", "ProductName", "SalesAmount", "TotalCost", "Profit"]
    ].head()
)

# Overall business metrics
total_sales = sales_analysis["SalesAmount"].sum()
total_cost = sales_analysis["TotalCost"].sum()
total_profit = sales_analysis["Profit"].sum()

print("\n==============================")
print("OVERALL BUSINESS METRICS")
print("==============================")

print(f"Total Sales:  {total_sales:,.0f}")
print(f"Total Cost:   {total_cost:,.0f}")
print(f"Total Profit: {total_profit:,.0f}")

# Calculate Profit Margin
profit_margin = (total_profit / total_sales) * 100

print(f"Profit Margin: {profit_margin:.2f}%")

# Sales by Region
sales_by_region = (
    sales_analysis
    .groupby("Region")["SalesAmount"]
    .sum()
    .sort_values(ascending=False)
)

print("\n==============================")
print("SALES BY REGION")
print("==============================")
print(sales_by_region)

# Sales by Product
sales_by_product = (
    sales_analysis
    .groupby("ProductName")["SalesAmount"]
    .sum()
    .sort_values(ascending=False)
)

print("\n==============================")
print("SALES BY PRODUCT")
print("==============================")
print(sales_by_product)

# Sales by Category
sales_by_category = (
    sales_analysis
    .groupby("Category")["SalesAmount"]
    .sum()
    .sort_values(ascending=False)
)

print("\n==============================")
print("SALES BY CATEGORY")
print("==============================")
print(sales_by_category)

# Convert Date column to datetime
sales_analysis["Date"] = pd.to_datetime(
    sales_analysis["Date"]
)

print("\nDate Data Type:")
print(sales_analysis["Date"].dtype)


# Monthly Sales
monthly_sales = (
    sales_analysis
    .groupby(
        sales_analysis["Date"].dt.to_period("M")
    )["SalesAmount"]
    .sum()
)

print("\n==============================")
print("MONTHLY SALES")
print("==============================")
print(monthly_sales)

# Monthly Sales Chart
plt.figure(figsize=(10, 5))

monthly_sales.plot(
    kind="line",
    marker="o"
)

plt.title("Monthly Sales Trend")
plt.xlabel("Month")
plt.ylabel("Sales Amount (TZS)")
plt.xticks(rotation=45)
plt.tight_layout()

plt.show()

average_order_value = (
    sales_analysis["SalesAmount"].sum()
    / sales_analysis["OrderID"].nunique()
)

print(f"\nAverage Order Value: {average_order_value:,.2f} TZS")