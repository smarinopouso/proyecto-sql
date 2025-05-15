--2 Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
SELECT f.TITLE
FROM FILM AS F 
WHERE f.RATING='R';

--3 Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
SELECT CONCAT(a.FIRST_NAME,' ',a.LAST_NAME)  
FROM ACTOR AS A 
WHERE a.ACTOR_ID >= 30 AND a.ACTOR_ID <= 40
;

SELECT CONCAT(a.FIRST_NAME,' ',a.LAST_NAME)  
FROM ACTOR AS A 
WHERE a.ACTOR_ID BETWEEN 30 and 40
;
--4 Obtén las películas cuyo idioma coincide con el idioma original
SELECT f.TITLE 
FROM 	FILM AS F
WHERE f.ORIGINAL_LANGUAGE_ID =f.LANGUAGE_ID ;

--5 Ordena las películas por duración de forma ascendente.
SELECT f.TITLE 
FROM FILM AS F 
ORDER BY f.LENGTH ASC ;

--6 Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
SELECT CONCAT(a.FIRST_NAME,' ',a.LAST_NAME)
FROM ACTOR AS A 
WHERE a.LAST_NAME LIKE '%ALLEN%'
 

--7 Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

SELECT FC.CATEGORY_ID, 
COUNT(FC.CATEGORY_ID)
FROM FILM_CATEGORY AS FC
GROUP BY FC.CATEGORY_ID ;

--8 Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
SELECT F.TITLE 
FROM FILM AS F 
WHERE F.RATING = 'PG-13'
OR F.LENGTH > 3;


--9 Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT 
  VARIANCE(REPLACEMENT_COST) AS VARIANZA,
  STDDEV(REPLACEMENT_COST) AS DESVIACION_ESTANDAR
FROM FILM;

--10 Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT MAX(F.LENGTH),
MIN(F.LENGTH)
FROM FILM AS F 

-- 11 Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT P.AMOUNT 
FROM PAYMENT AS P 
ORDER BY PAYMENT_DATE DESC 
OFFSET 3;


--12 Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación

SELECT f.TITLE ,
F.RATING 
FROM FILM AS F 
WHERE f.RATING != 'NC-17' OR F.RATING !='G';

--13 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.


SELECT AVG(LENGTH)	,
F.RATING 
FROM FILM AS F 
GROUP BY F.RATING ;

--14 Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT f.TITLE 
FROM FILM AS F 
WHERE LENGTH > 180;

--15 ¿Cuánto dinero ha generado en total la empresa?

SELECT sum(p.AMOUNT)
FROM PAYMENT AS P ;

--16 Muestra los 10 clientes con mayor valor de id.

SELECT c.CUSTOMER_ID 
FROM CUSTOMER AS C 
ORDER BY c.CUSTOMER_ID DESC ;


--17 Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

SELECT CONCAT(a.FIRST_NAME,' ', a.LAST_NAME) 
FROM ACTOR AS A 
INNER JOIN FILM_ACTOR AS FA 
ON a.ACTOR_ID = FA.ACTOR_ID 
INNER JOIN FILM AS F 
ON FA.FILM_ID =F.FILM_ID 
WHERE F.TITLE  LIKE '%EGG IGBY%' ;




--18 Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT (f.TITLE)
FROM FILM AS F ;

--19 Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film

SELECT f.TITLE 
FROM FILM AS F 
INNER JOIN FILM_CATEGORY AS FC 
ON f.FILM_ID =fc.FILM_ID 
INNER JOIN CATEGORY AS C 
ON fc.CATEGORY_ID =c.CATEGORY_ID 
WHERE c."name" ='Comedy' 
AND f.LENGTH >180;


--20 Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración

SELECT C."name" ,
AVG(F.LENGTH)
FROM FILM_CATEGORY AS FC 
INNER JOIN CATEGORY AS C 
ON FC.CATEGORY_ID = C.CATEGORY_ID 
INNER JOIN FILM AS F 
ON F.FILM_ID =FC.CATEGORY_ID 
GROUP BY C."name"
HAVING AVG(F.LENGTH)>110;

--21 ¿Cuál es la media de duración del alquiler de las películas?

SELECT AVG(F.LENGTH)
FROM FILM AS F ;

--22 Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT CONCAT(A.FIRST_NAME,' ', A.LAST_NAME) 
FROM ACTOR AS A ;

--23 Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT COUNT(R.RENTAL_ID)
FROM RENTAL AS R 
GROUP BY R.RENTAL_DATE 
ORDER BY COUNT(R.RENTAL_DATE) DESC ;


--24 Encuentra las películas con una duración superior al promedio.
 SELECT F.TITLE, F.LENGTH 
 FROM FILM AS F 
 WHERE F.LENGTH > (SELECT AVG(LENGTH) FROM FILM) ;

