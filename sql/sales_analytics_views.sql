/*
Project: Sales Analytics Dashboard
Database: SalesAnalytics
Purpose: Reproducible analytical views and KPI validation queries.

Prerequisites:
- Run in SQL Server after importing the source tables.
- Expected working tables: dbo.Orders, dbo.Returns, dbo.people.
- Column names reflect the imported dataset and may contain spaces.
*/

USE SalesAnalytics;
GO

/* 1. Executive KPIs */
CREATE OR ALTER VIEW dbo.vw_ExecutiveKPIs
AS
SELECT
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    COUNT(DISTINCT [Order ID]) AS TotalOrders,
    COUNT(DISTINCT [Customer ID]) AS TotalCustomers,
    CAST(
        SUM([Profit]) * 100.0 / NULLIF(SUM([Sales]), 0)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPct
FROM dbo.Orders;
GO

/* 2. Regional performance */
CREATE OR ALTER VIEW dbo.vw_RegionalPerformance
AS
SELECT
    [Region],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    COUNT(DISTINCT [Order ID]) AS TotalOrders,
    CAST(
        SUM([Profit]) * 100.0 / NULLIF(SUM([Sales]), 0)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPct
FROM dbo.Orders
GROUP BY [Region];
GO

/* 3. Category performance */
CREATE OR ALTER VIEW dbo.vw_CategoryPerformance
AS
SELECT
    [Category],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    SUM([Quantity]) AS UnitsSold,
    COUNT(DISTINCT [Order ID]) AS TotalOrders
FROM dbo.Orders
GROUP BY [Category];
GO

/* 4. Monthly sales and profit */
CREATE OR ALTER VIEW dbo.vw_MonthlySales
AS
SELECT
    YEAR([Order Date]) AS SalesYear,
    MONTH([Order Date]) AS SalesMonth,
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit
FROM dbo.Orders
GROUP BY
    YEAR([Order Date]),
    MONTH([Order Date]);
GO

/* 5. Customer performance */
CREATE OR ALTER VIEW dbo.vw_CustomerPerformance
AS
SELECT
    [Customer ID],
    [Customer Name],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    COUNT(DISTINCT [Order ID]) AS TotalOrders
FROM dbo.Orders
GROUP BY
    [Customer ID],
    [Customer Name];
GO

/* 6. Product profitability */
CREATE OR ALTER VIEW dbo.vw_ProductProfitability
AS
SELECT
    [Product ID],
    [Product Name],
    [Category],
    [Sub-Category],
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    SUM([Quantity]) AS UnitsSold
FROM dbo.Orders
GROUP BY
    [Product ID],
    [Product Name],
    [Category],
    [Sub-Category];
GO

/* 7. Return analysis */
CREATE OR ALTER VIEW dbo.vw_ReturnAnalysis
AS
SELECT
    COUNT(DISTINCT r.[Order ID]) AS ReturnedOrders,
    COUNT(DISTINCT o.[Order ID]) AS TotalOrders,
    CAST(
        COUNT(DISTINCT r.[Order ID]) * 100.0 /
        NULLIF(COUNT(DISTINCT o.[Order ID]), 0)
        AS DECIMAL(10,2)
    ) AS ReturnRatePct
FROM dbo.Orders AS o
LEFT JOIN dbo.Returns AS r
    ON o.[Order ID] = r.[Order ID];
GO

/* Validation queries: run after creating the views. */

/* Overall KPIs */
SELECT
    SUM([Sales]) AS TotalSales,
    SUM([Profit]) AS TotalProfit,
    COUNT(DISTINCT [Order ID]) AS TotalOrders,
    COUNT(DISTINCT [Customer ID]) AS TotalCustomers,
    CAST(
        SUM([Profit]) * 100.0 / NULLIF(SUM([Sales]), 0)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPct
FROM dbo.Orders;
GO

/* KPI view */
SELECT * FROM dbo.vw_ExecutiveKPIs;
GO

/* Regional performance */
SELECT *
FROM dbo.vw_RegionalPerformance
ORDER BY TotalSales DESC;
GO

/* Category performance */
SELECT *
FROM dbo.vw_CategoryPerformance
ORDER BY TotalSales DESC;
GO

/* Monthly trend */
SELECT *
FROM dbo.vw_MonthlySales
ORDER BY SalesYear, SalesMonth;
GO

/* Top 10 customers by sales */
SELECT TOP (10) *
FROM dbo.vw_CustomerPerformance
ORDER BY TotalSales DESC;
GO

/* 10 lowest-profit products */
SELECT TOP (10) *
FROM dbo.vw_ProductProfitability
ORDER BY TotalProfit ASC;
GO

/* Return-rate view */
SELECT * FROM dbo.vw_ReturnAnalysis;
GO
