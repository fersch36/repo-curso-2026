## importamos las librerias
library(nycflights13)
library(tidyverse)

# exploramos los datos
flights
glimpse(flights)
?flights


## filtramos

flights |>
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

# FILTRAMos para ver todos los vuelos que se demoraron mas de 120 minutos
flights |> 
  filter(dep_delay > 120)

# vuelos que salieron el primero de enero
flights |>
  filter(month == 1 & day == 1)
#vuelos salidos en Enero o en Febrero
flights |> 
  filter(month == 1 | month == 2)
#lo mismo que antes, pero ahora estamos diciendo, quedate con las filas cuyo mes esta dentro del vector que le pasamos
flights |> 
  filter(month %in% c(1, 2))

#podemos guardar la tabla filtrada en una variable
jan1 <- flights |>
  filter(month == 1 & day == 1)

#no confundir la sintaxis de r, = se usa para asignacion, == para comparar igualdad

#flights |> 
  #filter(month = 1) #esto falla

#esto tambien es erroneo, pero el interpetador no va a tirar un error. El problema es que no hace lo que esperamos que haga, no nos trae el mes 1 o el 2, nos trae el mes 
#1 algo que cumpla con la condicion 2, que no tiene sentido

flights |> 
  filter(month == 1 | 2)

#para hacer un sort, pero a nivel de DF
flights |> 
  arrange(year, month, day, dep_time)

#ordenamos en forma descendente
flights |> 
  arrange(desc(dep_delay))

#podemos eliminar duplicados con distinct
flights |> 
  distinct()

#trae todos los pares unicos de origen y destino
flights |> 
  distinct(origin, dest)

flights |> 
  distinct(origin, dest, .keep_all = TRUE)

#podemos contar filas tambien, como en excel contar si
flights |>
  count(origin, dest, sort = TRUE)

#4 funciones que afectan a las columnas sin modificar las filas, mutate(), select(), rename() y relocate()

#mutate, generamos nuevas columnas, calculadas de preexistentes
flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60
  )

#pero no lo vamos a ver en la consola, asique podemos pedirle que las asigne al inicio de la tabla
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )

#podemos asignar despues de una columna tambien
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

#podemos tambien dropear columnas y quedarnos, por ejemplo, con solo las columnas que usarmo para calcular las nuevas
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

#select sirve para quedarse con solo algunas columnas, como el argumento keep
#nos quedamos con solo año, mes y dia
flights |> 
  select(year, month, day)
#lo mismo que antes, pero ahora le estamos diciendo desde una columna hasta la otra, asique el orden aca importa
flights |> 
  select(year:day)
#esto es lo opuesto a antes
flights |> 
  select(!year:day)
# solo las columnas con texto en sus filas, osea, no valores numericos, especificamente, solo las columnas con el tipo chr
flights |> 
  select(where(is.character))

?select

#podemos renombrar columnas tambien, fijate que usamos un solo =
flights |> 
  select(tail_num = tailnum)

#pero es mejor usar rename para renombrar columnas, mejor funcionalidad
flights |> 
  rename(tail_num = tailnum)

#relocate mueve columnas, como el arrange de antes
# lleva estas dos columnas al frente de la tabla
flights |> 
  relocate(time_hour, air_time)

#usamos argumentos por dentro, con secuencias o el .before o el .after, o starts_with (esto es para seleccionar columnas, lo otro para ordenarlas)
flights |> 
  relocate(year:dep_time, .after = time_hour)
flights |> 
  relocate(starts_with("arr"), .before = dep_time)

# ahora vemos mas piping, combinamos mas funciones, para hacer una verdadera modificacion de la tabla

#los vuelos mas rapidos a IAH
flights |>
  filter(dest == "IAH") |>
  mutate(speed = distance / air_time * 60) |>
  select(year:day, dep_time, carrier, flight, speed) |>
  arrange(desc(speed))

# tambien se podria haber anidado los verbos, o usar asignaciones intermedias, pero lo primero es dificil de seguir y lo segundo no es muy funcional
# ademas de estar asignando muchos pasos intermedios superfluos en memoria

arrange(
  select(
    mutate(
      filter(
        flights, 
        dest == "IAH"
      ),
      speed = distance / air_time * 60
    ),
    year:day, dep_time, carrier, flight, speed
  ),
  desc(speed)
)

flights1 <- filter(flights, dest == "IAH")
flights2 <- mutate(flights1, speed = distance / air_time * 60)
flights3 <- select(flights2, year:day, dep_time, carrier, flight, speed)
arrange(flights3, desc(speed))

## grupos

#agrupar por mes, devuelve todo en una sola tabla, pero por dentro se va a comportar por grupos por mes
flights |> 
  group_by(month)

#summarize
#con el concepto de agrupar de antes, ahora colapsamos todas las filas en base al grupo, y calculamos un promedio, por ejemplo
flights |>
  group_by(month) |>
  summarize(
    avg_delay = mean(dep_delay)
  )

#pero como hay valores nulos en la db, tenemos que dropearlos
flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE)
  )

#podemos hacer varios en simultaneo, asique podemos contar el promedio de demora por mes, y cuantas vuelos hubo por mes
#excluimos los na para promediar, pero no para contar
flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    n = n()
  )

##slicing

#distintas variedades de como recortar filas, slicings, como cortar un pedazo de pizza
#df |> slice_head(n = 1) takes the first row from each group.
#df |> slice_tail(n = 1) takes the last row in each group.
#df |> slice_min(x, n = 1) takes the row with the smallest value of column x.
#df |> slice_max(x, n = 1) takes the row with the largest value of column x.
#df |> slice_sample(n = 1) takes one random row.

#nos quedamos todas las filas con la mayor cantidad de demora por aeropuerto de destino
flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1) |>
  relocate(dest)

#y usamos with_ties = FALSE, para quedarnos con solo 1 fila por grupo
flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1, with_ties = FALSE) |>
  relocate(dest)

#agrupamos por 3 columnas en simultaneo
daily <- flights |>  
  group_by(year, month, day)
daily

# hacemos summarize con multiples grupos, pero solo lo hace por año y mes, si entendí bien lo que dice el libro, porque el ultimo grupo lo ignora por defecto
daily_flights <- daily |> 
  summarize(n = n())
daily_flights

#Ese mismo comportamiento explicito
daily_flights <- daily |> 
  summarize(
    n = n(), 
    .groups = "drop_last"
  )
daily_flights

## podemos desagrupar explicitamente con el verbo ungroup()

daily |> 
  ungroup()

# y nos quedamos una sola fila si hacemos summarize en un grupo desagrupado, lo trata como si todas las filas estan en un solo grupo

daily |> 
  ungroup() |>
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    flights = n()
  )

## Con la ayuda del argumento .by, podemos agrupar directamente en summarize

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = month
  )

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = c(origin, dest)
  )