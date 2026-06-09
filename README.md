<p align="center">
  <img src="myntra.png" width="140"/>
</p>

<h1 align="center"> Myntra Product Rating & Customer Engagement Analysis </h1>

### Overview
- E-commerce platforms like Myntra face **challenges** with recommendation quality, where popular items often lack quality, leading to unhappy customers and more returns.

- This **report analyzes** a scraped Myntra fashion product dataset to identify trends in ratings, reviews, price, brand, and colour. 

- The **goal** is to improve recommendations by balancing high-volume items with high-rated ones for better customer engagement and satisfaction.

- This **is important because** optimized recommendations can increase sales and cut down on returns, which helps boost revenue in India's competitive fashion market.

The project demonstrates end-to-end analytics: Data cleaning, querying, visualization, and actionable recommendations.

---

### Business Problem

- Online fashion platforms often prioritize high-selling products in their recommendations. However, sales volume does not always reflect customer satisfaction, as factors like discounts, promotions, and brand influence can drive purchases even when ratings and reviews are moderate.

- The challenge is to identify patterns in ratings, pricing, and brands that influence customer satisfaction to understand
  
  - Which brands generate the highest customer engagement?
    
  - Which product colors perform best in terms of customer popularity and ratings?
    
  - Are there high-rated premium brands that are currently underexposed?
 
---

### Table of Contents

- Data Source & Cleaning

- Tools Used

- Key Insights & Recommendations
  
- Power BI Report
    
- DAX Measures

- Business Questions

---

### Data Source & Cleaning

