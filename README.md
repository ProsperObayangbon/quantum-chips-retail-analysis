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
* Customer Segment Contribution

Insights and recommendations are provided on the following key areas:
### Northstar Metrics
* **Sales trends** - Focusing on total sales revenue, transaction volume, and average transaction value.
* **Customer behaviour** - Understanding purchasing behaviours across customer lifestages and premium customer segments.
* **Product performance** - Evaluating top-performing and underperforming products across stores and customer groups.
The SQL queries used to inspect and clean the data for this analysis can be found here [link](https://github.com/ProsperObayangbon/quantum-chips-retail-analysis/blob/main/sql/data_cleaning.sql)

Targeted SQL queries regarding various business questions can be found here [link](https://github.com/ProsperObayangbon/quantum-chips-retail-analysis/blob/main/sql/Business_questions.sql)

An interactive Power BI dashboard used to report and explore this metrics can be found here [link](https://app.powerbi.com/groups/me/reports/35420d9c-aa13-4137-974f-4b846f02b3e6/4a21b509bc00898d8c75?experience=power-bi)
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
<img width="1196" height="406" alt="ChatGPT Image Jun 17, 2026 at 08_10_23 PM" src="https://github.com/user-attachments/assets/acc7a4c7-7b84-4723-9330-7b0ef369739e" />

## Executive Summary
The analysis revealed that **Older Families, Older Singles/Couples, and Retirees are the primary revenue drivers**, collectively contributing **58% of total sales**, making older life-stage customers the foundation of overall business performance. **Mainstream customers also play a critical role**, consistently generating the highest sales volume and demonstrating strong and stable purchasing behaviour across all months. Customer value is primarily driven by **purchase frequency rather than basket size or average transaction value**, indicating that repeat shopping behaviour is the key lever of revenue growth and retention.

At the product level, revenue is highly concentrated among a small number of strong-performing brands, with **Kettle alone contributing over 22% of total sales** through a broad and well-performing product portfolio. In contrast, a long tail of low-performing products contributes minimal revenue while occupying shelf space, highlighting a clear opportunity for **range rationalisation and portfolio optimisation**. Seasonal analysis further shows predictable demand patterns, with **strong sales peaks in December driven by holiday spending** and a consistent **post-holiday decline in February**, followed by a recovery in March.
<img width="1469" height="826" alt="image" src="https://github.com/user-attachments/assets/91446dd8-3c6f-458c-85c0-d65604b92167" />

An interactive Power BI dashboard used to report and explore this metrics can be found here [link](https://app.powerbi.com/groups/me/reports/35420d9c-aa13-4137-974f-4b846f02b3e6/4a21b509bc00898d8c75?experience=power-bi)


## Insights Deep Dive
### Sales Trends
* The company generated approximately **£1.93M in revenue from 505,122 units sold** between July 2018 and June 2019, with monthly revenue remaining relatively stable between **£150.7K and £167.9K**. This indicates a consistent level of customer demand throughout the year, with no prolonged periods of significant volatility outside of seasonal flutuations.
* **December 2018 recorded the hightest revenue (£167.9K) and sales volume (43,845 units)** of the year. Compared with the annual monthly average revenue of approximately **£161.2K**, December signicantly outpermed all other months. This suggests a strong seasonal uplift in customer purchasing activity, likely associated with increaswed holiday period spending and year end shopping behaviour.
* **February 2019 recorded the lowest revenue (£150.7K) and lowest sales volume (39,220 units)** during the reporting period. Compared with December 2018, revenue declined by approximately **10.3% (£17.2K)** and unit sales fell by **10.6% (4,625 units)**. The timing of this decline suggests a post holiday slowdown, where customer purchasing activity returned to lower levels following the yeat end peak.
* Following the February low point, revenue recovered from **£150.7K to £166.3K in March**, while dsales volume increased from **39,200 to 43,347K units**. This rapid rebound suggests that the decline observed in early 2019 was temporary and seasonal in nature, as customer purchasing activity quickly returned to level consistent with the rest of the year.
* Sales performance followed a clear seasonal pattern, with revenue increasing from **August to October**, softening slightly in Novermber, reaching its annual peak in **December**, and then declining through **January and February** before recovering in March. This pattern indicates that customer demand is influened by recurring seasonal cyces rather than sustained structural changes in purchasing behaviour.
<img width="1338" height="592" alt="image" src="https://github.com/user-attachments/assets/599aefe8-99b0-494b-aeb8-3a636e07b520" />

### Customer behaviour
* Revenue is heavily concentrated in older life stage group, with **Older Single/Couples contributing 21% of total revenue** and the combined **Older Families, Older singles/Couples, and Retirees accounting for 58% of total revenue**. This show that more than half of all customer revenue is generrated by olde life stage segments, making them the dominant customer base in overall sale performance.
* New families acount for only **3% of total revenue, generating approximately £50K** in sales during the period. This highlights a limited contribution from this life stage group to overall business performance.
* Mainstream customers are the most important customer segment, consistently generating the highest sales across every month and achieving the highest average transaction value at **£7,41**, while also representing the largest customer base. This indicates that Mainstream customers drive a disproportionate share of customer revenue due to their scale and consistent purchasing activity compared with other customer groups.
* Customer value differences are driven more by purchase behaviour than spending per transaction, as Average Transaction Value remains tightly grouped between **£7.31 and £7.41** and Average Basket Size stays stable around **1.91 to 1.92** across customer tiers. In Contrast, Purchase Frequence varies significantly across segments, showing that how often customers shop is the main factor separating high and low value customers rather than how much they spend per visit
<img width="1382" height="456" alt="image" src="https://github.com/user-attachments/assets/e5cb5885-30f6-452e-ba14-e2271c2118e6" />

### Product Performance
* Revenue is concentrated among a relatively small grroup of products, with **Dorito Corn Chips Supreme 300g generating £40.4K, repreesntiing approximately 2.1% of total reveue**. The top 10 products collectively generatted apprroximately **344.3K, accounting for 17.8% of total sales**, highlighting the disproportionate contribution of as small subset of the product portfolio to overall business performance.
* **Kettle is the strongest performing product brand, with its product variants generating approximattelly £434.0K in revenue, representing 22.4% of total sales**. Compared with individual competing brands, Kettle maintains a broad portolio of high performing products, demonstrating strong customer demand across multiple flavours rather than dependence on a single best seller.
* Lower performing product such as  **Woolworths Medium Salsa (2,700 units; £4.1K revenue) to Sunbites French Onin (2,823 units; £4.6K revenue) generated less than 0.3%** of category revenue each despite maintaining steady order volumes, suggesting these products occupy shelf space without creating meaningful financial impact and may warrant range rationalization review.
* The performance gap across the portfolio is significant. While the highest-performing product generated **£40.4K**, the lowest-performing products, such as **Woolworths Medium Salsa 300g (£4.1K)** and **Woolworths Mild Salsa 300g (£4.2K)**, generated less than one-eighth of that amount. This highlights considerable variation in product contribution and suggests that revenue generation is unevenly distributed across the portfolio.
<img width="1211" height="592" alt="image" src="https://github.com/user-attachments/assets/d6fdad90-0705-472e-9507-44735db04c07" />

## Recommendations
Based on the uncover insight, the following recommendations have been provided:
* The company derives 58% of its revenue from Older Families, Older Singles/Couples, and Retirees, making these segments the foundation of current performance. **Leadership should prioritise retention initiatives targeted at these customers through loyalty programs, personalised promotions, and product offerings aligned to their purchasing habits**. At the same time, **the company should gradually diversify its customer mix by increasing investment in younger life-stage segments to reduce long-term dependency on aging demographics and create a more sustainable growth pipeline**.

* Customer analysis shows that Average Transaction Value and Basket Size are largely consistent across customer segments, while Purchase Frequency is the primary driver of customer value. Rather than focusing on increasing spend per visit, **the company should prioritise strategies that encourage customers to shop more often, such as personalised offers, replenishment reminders, loyalty rewards based on visit frequency, and targeted retention campaigns**.
  
* Sales performance follows a predictable seasonal cycle, with December delivering the strongest revenue and February experiencing the sharpest decline. This presents an opportunity to strengthen promotional planning, inventory management, and marketing execution around key seasonal periods. **Leadership should implement proactive holiday campaigns to maximize peak-season demand while introducing targeted retention and reactivation programs in January and February to reduce the impact of the post-holiday slowdown and stabilize revenue throughout the year**.

* Mainstream customers consistently generate the highest sales, represent the largest customer base, and achieve the highest Average Transaction Value among customer tiers. **Because overall company performance is highly sensitive to changes in this segment, maintaining engagement and retention among mainstream customers should be a strategic priority**. Investments in customer experience, loyalty incentives, and targeted product recommendations aimed at this group are likely to generate the highest short-term return on investment and protect the largest share of company revenue.
  
* Product revenue is concentrated among a relatively small number of products, while Kettle alone contributes over 22% of total sales through a broad portfolio of successful variants. **The business should leverage these strong-performing products by increasing promotional support, optimizing shelf placement, expanding distribution, and introducing complementary cross-sell opportunities.** Investing behind proven winners is likely to generate faster and lower-risk revenue growth than spreading resources evenly across the entire product portfolio.

* Several low-performing products generate less than 0.3% of category revenue despite occupying shelf space and operational resources. **Leadership should conduct a structured portfolio review to identify products that can be removed, consolidated, repositioned, or replaced with higher-performing alternatives**. Rationalising underperforming products can improve inventory efficiency, simplify operations, increase shelf productivity, and create space for products with stronger revenue and margin potential.
  
* While New Families contribute only 3% of total revenue and younger customer segments remain underrepresented, they represent a significant long-term growth opportunity. **The company should develop targeted acquisition strategies, family-oriented promotions, and product offerings tailored to younger households**. Strengthening engagement with these segments today will help offset future demographic risks, increase customer lifetime value, and create the next generation of loyal customers as their purchasing power and household spending grow over time.

## Assumptions and Caveats
