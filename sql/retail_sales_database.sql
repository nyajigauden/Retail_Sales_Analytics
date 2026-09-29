-- =========================================================
-- RETAIL SALES ANALYTICS PROJECT
-- PostgreSQL Database Setup, Data Loading and Analysis
-- =========================================================

-- Database:
-- retail_sales
--
-- CSV files:
-- E:/Retail_Sales_Analytics/data/customers.csv
-- E:/Retail_Sales_Analytics/data/products.csv
-- E:/Retail_Sales_Analytics/data/regions.csv
-- E:/Retail_Sales_Analytics/data/sales.csv


-- =========================================================
-- 1. CREATE TABLES
-- =========================================================

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS regions;


CREATE TABLE customers (
    "CustomerKey" INTEGER PRIMARY KEY,
    "CustomerName" VARCHAR(100),
    "Gender" VARCHAR(20),
    "Age" INTEGER
);


CREATE TABLE products (
    "ProductKey" INTEGER PRIMARY KEY,
    "ProductName" VARCHAR(100),
    "Category" VARCHAR(100),
    "UnitCost" NUMERIC(15,2),
    "UnitPrice" NUMERIC(15,2)
);


CREATE TABLE regions (
    "RegionKey" INTEGER PRIMARY KEY,
    "Region" VARCHAR(100),
    "Country" VARCHAR(100)
);


CREATE TABLE sales (
    "OrderID" INTEGER PRIMARY KEY,
    "Date" DATE,
    "CustomerKey" INTEGER,
    "ProductKey" INTEGER,
    "RegionKey" INTEGER,
    "Quantity" INTEGER,

    CONSTRAINT fk_customer
        FOREIGN KEY ("CustomerKey")
        REFERENCES customers("CustomerKey"),

    CONSTRAINT fk_product
        FOREIGN KEY ("ProductKey")
        REFERENCES products("ProductKey"),

    CONSTRAINT fk_region
        FOREIGN KEY ("RegionKey")
        REFERENCES regions("RegionKey")
);


-- =========================================================
-- 2. LOAD CSV DATA
-- =========================================================

COPY customers
FROM 'E:/Retail_Sales_Analytics/data/customers.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);


COPY products
FROM 'E:/Retail_Sales_Analytics/data/products.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);


COPY regions
FROM 'E:/Retail_Sales_Analytics/data/regions.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);


COPY sales
FROM 'E:/Retail_Sales_Analytics/data/sales.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);


-- =========================================================
-- 3. VERIFY DATA
-- =========================================================

SELECT COUNT(*) AS customers
FROM customers;

SELECT COUNT(*) AS products
FROM products;

SELECT COUNT(*) AS regions
FROM regions;

SELECT COUNT(*) AS sales
FROM sales;


-- =========================================================
-- 4. VIEW COMPLETE SALES DATA
-- =========================================================

SELECT
    s."OrderID",
    s."Date",
    c."CustomerName",
    p."ProductName",
    p."Category",
    r."Region",
    s."Quantity",
    p."UnitPrice"
FROM sales s
JOIN customers c
    ON s."CustomerKey" = c."CustomerKey"
JOIN products p
    ON s."ProductKey" = p."ProductKey"
JOIN regions r
    ON s."RegionKey" = r."RegionKey"
ORDER BY s."OrderID";


-- =========================================================
-- 5. TOTAL SALES
-- =========================================================

SELECT
    SUM(s."Quantity" * p."UnitPrice") AS total_sales
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey";


-- =========================================================
-- 6. TOTAL COST
-- =========================================================

SELECT
    SUM(s."Quantity" * p."UnitCost") AS total_cost
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey";


-- =========================================================
-- 7. TOTAL PROFIT
-- =========================================================

SELECT
    SUM(
        s."Quantity" *
        (p."UnitPrice" - p."UnitCost")
    ) AS total_profit
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey";


-- =========================================================
-- 8. PROFIT MARGIN
-- =========================================================

SELECT
    ROUND(
        SUM(
            s."Quantity" *
            (p."UnitPrice" - p."UnitCost")
        )
        /
        SUM(
            s."Quantity" * p."UnitPrice"
        ) * 100,
        2
    ) AS profit_margin
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey";


-- =========================================================
-- 9. SALES BY PRODUCT
-- =========================================================

SELECT
    p."ProductName",
    SUM(s."Quantity") AS total_quantity,
    SUM(s."Quantity" * p."UnitPrice") AS total_sales
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey"
GROUP BY p."ProductName"
ORDER BY total_sales DESC;


-- =========================================================
-- 10. SALES BY CATEGORY
-- =========================================================

SELECT
    p."Category",
    SUM(s."Quantity" * p."UnitPrice") AS total_sales
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey"
GROUP BY p."Category"
ORDER BY total_sales DESC;


-- =========================================================
-- 11. SALES BY REGION
-- =========================================================

SELECT
    r."Region",
    SUM(s."Quantity" * p."UnitPrice") AS total_sales
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey"
JOIN regions r
    ON s."RegionKey" = r."RegionKey"
GROUP BY r."Region"
ORDER BY total_sales DESC;


-- =========================================================
-- 12. MONTHLY SALES
-- =========================================================

SELECT
    DATE_TRUNC('month', s."Date") AS month,
    SUM(s."Quantity" * p."UnitPrice") AS total_sales
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey"
GROUP BY DATE_TRUNC('month', s."Date")
ORDER BY month;


-- =========================================================
-- 13. TOP CUSTOMERS
-- =========================================================

SELECT
    c."CustomerName",
    COUNT(s."OrderID") AS total_orders,
    SUM(s."Quantity" * p."UnitPrice") AS total_sales
FROM sales s
JOIN customers c
    ON s."CustomerKey" = c."CustomerKey"
JOIN products p
    ON s."ProductKey" = p."ProductKey"
GROUP BY c."CustomerName"
ORDER BY total_sales DESC;


-- =========================================================
-- 14. AVERAGE ORDER VALUE
-- =========================================================

SELECT
    ROUND(
        SUM(s."Quantity" * p."UnitPrice")
        / COUNT(DISTINCT s."OrderID"),
        2
    ) AS average_order_value
FROM sales s
JOIN products p
    ON s."ProductKey" = p."ProductKey";