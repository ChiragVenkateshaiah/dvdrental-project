This space is mainly for all the queries with respect to the business usecase:

Business Situation and Challenge Questions are the two way approach that I have used to build this project of querying the dvdrental database

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
First things first: I have used the below time to query the columns of tables and columns of each individual tables

SELECT table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'
	AND table_schema = 'public'
ORDER BY table_name;

SELECT DISTINCT
		column_name
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name = 'customer'
ORDER BY column_name;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 1: We want to send out a promotional email to our existing customers!

Challenge: Grab the first_name and last_name of every customer and their email address
SQL statement - 
SELECT first_name, last_name FROM customer;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 2: An Australian visitor isn't familiar with MPAA Movie ratings, we want to know the types of rating we have in our database, what rating do we have availabe?

SQL statement - 
SELECT * FROM film;
SELECT DISTINCT(rating) FROM film;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 3: How many customers have the first_name 'Jared'?

SQL Statement -
SELECT * FROM customer
WHERE first_name = 'Jared';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 4: A customer forgot their wallet at our store! We need to track their email to inform them. What is the email for the customer with the name Nancy Thomas?

SQL Statement -
SELECT email FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 5: A customer wants to know What the movie "Outlaw Hanky" is about. Could you give them the description for the movie "Outlaw Hanky"?

SQL Statement -
SELECT * FROM film;

SELECT description FROM film
WHERE title = 'Outlaw Hanky';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 6: A customer is late on their movie return, and we have mailed them a letter to their address at '259 Ipoh Drive'. We should also call them on their number. 
					  Get the phone of the customer with respect to 'address'

SQL Statement -
SELECT phone FROM address
WHERE address = '259 Ipoh Drive';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 7: Owner wants to reward the first 10 paying customers. What are the customer ids of the first 10 customers who created the payment?

SQL Statement -
SELECT * FROM payment
ORDER BY payment_date ASC
LIMIT 10;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 8: A customer wants to quickly rent a movie to watch in their short lunch break. What are the titles of the 5 shortest (in length of runtime) movies?

SQL Statement -
SELECT title, length FROM film
ORDER BY length ASC
LIMIT 5;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 9: If the previous customer can watch any movie that is 50 minutes or less in run time, how many options does she have?

SQL Statement -
SELECT COUNT(title) FROM film
WHERE length <= 50;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 10: How many payment transactions were greater than $5.00?

SQL Statement -
SELECT COUNT(amount) FROM payment
WHERE amount > 5;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 11: How many actors have a first name that starts with the letter P?

SQL Statement -
SELECT COUNT(first_name) FROM actor
WHERE first_name LIKE 'P%';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 12: How many unique districts are our customers from?

SQL Statement -
Grabing the Unique districts from the below statement:
SELECT DISTINCT(district) FROM address;

Counting the number of districts from the below statement:
SELECT COUNT(DISTRICT(district)) FROM address;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 13: Retrieve the list of names for those distinct districts from the previous question

SQL Statement -
SELECT DISTINCT(district) FROM address;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 14: How many films have a rating of R and a replacement cost between $5 and $15?

SQL Statement -
SELECT COUNT(*) FROM film
WHERE rating = 'R'
AND replacement_cost BETWEEN 5 AND 15;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 15: How many films have the word Truman somewhere in the title?

SQL Statement -
SELECT COUNT(title) FROM film
WHERE title LIKE '%Truman%';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 16: We have a two staff members, with staff ids 1 and 2. We want to give a bonus to the staff member that handled the most payments. 
					   Most in terms of number of payments processed, not total dollar amount.

SQL Statement -
SELECT staff_id, COUNT(amount) FROM payment
GROUP BY staff_id
ORDER BY COUNT(amount) DESC;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 17: Corporate HQ is conducting a study on the relationship between replacement cost and a movie MPAA Rating. What is the avg replacement cost per MPAA rating?

SQL Statement -
SELECT rating, ROUND(AVG(replacement_cost), 2) FROM film
GROUP BY rating
ORDER BY AVG(replacement_cost);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 18: We are running a promotion to reward our top 5 customers with coupons. What are the customer ids by total spend?

SQL Statement -
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 19: We are launching a plantinum service for our most loyal customers. We will assign platinum status to customers that have had 40 or more transactions payments.
					   What customer_ids are eligible for platinum status?

SQL Statement -
SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
HAVING COUNT(amount) >= 40;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 20: What are the customer_ids of customers who have spent more than $100 in payment transaction with our staff_id memeber 2?

SQL Statement -
SELECT customer_id, staff_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY  customer_id, staff_id
HAVING SUM(amount) > 100;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 21: What customer has the highest customer ID number whose name starts with an 'E' and has an address ID lower than 500?

SQL Statement -
SELECT first_name, last_name FROM customer
WHERE first_name LIKE 'E%'
AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 22: California sales taxs have changed and we need to alert our customers to this through emails. What are the emails of the customers who live in California

SQL Statment -
SELECT email, district
FROM customer
INNER JOIN address ON
address.address_id = customer.address_id
WHERE district = 'California';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 23: A customer walks in and is a huge fan of the actor 'Nick Wahlberg'and wants to know which moveis he is in. Get a list of all the movies 'Nick Wahlberg' has been in

SQL Statement -
SELECT
	title,
	first_name,
	last_name
FROM film_actor
INNER JOIN actor
	ON actor.actor_id = film_actor.actor_id
INNER JOIN film
	ON film.film_id = film_actor.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Situation 24: 