/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' AS (letra:chararray, fecha:chararray, valor:int);

datos_ordenados_asc = ORDER datos BY valor ASC;

datos_valor = FOREACH datos_ordenados_asc GENERATE valor;

s = LIMIT datos_valor 5;

STORE s INTO 'output' USING PigStorage(',');