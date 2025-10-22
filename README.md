[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=21090508&assignment_repo_type=AssignmentRepo)

# KOOLKLUB: Data Warehousing Project
**Online Store Customer Behavior and Sales Funnel**


**Course:** Data Warehousing  
**Instructor:** Ms. Grachel Eliza Ching

## 🎯 Objective

    1. Implement and analyze data warehouse optimization techniques using Google BigQuery.  
    2. Apply partitioning, clustering, and materialized views to improve query performance.  
    3. Demonstrate version-controlled collaboration through GitHub Classroom.

## 👥 Team Members

**Group Name:** KOOLKLUB  
**Project Topic:** *Online Store Customer Behavior and Sales Funnel*  

|      Member       | Role |
|-------------------|------|
| Jerome Agustin    | ---- |
| Junell Torres     | ---- |
| Nicole Bermundo   | ---- |
| Zynnon Kyle Depoo | ---- |

## 🧩 Project Description

The **Online Store Customer Behavior and Sales Funnel** project focuses on analyzing how customers interact with an e-commerce platform — from browsing and adding items to the cart, to completing purchases.  

The goal is to gain insights into:
- Purchase behavior and conversion rates  
- Product performance and sales trends  
- Customer retention and engagement metrics  

The data warehouse supports decision-making for marketing, promotions, and product optimization.

## 🛠️ Considerations for Tools and Technologies

| Tool | Purpose | Advantage | Possible Issues |
|------|---------| --------- | --------------- |
| **Google BigQuery** | Cloud data warehouse for storing, transforming, and querying large datasets | Cloud-native, should integrate nicely with Looker (GCP ecosystem) | Free tier limits on storage and processing |
| **Google Looker Studio** | Visualization tool for building interactive dashboards and reports |Cloud-native, should integrate nicely with Bigquery (GCP ecosystem) | Free tier limits on storage and processing |
| **PostgreSQL** | Relational DB, can be used for analytics with some setup | Free and open-source | Might have to require hosting via cloud providers for the purpose of the project |
| **SQL Server** | Relational DB, can also be used for analytics with some setup | Could integrate with PowerBI (Microsoft ecosystem) and 🗣️🔥 AZURE FREE TIER $100 IN CREDITS 🔥 | Group's familiarity with Azure |
| **PowerBI** | Data visualization tool for dashboards | Free, industry-standard for visualizations | Not free for embedded analytics, but should be irrelevant for the project |
| **SQL** | Query language for transformations, joins, and creating views/materialized views | Industry-standard | Other SQL dialects could be confusing 
| **Git, Github** | Version control and collaboration platform for the project repository | Free, easily accessible | Group's comfort with using Git

## Project Plan ⚙️

The project follows the Kimball Data Warehousing Model using either PostgreSQL hosted on Azure or Google BigQuery as the platform. This approach focuses on building data marts for key areas like customers, products, and sales, which are then integrated into a single data warehouse for analytics and reporting.

Implementation Overview

1.	Data Collection – Gather raw e-commerce data (transactions, customer activity, products).
2.	Data Modeling – Design a Star Schema with fact and dimension tables.
3.	ETL Process – Extract, clean, and load data into the warehouse.
4.	Optimization – Apply partitioning, indexing/clustering, and materialized views to improve query performance.
5.	Visualization – Connect to Power BI, Tableau, or Looker Studio for dashboards and reports.
6.	Collaboration – Use GitHub Classroom for version control and teamwork.
