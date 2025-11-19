# Project Documentation: E-Commerce Data Analysis

## 1. Project Overview and Methodology

**Project Goal:**  
To analyze E-commerce customer behavior to derive actionable insights related to sales performance, customer loyalty (retention), and product quality (return rates).

**Methodology:**  
This project was executed using the Kimball Data Warehousing Bottom-Up Approach. Specialized analytical structures (Data Marts / SQL Views) were created for direct reporting.

**Key Tools Used:**  
- **Storage and Processing:** Google BigQuery  
- **Visualization and Reporting:** Looker Studio  

---

## 2. Data Flow and Architecture

The process followed an **ELT (Extract, Load, Transform)** pattern, where raw data was loaded first, and cleaning/modeling took place within BigQuery.

### A. Data Source
- **Source:** E-commerce Customer Behavior Dataset from Kaggle  
- **Volume:** 1,000 transaction records  
- **Initial Challenge:** `Purchase_Amount` was a STRING because it contained the dollar symbol ($), preventing numerical calculations.

### B. Analytical Flow
1. **Extract & Load:** Raw data loaded into BigQuery table `Consumer_Behavior_Fact`  
2. **Transform (Cleaning):** SQL used to fix data quality issues and create `clean_fact_table` view  
3. **Model (Data Marts):** Complex SQL logic run against the clean table to create five targeted analytical views  
4. **Reporting:** Looker Studio connected to Data Marts for interactive visualization  

---

## 3. Data Processing and Problem/Solution Log

### A. Data Cleaning Solution (`clean_fact_table` View)
**Problem Encountered:** The Purchase_Amount field was an unusable TEXT data type.
**Solution Applied (SQL Logic):** We created the clean_fact_table view using two key SQL commands:
1. REPLACE(Purchase_Amount, '$', '') was used to remove the dollar symbol.
2. The result was then converted using CAST AS NUMERIC to ensure correct aggregation.

### B. Analytical Views (Data Marts)
The following views were created to answer specific business questions:

**monthly_conversion_proxy**
Question: What is the conversion trend per month?
Logic: Calculated the Average Purchase Amount per Customer, grouped by month.

**category_return_analysis**
Question: Which product categories have the highest return rate?
Logic: Calculated the ratio of Return_Rate to total transactions for each Purchase_Category.

**top_high_value_customers**
Question: Who are the most frequent or high-value customers?
Logic: Summarized total Purchase_Amount and COUNT of purchases per Customer_ID and ranked the results.

**sales_by_day_of_week**
Question: Which days of the week show the highest sales?
Logic: Grouped sales volume by the day name (e.g., 'Monday').

**customer_retention_analysis**
Question: What is the customer retention rate?
Logic (Advanced): Used the LEAD() Window Function to compare consecutive purchase dates for each customer to determine repeat buyers.

---

### 4. Key Business Findings
The interactive dashboard based on these views delivered the following critical results:

**Critical Finding:** The calculated Customer Retention Rate was 0%. This indicates a severe lack of repeat business and a major priority for loyalty program development.

**High Cost Driver:** Electronics and Home Appliances were identified as having the highest return rates, suggesting quality control or product description issues.

**Sales Optimization:** Thursday and Friday are the peak sales days, confirming the best time to deploy marketing promotions.
