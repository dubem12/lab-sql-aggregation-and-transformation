USE sakila;
-- visualize columnname in table film
select * from sakila.film;

-- select maximum and minimum
select max(length) as max_duration,
 min(length) as min_duration from sakila.film;
 
 -- express average movie duration in hours and minutes
SELECT CONCAT(FLOOR(AVG(length) / 60),
' hr ',
ROUND(AVG(length) % 60) 
) AS average_movie_duration 
FROM sakila.film;

-- find number of days that the company has been operating

SELECT DATEDIFF(MAX(rental_date) ,MIN(rental_date)) AS days_of_operation
FROM sakila.rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select rental_date from rental;

SELECT
    *,
    MONTHNAME(rental_date) AS Month,
    WEEK(rental_date) AS week
FROM rental;

-- Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *,
case
when (dayname(rental_date) = 'saturday') then 'weekend'
when  (dayname(rental_date) = 'sunday') then 'weekend'
else 'weekday'
  end as 'DAY_TYPE'
FROM rental
limit 20;

-- retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by the film title in ascending order

SELECT
    title,
    CASE
        WHEN rental_duration IS NULL THEN 'Not Available'
        ELSE rental_duration
    END AS rental_duration
FROM film
ORDER BY title ASC;

-- To achieve this, we want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address, so that we can address them by their first name and use their email address to send personalized recommendations. 

select * from customer;
select last_name, first_name, concat(first_name, ' ', last_name) as customer_name, left(email, 3) as email_pre
FROM customer
order by last_name ASC;

-- CHALLENGE 2
-- he total number of films that have been released.
select count( distinct (title)) as 'number of released movies' from film; 

-- The number of films for each rating
select rating, count(distinct (title)) as number_of_films
from film
group by rating;

 -- number of films for each rating, and sort the results in descending order
select rating, count(distinct (title)) as number_of_films
from film
group by rating
order by count(distinct (title)) desc;

-- number of rentals processed by each employee. 
SELECT staff_id, COUNT(*) AS processed_rentals
FROM rental
GROUP BY staff_id
ORDER BY staff_id;
-- 3

SELECT rating, round(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY round(avg(length),2) desc;

-- Identify which ratings have a mean duration of over two hours,
select rating, round(AVG(length),2) AS mean_duration
FROM film
group by rating
having AVG(length) > 120; -- 120 minutes=2 hours

-- Determine which last names are not repeated in the table actor.
select last_name from actor
group by last_name
having count(*) =1;
 
