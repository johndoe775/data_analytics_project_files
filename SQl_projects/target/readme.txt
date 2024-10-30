# SQL Project: E-commerce Data Analysis

This project focuses on analyzing an e-commerce dataset to derive insights on customer behavior, product demand, and regional sales trends. It uses complex SQL queries to extract and organize data, followed by recommendations for strategic improvements. The project employs data from multiple tables, including `orders`, `order_items`, `products`, `customers`, and `sellers`.

## Table of Contents

- [Project Structure](#project-structure)
- [Data Analysis](#data-analysis)
- [Key Insights](#key-insights)
- [Recommendations](#recommendations)
- [Setup and Usage](#setup-and-usage)
- [Contributing](#contributing)
- [License](#license)

## Project Structure

The project comprises three main files:

1. **analysis of the data.pdf** - Contains SQL queries and explanations of how various data attributes are analyzed, particularly around product categories and delivery times.
2. **Recomendations.pdf** - Offers SQL queries used to derive strategic recommendations, such as increasing the number of sellers in specific regions with low seller density.
3. **sql-project.pdf** - Provides an overview of the project’s goals and data sources.

## Data Analysis

This project analyzes several key aspects of the dataset:

1. **Product Category Analysis**:
   - Queries are used to categorize products and analyze order details by `product_category`, `customer_state`, and `delivery times`.
   - Example Query:
     ```sql
     SELECT product_category, count(order_id) as no_of_orders,
            avg(time_to_delivery) as avg_del_time,
            avg(diff_estimated_delivery) as avg_est_del_time,
            avg(price) as avg_price,
            avg(freight_value) as avg_freight_value
     FROM `scaler-dsml-sql-381611.sql_project.analysis_product_state`
     GROUP BY product_category
     ORDER BY no_of_orders DESC;
     ```
   - This query results in insights on average delivery time, estimated delivery time, price, and freight value by product category.

2. **Regional Customer and Order Insights**:
   - Analyzes customer location data to identify trends by `customer_state`.
   - Highlights specific regions with high demand, notably identifying "SP" as a region with the highest order volume for several top-selling product categories.

## Key Insights

From the data analysis, several important insights were identified:

- **Product Demand by Region**:
  - High demand for product categories such as 'bed table bath' and 'furniture' was identified.
  - Certain states, particularly "SP" and "RJ", lead in order volume for these high-demand categories.

- **Seller and Customer Distribution**:
  - An analysis of `customer_state` versus `seller_state` shows that some states have a high customer count but few or no sellers. Increasing seller presence in these regions could improve delivery efficiency and customer satisfaction.

## Recommendations

Based on the data analysis, the following actions are recommended:

1. **Increase Seller Presence in Low-Coverage States**:
   - Identified states with low seller counts relative to customer counts.
   - Suggested query to assess regions with a high customer-to-seller ratio:
     ```sql
     SELECT t1.*, no_of_sellers
     FROM (SELECT customer_state, count(customer_id) as no_of_customers
           FROM `sql_project.customers`
           GROUP BY customer_state) t1
     LEFT JOIN (SELECT seller_state, count(seller_id) as no_of_sellers
                FROM `scaler-dsml-sql-381611.sql_project.sellers`
                GROUP BY seller_state) t2
     ON t1.customer_state = t2.seller_state
     ORDER BY no_of_customers DESC
     LIMIT 10;
     ```

2. **Focus on High-Demand Categories**:
   - Emphasize improving logistics for top product categories in regions with high order volumes to reduce delivery times and costs.

## Setup and Usage

To use the SQL scripts in this project:

1. **Requirements**:
   - SQL environment with access to the e-commerce dataset.
   - Access to Google BigQuery or a similar SQL-compatible platform.

2. **Run Queries**:
   - Use the queries provided in the `analysis of the data.pdf` and `Recomendations.pdf` to perform data analysis and generate insights.
   - Modify the queries as necessary for different datasets or database schemas.

3. **View Results**:
   - The results from these queries can be exported or visualized using SQL or BI tools like Tableau or Power BI for more advanced analysis.




