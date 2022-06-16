/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' AS (letra:chararray, letras:bag{}, pares:map[]);

col = FOREACH datos GENERATE FLATTEN(letras) AS letras_aplanadas, FLATTEN(pares) as pares_aplanados;

subset_datos_tupla = FOREACH col GENERATE(letras_aplanadas, pares_aplanados) as tupla_datos;

agrupados = GROUP subset_datos_tupla BY tupla_datos;

contador_pares = FOREACH agrupados GENERATE group, COUNT(subset_datos_tupla);

STORE contador_pares INTO 'output' USING PigStorage(',');