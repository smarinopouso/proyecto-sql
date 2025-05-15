# Proyecto SQL – Análisis de Base de Datos de Películas

## Descripción
Este proyecto consiste en el análisis de una base de datos de una empresa de alquiler de películas. El objetivo es responder a una serie de preguntas de negocio utilizando consultas SQL para explorar los datos, generar informes y detectar patrones relevantes sobre películas, clientes, actores y tiendas.

---

## Pasos Seguidos

1. **Exploración inicial de las tablas**:
   - Identificación de tablas principales: `FILM`, `ACTOR`, `CATEGORY`, `RENTAL`, `CUSTOMER`, `STORE`, etc.
   - Revisión de relaciones: claves foráneas entre películas, categorías, alquileres y clientes.

2. **Consultas de análisis**:
   - Búsqueda de actores y películas (por nombre, categoría, duración, etc.).
   - Identificación de películas no alquiladas o con bajo rendimiento.
   - Agrupaciones por cliente, tienda o categoría para análisis de rendimiento.
   - Análisis de comportamiento de los clientes (frecuencia de alquileres, películas no devueltas, etc.).
   - Evaluación del coste de reemplazo de películas y su variabilidad.

3. **Creación de estructuras auxiliares**:
   - Vistas: para almacenar resultados reutilizables, como el número de películas por actor.
   - Tablas temporales: para análisis más específicos como películas alquiladas más de 10 veces.

4. **Prevención de fraudes o amenazas**:
   - Análisis de patrones sospechosos (por ejemplo, correos maliciosos fuera del entorno SQL, abordados en comunicación interna).

---

## Informe de Análisis


 Principales Resultados

- **Clientes activos**: se identificaron los clientes que más alquilaron (más de 7 películas) y aquellos que alquilaron películas sin devolver.
- **Rendimiento por categoría**: las categorías con mayor número de alquileres fueron analizadas, destacando cuáles tienen mayor impacto en ingresos.
- **Costes de reemplazo**: se analizó la variabilidad del `REPLACEMENT_COST`, observando una dispersión significativa que puede influir en la estrategia de inventario.
- **Actores y participación**: se identificaron los actores que nunca participaron en películas, así como los que no estuvieron en películas de categorías específicas como ‘Music’.
- **Películas duplicadas por duración**: se detectaron películas con la misma duración que ‘Dancing Fever’, lo que puede sugerir patrones de producción.

---