--25. Averigua el número de alquileres registrados por mes.
 
 SELECT EXTRACT(MONTH FROM R.RENTAL_DATE),
 COUNT(R.RENTAL_ID)
 FROM RENTAL AS R
 GROUP BY EXTRACT(MONTH FROM R.RENTAL_DATE);

 
 --26. Encuentra el promedio, la desviación estándar y varianza del total pagado
 
 SELECT 
 AVG(P.AMOUNT) AS promedio,
 STDDEV(P.AMOUNT) AS desviacionestandar,
 VARIANCE(P.AMOUNT) AS varianza
 FROM PAYMENT AS P ;
 
 
 --27. ¿Qué películas se alquilan por encima del precio medio?
 
 SELECT I.FILM_ID,P.AMOUNT 
 FROM INVENTORY AS I 
 INNER JOIN RENTAL AS R 
 ON I.INVENTORY_ID =R.INVENTORY_ID 
 INNER JOIN PAYMENT AS P 
 ON R.RENTAL_ID =P.RENTAL_ID 
 WHERE P.AMOUNT > (
    SELECT AVG(AMOUNT)
    FROM PAYMENT);
 
 --28. Muestra el id de los actores que hayan participado en más de 40 películas.
 
 
 SELECT FA.ACTOR_ID
 FROM FILM_ACTOR AS FA 
 GROUP BY FA.ACTOR_ID 
 HAVING COUNT(FA.FILM_ID) >40;
 
 
 --29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible
 
 SELECT i.INVENTORY_ID ,
 f.TITLE 
 FROM FILM AS F 
 INNER JOIN INVENTORY AS I 
 ON F.FILM_ID =I.FILM_ID ;

 
 --30. Obtener los actores y el número de películas en las que ha actuado.
 SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME) ,
 COUNT(f.FILM_ID) 
 FROM FILM_ACTOR AS FA 
 INNER JOIN FILM AS F 
 ON fa.FILM_ID=f.FILM_ID 
 INNER JOIN ACTOR AS A 
 ON fa.ACTOR_ID =a.ACTOR_ID 
 GROUP BY a.ACTOR_ID ;
 
 
 --31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados

 SELECT f.TITLE ,	
 CONCAT(a.FIRST_NAME,' ',a.LAST_NAME) 
 FROM FILM AS F LEFT JOIN FILM_ACTOR AS FA 
 ON f.FILM_ID =fa.FILM_ID 
 LEFT JOIN ACTOR AS A 
 ON fa.ACTOR_ID =a.ACTOR_ID ;
 


--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película

SELECT	CONCAT(A.FIRST_NAME,' ',A.LAST_NAME) ,
F.TITLE 
FROM ACTOR AS A LEFT JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID =FA.ACTOR_ID 
LEFT JOIN FILM AS F 
ON FA.FILM_ID =F.FILM_ID ;


--33. Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT F.TITLE ,
R.RENTAL_ID 
FROM FILM AS F INNER JOIN INVENTORY AS I 
ON F.FILM_ID =I.FILM_ID 
INNER JOIN RENTAL AS R 
ON I.INVENTORY_ID =R.INVENTORY_ID ;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros
SELECT C.CUSTOMER_ID, SUM(P.AMOUNT) AS PAGO
FROM CUSTOMER AS C 
INNER JOIN PAYMENT AS P ON C.CUSTOMER_ID =P.CUSTOMER_ID 
GROUP BY C.CUSTOMER_ID
ORDER BY PAGO DESC LIMIT 5 ;


--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT *
FROM ACTOR AS A 
WHERE A.FIRST_NAME='JHONNY';



--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.


SELECT 
    A.FIRST_NAME AS Nombre,
    A.LAST_NAME AS Apellido
FROM ACTOR AS A;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MAX(A.ACTOR_ID) ,MIN(A.ACTOR_ID) 
FROM ACTOR AS A ;


--38. Cuenta cuántos actores hay en la tabla “actor”.

SELECT COUNT(A.ACTOR_ID) 
FROM ACTOR AS A ;


--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT *
FROM ACTOR AS A 
ORDER BY A.FIRST_NAME ASC;

--40. Selecciona las primeras 5 películas de la tabla “film”.

SELECT F.TITLE 
FROM FILM AS F 
ORDER BY F.FILM_ID 
LIMIT 5 ;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

SELECT A.FIRST_NAME ,
COUNT(A.ACTOR_ID)
FROM ACTOR AS A 
GROUP BY A.FIRST_NAME ;

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT R.RENTAL_ID ,C.FIRST_NAME 
FROM RENTAL AS R 
INNER JOIN CUSTOMER AS C ON R.CUSTOMER_ID =C.CUSTOMER_ID ;


