/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

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

lista_fechas = FOREACH datos GENERATE fecha as fechas;

to_date = FOREACH lista_fechas GENERATE ToDate(fechas,'yyyy-MM-dd') as (DT:DateTime);

str = FOREACH to_date GENERATE ToString(DT, 'yyyy') as cumple;

group_by = GROUP str BY cumple;

total_por_cumple = FOREACH group_by GENERATE group, COUNT(str);

STORE total_por_cumple INTO 'output' USING PigStorage(',');