USE SAKILA_SNOWFLAKE;

INSERT INTO sakila_snowflake.fact_rental 
(rental_id, rental_last_update, customer_key, staff_key, film_key, store_key, rental_date_key,
	return_date_key, count_returns, count_rentals, rental_duration, dollar_amount) 
(SELECT 
	r.rental_id AS rental_id, r.last_update AS rental_last_update,
    c.customer_key AS customer_key, st.staff_key AS staff_key,
    f.film_key AS film_key, s.store_key AS store_key,
    ssd.date_id AS rental_date_key,
    ssd2.date_id AS return_date_key,
    CASE WHEN r.return_date IS NOT NULL THEN 1 ELSE 0 END AS count_returns,
    CASE WHEN r.rental_date IS NOT NULL THEN 1 ELSE 0 END AS count_rentals,
    fi.rental_duration AS rental_duration,
    CASE WHEN r.return_date IS NOT NULL THEN
		((f.film_rental_rate/f.film_rental_duration) * DATEDIFF(r.return_date, r.rental_date)) 
        ELSE 0 END AS dollar_amount
        
FROM sakila.rental AS r
LEFT JOIN sakila.inventory AS i ON i.inventory_id = r.inventory_id
LEFT JOIN sakila.payment AS p ON p.rental_id = r.rental_id
LEFT JOIN sakila_snowflake.dim_customer AS c ON c.customer_id = r.customer_id
LEFT JOIN sakila_snowflake.dim_store AS s ON i.store_id = s.store_id
LEFT JOIN sakila_snowflake.dim_staff AS st ON st.staff_id = r.staff_id
LEFT JOIN sakila_snowflake.dim_film AS f ON f.film_id = i.film_id
LEFT JOIN sakila.film AS fi ON fi.film_id = f.film_id
LEFT JOIN sakila_snowflake.dim_date AS ssd ON DATE(ssd.date) = DATE(r.rental_date)
LEFT JOIN sakila_snowflake.dim_date AS ssd2 ON DATE(ssd2.date) = DATE(r.return_date))