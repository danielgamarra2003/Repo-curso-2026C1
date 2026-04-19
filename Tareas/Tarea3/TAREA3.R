
library(tidyverse)
library(palmerpenguins)
?penguins

# EJERCICIOS 1.2.5 --------------------------------------------------------

#EJERCICIO 1
#¿Cuántas filas hay? ¿Cuántas columnas?penguins

#344 filas y 8 columnas



#EJERRCICIO 2
#¿Qué describe la variable en el marco de datos? Lee la ayuda para averiguarlo.bill_depth_mmpenguins?penguins

#describe la profundidad del pico (en milimetros) de los pinguinos



#EJERCICIO 3
#Haz un gráfico de dispersión de vs. Es decir, hacer un diagrama de dispersión con en el eje y y en el eje x. Describe la relación entre estas dos variables. bill_depth_mm bill_length_mm 
  

#vemos una relacion en el siguiente codigo que nos indica que a mayor profundidad del pico (en mm), la longitud(en mm) de este cae
ggplot( data = penguins,
        mapping = aes(x = bill_depth_mm, y = bill_length_mm)
) +
  geom_point(mapping = aes( color = species)) +
  geom_smooth(method = "lm")


#ahora en el siguiente codigo en el que separamos por especie, podemos ver que que ocurre la relacion de que a mayor profundidad del pico, aumenta su longitud
ggplot( data = penguins,
        mapping = aes(x = bill_depth_mm, y = bill_length_mm)
) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth(aes(color = species), method = "lm")

#podemos sacar una pequeña conclusio que capaz hay una distincion en el largo de los pico de los pinguinos por especie que hace que nuestra primera linea de tendencia nos de negativa


#EJERCICIO 4
#¿Qué ocurre si haces un gráfico de dispersión de vs. ? ¿Cuál podría ser una mejor opción de geom? speciesbill_depth_mm

ggplot( data = penguins,
        mapping = aes(x = species, y = bill_depth_mm)
)  +
  geom_point()
#en el codigo, la tabla se nos da como columnas en el que los datos se puede superponer y podriamos no estar oviando datos que nos serian utiles

ggplot( data = penguins,
        mapping = aes(x = species, y = bill_depth_mm)
)  +
  geom_jitter( mapping = aes(color = species))

#para mi el geom_jitter es una muy buena forma de usar el geom, ya que no estoy superponiendo los datos como en la anterior, mas bien los estoy tratando de dispersar mejor


#EJERCICIO 5
#¿Por qué lo siguiente da un error y cómo lo solucionarías?

ggplot(data = penguins) + 
  geom_point()

#nos da error pq simplemente estamos indicandole el data set que usara ggplot, mas bien no le estamos especificando que variables vamos a utilizar, por eso debemos de especifcarles que variables vamos usar como en los codigos anteriores

ggplot( data = penguins,
        mapping = aes(x = bill_depth_mm, y = bill_length_mm)  #ACA ESTA LA SOLUCION
) +
  geom_point(mapping = aes( color = species)) +
  geom_smooth(method = "lm")


#EJERCICIO 6
#¿Qué hace el argumento na.rm en geom_poin() ? ¿Cuál es el valor predeterminado del argumento? Crea un diagrama de dispersión donde uses con éxito este conjunto de argumentos como na.rm geom_point() TRUE


#geom_point(na.rm)  ignora los valores faltantes antes de graficar nuestra tabla
#el valor predetermindo es FALSE, cuando lo dejamos asi, nos avisa si es que hay valores faltantes o no al graficar

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point(na.rm = TRUE )



#EJERCICIO 7 
#Añade el siguiente pie de foto al gráfico que hiciste en el ejercicio anterior: "Los datos provienen del paquete de palmerpenguins." Pista: Echa un vistazo a la documentación de .labs()


library(ggplot2)


ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point(na.rm = TRUE ) +
  labs(caption = "Los datos provienen del paquete de palmerpenguins")






#EJERCICIO 8
#Recrea la siguiente visualización. ¿A qué estética debería asignarse? ¿Y debería mapearse a nivel global o a nivel geom?


