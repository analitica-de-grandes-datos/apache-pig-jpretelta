/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

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

lista_color = FOREACH datos GENERATE color;

s = FILTER lista_color BY NOT color matches 'b.*';

STORE s INTO 'output' USING PigStorage(',');