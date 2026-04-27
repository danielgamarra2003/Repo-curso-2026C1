library(tidyverse)
library(lubridate)

# CARGAR DATOS ------------------------------------------------------------       

#VUELOS AR 2025
anac_2025 <- 
  read_csv2(
    file = 'CS_DE_DATOS/Repo-curso-2026C1/202512-informe-ministerio-actualizado-dic-final.csv')

#AEROPUERTOS
aeropuertos <- read_csv(file = 'CS_DE_DATOS/Repo-curso-2026C1/iata-icao.csv')


#CLIMA  
#REVISAR SI PODEMOS ENCONTRAR UNA RELACION ENTRE NOMBRE DE ESTACION METEOREOLOGICA Y CODIGO DE AEROPUERTO
clima <- read_fwf(file = 'CS_DE_DATOS/Repo-curso-2026C1/registro_temperatura365d_smn.txt', 
                  col_positions = fwf_widths(c(8,1,5,1,5,200), c("fecha", "x", "tmax", "y", "tmin", "nombre"))
                  ,skip = 3
                  
                  ) |> select(-x,-y)


clima[1:2,]

# ANALISIS DE DATOS -------------------------------------------------------

glimpse(anac_2025)

anac_2025_1 <- 
  anac_2025 |>
  mutate(
    tipo_vuelo = factor(`Clase de Vuelo (todos los vuelos)`),
    clasif_vuelo = factor(`Clasificación Vuelo`),
    tipo_movimiento = factor(`Tipo de Movimiento`),
    aeropuerto = factor(Aeropuerto),
    origen_destino = factor(`Origen / Destino`),
    aerolinea = factor(`Aerolinea Nombre`),
    aeronave = factor(Aeronave),
    calidad_dato = factor(calidad_dato)
  )


summary(anac_2025)

#EXPLORAR AEROPUERTOS
glimpse(aeropuertos)


#TARE 5

# CARGA DE DATOS 2019-2025 -------------------------------------------------------------------------


anac_2019 <-
  read_csv2(file = 'CS_DE_DATOS/Repo-curso-2026C1/201912-informe-ministerio-actualizado-dic-final (1).csv')

anac_2020 <-
  read_csv2(file = 'CS_DE_DATOS/Repo-curso-2026C1/202012-informe-ministerio-actualizado-dic-final.csv')

anac_2021 <-
  read_csv2(file = 'CS_DE_DATOS/Repo-curso-2026C1/202112-informe-ministerio-actualizado-dic-final.csv')

anac_2022 <-
  read_csv2(file = 'CS_DE_DATOS/Repo-curso-2026C1/202212-informe-ministerio-actualizado-dic-final.csv')

anac_2023 <-
  read_csv2(file = 'CS_DE_DATOS/Repo-curso-2026C1/202312-informe-ministerio-actualizado-dic.csv')

anac_2024 <-
  read_csv2(file = 'CS_DE_DATOS/Repo-curso-2026C1/202412-informe-ministerio-actualizado-dic-final.csv')


anac_2025 <-
  read_csv2(file = 'CS_DE_DATOS/Repo-curso-2026C1/202512-informe-ministerio-actualizado-dic-final.csv')


# PROMEDIO DE VUELOS  -----------------------------------------------------
#AGRUPAMOS Y LIMPIAMOS DATOS QUE NOS INTERESAN

promedio_vuelos_2019 <- anac_2019 |>
  filter( `Tipo de Movimiento` == "DESPEGUE") |>
  mutate(mes = month(dmy(`Fecha UTC`), label = TRUE, abbr = FALSE)) |>
  group_by(mes) |>
  summarise(
    total_vuelos_mes = n(),
    promedio_diario = n() / n_distinct(`Fecha UTC`)
  )
 
promedio_vuelos_2020 <- anac_2020 |>
  filter( `Tipo de Movimiento` == "Despegue") |>
  mutate(mes = month(dmy(`Fecha UTC`), label = TRUE, abbr = FALSE)) |>
  group_by(mes) |>
  summarise(
    total_vuelos_mes = n(),
    promedio_diario = n() / n_distinct(`Fecha UTC`)
  )



