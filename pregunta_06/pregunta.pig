/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' AS (letra:chararray, letras:bag{}, pares:map[]);

pares_tokenizadas_aplanados = FOREACH datos GENERATE FLATTEN(pares) AS pares_individuales;

pares_tokenizados = FOREACH pares_tokenizadas_aplanados GENERATE FLATTEN(TOKENIZE(pares_individuales,',')) AS claves_individuales;

pares_agrupados = GROUP pares_tokenizados BY claves_individuales;

total_claves_individuales = FOREACH pares_agrupados GENERATE group, COUNT(pares_tokenizados);

STORE total_claves_individuales INTO 'output' USING PigStorage(',');