
--7.Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuent
SELECT F.RATING, 
       COUNT(F.FILM_ID) AS total_peliculas
FROM FILM AS F
GROUP BY F.RATING;

-- 11 Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT P.AMOUNT 
FROM PAYMENT AS P 
ORDER BY PAYMENT_DATE DESC 
OFFSET 2 LIMIT 1;
--12 Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación
SELECT F.TITLE, F.RATING
FROM FILM AS F
WHERE F.RATING != 'NC-17' AND F.RATING != 'G';
--20 Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración
SELECT C."name", 
       AVG(F.LENGTH) AS avg_duration
FROM FILM_CATEGORY AS FC
INNER JOIN CATEGORY AS C ON FC.CATEGORY_ID = C.CATEGORY_ID
INNER JOIN FILM AS F ON F.FILM_ID = FC.FILM_ID
GROUP BY C."name"
HAVING AVG(F.LENGTH) > 110;
--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT *
FROM ACTOR AS A
WHERE A.FIRST_NAME = 'JOHNNY';

--50. Calcula la duración total de las películas en la categoría 'Action
SELECT SUM(F.LENGTH) AS total_duration
FROM FILM AS F
INNER JOIN FILM_CATEGORY AS FC ON F.FILM_ID = FC.FILM_ID
INNER JOIN CATEGORY AS C ON FC.CATEGORY_ID = C.CATEGORY_ID
WHERE C."name" = 'Action';

52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces

CREATE TEMP TABLE peliculas_alquiladas AS
SELECT F.FILM_ID, F.TITLE, COUNT(R.RENTAL_ID) AS total_alquileres
FROM FILM AS F
INNER JOIN INVENTORY AS I ON F.FILM_ID = I.FILM_ID
INNER JOIN RENTAL AS R ON I.INVENTORY_ID = R.INVENTORY_ID
GROUP BY F.FILM_ID, F.TITLE
HAVING COUNT(R.RENTAL_ID) >= 10;