promedio_vuelos_2021 <- anac_2021 |>
  filter( `Tipo de Movimiento` == "Despegue") |>
  mutate(mes = month(dmy(`Fecha UTC`), label = TRUE, abbr = FALSE)) |>
  group_by(mes) |>
  summarise(
    total_vuelos_mes = n(),
    promedio_diario = n() / n_distinct(`Fecha UTC`)
  )



promedio_vuelos_2022 <- anac_2022 |>
  filter( `Tipo de Movimiento` == "Despegue") |>
  mutate(mes = month(dmy(`Fecha UTC`), label = TRUE, abbr = FALSE)) |>
  group_by(mes) |>
  summarise(
    total_vuelos_mes = n(),
    promedio_diario = n() / n_distinct(`Fecha UTC`)
  )


promedio_vuelos_2023 <- anac_2023 |>
  filter( `Tipo de Movimiento` == "Despegue") |>
  mutate(mes = month(dmy(`Fecha UTC`), label = TRUE, abbr = FALSE)) |>
  group_by(mes) |>
  summarise(
    total_vuelos_mes = n(),
    promedio_diario = n() / n_distinct(`Fecha UTC`)
  )


promedio_vuelos_2024 <- anac_2024 |>
  filter( `Tipo de Movimiento` == "Despegue") |>
  mutate(mes = month(dmy(`Fecha UTC`), label = TRUE, abbr = FALSE)) |>
  group_by(mes) |>
  summarise(
    total_vuelos_mes = n(),
    promedio_diario = n() / n_distinct(`Fecha UTC`)
  )

promedio_vuelos_2025 <- anac_2025 |>
  filter( `Tipo de Movimiento` == "Despegue") |>
  mutate(mes = month(dmy(`Fecha UTC`), label = TRUE, abbr = FALSE)) |>
  group_by(mes) |>
  summarise(
    total_vuelos_mes = n(),
    promedio_diario = n() / n_distinct(`Fecha UTC`)
  )


#UNIFICAMOS


# Unimos todos tus objetos procesados
evolucion_total <- bind_rows(
  promedio_vuelos_2019 |> mutate(anio = 2019),
  promedio_vuelos_2020 |> mutate(anio = 2020),
  promedio_vuelos_2021 |> mutate(anio = 2021),
  promedio_vuelos_2022 |> mutate(anio = 2022),
  promedio_vuelos_2023 |> mutate(anio = 2023),
  promedio_vuelos_2024 |> mutate(anio = 2024),
  promedio_vuelos_2025 |> mutate(anio = 2025)
  )  |>
 
    
     # Creamos una columna de fecha para que R sepa el orden temporal exacto
  mutate(fecha_eje = make_date(year = anio, month = as.numeric(mes)))




ggplot(evolucion_total, aes(x = fecha_eje, y = promedio_diario)) +
  geom_line(color = "black", size = 1) +
  geom_point(color = "red", size = 2) +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  
  # Etiquetas
  labs(
    title = "Evolución Mensual de Vuelos en Argentina (2019-2024)",
    subtitle = "Promedio diario de despegues por mes",
    x = "Año",
    y = "Vuelos promedio por día"
  ) +
  theme_minimal()





# RESPUESTAS --------------------------------------------------------------

#QUE SE OBSERVA EN LA PANDEMIA?

#VEMOS UNA FUERTE CAIDA DE VUELOS QUE SALIERON DEL PAIS, PRODUCTO DE QUE ESTABA CASI MUY ESTRICTO EL TEMA DE VIAJES, ERA CASI IMPOSIBLE VIAJAR EN LOS PRIMEROS MESES DE PANDEMIA MARZO-2020


#CUANTO TARDA DEN RECUPERAR LOS FLUJOS PRE-PANDEMIA?

#Tardamos aproximadamente 2 años, no es hasta el año 2023 donde empieza a volver a tomar forma la misma tendencia que tenia incialmente en 2019, año previo a la pandemia


