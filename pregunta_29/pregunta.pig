/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

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

str = FOREACH to_date GENERATE ToString(DT, 'yyyy-MM-dd') as (fecha_completa:chararray), ToString(DT, 'MMM') as (nombre_del_mes:chararray), ToString(DT, 'MM') as (mes:chararray), ToString(DT, 'M') as (mes_indv:chararray);

subset_data = FOREACH str GENERATE fecha_completa, REPLACE(nombre_del_mes,'Jan','ene') AS nombre_del_mes, mes, mes_indv;

subset_data = FOREACH subset_data GENERATE fecha_completa, REPLACE(nombre_del_mes,'Apr','abr') AS nombre_del_mes, mes, mes_indv;

subset_data = FOREACH subset_data GENERATE fecha_completa, REPLACE(nombre_del_mes,'Aug','ago') AS nombre_del_mes, mes, mes_indv;

subset_data = FOREACH subset_data GENERATE fecha_completa, REPLACE(nombre_del_mes,'Dec','dic') AS nombre_del_mes, mes, mes_indv;

s = FOREACH subset_data GENERATE fecha_completa, LOWER(nombre_del_mes), mes, mes_indv;

STORE s INTO 'output' USING PigStorage(',');