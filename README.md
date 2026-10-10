# Sales Analytics Dashboard

An end-to-end sales analytics portfolio project built with **SQL Server, Power BI, and DAX**. The project explores sales, profitability, customers, products, regions, categories, and returns through SQL analysis and interactive Power BI reports.

## Dashboard preview

### Executive Dashboard

![Executive Dashboard](screenshots/Screenshot%202026-10-10%20132525.png)

### Detailed Analysis

![Detailed Analysis](screenshots/Screenshot%202026-10-10%20132536.png)

The Power BI report contains two pages:

- **Executive Dashboard** — KPI cards, monthly sales and profit trend, sales by region and category, top customers, loss-making products, and Region/Category/Segment slicers.
- **Detailed Analysis** — sales and profit by sub-category, customer and product analysis, return-rate KPI, and regional manager information.

## Technology stack

- **SQL Server** — data storage, aggregation, analytical queries, and views
- **Power BI Desktop** — data model, report visuals, and interactive filtering
- **DAX** — KPI measures and business metrics

## Key metrics

The report was validated against SQL results. Overall metrics include:

| Metric | Result |
|---|---:|
| Total Sales | 2,326,534.44 |
| Total Profit | 292,295.93 |
| Total Orders | 5,111 |
| Total Customers | 804 |
| Profit Margin | 12.56% |
| Return Rate | 5.79% |

Values may display in abbreviated form (for example, 2.33M) in the dashboard.

## Data model and analysis

The SQL Server database is named `SalesAnalytics` and includes the working tables `Orders`, `Returns`, and `people`. Analytical views created for the project cover:

- Executive KPIs
- Regional performance
- Category performance
- Monthly sales
- Customer performance
- Product profitability
- Return analysis

The Power BI model relates order data to returns by Order ID and regional manager information by Region.

## Repository contents

- `powerbi/` — Power BI report (`.pbix`)
- `screenshots/` — dashboard screenshots
- `sql/sales_analytics_views.sql` — analytical views and KPI validation queries

## How to view

1. Download the `.pbix` file from the `powerbi` folder.
2. Open it with Power BI Desktop.
3. The report was developed against a local SQL Server database named `SalesAnalytics`. To refresh data on another machine, configure the SQL Server connection and ensure the required tables and views are available.

## Notes

This is a portfolio analytics project using a Superstore-style sales dataset. It demonstrates a local SQL-to-Power BI workflow; the results describe the dataset and should not be interpreted as actual company financial results.
