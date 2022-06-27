/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.csv' USING PigStorage(',') AS (
        id:int, 
        nombre:chararray, 
        apellido:chararray,
        fecha:chararray,
        color:chararray,
        codigo:int
);

cumple = FOREACH datos GENERATE REGEX_EXTRACT(fecha,'(.*)-(.*)-(.*)', 2);

STORE cumple INTO 'output' USING PigStorage(',');