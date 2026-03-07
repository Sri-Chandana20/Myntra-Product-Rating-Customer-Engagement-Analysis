
# Create a table for importing data

CREATE TABLE myntra_cleaned_dataset (
    p_id VARCHAR(20) PRIMARY KEY,
    `name` VARCHAR(255),
    price DECIMAL(10 , 2 ),
    colour VARCHAR(50),
    brand VARCHAR(100),
    ratingCount INT,
    avg_rating DECIMAL(3 , 2 )
);

# Imported data using 'Table data import wizard'

SELECT 
    *
FROM
    myntra_cleaned_dataset;


# QUERIES

-- 1. Uniqueness Validation Query

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT p_id) AS unique_products
FROM
    myntra_cleaned_dataset;

/* 
Purpose: This query checks whether the p_id column contains unique values for each product. 
It compares the total number of rows with the number of distinct product IDs 
To ensure there are no duplicate records in the dataset.
*/

-- 2. Top 10 Highest-Rated Brands (Min 5 Products)

SELECT 
    brand,
    AVG(avg_rating) AS avg_rating,
    SUM(ratingCount) AS total_rating_counts,
    count(*) as product_count
FROM
    myntra_cleaned_dataset
GROUP BY brand
HAVING product_count >= 5  
ORDER BY total_rating_counts DESC
LIMIT 10;

/*
Purpose: This query analyzes brand performance by calculating the average rating, total number of reviews, and number of products for each brand. 
It only includes brands with at least 5 products to ensure meaningful comparisons and lists the top 10 brands based on total customer review counts.
*/

-- 3. Average Price & Rating by Colour

SELECT 
    colour,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(avg_rating), 2) AS avg_rating,
    COUNT(*) AS product_count
FROM
    myntra_cleaned_dataset
GROUP BY colour
ORDER BY avg_rating DESC;

/*
Purpose: This query examines product performance by color. 
It calculates the average price, average rating, and number of products available for each color to identify which colors perform better in terms of customer satisfaction and pricing.
*/

-- 4. Brands with Highest Average Rating (Min 10 Reviews)

SELECT 
    brand,
    ROUND(AVG(avg_rating), 2) AS avg_rating,
    SUM(ratingcount) as total_reviews
FROM
    myntra_cleaned_dataset
GROUP BY brand
HAVING total_reviews >= 10   
ORDER BY avg_rating DESC
LIMIT 10;

/*
Purpose: This query identifies brands with the highest average customer ratings while ensuring reliability by only including brands that have at least 10 total reviews. 
This helps highlight brands that consistently receive strong customer feedback.
*/





