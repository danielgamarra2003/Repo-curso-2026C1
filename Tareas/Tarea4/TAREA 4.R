#TAREA 4  


# CARGA DE DATOS ----------------------------------------------------------

library(nycflights13)
library(tidyverse)

glimpse(flights)

# EJERCICIO 3.2.5 ---------------------------------------------------------


#EJERCICIO1
#En una sola cadena para cada condición, encuentra todos los vuelos que cumplan la condición:

#Ha tenido un retraso en la llegada de dos o más horas
flights |>
  filter(arr_delay >= 120)
    

#Voló a Houston (o IAH/HOU)
flights |>
  filter(dest %in% c("IAH", "HOU"))
             
#Fueron operados por United, American o Delta

flights |>
  filter(carrier %in% c("UA", "AA", "DL"))
    
#Partió en verano (julio, agosto y septiembre)
flights |>
  filter(month %in% c(7, 8, 9))

#Llegó con más de dos horas de retraso pero no salió tarde    
flights |>
  filter(arr_delay >= 120, dep_delay <= 0)

#Me retrasaron al menos una hora, pero recuperaron más de 30 minutos en vuelo
flights |>
  filter(dep_delay >= 60, (dep_delay - arr_delay) > 30)
         




#EJERCICIO 2

#Busca los vuelos con los retrasos de salida más largos

flights |>
  arrange(desc(dep_delay))

#Busca los vuelos que salían más temprano por la mañana, arrange ordena de menor a mayor, asi que arriba de todo estariamos viendo los que salieron mas temprano
flights|>
  arrange(dep_time)



#EJERCICIO 3
#Busca los vuelos más rápidos. (Pista: Intenta incluir un cálculo matemático dentro de tu función.)flights

#VELOCIDAD= DISTANCIA/TIEMPO

flights |>
  mutate(velocidad = distance/ air_time) |>
  arrange(desc(velocidad))



#EJERCICIO 4
#¿Había vuelo todos los días de 2013?
  
flights |>
  distinct(year, month, day)



#EJERCICIO 5
#¿Qué vuelos recorrieron la distancia más larga? ¿Cuál recorrió menos distancia?
  
flights |>
  arrange(desc(distance))

flights |>
  slice_min(distance, n = 1)

#EJERCICIO 6
#¿Importa el orden que usaste y si usas ambos? ¿Por qué o por qué no? Piensa en los resultados y en cuánto trabajo tendrían que hacer las funciones.filter()arrange()

#QUIERO CREER QUE NO SI ES QUE ESCRIBIMOS BIEN E INTERPRETAMOS LO QUE NOS PIDEN, PERO SI PODEMOS ORDENARLO PARA EVITAR TRATAR DE ESPECIFICAR CODIGOS QUE YA HABIAMOS ESCRITO ANTES ES MEJOR, ADEMAS DE QUE SE VE MAS ORDENADO TODO Y PODEMOS TRATAR DE DETECTAR UN ERROR MAS RAPIDO QUE SI TENEMOS CODIGOS REPETIDOS




# EJERCICIOS 19.2.4  ------------------------------------------------------


#EJERCICIO 1
#Se nos olvidó dibujar la relación entre y en la Figura 19.1. ¿Cuál es la relación y cómo debería aparecer en el diagrama? weather airports

glimpse(weather)
glimpse(airports)


weather$origin

airports$faa

#La relacion se da de manera indirecta
#dentro la tabla weather tenemos origin, para saber el clima que hubo para cierto vuelo, analizamos el origen de este, para los vuelos el clima es importante ya que podria registrarse demoras en caso haya mal clima para volar
#asu vez dentro de los airports, encontramos el codigo del aeropuerto esto nos podria indicar el clima de que hubo en este aeropuerto
#de esta manera podriamos crear una relacion entre estos, aunque es de manera indirecta, ya que lo que los une a ambos, es que tienen relacion con la key primary de flights, en el origen de los vuelos




#EJERCICIO 2
#weather solo contiene información sobre los tres aeropuertos de origen en Nueva York. Si contuviera registros meteorológicos de todos los aeropuertos de EE. UU., ¿qué conexión adicional haría?flights


#Tendria conexion con "dest" de la tabla flights, ya que podriamos ver el clima de la llegada de los vuelos que salen de new york



#EJERCICIO 3
#Las variables , , , , y casi forman una clave compuesta para , pero hay una hora que tiene observaciones duplicadas. ¿Puedes averiguar qué tiene de especial esa hora?
#year,  month,  day,  hour,  origin, /   weather


