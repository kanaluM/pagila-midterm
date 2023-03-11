/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */

-- films with f in title
WITH f_titles AS (
    SELECT film_id
    FROM film
    WHERE title ILIKE '%F%'
),

-- films with actors with f in name
f_actors AS (
    SELECT film_id
    FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    WHERE first_name ILIKE '%F%' OR
          last_name  ILIKE '%F%'
),

-- films rented by customers with f in name or address
f_customers_and_addresses AS (
    SELECT film_id
    FROM country
    JOIN city USING (country_id)
    JOIN address USING (city_id)
    JOIN customer USING (address_id)
    JOIN rental USING (customer_id)
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
    WHERE first_name ILIKE '%F%' OR
          last_name  ILIKE '%F%' OR
          country    ILIKE '%F%' OR
          city       ILIKE '%F%' OR
          address    ILIKE '%F%' OR
          address2   ILIKE '%F%' OR
          district   ILIKE '%F%'
)

SELECT DISTINCT title
FROM film
WHERE film_id NOT IN (SELECT film_id FROM f_titles) AND
      film_id NOT IN (SELECT film_id FROM f_actors) AND
      film_id NOT IN (SELECT film_id FROM f_customers_and_addresses)
ORDER BY title ASC;
