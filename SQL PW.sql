create table employees(
  emp_id int primary key,
  emp_name varchar(30) not null,
  age int check(age>=18),
  email varchar(30) unique,
  salary decimal default 30000);
/*Q2
Constraints are rules that ensure data integrity in a database. They ensure that the data is
accurate, consistent, and reliable by preventing invalid or inconsistent data from being entered.
NOT NULL: Ensures a column cannot have NULL values.
Example: emp_name TEXT NOT NULL
PRIMARY KEY: Uniquely identifies each record and cannot be NULL.
Example: emp_id INTEGER PRIMARY KEY
UNIQUE: Ensures all values in a column are unique.
Example: email TEXT UNIQUE
FOREIGN KEY: Ensures referential integrity by linking columns in different tables.
Example: FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
CHECK: Ensures data satisfies a condition.
Example: age INTEGER CHECK(age >= 18)
DEFAULT: Provides a default value if none is specified.
Example: salary DECIMAL DEFAULT 30000 */

/*Q3
To ensure a column always has a value and doesn't allow NULL entries, ensuring data consistency
And a primary key cannot contain NULL because it must uniquely identify each record, and NULL is not unique.*/

/*Q4
-To add a constraint to an existing table, you can use the ALTER TABLE statement with the ADD CONSTRAINT clause.
ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type;
-To remove a constraint from an existing table, you can use the ALTER TABLE statement with the DROP CONSTRAINT clause.
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;*/

/*Q5
When you attempt to insert, update, or delete data in a way that violates a constraint, the database will reject
the operation and return an error. This ensures data integrity is maintained by preventing invalid or inconsistent data.
Consequences for Each Operation:
Insert:
If you try to insert a row with data that violates a constraint (e.g., a NULL value in a NOT NULL column, or a duplicate in a UNIQUE column), the insert operation will fail.
Update:
If you try to update data in a way that violates constraints (e.g., changing a primary key to NULL or duplicating a UNIQUE value), the update will fail.
Delete:
If you try to delete a row that is referenced by another table's foreign key (without handling cascading effects), the delete will fail due to referential integrity violation.*/

create table products(
  product_id int,
  product_name varchar(50),
  price decimal(10,2)
);

create table products_new(
  product_id int primary key,
  product_name varchar(50),
  price decimal(10,2) default 50.00
);

drop table products;

alter table products_new rename to products;


select * from studets
inner join classes on students.class_id = classes.class_id;


select orders.order_id,customers.customer_name,prodcuts.product_name
from customers
inner join orders on
customers.customer.id=orders.customer_id
left join products on
orders.order_id=products.order_id;


#Q9
select products.prodcut_name,
sum(sales.amount) as total_sales_amount
from products
left join sales on products.product_id=sales.product_id
group by products.product_name;


SELECT
    orders.order_id,
    customers.customer_name,
    SUM(order_details.quantity) AS total_quantity
FROM
    orders
INNER JOIN
    customers ON orders.customer_id = customers.customer_id
INNER JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY
    orders.order_id, customers.customer_name;

#SQL Commands

#1.Identify the primary keys and foreign keys in maven movies db. Discuss the differences


SELECT
    TABLE_NAME AS table_name,
    COLUMN_NAME AS primary_key_column
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    CONSTRAINT_NAME = 'PRIMARY'
    AND TABLE_SCHEMA = 'maven_movies';

SELECT
    TABLE_NAME AS table_name,
    COLUMN_NAME AS foreign_key_column,
    REFERENCED_TABLE_NAME AS referenced_table,
    REFERENCED_COLUMN_NAME AS referenced_column
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    REFERENCED_TABLE_NAME IS NOT NULL
    AND TABLE_SCHEMA = 'maven_movies';
