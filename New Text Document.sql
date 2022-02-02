SELECT COUNT(DISTINCT(first_name)) FROM actor;
SELECT COUNT(DISTINCT (amount)) FROM payment;
SELECT COUNT (amount) FROM payment;

SELECT * FROM customer WHERE first_name='Jared';
SELECT * FROM film WHERE rental_rate > 4;
SELECT * FROM film WHERE rental_rate > 4 AND replacement_cost >=19.99 AND rating='R';
SELECT title FROM film WHERE rental_rate > 4 AND replacement_cost >=19.99 AND rating='R';
SELECT COUNT (*)  FROM film where rating='R' OR rating='PG-13';
SELECT *  FROM film where rating !='R';
SELECT email from customer WHERE first_name='Nancy' and last_name='Thomas';
SELECT title FROM film;
SELECT description FROM film WHERE title='Outlaw Hanky';
SELECT phone FROM address WHERE address='259 Ipoh Drive';

--ORDER BY
SELECT store_id,first_name,last_name FROM customer ORDER BY store_id,first_name;

SELECT store_id,first_name,last_name 
FROM customer 
ORDER BY store_id DESC,first_name ASC;

--LIMIT
SELECT * FROM payment
WHERE amount != 0.00
ORDER BY payment_date LIMIT 5;

--Challenge
SELECT customer_id FROM payment ORDER BY payment_date  LIMIT 10;
SELECT title FROM film ORDER BY length LIMIT 5;

--Between 
SELECT   * FROM payment WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

--IN
SELECT DISTINCT amount FROM payment ORDER BY amount;
SELECT * FROM payment WHERE amount IN(0.00,0.99,1.99) ORDER BY amount;
SELECT COUNT(*) FROM payment WHERE amount NOT IN(0.00,0.99,1.99);
SELECT * FROM customer WHERE first_name IN('John','Jake','Julie')

/* -- LIKE %a-->last ae a -->A% suru A diye hobe --> _ -->single character --> __ double character --*/

SELECT * FROM customer WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';
SELECT * FROM customer WHERE first_name LIKE '%er';
SELECT * FROM customer WHERE first_name LIKE '%er%';
SELECT * FROM customer WHERE first_name LIKE '_er%';
SELECT * FROM customer WHERE first_name LIKE '__er%';
SELECT * FROM customer WHERE first_name NOT LIKE '__er%';
SELECT * FROM customer WHERE first_name 
LIKE 'A%' AND 
last_name NOT LIKE 'B%' ORDER BY last_name;

--General challenge
SELECT COUNT(amount) FROM payment WHERE amount >5;
SELECT COUNT(first_name) FROM actor WHERE first_name LIKE 'P%';
SELECT COUNT (DISTINCT district) FROM address;
SELECT DISTINCT district FROM address;
SELECT COUNT(rating) FROM film WHERE rating='R' AND replacement_cost BETWEEN 5 and 15;
SELECT COUNT(title) FROM film WHERE title LIKE '%Truman%';


--Aggregrate Function
SELECT MIN(replacement_cost) FROM film;
SELECT MAX(replacement_cost) FROM film;

SELECT  MAX(replacement_cost),
MIN(replacement_cost),
SUM(replacement_cost),
ROUND(AVG(replacement_cost),2) FROM film;

--Group BY
SELECT customer_id FROM payment GROUP BY customer_id ORDER BY customer_id;
SELECT customer_id,SUM(amount) FROM payment GROUP BY customer_id ORDER BY SUM(amount);
SELECT customer_id,COUNT(amount) FROM payment GROUP BY customer_id ORDER BY COUNT(amount) DESC;
SELECT customer_id,staff_id,SUM(amount) FROM payment 
GROUP BY customer_id,staff_id ORDER BY customer_id;
SELECT payment_date FROM payment;
SELECT DATE(payment_date),COUNT(amount) FROM payment 
GROUP BY DATE(payment_date) ORDER BY COUNT(amount);

--GROUP BY TASK
SELECT DISTINCT staff_id FROM payment;
SELECT staff_id,COUNT(amount) FROM payment GROUP BY staff_id ORDER BY COUNT(amount);
SELECT staff_id,ROUND(sum(amount)) FROM payment GROUP BY staff_id ORDER BY sum(amount);

SELECT rating,ROUND(AVG(replacement_cost),2) FROM film GROUP BY rating ORDER BY AVG(replacement_cost);
SELECT  customer_id,SUM(amount) FROM payment GROUP BY customer_id ORDER BY sum(amount) DESC LIMIT 5;

--HAVING COMES AFTER GROUP BY
SELECT customer_id,SUM(amount) FROM payment 
WHERE customer_id NOT IN (184,87,477)
GROUP BY customer_id
HAVING SUM(amount)>100;

SELECT store_id,COUNT(customer_id) FROM customer GROUP BY store_id HAVING COUNT(customer_id) > 300;