**Source:** [Myntra Fashion Product Dataset](https://www.kaggle.com/datasets/hiteshsuthar101/myntra-fashion-product-dataset/data) with ~15K rows, and 11 columns: index, p_id, name, price, color, brand, img, ratingCount, avg_rating, description, p_attributes.

**Cleaning Process (Excel):**

- **Removed Irrelevant Columns:** Deleted non-analytical fields (index, images, descriptions, p_attributes, unnamed row numbers) to focus on core data (p_id, name, price, colour, brand, ratingCount, avg_rating).

- **Handled Blank Rows:** Used copy-paste values to a new sheet to eliminate empty rows, ensuring only populated records remained.

- **Filtered Incomplete Records:** Applied filters to remove rows with blank ratingCount, resulting in a high-quality dataset of 355 rated products for reliable analysis.

---

### Tools Used

**Excel:** Initial exploration and cleaning.

**MySQL:** Database storage (CREATE TABLE with data types like DECIMAL for price/avg_rating, VARCHAR for brand/colour) and querying.

[Check out the queries here!](SQL_queries.sql)

**Power BI:** Interactive visualization (5 pages with KPIs, donut chart, bar charts, scatter plots, matrix; synced slicers for brand and colour).

---

### Key Insights & Recommendations

- **Feature Ahika more in recommendations**

Ahika has the most reviews (58,569) with a good 4.10 average rating - showing it more can increase clicks and sales.

- **Prioritize Black and Pink colors** 

Black (48,410 reviews, 4.18 rating) and Pink (44,057 reviews, 4.15 rating) are the top performers - recommend giving them more space in the recommendations sections for better engagement.

- **Promote high-rated premium & niche brands** 

Brands like Divena, Fashion Depth, and Ojjasvi have excellent ratings (>=4.5) at prices >1500 but low reviews - suggest featuring them in luxury or “Top Rated” sections to attract high-value customers and build trust.

- **Improve quality in high-volume brands** 

Ahika leads reviews, but only 7.1% products are >=4.5 stars - opportunity to upgrade popular products and boost overall recommendation quality.

---

### Power BI Report

The report has 5 pages with synced slicers (Brand & Colour) for interactivity.

- **Page 1:** Overview - KPIs (overall avg rating 4.1, total reviews 58k+), rating distribution donut, top 10 brands bar chart.
  
- **Page 2:** Price & Color Insights - Price vs rating scatter (bubble size = reviews), avg rating & price by colour clustered charts.
  
- **Page 3:** Detailed Matrix - Detailed comparison (brand rows, KPI values; drill-down to colour).
  
- **Page 4:** Insights & Recommendations - Actionable bullets from analysis.

- **Page 5:** About - Overview, objective, data source, tools used, and analyst profile.

[Check out the report here!](https://app.powerbi.com/view?r=eyJrIjoiMDQwNDA2YzMtNDE3NC00MzBlLWE5YzgtMmI2MDViYTE2YjIzIiwidCI6ImM2ZTU0OWIzLTVmNDUtNDAzMi1hYWU5LWQ0MjQ0ZGM1YjJjNCJ9&pageName=1271ee86e09a16929815)

---

### DAX Measures

Key measures used for KPIs:

- **Overall Avg Rating =**

                           CALCULATE ( AVERAGE ( myntra_cleaned_dataset[avg_rating] ), ALL ( myntra_cleaned_dataset ) )

**Purpose:** Calculates the overall average product rating, ignoring slicers and filters.

- **Total reviews =**

                      SUM ( myntra_cleaned_dataset[ratingCount] )

**Purpose:** Measures total customer engagement through review volume.

- **High-Rated Product% =** 

                             DIVIDE ( COUNTROWS ( FILTER ( myntra_cleaned_dataset, myntra_cleaned_dataset[avg_rating]>=4.5 ) ),

                             COUNTROWS ( myntra_cleaned_dataset ), 0 )

**Purpose:** Identifies the proportion of products rated 4.5 stars and above.

- **Avg Price for High Ratings =**

                                 CALCULATE ( AVERAGE ( myntra_cleaned_dataset[price] ), myntra_cleaned_dataset[avg_rating]>=4.5 )

**Purpose:** Shows the average price point of well-rated products.

- **Top Brand Rating Share =**

                             VAR Top3Brands =
                                              TOPN ( 3,
                                                    ALLSELECTED ( myntra_cleaned_dataset[brand] ),
                                                    CALCULATE ( AVERAGE ( myntra_cleaned_dataset[avg_rating] ) ),
                                                    DESC )

                             VAR HighRatedInTop3 =
                                                  CALCULATE (
                                                      COUNTROWS ( myntra_cleaned_dataset ),
                                                      myntra_cleaned_dataset[avg_rating] >= 4.5,
                                                      KEEPFILTERS ( Top3Brands )
                                                  )

                            VAR TotalHighRated =
                                                CALCULATE (
                                                    COUNTROWS ( myntra_cleaned_dataset ),
                                                    myntra_cleaned_dataset[avg_rating] >= 4.5
                                                )
                            
                            RETURN
  
                            DIVIDE ( HighRatedInTop3, TotalHighRated, 0 )

**Purpose:** Measures how much top-rated products are concentrated among the top 3 highest-rated brands.

---

### Business Questions Answered

**1. Which brands generate the highest customer engagement and should be prioritized in recommendations?**

Analysis shows that Ahika has the highest customer engagement with 58,569 reviews and a solid 4.10 average rating. 

Featuring Ahika products more prominently in recommendation sections could increase clicks and drive additional sales.

---

**2. Which product colors perform best in terms of customer popularity and ratings?**

Customer feedback indicates strong demand for Black and Pink products.

- Black: 48,410 reviews, 4.18 rating

- Pink: 44,057 reviews, 4.15 rating
  
These colors should be prioritized in recommendation panels to improve engagement and conversion rates.

---

**3. Are there high-rated premium brands that are currently underexposed?**

Several niche brands such as Divena, Fashion Depth, and Ojjasvi have excellent ratings (≥4.5) but relatively low review volumes, despite higher price points (>1500). 

Featuring these brands in “Top Rated” or premium collections could attract high-value customers and improve trust in premium segments.










