/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/
datos = LOAD 'data.csv' USING PigStorage(',') AS (
        id:int, 
        nombre:chararray, 
        apellido:chararray,
        fecha:chararray,
        color:chararray,
        codigo:int
);

lista_datos = FOREACH datos GENERATE nombre, color;

s = FILTER lista_datos BY color == 'blue' AND nombre MATCHES 'Z.*';

format_output = FOREACH s GENERATE CONCAT(nombre, ' ', color);

STORE format_output INTO 'output' USING PigStorage(',');