ggplot( data = penguins,
        aes( x = flipper_length_mm, y = body_mass_g, color = bill_depth_mm)
        ) +
  geom_point() +
  geom_smooth()

# bill_length_mm debe asignarse a color, y se debe mapear en el global


#EJERCICIO 9
#Ejecuta este código en tu cabeza y predice cómo será la salida. Luego, ejecuta el código en R y revisa tus predicciones.

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

#Se va a venir ejecutando como codigo anterior, pero color = island hara que se clasifiquen segun la isla donde fueron registrados los pinguinos
#se = FALSE ?

#simplemente el se=false, era quitar el error estandar osea la banda alrededor de las lineas de tendencia, dejando solo esta


#EJERCICIO 10
#¿Estos dos gráficos se verán diferentes? ¿Por qué o por qué no?


ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()



ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )


#NO DEBERIAN VERSE DIFERENTES, EL TEMA ES QUE ESTAMOS CAMBIANDO LAS CAPAS DEL GRAFICO O EL ORDEN EL CUAL VAMOS CREANDO, AVECES NOS PUEDE SERVIR MAS UNO, PERO EN OTROS COMO IR AÑADIENDO OTROS DATASETS AL QUE YA TENIAMOS NOS SIRVE EL SEGUNDO, ASI VAMOS SEPARANDO TODO PARA EVITAR ERRORES GLOBALES Y SABER DETECTAR DONDE ESTAN LOS ERRORES PUNTUALES




# EJERCICIOS 1.4.3 --------------------------------------------------------

#EJERCICIO 1
#Haz un gráfico de barras de , donde asignas a la estética. ¿En qué se diferencia esta trama?

ggplot( penguins,
        aes(x= species))+
  geom_bar()

#EL USAR X O Y PARA LA VARIABLE INDICA SI SERA HORIZONTAL O VERTICAL LA TABLA, YA QUE GEOM_VAR HACE EL CONTEO DE LAS OBSERVACIONES Y NO NECESITA OTRA VARIABLES

#EJERCICIO 2
#¿En qué se diferencian las dos siguientes tramas? ¿Qué estética, o , es más útil para cambiar el color de las barras?colorfill


ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")


ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "lightblue")

#LA MAS UTIL ES FILL PARA CAMBIAR EL COLOR DE LAS BARRAS, YA QUE PINTA EL RELLENO DE LAS BARRAS, Y SE HACE MAS NOTORIO LAS BARRAS, EN CAMBIO EL OTRO SOLO PINTA EL CONTORNO


#EJERCICIO 3
#¿Qué hace el argumento bins en geom_histogram() ?

# El argumento bins en geom_histogram() define la división entre el rango
#de datos, por ejemplo si hay 20 bins los datos se agrupan en 20 cajas iguales.




#EJERCICIO 4

#Haz un histograma de la variable en el conjunto de datos que está disponible cuando cargues el paquete de tidyverse. Experimenta con diferentes anchos de contenedor. ¿Qué ancho de contenedor revela los patrones más interesantes?  carat  diamonds


?diamonds
diamonds

ggplot( diamonds,
        aes(x = carat))+
  geom_histogram( binwidth = 1)

ggplot( diamonds,
        aes(x = carat))+
  geom_histogram( binwidth = 0.5)

ggplot( diamonds,
        aes(x = carat))+
  geom_histogram( binwidth = 2)

#el grafico con un binwidth =0.5 se me hace el que revela patrones mas interesantes



# EJERCICIO 1.5.5 ---------------------------------------------------------

#EJERCICIO 1
#El marco de datos que viene incluido con el paquete ggplot2 contiene 234 observaciones recogidas por la Agencia de Protección Ambiental de EE. UU. sobre 38 modelos de coches. ¿Qué variables en son categóricas? ¿Qué variables son numéricas? (Pista: Escribe para leer la documentación del conjunto de datos.) ¿Cómo puedes ver esta información cuando corres?

?mpg
str(mpg)

