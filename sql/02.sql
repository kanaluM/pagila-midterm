/*
 * Write a SQL query SELECT query that:
 * computes the country with the most customers in it. 
 */

-- This is the same as hw3 q2

SELECT country FROM (
    -- country + count of customers
    SELECT country, count(customer_id)
    FROM country
    JOIN city USING (country_id)
    JOIN address USING (city_id)
    JOIN customer USING (address_id)
    GROUP BY country
    ORDER BY count DESC) AS t
LIMIT 1;
