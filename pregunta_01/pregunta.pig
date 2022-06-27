/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
letras = LOAD 'data.tsv' AS (letra:chararray);

letras_tokenizadas = FOREACH letras GENERATE FLATTEN(TOKENIZE(letra)) AS letra_individual;

letras_agrupadas = GROUP letras_tokenizadas BY letra_individual;

total_letras = FOREACH letras_agrupadas GENERATE group, COUNT(letras_tokenizadas);

STORE total_letras INTO 'output' USING PigStorage(',');