/* Differences Between Primary and Foreign Keys
Purpose: Primary Key uniquely identifies rows; Foreign Key links tables.
Uniqueness: Primary Key values are unique; Foreign Key values can repeat.
Nullability: Primary Key cannot have NULL; Foreign Key can have NULL.
Integrity: Primary Key ensures entity integrity; Foreign Key ensures referential integrity.
Multiplicity: One Primary Key per table; multiple Foreign Keys allowed.*/

/*2.List all details of actors*/
SELECT *
FROM actors;

/*3.List all customer information from DB.*/
SELECT *
FROM customers;

/*4List different countries.*/
SELECT DISTINCT country
FROM country;

#5.Display all active customers.
SELECT *
FROM customers
WHERE active = 1;

#6.List of all rental IDs for customer with ID 1.
SELECT rental_id
FROM rentals
WHERE customer_id = 1;

#7. Display all the films whose rental duration is greater than 5
SELECT *
FROM films
WHERE rental_duration > 5;

#8.List the total number of films whose replacement cost is greater than $15 and less than $20
SELECT COUNT(*)
FROM films
WHERE replacement_cost BETWEEN 15 AND 20;

#9.Display the count of unique first names of actors.
SELECT COUNT(DISTINCT first_name)
FROM actors;

#10.Display the first 10 records from the customer table
SELECT *
FROM customers
LIMIT 10;

#11.Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT *
FROM customers
WHERE first_name LIKE 'b%'
LIMIT 3;

#12.Display the names of the first 5 movies which are rated as ‘G’.
SELECT title
FROM films
WHERE rating = 'G'
LIMIT 5;

#13.Find all customers whose first name starts with "a".
SELECT *
FROM customers
WHERE first_name LIKE 'a%';

#14.Find all customers whose first name ends with "a".
SELECT *
FROM customers
WHERE first_name LIKE '%a';

#15.Display the list of first 4 cities which start and end with ‘a’
SELECT *
FROM cities
WHERE city LIKE 'a%a'
LIMIT 4;

#16.Find all customers whose first name have "NI" in any position
SELECT *
FROM customers
WHERE first_name LIKE '%NI%';

#17.Find all customers whose first name have "r" in the second position .
SELECT *
FROM customers
WHERE first_name LIKE '_r%';

#18.Find all customers whose first name starts with "a" and are at least 5 characters in length
SELECT *
FROM customers
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

#19.Find all customers whose first name starts with "a" and ends with "o".
SELECT *
FROM customers
WHERE first_name LIKE 'a%o';

#20.Get the films with pg and pg-13 rating using IN operator
SELECT *
FROM films
WHERE rating IN ('PG', 'PG-13');

#21.Get the films with length between 50 to 100 using between operator.
SELECT *
FROM films
WHERE length BETWEEN 50 AND 100;

#22.Get the top 50 actors using limit operator.
SELECT *
FROM actors
LIMIT 50;

#23.Get the distinct film ids from inventory table
SELECT DISTINCT film_id
FROM inventory;

#Functions ,Basic Aggregate Functions

#1 Retrieve the total number of rentals made in the Sakila database.
SELECT COUNT(*) AS total_rentals
FROM rentals;

#2 Find the average rental duration (in days) of movies rented from the Sakila database
SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_duration
FROM rentals;

#(String Functions)3 Display the first name and last name of customers in uppercase
SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name
FROM customers;

#4 Extract the month from the rental date and display it alongside the rental ID
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rentals;

#(GROUP BY)5 Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id, COUNT(*) AS rental_count
FROM rentals
GROUP BY customer_id;

#6 Find the total revenue generated by each store
SELECT store_id, SUM(amount) AS total_revenue
FROM payments
GROUP BY store_id;

#7 Determine the total number of rentals for each category of movies
SELECT category_id, COUNT(*) AS total_rentals
FROM rentals
GROUP BY category_id;


#8 Find the average rental rate of movies in each language.

SELECT language_id, AVG(rental_rate) AS avg_rental_rate
FROM films
GROUP BY language_id;

