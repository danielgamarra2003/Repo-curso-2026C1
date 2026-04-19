
#ASIGNACION DE UN VALOR A UNA VARIABLES

encuestado_id <-  1045
ingreso <- 350000.50     
miembros_hogar <- 4L     
estado <- "Ocupado"      
busca_trabajo <- FALSE



#FUNCION PARA IDENTIFICAR EL TIPO DE VARIABLE

class(ingreso)
class(busca_trabajo)



#DIFERENCIAS ENTRE NUMERIC E INTEGER EN LA PRACTICA

horas_trabajadas <- 40.5   # Puede tener decimales
edad_anios <- 28L          # Numeros enteros


class(horas_trabajadas)
class(edad_anios)



#CADENAS DE TEXTO

sector_actividad <- "Comercio"
categoria_ocupacional <- 'Cuentapropista'



#Funciones útiles: nchar(), grepl(), paste().

# Unir textos para un reporte

paste("Sector:", sector_actividad, "-", categoria_ocupacional) 


# Buscar un patrón (¿Contiene la palabra "propia"?)

grepl("propia", "Cuenta propia con local") # Devuelve: TRUE



salario_mensual <- 45000
salario_anual <- salario_mensual * 13 # Incluye aguinaldo


#Operadores de comparación (==, >, <).

es_mayor_edad <- edad_anios >= 18
es_desocupado <- estado == "Desocupado"


#Operadores lógicos (& AND, | OR, ! NOT).
# Verificamos si pertenece a la Población Económicamente Activa (PEA)
es_pea <- (estado == "Ocupado" | estado == "Desocupado") & edad_anios >= 16


#Estructura básica de if.
#comando que evalua la condicion dentro y con print, nos responde en caso de ser true la afirmarcion lo que escribamos dentro

if (salario_mensual < 200000) {
  print("Por debajo del salario mínimo")
}


#Añadiendo else if y else para clasificar un ingreso en ambos casos(TRUE O FALSE)

if (salario_mensual > 800000) {
  decil <- "Alto"
} else if (salario_mensual >= 300000) {
  decil <- "Medio"
} else {
  decil <- "Bajo"
}




#Bucles - While Loop

#Iteración mientras se cumpla una condición (Simulación de búsqueda).

meses_busqueda <- 0

while (meses_busqueda < 3) {
  print(paste("Mes", meses_busqueda, ": Buscando empleo..."))
  meses_busqueda <- meses_busqueda + 1
}



#Uso de break para salir del bucle prematuramente.

# Simulación: encuentra trabajo al mes 2
meses_busqueda <- 0
while (TRUE) {
  meses_busqueda <- meses_busqueda + 1
  if (meses_busqueda == 2) {
    print("¡Empleo encontrado!")
    break 
  }
}


## Vector con salarios horarios
salarios_hora <- c(1500, 2200, 1800, 3100)
for (salario in salarios_hora) {
  print(salario * 8) # Imprime el salario por jornada de 8 horas
}


#Iteración usando índices (muy común en limpieza de datos).

for (i in 1:length(salarios_hora)) {
  # Aplicar un aumento del 10% a cada elemento
  salarios_hora[i] <- salarios_hora[i] * 1.10 
}



#VECTORES Y LISTAS

#Vectores: Elementos del mismo tipo (ideal para columnas de variables).
edades_hogar <- c(45, 42, 16, 12)
promedio_edad <- mean(edades_hogar)


#Listas: Contenedores heterogéneos (ideal para perfiles completos).
jefe_hogar <- list(
  id = 101,
  nombre = "Carlos",
  edades_familia = edades_hogar,
  es_propietario = TRUE
)


#MATRICES Y ARRAYS

datos_transicion <- c(80, 20, 15, 85)
matriz_transicion <- matrix(datos_transicion, nrow = 2, byrow = TRUE)

#ESTOY CONVIRTIENDO LO DATOS DEL VECTOR datos_transicion, en una matriz de 2 filas, los datos se ordenan mediante las fila


#ESTRUCTURA PARA N DIMENSIONALES
panel_laboral <- array(1:12, dim = c(2, 2, 3))
panel_laboral


#CREACION DE UN BASE DE DATOS PEQUEÑA

microdatos <- data.frame(
  id_persona = c(1, 2, 3),
  edad = c(34, 19, 52),
  ingreso = c(450000, 0, 780000),
  trabajo_semana_pasada = c(TRUE, FALSE, TRUE)
)


str(microdatos)  #inspeccion de datos
summary(microdatos)   #resumen estadsitico de los datos


microdatos$ingreso   #extraigo el vector ingreso de los datos


#FACTORES


vector_estados <- c("Ocupado", "Desocupado", "Inactivo", "Ocupado")

estado_factor <- factor(vector_estados)

estado_factor

levels(estado_factor)



nivel_edu <- factor(c("Secundario", "Universitario", "Primario"),
                    levels = c("Primario", "Secundario", "Universitario"),
                    ordered = TRUE)

levels(nivel_edu)
#estoy forzando el orden de los levels, ya que le estoy dando su estructura 