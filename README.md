# Quantum Chips Retail Performance Analysis
## Project Background
Quantum Chips Retail is a fictional FMCG retail company specialising in packaged snack products, particularly chips and convenience snack items, sold across multiple retail store locations. Established in 2017, the company has expanded rapidly across several regions and built a strong customer base through it loyalty card program

The business operates using a high volume retail model where revenue is driven by repeat customer purchases, product assortment optimisation, and customer loyalty engagement. As competition within the snack retail industry intensified, company leadership sought a better understand of customer purchasing behavior, product performance, and store-level sales trends to support data-driven decision-making.

As a Data Analyst working within the Commercial Analytics team, this project was conducted to analyse transactional sales data alongside customer behavior data to uncover strategic insights for stakeholders across Marketing, Finance, Product and Store Operations teams.

The analysis focuses on key business metrics including
* Total Sales Revenue
* Transaction Volume
* Average Transaction Value (ATV)
* Customer Purchase Frequency
* Product Sales Performance
* Store Performance
* Customer Segment Contribution
* Loyalty Customer Retention

Insights and recommendations are provided on the following key areas:
### Northstar Metrics
* **Sales trends** - Focusing on total sales revenue, transaction volume, and average transaction value.
* **Customer behaviour** - Understanding purchasing behaviours across customer lifestages and premium customer segments.
* **Product performance** - Evaluating top-performing and underperforming products across stores and customer groups.
* **Loyalty program effectiveness** - Measuring the impact of loyalty customers on revenue growth and repeat purchasing behaviour.

The SQL queries used to inspect and clean the data for this analysis can be found here [link](https://github.com/ProsperObayangbon/quantum-chips-retail-analysis/blob/main/sql/data_cleaning.sql)

Targeted SQL queries regarding various business questions can be found here [link](https://github.com/ProsperObayangbon/quantum-chips-retail-analysis/blob/main/sql/Business_questions.sql)

An interactive Power BI dashboard used to report and explore this metrics can be found here [link]
## Data Structure & Initial Checks
The company's database structure consist of two primary tables: transaction_data and purchase_behaviour, with a combined row count exceeding 250,000 records.

A description of each table is as follows:

### transaction_data

This table contains all customer transaction records across stores.

| Column Name      | Description                          |
|------------------|--------------------------------------|
| DATE             | Transaction date                     |
| STORE_NBR        | Store identification number          |
| LYLTY_CARD_NBR   | Customer loyalty card number         |
| TXN_NBR          | Unique transaction number            |
| PROD_NBR         | Product identification number        |
| PROD_NAME        | Product name                         |
| TOT_SALES        | Total sales value                    |

### Purchase_behaviour

This table contains customer demographic and segmentation data.

| Column Name      | Description                          |
|------------------|--------------------------------------|
| LYLTY_CARD_NBR   | Customer loyalty card number         |
| LIFESTAGE        | Customer lifestage classification    |
| PREMIUM_CUSTOMER | Premium customer category            |

## Initial Data Checks Performed
Before analysis, several data quality checks and cleaning procedures were completed [link](https://github.com/ProsperObayangbon/quantum-chips-retail-analysis/blob/main/sql/data_cleaning.sql):
* Removed duplicate transaction records.
* Checked for missing values across key fields.
* Validated transaction dates and standardized data formats.
* Verified customer loyalty card number across both tables.
* Checked for negative sales values and transaction anomalies.
* Checked and standardised inconsistent product naming conventions.

## Entity Relationship Diagram (ERD)
<img width="1000" height="768" alt="Gemini_Generated_Image_e2ltw1e2ltw1e2lt" src="https://github.com/user-attachments/assets/ec636566-fb08-4ec0-891c-00649485d166" />


## Executive Summary
## Insights Deep Dive
## Recommendations
## Assumptions and Caveats