#(Joins)9 Display the title of the movie, customer s first name, and last name who rented it.

SELECT films.title, customers.first_name, customers.last_name
FROM rentals
JOIN films ON rentals.film_id = films.film_id
JOIN customers ON rentals.customer_id = customers.customer_id;

#10 Retrieve the names of all actors who have appeared in the film "Gone with the Wind".

SELECT actors.first_name, actors.last_name
FROM actors
JOIN film_actor ON actors.actor_id = film_actor.actor_id
JOIN films ON film_actor.film_id = films.film

#11 Retrieve the customer names along with the total amount they've spent on rentals.

SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM customer c
JOIN rentals r ON c.customer_id = r.customer_id
JOIN payments p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;


#12 List the titles of movies rented by each customer in a particular city (e.g., 'London').
SELECT films.title, customers.first_name, customers.last_name
FROM rentals
JOIN films ON rentals.film_id = films.film_id
JOIN customers ON rentals.customer_id = customers.customer

#(Advanced Joins and GROUP BY) 13 Display the top 5 rented movies along with the number of times they've been rented.
SELECT films.title, COUNT(*) AS rental_count
FROM rentals
JOIN films ON rentals.film_id = films.film_id
GROUP BY films.film_id
ORDER BY rental_count DESC
LIMIT 5;

#14 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT customers.first_name, customers.last_name
FROM customers
JOIN rentals ON customers.customer_id = rentals.customer_id
WHERE rentals.store_id IN (1, 2)
GROUP BY customers.customer

#(Windows Function)1. Rank the customers based on the total amount they've spent on rentals
SELECT customers.first_name, customers.last_name, SUM(payments.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(payments.amount) DESC) AS customer_rank
FROM customers
JOIN payments ON customers.customer_id = payments.customer_id
GROUP BY customers

#2. Calculate the cumulative revenue generated by each film over time.
SELECT
    film.film_id,
    film.title,
    payment.payment_date,
    SUM(payment.amount) OVER (PARTITION BY film.film_id ORDER BY payment.payment_date) AS cumulative_revenue
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
ORDER BY film.film_id, payment.payment_date;

#3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT
    film.length AS film_length,
    film.film_id,
    film.title,
    AVG(DATEDIFF(rental.return_date, rental.rental_date)) AS avg_rental_duration
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date IS NOT NULL
GROUP BY film.length, film.film_id, film.title
ORDER BY film.length, avg_rental_duration DESC;

#4. Identify the top 3 films in each category based on their rental counts
SELECT
    category.name AS category_name,
    film.film_id,
    film.title,
    COUNT(rental.rental_id) AS rental_count,
    RANK() OVER (PARTITION BY category.name ORDER BY COUNT(rental.rental_id) DESC) AS rank_in_category
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name, film.film_id, film.title
HAVING RANK() OVER (PARTITION BY category.name ORDER BY COUNT(rental.rental_id) DESC) <= 3
ORDER BY category_name, rank_in_category;

#5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers
SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS customer_rental_count,
    AVG(COUNT(rental.rental_id)) OVER () AS avg_rental_count,
    COUNT(rental.rental_id) - AVG(COUNT(rental.rental_id)) OVER () AS rental_count_difference
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY rental_count_difference DESC;

#6. Find the monthly revenue trend for the entire rental store over time.
SELECT
    DATE_FORMAT(payment.payment_date, '%Y-%m') AS month,
    SUM(payment.amount) AS monthly_revenue
FROM payment
GROUP BY month
ORDER BY month;

#7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH CustomerSpending AS (
    SELECT
        customer_id,
        SUM(rental_amount) AS total_spending
    FROM
        rentals
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    total_spending
FROM (
    SELECT
        customer_id,
        total_spending,
        NTILE(5) OVER (ORDER BY total_spending DESC) AS spending_quantile
    FROM
        CustomerSpending
) RankedSpending
WHERE
    spending_quantile = 1; -- Top 20%

