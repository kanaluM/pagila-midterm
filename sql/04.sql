/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query SELECT query that:
 * Lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 * (You may choose to either include or exclude the movie 'AMERICAN CIRCUS' in the results.)
 */

-- This is the same as hw3 q5

-- actors in AMERICAN CIRCUS
WITH circus_actors AS (
    SELECT film_id, actor_id, first_name, last_name
    FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
)

SELECT DISTINCT title
FROM film
JOIN film_actor F1 USING (film_id)
JOIN film_actor F2 USING (film_id)
WHERE F1.actor_id != F2.actor_id  -- distinct actors
  AND F1.actor_id IN (SELECT actor_id FROM circus_actors)
  AND F2.actor_id IN (SELECT actor_id FROM circus_actors)
ORDER BY title ASC;
