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
<img width="800" height="500" alt="Gemini_Generated_Image_e2ltw1e2ltw1e2lt" src="https://github.com/user-attachments/assets/ec636566-fb08-4ec0-891c-00649485d166" />


## Executive Summary
## Insights Deep Dive
## Sales Trend
* The company generated approximately **£1.93M in revenue from 505,122 units sold** between July 2018 and June 2019, with monthly revenue remaining relatively stable between **£150.7K and £167.9K**. This indicates a consistent level of customer demand throughout the year, with no prolonged periods of significant volatility outside of seasonal flutuations.
* **December 2018 recorded the hightest revenue (£167.9K) and sales volume (43,845 units) of the year. Compared with the annual monthly average revenue of approximately **£161.2K**, December signicantly outpermed all other months. This suggests a strong seasonal uplift in customer purchasing activity, likely associated with increaswed holiday period spending and year end shopping behaviour.
* **February 2019 recorded the lowest revenue (£150.7K) and lowest sales volume (39,220 units)** during the reporting period. Compared with December 2018, revenue declined by approximately **10.3% (£17.2K)** and unit sales fell by **10.6% (4,625 units). The timing of this decline suggests a post holiday slowdown, where customer purchasing activity returned to lower levels following the yeat end peak.
* Following the February low point, revenue recovered from **£150.7K to £166.3K in March**, while dsales volume increased from **39,200 to 43,347K units**. This rapid rebound suggests that the decline observed in early 2019 was temporary and seasonal in nature, as customer purchasing activity quickly returned to level consistent with the rest of the year. 
### Customer behaviour
* Revenue is heavily concentrated in older life stage group, with **Older Single/Couples contributing 21% of total revenue** and the combined **Older Families, Older singles/Couples, and Retirees accounting for 58% of total revenue**. This show that more than half of all customer revenue is generrated by olde life stage segments, making them the dominant customer base in overall sale performance.
* New families acount for only **3% of total revenue, generating approximately £50K** in sales during the period. This highlights a limited contribution from this life stage group to overall business performance.
* Mainstream customers are the most important customer segment, consistently generating the highest sales across every month and achieving the highest average transaction value at **£7,41**, while also representing the largest customer base. This indicates that Mainstream customers drive a disproportionate share of customer revenue due to their scale and consistent purchasing activity compared with other customer groups.
* Customer value differences are driven more by purchase behaviour than spending per transaction, as Average Transaction Value remains tightly grouped between **£7.31 and £7.41** and Average Basket Size stays stable around **1.91 to 1.92** across customer tiers. In Contrast, Purchase Frequence varies significantly across segments, showing that how often customers shop is the main factor separating high and low value customers rather than how much they spend per visit
<img width="1143" height="372" alt="image" src="https://github.com/user-attachments/assets/7a80273c-95f6-46a3-bac0-ad6e9dfdc652" />

## Recommendations
## Assumptions and Caveats
