show databases;
USE sakila;
show TABLES;
-- 1a. Display the first and last names of all actors from the table actor.

SELECT * from actor;
SELECT first_name, last_name from actor;
-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.

SELECT UPPER(CONCAT(first_name," ",last_name)) as "Actor Name" from actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?

SELECT actor_id, first_name, last_name from actor
WHERE first_name = "Joe";

-- 2b. Find all actors whose last name contain the letters GEN:
SELECT last_name, first_name, actor_id  from actor
WHERE last_name LIKE "%GEN%";

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT last_name, first_name, actor_id from actor
WHERE last_name LIKE '%LI%' 
ORDER BY last_name, first_name;

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT * from country
WHERE country.country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, 
-- so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, 
-- as the difference between it and VARCHAR are significant).
SELECT * from actor;
SELECT first_name, last_name from actor;

ALTER TABLE sakila.actor
ADD COLUMN description BLOB;
-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE sakila.actor
DROP COLUMN description;

-- 4a. List the last names of actors, as well as how many actors have that last name.
-- select last_name, count(last_name) 
-- from sakila.actor;
SELECT last_name, COUNT(last_name) AS Last_NameCount
FROM actor GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors.
SELECT last_name, COUNT(last_name) AS Last_NameCount
FROM actor GROUP BY last_name
HAVING Last_NameCount > 1;


-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = 'HARPO'  
WHERE first_name = 'GROUCHO';

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = 'GROUCHO'  
WHERE first_name = 'HARPO';

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE sakila.address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT  first_name, last_name from staff
INNER JOIN address ON staff.address_id = address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
-- SELECT staff_id from staff, SUM (payment.amount)
-- JOIN payment ON staff.staff_id = payment.staff_id;
SELECT staff.staff_id,
SUM(payment.amount) AS 'Sum of Payment'
FROM staff
JOIN payment USING (staff_id)
WHERE payment_date  BETWEEN '2005/08/01' AND '2005/08/31'
GROUP BY staff_id;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT  film.film_id,film.title, COUNT(actor_id) AS 'Number of Actors'
FROM film
INNER JOIN film_actor ON film_actor.film_id= film.film_id
GROUP BY film_id;
-- GROUP BY film_actor.actor_id;
-- SELECT f.title AS 'Film Title', COUNT(actor_id) AS 'Number of Actors'
-- FROM film_actor AS a
-- INNER JOIN film AS f ON (f.film_id = a.film_id)
-- GROUP BY f.film_id;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film.title, COUNT(inventory.film_id)
FROM film
JOIN inventory USING (film_id)
WHERE title = 'Hunchback Impossible' ;


-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS 'Total Amount Paid'
from customer
JOIN payment USING (customer_id)
GROUP BY customer_id
ORDER BY last_name ASC;