--HAVING CHALLENGES
SELECT customer_id,COUNT(amount) FROM payment GROUP BY customer_id HAVING COUNT(amount)>=40;
SELECT DISTINCT amount FROM payment;
SELECT customer_id,staff_id,SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id,staff_id  HAVING sum(amount)>100;

--Assesment Task
--Return the customer IDs of 
--customers who have spent at least $110 with the staff member who has an ID of 2.
SELECT customer_id,SUM(amount) FROM payment
WHERE staff_id=2
GROUP BY customer_id
HAVING SUM(amount)>110;

SELECT COUNT(title) from film WHERE title LIKE 'J%';

SELECT first_name,last_name  FROM customer 
WHERE first_name LIKE 'E%' AND address_id < 500
ORDER BY customer_id DESC LIMIT 1;

--As Statement
SELECT amount as rental_price FROM payment;
SELECT * FROM payment;
SELECT customer_id, SUM(amount) as Rental_price FROM payment GROUP BY customer_id ORDER BY SUM(amount);

--Inner JOin
SELECT customer.customer_id,customer.store_id,payment.customer_id AS payment_customer_id FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id;

SELECT payment_id,payment.customer_id,first_name FROM customer
INNER JOIN payment
ON payment.customer_id = customer.customer_id;

--FULL OUTER JOIN
SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null OR
payment.payment_id IS null;

--Left JOIN
SELECT * FROM customer
LEFT OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.customer_id IS null;

SELECT film.film_id,title,inventory_id,store_id
FROM film
LEFT JOIN inventory
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS NULL;

--RIGHT JOIN
SELECT film.film_id,title,inventory_id FROM film
RIGHT JOIN inventory
ON inventory.film_id = film.film_id;

--UNION
SELECT customer_id FROM customer
UNION
SELECT customer_id FROM payment;

--JOIN CHALLENGE
SELECT DISTINCT address FROM address;

SELECT district,email FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'California';

SELECT title,first_name,last_name  FROM actor
INNER JOIN film_actor
ON film_actor.actor_id = actor.actor_id
INNER JOIN film
ON film.film_id = film_actor.film_id
WHERE actor.first_name='Nick' and actor.last_name='Wahlberg';



--Advance SQL COMMAND
SHOW ALL;
SHOW TIMEZONE;
SELECT NOW();
SELECT TIMEOFDAY();
SELECT CURRENT_TIME;
SELECT CURRENT_DATE;

--EXTRACT day,week,year,month,quarter
SELECT EXTRACT(YEAR FROM payment_date) AS MYYEAR FROM payment;
SELECT EXTRACT(MONTH FROM payment_date) FROM payment;
SELECT EXTRACT(WEEK FROM payment_date) FROM payment;
SELECT AGE(payment_date) FROM payment;
--TO CHAR
SELECT TO_CHAR(payment_date,'MONTH YYYY') FROM payment;
SELECT TO_CHAR(payment_date,'month/dd/yyyy') FROM payment;
--Timestamps and Extract challenge
SELECT DISTINCT (TO_CHAR(payment_date,'MONTH')) FROM payment;
SELECT  COUNT(*) FROM payment WHERE EXTRACT(dow FROM payment_date)=1;

--Mathmatical Funciton
SELECT ROUND(rental_rate/replacement_cost,2) FROM film;
--In terms of parcent
SELECT ROUND(rental_rate/replacement_cost,2)*100 AS PARCENT_COST FROM film;

--STRING FUNCTION
SELECT char_length(first_name) FROM actor;
SELECT first_name || ' ' || last_name AS combineFNLN FROM actor;
SELECT upper(first_name) || ' ' || upper(last_name) AS upperANDCombineFNLN FROM actor;

SELECT LOWER(substring(first_name for 1)) || LOWER(last_name) || '@gmail.com' 
AS Make_EMail FROM customer;


--SUBQUERY
-- IN the subquery parenthesis occur first
SELECT title,rental_rate FROM film 
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);

SELECT film.film_id,title FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
on film.film_id = inventory.film_id
WHERE return_date 
BETWEEN '2005-05-29' AND '2005-05-30';

SELECT title,film_id FROM film
WHERE film_id IN
(SELECT inventory.film_id FROM rental
INNER JOIN inventory
ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date
BETWEEN '2005-05-29' AND '2005-05-30')
ORDER BY film_id;

--EXIST
SELECT first_name,last_name FROM customer AS c
WHERE  EXISTS
(SELECT * FROM payment as p WHERE p.customer_id = c.customer_id AND amount>11);


SELECT first_name,last_name FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount>11;

--SELF JOIN
SELECT f1.title,f2.title,f1.length FROM film AS f1
INNER JOIN film as f2 
on f1.film_id != f2.film_id
AND f1.length = f2.length;
