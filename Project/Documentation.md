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

## 4. Key Business Findings:
The insights generated from the interactive dashboard revealed several important business trends:

**1. Customer Retention Issue**:
  The Customer Retention Rate was measured at 0%, meaning no customers returned to make a second purchase.
This highlights a major opportunity and an urgent need to implement a customer loyalty or retention strategy.

**2. High Return Rate Categories**:
  Electronics and Home Appliances showed the highest product return rates.
These categories may require deeper investigation into product quality, customer expectations, or inaccurate product descriptions.

**3. Sales Timing Optimization**:
  Thursday and Friday were identified as the highest-performing sales days.
These days present the best opportunity to schedule marketing campaigns, promotions, and product launches for maximum impact.

##Extra Questions:
**Why is the return rate showing above 100%, and how do I fix it?**
The problem of the return rate exceeding $100\%$ was caused by corrupted data in the source file, where some return indicators were incorrectly marked as '2' instead of '1'. To fix this, we updated the BigQuery SQL query to clean the data, forcing any corrupted return value to be counted as only '1', which ensured the math was correct. Finally, in Looker Studio, we set the category_return_rate_final field to the Percent type, which correctly displays the true ratio (like $0.152$) as the accurate percentage ($15.2\%$).

**What is the system architecture of your E-Commerce Data Analysis project, and how does data flow from raw sources to final reports?**
The project follows a four-layer architecture:
**Data Source Layer:** Raw data comes from the Kaggle E-commerce Customer Behavior dataset, including purchases, product details, and return information.
**Data Storage and Processing Layer:** BigQuery stores raw data in fact tables. ELT operations are performed to clean and transform data using SQL queries and views. Data marts are created for specific business analyses.
**Business Logic Layer:** SQL computations are applied to calculate customer retention, sales trends, high-value customers, and product return rates. Window and aggregation functions help extract insights.
**Visualization and Reporting Layer:** Looker Studio connects to BigQuery to create dashboards. Analysts and managers use this layer to explore key metrics like retention, returns, and sales patterns.

**Data Flow:** Raw data → BigQuery (fact tables) → SQL transformations (analytical views, data marts) → Looker Studio dashboards → End-user decision-making.

**Answers to the Business Questions**

●	What is the conversion rate from cart to purchase per month?
February recorded the highest average spending per customer at 298.45 dollars, even though it only had 68 customers. March, April, July, and August also showed strong performance in terms of customer count, but their average spending was slightly lower than in February. December had the lowest number of customers at 64, although the average spending stayed close to the overall trend. Overall, February stands out as the month where customers spent the most on average.

●	Which product categories have the highest return rate?
Travel and Leisure (Flights) has the highest return rate at about 84 percent, followed by Office Supplies at about 79 percent. Hotels, Books, and Gardening and Outdoors also show high return rates, all above 72 percent. These categories stand out because a large portion of the items sold were eventually returned, making them the top contributors to overall return activity in the dataset.

●	Who are the most frequent or high-value customers?
The top high-value customers are those with the highest total spending, even if they only made one purchase. The highest spender is customer 60-470-3563, with a total value of 498.33 dollars. Other top customers include 13-848-5757, 15-663-7994, and 86-257-9581, all spending close to 498 dollars. These customers stand out because they made large single transactions, making them the highest-value customers in the dataset.

●	Which days of the week show the highest sales?
Tuesday recorded the highest sales at 44241.29 dollars, making it the strongest performing day of the week. Thursday and Sunday follow closely, also showing high sales levels. Saturday had the lowest total sales among all days. Overall, weekday sales are stronger than weekend sales in this dataset.