--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres

SELECT CONCAT(C.FIRST_NAME,' ',C.LAST_NAME) ,
R.RENTAL_ID 
FROM CUSTOMER AS C LEFT JOIN RENTAL AS R 
ON C.CUSTOMER_ID =R.CUSTOMER_ID ;

 --44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valoresta consulta? ¿Por qué? Deja después de la consulta la contestación
SELECT F.TITLE, C.NAME
FROM FILM AS F
CROSS JOIN CATEGORY AS C;

--El CROSS JOIN genera todas las combinaciones posibles entre las películas y las categorías, lo cual generalmente no tiene mucho sentido si las tablas no están directamente relacionadas

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.

SELECT A.FIRST_NAME, A.LAST_NAME
FROM ACTOR AS A
INNER JOIN FILM_ACTOR AS FA ON A.ACTOR_ID = FA.ACTOR_ID
INNER JOIN FILM AS F ON FA.FILM_ID = F.FILM_ID
INNER JOIN FILM_CATEGORY AS FC ON F.FILM_ID = FC.FILM_ID
INNER JOIN CATEGORY AS C ON FC.CATEGORY_ID = C.CATEGORY_ID
WHERE C.NAME = 'Action';

--46. Encuentra todos los actores que no han participado en películas

SELECT a.FIRST_NAME ,a.LAST_NAME,COUNT(FA.FILM_ID) AS PELIS 
FROM ACTOR AS A 
LEFT JOIN FILM_ACTOR AS FA ON a.ACTOR_ID =fA.ACTOR_ID 
GROUP BY A.FIRST_NAME ,A.LAST_NAME
HAVING COUNT(FA.FILM_ID)=0 ;

--47. Selecciona el nombre de los actores y la cantidad de películas en lasque han participado
SELECT a.FIRST_NAME ,a.LAST_NAME,COUNT(FA.FILM_ID) AS PELIS 
FROM ACTOR AS A 
LEFT JOIN FILM_ACTOR AS FA ON a.ACTOR_ID =fA.ACTOR_ID 
GROUP BY A.FIRST_NAME ,A.LAST_NAME;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado

CREATE VIEW ACTOR_NUM_PELICULAS AS
SELECT a.FIRST_NAME ,a.LAST_NAME,COUNT(FA.FILM_ID) AS PELIS 
FROM ACTOR AS A 
LEFT JOIN FILM_ACTOR AS FA ON a.ACTOR_ID =fA.ACTOR_ID 
GROUP BY A.FIRST_NAME ,A.LAST_NAME;


--49. Calcula el número total de alquileres realizados por cada cliente.

SELECT C.FIRST_NAME ,C.LAST_NAME ,COUNT(R.RENTAL_ID) 
FROM CUSTOMER AS C 
INNER JOIN RENTAL AS R ON C.CUSTOMER_ID =R.CUSTOMER_ID
GROUP BY C.FIRST_NAME ,C.LAST_NAME ;


--50. Calcula la duración total de las películas en la categoría 'Action
SELECT SUM(F.LENGTH)
FROM FILM AS F 
INNER JOIN FILM_CATEGORY AS FC ON F.FILM_ID =FC.FILM_ID ;


--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

CREATE TABLE CLIENTES_RENTAS_TEMPORAL
AS
SELECT SUM(P.AMOUNT)
FROM PAYMENT AS P ;

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces


--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

SELECT F.TITLE ,C.FIRST_NAME ,C.LAST_NAME 
FROM FILM AS F 
INNER JOIN INVENTORY AS I ON F.FILM_ID =I.FILM_ID 
INNER JOIN RENTAL AS R ON I.INVENTORY_ID =R.INVENTORY_ID 
INNER JOIN CUSTOMER AS C ON R.CUSTOMER_ID =C.CUSTOMER_ID 
WHERE C.FIRST_NAME = 'TAMMY'	 AND C.LAST_NAME = 'SANDERS'AND  R.RETURN_DATE IS NULL
ORDER BY C.FIRST_NAME DESC ;


--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.

SELECT DISTINCT A.FIRST_NAME ,A.LAST_NAME 
FROM ACTOR AS A 
INNER JOIN FILM_ACTOR AS FA ON A.ACTOR_ID =FA.ACTOR_ID 
INNER JOIN FILM AS F ON FA.FILM_ID =F.FILM_ID 
INNER JOIN FILM_CATEGORY AS FC ON F.FILM_ID =FC.FILM_ID 
INNER JOIN CATEGORY AS C ON FC.CATEGORY_ID =C.CATEGORY_ID 
WHERE C."name" ='Sci-Fi'
ORDER BY a.LAST_NAME ;


--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.



