/*

1- Procedimiento almacenado que devuelva el título de las diez primeras películas

*/

/*

Aquí tendríamos dos opciones para crear el procedimiento almacenado, aunque no creo que para el segundo haga falta un bucle

*/

USE sakila;

DELIMETER //

CREATE PROCEDURE diez_primeros_actores()
BEGIN

    SELECT first_name
    FROM actor
    WHERE actor_id BETWEEN 1 AND 10;

END

//

CALL diez_primeros_actores();





USE sakila;

DELIMITER //

CREATE PROCEDURE diez_primeros_actores2()
BEGIN

    SELECT first_name
    FROM actor
    WHERE actor_id
    ORDER BY actor_id
    LIMIT 10;

END

//

DELIMITER;

CALL diez_primeros_actores2();


USE sakila;

CREATE PROCEDURE diez_primeros_actores3()
REPEAT

    SET x = x + 1;

    SELECT first_name
    FROM actor 

UNTIL x = 10 END REPEAT;

/*

Procedimiento almacenado que, dado un número de actores cuyo apellido comienza por "L", nos muestre el mensaje "Más de 15 actores" o
"Menos de 15 actores" según sea el caso

*/

CREATE PROCEDURE sakila.nombreActor(IN codigo INT, OUT nombre VARCHAR(45))
BEGIN
SELECT first_name
INTO nombre
FROM actor
WHERE actor_id = codigo;
END

