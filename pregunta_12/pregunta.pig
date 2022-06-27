/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

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

lista_apellidos = FOREACH datos GENERATE (apellido);

s = FILTER lista_apellidos BY (apellido>'D') AND (apellido<'L');

STORE s INTO 'output' USING PigStorage(',');