#CATEGORICAS: class, fl, drv, trans, model, manufacturer
#NUMERICAS: displ, year, cyl, cty, hwy

#EJERCICIO 2
#Haz un diagrama de dispersión de hwy vs displ. usando el data frame. A continuación, mapea una tercera variable numérica a , luego , luego ambos y , y luego . ¿Cómo se comportan estas estéticas de forma diferente para variables categóricas frente a numéricas?

#hwy  displ  mpg  color  size  color  size  shape

ggplot(mpg, aes(x=hwy, y=displ))+
  geom_point()


ggplot(mpg, aes(x=hwy, y=displ, color = cty))+
         geom_point()
  
ggplot(mpg, aes(x=hwy, y = displ, size = cty))+
  geom_point()

ggplot(mpg, aes(x=hwy, y = displ, color= cty, size = cty) )+
  geom_point()

#las variables categoricas generan distinciones de colores entre las variables, mientras que las numericas nos hacen una distencion del dato especifico, en este caso agrandan mas ciertas variables, nos ayudan ams que nada para poder identificar y poder calsificar mejor las observaciones


#EJERCICIO 3
#En el diagrama de dispersión de vs. , ¿qué ocurre si mapeas una tercera variable a ?hwydispllinewidth

?linewidth
ggplot(mpg, aes(x=hwy, y = displ, linewidth = cty) )+
  geom_point()

#linewidth controla el grosor de las lineas, en un grafico de dispersion, pierde sentido usarlo pq no tiene efecto en los puntos, salvo que hiciese una linea de tendencia


#EJERCICIO 4

#LE ESTOY DANDO MAS PODER DE CONTROL A ESA VARIABLE SOBRE LA PRESENTACION DEL GRAFICO, COMO EN EL EJERCICIO 2, LA VARIABLES CTY ME DEFINIA EL COLOR Y EL ANCHO DE LAS OBSERVACIONES QUE RESPONDIAN A MI GRAFICO



#EJERCICIO 5

#Haz un diagrama de dispersión de vs. y colorean los puntos por . ¿Qué revela añadir coloración por especie sobre la relación entre estas dos variables? ¿Y qué hay del facetado por ?  bill_depth_mm   bill_length_mm  species  species


ggplot(penguins, aes(x=bill_depth_mm, y = bill_length_mm, color = species ))+
  geom_point()

#nos ayuda da darnos cuanta que como varian las longitudes y profundides del pico varian por especie, haciendo que no hagamos generalizaciones



ggplot(penguins, aes(x=bill_depth_mm, y = bill_length_mm ))+
  geom_point()+
  facet_wrap(~ species)

#nos separa mejor el grafico en partes, asi no tenemos todos los datos juntos en un solo grafico

#EJERCICIO 6
#¿Por qué lo siguiente da dos leyendas separadas? ¿Cómo lo arreglarías para combinar las dos leyendas?


ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() 
  #labs( color = "Species")   borramos este codigo

#porque estoy cambiando el nombre de la variables color de species a Species, esa mayuscula esta creando una distincion entre ellas, por ende R entiende que son 2 comandos distintos, se soluciona eliminando labs, para que no sean difirentes las leyendas, y R interprete que son lo mismo

#EJERCICIO 7
#Crea los dos siguientes gráficos de barras apiladas. ¿Qué pregunta puedes responder con la primera? ¿Qué pregunta puedes responder con la segunda?

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

#EL PORCENTAJE DE LAS ESPECIES DE PINGUINOS QUE HABITAN EN LAS 3 ISLAS DE LAS QUE OBTUVIMO LOS DATOS, COMO SE DISTRIBUYEN EN CADA ISLA

ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")

#ES PRACTICAMENTE LOS MISMO, SOLO QUE AHORA LO VEO DESDE OTRO ENFOQUE, OTRO EJE DE REFERNCIA. ESTOY VIENDO DIRECTAMENTE LAS ESPECIES Y VEO QUE PORCENTAJE DE ESTE VIVEN EN CADA ISLA