#BUSCAMOS LOS DATOS DUPLICADOS EN NUESTRAS OBSERVACIONES, encontramos que ne el 3/11/2013 estan las observaciones duplicadas

weather |>
  count(year, month, day, hour, origin) |>
  filter(n > 1)

#estuve investigando y en esa fecha y ese horario es cuando se produce el cambio de horario de verano en new york, los relojes se atrasan 1 hora, por ende tiene algo de sentido que se hayan duplicado los datos, ya que se registraron 2 veces 



#EJERCICIO 4
#Sabemos que algunos días del año son especiales y menos gente de lo habitual vuela en el los (por ejemplo, Nochebuena y el día de Navidad). ¿Cómo podrías representar esos datos como un data frame? ¿Cuál sería la clave primaria? ¿Cómo se conectaría con los dataframes existentes?
  
#data frame
nochebuena <- flights|>
  filter( day == 24, month == 12)

nrow(nochebuena)

vuelos_en_navidad <- flights |>
  filter( day == 25, month == 12 )

nrow(vuelos_en_navidad)

#crearia un tabla secundaria para fechas especiales, que conecte con days y month para poder filtrar y buscar fechas especificas de manera directa



#EJERCICIO 5
#Dibuja un diagrama que ilustre las conexiones entre los , , y los marcos de datos en el paquete de Lahman. Dibujamos otro diagrama que muestre la relación entre , , . ¿Cómo caracterizarías la relación entre los , , y los marcos de datos?

#Batting People Salaries 
#People Managers Awards Managers 
#Batting Pitching Fielding


#NO SE ME OCURRE NADA TODAVIA


# EJERCICIOS 19.3.4 -------------------------------------------------------

#EJERCICIO 1
#Busca las 48 horas (a lo largo de todo el año) que tienen los mayores retrasos. Haz contraste con los datos. ¿Ves algún patrón?weather


"48_horas_con_mayor_retraso" <- flights |>
  group_by(year, month, day, hour, origin) |>  #agrupo en fecha para que se haga mas facil reconocer
  summarize( #me hace un resumen de la tabla
    delay_prom = mean(dep_delay, na.rm = TRUE), #nueva variable que es el promedio de los retrasos de salida ignorando los valores faltantes NA
    .groups = "drop") |>
  arrange(desc(delay_prom)) |>  #que me los ordende en orden descendente
  slice(1:48) |> #solo quiero las filas del 1 al 48
  left_join(weather, by = c("year", "month", "day", "hour", "origin"))

#EJERCICIO 2
#Imagina que has encontrado los 10 destinos más populares usando este código:

top_dest <- flights |>
  count(dest, sort = TRUE) |>
  head(10)
#con el dato fligths2 nos da error ya que no es una varible de nuestra tabla, asi que usamos flights
#¿Cómo puedes encontrar todos los vuelos a esos destinos?


flights |>
  semi_join(top_dest, by = "dest")
  
#estoy pidiendo que de la tabla de vuelos, me devuelva los vuelos que su destino coincida con el top_dest que habiamos creado previamente


#EJERCICIO 3
#¿Cada vuelo de salida tiene datos meteorológicos correspondientes para esa hora?

flights |>
  left_join(weather, 
            by = c("year", "month", "day", "hour", "origin")) |>
  summarize(todos_tienen_clima = all(!is.na(temp)))



#EJERCICIO 4
#¿Qué tienen en común los números de cola que no tienen un registro coincidente? (Pista: una variable explica el ~90% de los problemas.)planes

#Podria ser que los aviones que no tengan numero de cola o informacion incompleta, pertenezcan a una misma aerolinea, si podriamos encontrar una relacion entre ello, podriamos decir que la variable carrier es una que explica el problema


flights |>
    select(tailnum)

planes |>
  select(tailnum)


#EJERCICIO 5
#Añade una columna que liste todos los que han volado ese avión. Podrías esperar que haya una relación implícita entre avión y aerolínea, porque cada avión es operado por una sola aerolínea. Confirma o rechaza esta hipótesis usando las herramientas que has aprendido en capítulos anteriores.planescarrier



planes_carrier <- flights |>
  filter(!is.na(tailnum)) |>   #filtrar los vuelos que no tinenn falta numero de avion
  distinct(tailnum, carrier)   #


