/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.csv' USING PigStorage(',') AS (
        id:int, 
        nombre:chararray, 
        apellido:chararray,
        fecha: chararray,
        color: chararray,
        codigo:int
);

col = FOREACH datos GENERATE apellido;

group_by_apellido = GROUP col BY apellido;

longitud_apellido = FOREACH group_by_apellido GENERATE group as apellido, SIZE(group) as longitud;

order_by = ORDER longitud_apellido BY longitud DESC, apellido;

s = LIMIT order_by 5; 

STORE s INTO 'output' USING PigStorage(',');