/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' AS (letra:chararray, letras:bag{});

letras_tokenizadas = FOREACH datos GENERATE FLATTEN(letras) AS letra_individual;

letras_agrupadas = GROUP letras_tokenizadas BY letra_individual;

total_letras = FOREACH letras_agrupadas GENERATE group, COUNT(letras_tokenizadas);

STORE total_letras INTO 'output' USING PigStorage(',');