#8. Calculate the running total of rentals per category, ordered by rental count.
SELECT
    category_id,
    rental_count,
    SUM(rental_count) OVER (PARTITION BY category_id ORDER BY category_id) AS running_total
FROM (
    SELECT
        category_id,
        COUNT(rental_id) AS rental_count
    FROM rentals
    GROUP BY category_id
) AS rental_counts
ORDER BY category_id, rental_count;

#9. Find the films that have been rented less than the average rental count for their respective categories.
SELECT 
    f.film_id,
    f.title,
    f.category_id,
    COUNT(r.rental_id) AS rental_count
FROM films f
JOIN rentals r ON f.film_id = r.film_id
GROUP BY f.film_id, f.title, f.category_id
HAVING COUNT(r.rental_id) < (
    SELECT AVG(rental_count) 
    FROM (
        SELECT 
            f2.category_id, 
            COUNT(r2.rental_id) AS rental_count
        FROM films f2
        JOIN rentals r2 ON f2.film_id = r2.film_id
        GROUP BY f2.category_id
    ) AS avg_rentals
    WHERE avg_rentals.category_id = f.category_id
)
ORDER BY f.category_id, rental_count;

#10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
SELECT 
    DATE_FORMAT(rental_date, '%Y-%m') AS month,
    SUM(f.rental_rate) AS revenue
FROM rentals r
JOIN films f ON r.film_id = f.film_id
GROUP BY month
ORDER BY revenue DESC
LIMIT 5;


/*Normalisation & CTE
1. First Normal Form (1NF):
Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF
ans= In the Sakila database, the film_text table could be a candidate for violating 1NF if, for example:
The description column contains multiple pieces of information in a single field (e.g., a concatenated list of genres, actors, or tags).
Steps to Normalize to 1NF
To normalize the above table to 1NF:
Break Multivalued Columns:
Create separate rows for each actor and each category.
Create Separate Tables:
Break the table into related tables to handle actors and categories in a structured way.
Use Relationships:
Use foreign keys to establish relationships between the tables.*/

/*2. Second Normal Form (2NF):
Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it
ans= Consider the film_actor table in the Sakila database
Primary Key:
The composite key is (actor_id, film_id).
Violation of 2NF:
The columns actor_name and film_title are partially dependent on the primary key:
actor_name depends only on actor_id.
film_title depends only on film_id.
These columns do not depend on the entire composite key.
Steps to Normalize the Table to 2NF
Identify Partial Dependencies:
actor_name depends on actor_id.
film_title depends on film_id.
Remove Partial Dependencies
Create separate tables for actor and film to store the data related to actor_id and film_id, respectively.
Create a Junction Table:
Use the film_actor table as a mapping table to associate actors with films.*/

/*3. Third Normal Form (3NF):
Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.
ans= Consider the payment table in the Sakila database
Primary Key:
payment_id

Violation of 3NF:
The customer_email column is a transitive dependency:
customer_email depends on customer_id.
customer_id depends on payment_id.
Therefore, customer_email indirectly depends on the primary key (payment_id) through customer_id, violating 3NF.
Steps to Normalize the Table to 3NF
Identify Transitive Dependencies:
customer_email depends on customer_id, not directly on payment_id.
Remove Transitive Dependencies:
Create a separate table to store customer details like customer_email.
Link the Tables:
Use customer_id as a foreign key in the payment table to reference the customer table.*/

