# Brazil E-commerce Operations Analysis (SQL & BigQuery)

## Project Overview
This project analyzes over 100,000 e-commerce orders from Brazil to uncover operational patterns and actionable business insights. The focus is on **order trends, customer distribution, payment behavior, freight costs, and delivery performance**. The goal is to identify opportunities to improve operational efficiency, optimize logistics, and support data-driven decision-making.

The analysis is performed entirely using **SQL in Google BigQuery**, showcasing the ability to work with **large-scale datasets**, perform complex joins, aggregations, and time-based analyses efficiently.

## Tools & Technology
- **SQL** – querying, aggregating, and analyzing data  
- **Google BigQuery** – cloud-based data warehouse for handling large datasets efficiently  
- **GitHub** – version control and project documentation  

## Dataset
The project uses the following tables from BigQuery:

- **orders** – order-level details including purchase and delivery timestamps  
- **customers** – customer information including city and state  
- **order_items** – item-level pricing and freight details  
- **payments** – payment type, value, and installments  
- **products** – product-level attributes  

> **Note:** Raw datasets are not included. The **dataset schema is documented** in `data/dataset_schema.md`.

## Project Structure
The repository is organized to provide clarity and easy navigation:

- `sql/ecommerce_operations_analysis.sql` – all SQL queries organized into sections  
- `data/dataset_schema.md` – table schemas and relationships for reference  
- `insights/business_insights.md` – key insights and recommendations derived from the analysis  
- `README.md` – this file, explaining the project  

This structure reflects a professional workflow commonly used in real-world analytics projects.

## Analyses Conducted
- **Order Trends:** monthly, yearly, and hourly patterns, including seasonality and peak order periods  
- **Customer Distribution:** orders analyzed across cities and states to understand regional demand  
- **Payment Behavior:** payment types, installment trends, and year-over-year revenue growth  
- **Freight & Delivery:** average freight costs, delivery times, and deviations from estimated delivery  
- **Business Insights:** actionable recommendations for operational improvements, logistics optimization, and pricing strategies  

## How to Use
1. Open `sql/ecommerce_operations_analysis.sql` to review all SQL queries and logic  
2. Refer to `data/dataset_schema.md` for table relationships and schema details  
3. Read `insights/business_insights.md` for business-focused findings and recommendations  

## Key Takeaways
- **BigQuery + SQL** can efficiently handle large-scale datasets and generate actionable insights  
- Structured queries with proper documentation make the analysis **easy to follow** for stakeholders  
- This project demonstrates **both technical proficiency and business understanding**, making it strong portfolio material for data analyst and data scientist roles
