-- inner join on the Actor and Film actor table 
SELECT ACTOR.ACTOR_ID, FIRST_NAME, LAST_NAME, FILM_ID 
FROM FILM_ACTOR 
INNER JOIN ACTOR 
ON ACTOR.ACTOR_ID = FILM_ACTOR.ACTOR_ID;

-- Left join on the Actor and Film_actor table 
SELECT ACTOR.ACTOR_ID, FIRST_NAME, LAST_NAME, FILM_ID 
FROM FILM_ACTOR 
LEFT JOIN ACTOR 
ON ACTOR.ACTOR_ID = FILM_ACTOR.ACTOR_ID;

-- Join that will produce info about a customer from the country of Angola
SELECT CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME, CUSTOMER.EMAIL, COUNTRY 
FROM CUSTOMER 
FULL JOIN ADDRESS 
ON CUSTOMER.ADDRESS_ID = ADDRESS.ADDRESS_ID 
FULL JOIN CITY 
ON ADDRESS.CITY_ID = CITY.CITY_ID 
FULL JOIN COUNTRY 
ON CITY.COUNTRY_ID = COUNTRY.COUNTRY_ID 
WHERE COUNTRY = 'Angola';

-- Subqueries 

-- Two queries split apart 

-- Find a customer id that has an amount greater than 175 in total payments
SELECT CUSTOMER_ID 
FROM PAYMENT 
GROUP BY CUSTOMER_ID 
HAVING SUM(AMOUNT) > 175
ORDER BY SUM(AMOUNT) DESC;

SELECT STORE_ID, FIRST_NAME, LAST_NAME 
FROM CUSTOMER 
WHERE CUSTOMER_ID IN (
	SELECT CUSTOMER_ID 
	FROM PAYMENT 
	GROUP BY CUSTOMER_ID 
	HAVING SUM(AMOUNT) > 175 
	ORDER BY SUM(AMOUNT) DESC
)
GROUP BY STORE_ID, FIRST_NAME, LAST_NAME;

-- Basic subquery

SELECT * 
FROM CUSTOMER 
WHERE CUSTOMER_ID IN (
	SELECT CUSTOMER_ID 
	FROM PAYMENT 
	GROUP BY CUSTOMER_ID
	HAVING SUM(AMOUNT) > 175
	ORDER BY SUM(AMOUNT) DESC
);

-- Another basic subquery where all films are in english 
SELECT * 
FROM FILM 
WHERE LANGUAGE_ID IN (
	SELECT LANGUAGE_ID 
	FROM LANGUAGE 
	WHERE NAME = 'English'
);


-- Homework questions

-- 1. List all customers who live in Texas (use JOINs)
SELECT FIRST_NAME, LAST_NAME, DISTRICT 
FROM CUSTOMER 
FULL JOIN ADDRESS 
ON CUSTOMER.ADDRESS_ID = ADDRESS.ADDRESS_ID 
WHERE DISTRICT = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT FIRST_NAME, LAST_NAME, AMOUNT
FROM CUSTOMER 
FULL JOIN PAYMENT 
ON CUSTOMER.CUSTOMER_ID = PAYMENT.CUSTOMER_ID 
WHERE AMOUNT > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT FIRST_NAME, LAST_NAME 
FROM CUSTOMER 
WHERE CUSTOMER_ID IN (
	SELECT CUSTOMER_ID
	FROM PAYMENT 
	GROUP BY CUSTOMER_ID   
	HAVING SUM(AMOUNT) > 175
	ORDER BY FIRST_NAME
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT FIRST_NAME, LAST_NAME, COUNTRY
FROM CUSTOMER
FULL JOIN ADDRESS 
ON CUSTOMER.ADDRESS_ID = ADDRESS.ADDRESS_ID 
FULL JOIN CITY 
ON ADDRESS.CITY_ID = CITY.CITY_ID 
FULL JOIN COUNTRY 
ON CITY.COUNTRY_ID = COUNTRY.COUNTRY_ID
WHERE COUNTRY = 'Nepal';

-- 5. Which staff member had the most transactions?
SELECT STAFF.FIRST_NAME, STAFF.LAST_NAME, COUNT(PAYMENT_ID)
FROM STAFF 
FULL JOIN PAYMENT 
ON STAFF.STAFF_ID = PAYMENT.STAFF_ID 
GROUP BY STAFF.FIRST_NAME, STAFF.LAST_NAME
ORDER BY COUNT(PAYMENT_ID) DESC LIMIT 1;

-- 6. How many movies of each rating are there?
SELECT RATING, COUNT(RATING) 
FROM MOVIES_MP 
GROUP BY RATING;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT FIRST_NAME, LAST_NAME
FROM CUSTOMER 
WHERE CUSTOMER_ID IN (
	SELECT CUSTOMER_ID 
	FROM PAYMENT 
	GROUP BY CUSTOMER_ID, AMOUNT
	HAVING AMOUNT > 6.99
	ORDER BY FIRST_NAME
);

-- 8. How many free rentals did our stores give away?
SELECT PAYMENT_ID, AMOUNT 
FROM PAYMENT 
FULL JOIN RENTAL 
ON PAYMENT.RENTAL_ID = RENTAL.RENTAL_ID 
WHERE AMOUNT = 0.00
GROUP BY PAYMENT_ID;


















































































