/*
 * Write a SQL query SELECT query that:
 * List the first and last names of all actors who have appeared in movies in the "Children" category,
 * but that have never appeared in movies in the "Horror" category.
 */

-- This is the same as hw3 q4

-- actor_id and every category appeared in
WITH actor_by_category AS (
    SELECT actor_id, name
    FROM film_actor
    JOIN film USING (film_id)
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
)

SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (   -- no horror
    SELECT actor_id
    FROM actor_by_category
    WHERE name = 'Horror'
) AND actor_id IN (       -- yes children
    SELECT actor_id
    FROM actor_by_category
    WHERE name = 'Children'
) ORDER BY last_name ASC, first_name ASC;