/*4. Normalization Process:
Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
ans= Let's go through the normalization process of a specific table from the Sakila database.
We'll start from an unnormalized table and normalize it up to Second Normal Form (2NF).
We'll use the film_actor table as an example, which could initially be in an unnormalized form.
Step 1: Unnormalized Table (UNF)
Problems with UNF:
The table contains repeating groups. For example, the film_title is repeated for each actor associated with that film.
The actor_name is stored alongside each actor's entry, causing redundancy
Step 2: First Normal Form (1NF)
Key Changes:
Each actor is now listed in a separate row with a unique film_id and actor_id.
The table now satisfies 1NF, but there's still some redundancy (film title and actor names are repeated).
Step 3: Second Normal Form (2NF)
Identify Partial Dependencies:
The primary key is a composite key: (film_id, actor_id).
film_title depends only on film_id (partial dependency).
actor_name depends only on actor_id (partial dependency).*/

/*5. CTE Basics:
Write a query using a CTE to retrieve the distinct list of actor names and the number of films they  have acted in from the actor and film_actor tables*/
SELECT 
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS num_films
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY num_films DESC;


/*6. CTE with Joins:
Create a CTE that combines information from the film and language tables to display the film title,language name, and rental rate*/
WITH FilmLanguageInfo AS (
    SELECT
        film.film_id,
        film.title AS film_title,
        language.name AS language_name,
        film.rental_rate
    FROM
        film
    JOIN
        language ON film.language_id = language.language_id
)
SELECT
    film_title,
    language_name,
    rental_rate
FROM
    FilmLanguageRental;

/*7 CTE for Aggregation:
Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.*/
WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue
    FROM
        customer c
    JOIN
        payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
)
SELECT
    first_name,
    last_name,
    total_revenue
FROM
    CustomerRevenue
ORDER BY
    total_revenue DESC;


/*8 CTE with Window Functions:
Utilize a CTE with a window function to rank films based on their rental duration from the film table.*/
WITH FilmRentalDurationRank AS (
    SELECT
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_duration_rank
    FROM
        film
)
SELECT
    film_id,
    title,
    rental_duration,
    rental_duration_rank
FROM
    FilmRentalDurationRank
ORDER BY
    rental_duration_rank;

/*9 CTE and Filtering:
Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details*/

WITH CustomerRentalCount AS (
    SELECT
        p.customer_id,
        COUNT(p.payment_id) AS rental_count
    FROM
        payment p
    GROUP BY
        p.customer_id
    HAVING
        COUNT(p.payment_id) > 2
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    crc.rental_count
FROM
    CustomerRentalCount crc
JOIN
    customer c ON crc.customer_id = c.customer_id
ORDER BY
    crc.rental_count DESC;

/*10 CTE for Date Calculations:
Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table.*/
WITH MonthlyRentals AS (
    SELECT
        DATE_FORMAT(r.rental_date, '%Y-%m') AS rental_month,
        COUNT(r.rental_id) AS total_rentals
    FROM
        rental r
    GROUP BY
        rental_month
)
SELECT
    rental_month,
    total_rentals
FROM
    MonthlyRentals
ORDER BY
    rental_month;

/*11 CTE and Self-Join:
Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.*/
WITH ActorPairs AS (
    SELECT
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id
    FROM
        film_actor fa1
    JOIN
        film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE
        fa1.actor_id < fa2.actor_id  -- Avoid duplicate pairs
)
SELECT
    a1.actor_id AS actor1_id,
    a2.actor_id AS actor2_id,
    f.title AS film_title
FROM
    ActorPairs ap
JOIN
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN
    actor a2 ON ap.actor2_id = a2.actor_id
JOIN
    film f ON ap.film_id = f.film_id
ORDER BY
    film_title;

/*2. CTE for Recursive Search:
Implement a recursive CTE to find all employees in the staff table who report to a specific manager,considering the reports_to column*/
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: Start with the specific manager
    SELECT
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM
        staff
    WHERE
        staff_id = <specific_manager_id>  -- Replace with the manager's staff_id

    UNION ALL

    -- Recursive case: Get employees who report to those already selected
    SELECT
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM
        staff s
    JOIN
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT
    staff_id,
    first_name,
    last_name,
    reports_to
FROM
    EmployeeHierarchy
ORDER BY
    first_name, last_name;

