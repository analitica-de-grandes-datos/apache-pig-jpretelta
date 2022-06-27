/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' AS (letra:chararray, letras:bag{}, pares:map[]);

datos_tokenizados = FOREACH datos GENERATE letra, COUNT_STAR(letras), SIZE(pares);

datos_ordenados = ORDER datos_tokenizados BY $0, $1, $2;

STORE datos_ordenados INTO 'output' USING PigStorage(',');