SELECT DISTINCT A.FIRST_NAME, A.LAST_NAME
FROM ACTOR AS A
INNER JOIN FILM_ACTOR AS FA ON A.ACTOR_ID = FA.ACTOR_ID
INNER JOIN FILM AS F ON FA.FILM_ID = F.FILM_ID
INNER JOIN INVENTORY AS I ON F.FILM_ID = I.FILM_ID
INNER JOIN RENTAL AS R ON I.INVENTORY_ID = R.INVENTORY_ID
WHERE R.RENTAL_DATE > (
    SELECT MIN(R2.RENTAL_DATE)
    FROM RENTAL AS R2
    INNER JOIN INVENTORY AS I2 ON R2.INVENTORY_ID = I2.INVENTORY_ID
    INNER JOIN FILM AS F2 ON I2.FILM_ID = F2.FILM_ID
    WHERE F2.TITLE = 'Spartacus Cheaper'
)
ORDER BY A.LAST_NAME ASC;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

SELECT A.FIRST_NAME, A.LAST_NAME
FROM ACTOR AS A
WHERE A.ACTOR_ID NOT IN (
    SELECT FA.ACTOR_ID
    FROM FILM_ACTOR AS FA
    INNER JOIN FILM AS F2 ON FA.FILM_ID = F2.FILM_ID
    INNER JOIN FILM_CATEGORY AS FC ON F2.FILM_ID = FC.FILM_ID
    INNER JOIN CATEGORY AS C ON FC.CATEGORY_ID = C.CATEGORY_ID
    WHERE C.name = 'Music'
)
ORDER BY A.LAST_NAME ASC;



--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

SELECT DISTINCT f.TITLE 
FROM RENTAL AS R 
INNER JOIN INVENTORY AS I ON r.INVENTORY_ID =i.INVENTORY_ID 
INNER JOIN FILM AS F ON i.FILM_ID =f.FILM_ID 
WHERE (r.RETURN_DATE::date-r.RENTAL_DATE::date)>8 ;


--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

SELECT f.TITLE 
FROM FILM AS F 
INNER JOIN FILM_CATEGORY AS FC ON f.FILM_ID =fc.FILM_ID 
INNER JOIN CATEGORY AS C ON fc.CATEGORY_ID =c.CATEGORY_ID 
WHERE c."name" ='Animation' ;


--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.


SELECT f.TITLE 
FROM FILM AS F 
WHERE f.LENGTH =(
 SELECT F2.LENGTH
    FROM FILM AS F2
    WHERE F2.TITLE = 'Dancing Fever'
)
ORDER BY F.TITLE ASC;

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido
SELECT C.FIRST_NAME, C.LAST_NAME
FROM CUSTOMER AS C
INNER JOIN RENTAL AS R ON C.CUSTOMER_ID = R.CUSTOMER_ID
INNER JOIN INVENTORY AS I ON R.INVENTORY_ID = I.INVENTORY_ID
GROUP BY C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME
HAVING COUNT(DISTINCT I.FILM_ID) >= 7
ORDER BY C.LAST_NAME ASC;

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquile

SELECT C.NAME AS CATEGORIA, COUNT(R.RENTAL_ID) AS TOTAL_ALQUILERES
FROM CATEGORY AS C
INNER JOIN FILM_CATEGORY AS FC ON C.CATEGORY_ID = FC.CATEGORY_ID
INNER JOIN FILM AS F ON FC.FILM_ID = F.FILM_ID
INNER JOIN INVENTORY AS I ON F.FILM_ID = I.FILM_ID
INNER JOIN RENTAL AS R ON I.INVENTORY_ID = R.INVENTORY_ID
GROUP BY C.NAME
ORDER BY TOTAL_ALQUILERES DESC;

--62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT C.NAME AS CATEGORIA, COUNT(F.FILM_ID) AS NUMERO_PELICULAS
FROM CATEGORY AS C
INNER JOIN FILM_CATEGORY AS FC ON C.CATEGORY_ID = FC.CATEGORY_ID
INNER JOIN FILM AS F ON FC.FILM_ID = F.FILM_ID
WHERE F.RELEASE_YEAR = 2006
GROUP BY C.NAME
ORDER BY NUMERO_PELICULAS DESC;


--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT S.STAFF_ID, S.FIRST_NAME, S.LAST_NAME, T.STORE_ID
FROM STAFF AS S
CROSS JOIN STORE AS T
ORDER BY S.STAFF_ID, T.STORE_ID;

--64 Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT 
  C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, 
  COUNT(R.RENTAL_ID) AS TOTAL_ALQUILERES
FROM CUSTOMER AS C
INNER JOIN RENTAL AS R ON C.CUSTOMER_ID = R.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME
ORDER BY TOTAL_ALQUILERES DESC;
--