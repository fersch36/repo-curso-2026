##Ejercicio 19.2.4

library(tidyverse)
library(nycflights13)
library(dplyr)
library(ggplot2)

#1. We forgot to draw the relationship between weather and airports in Figure 19.1. What is the relationship and how should it appear in the diagram?

#r. La relación faltante es weather$origin a airports$faa,
# porque origin es una foreign key, y faa es la clave primaria de airports 
# así que en el diagrama debería aparecer una flecha muchos-a-uno desde weather hacia airports.

#2. weather only contains information for the three origin airports in NYC.
# If it contained weather records for all airports in the USA, what additional connection would it make to flights?

#r.además de la conexión con origin, también habría una conexión entre weather.origin y flights.dest (junto con time_hour) para representar el clima en el aeropuerto de destino

#3. The year, month, day, hour, and origin variables almost form a compound key for weather, but there’s one hour that has duplicate observations. Can you figure out what’s special about that hour?
weather |>
  count(year, month, day, hour, origin) |>
  filter(n >1)

##la hora duplicada corresponde a un cambio de horario (daylight saving time) donde una misma hora local ocurre dos veces, rompiendo la unicidad de la clave
## El dia fue 11/3/2013

#4. We know that some days of the year are special and fewer people than usual fly on them (e.g., Christmas eve and Christmas day). How might you represent that data as a data frame? What would be the primary key? How would it connect to the existing data frames?

# Podriamos crear un df especifico para feriados, con solo esos días. La clave tendria que ser el año, mes y dia conectandola con airports.

flights |>
  group_by(year, month, day) |>
  summarize(vuelos= n()) |>
  arrange(vuelos)

#5. Draw a diagram illustrating the connections between the Batting, People, and Salaries data frames in the Lahman package. Draw another diagram that shows the relationship between People, Managers, AwardsManagers. How would you characterize the relationship between the Batting, Pitching, and Fielding data frames?




#agrupa los vuelos por fecha y hora, calcula el retraso promedio y selecciona las 48 horas con mayor demora

##Ejercicio 19.3.4


#1. Find the 48 hours (over the course of the whole year) that have the worst delays. Cross-reference it with the weather data. Can you see any patterns?

flights |> 
  group_by(year, month, day, hour, origin) |> 
  summarize(mean_delay = mean(arr_delay, na.rm = TRUE), .groups = "drop") |> 
  slice_max(mean_delay, n = 48) |> 
  left_join(weather, by = c("year", "month", "day", "hour", "origin")) |>
  print(n = 100)

##veo que las mayores demoras son cuando el viendo estaba soplando particularmente fuerte, mucha humedad, en algunos casos lluvia.

#2. Imagine you’ve found the top 10 most popular destinations using this code:
  
  top_dest <- flights2 |>
  count(dest, sort = TRUE) |>
  head(10)
  
 

# How can you find all flights to those destinations?
  
  top_dest
  
  flights2 |>
    semi_join(top_dest, by = "dest")
  #usando un semi join entre flights2 y top dest por la columna destm quedandonos solo con los vuelos a ese destino
  
#3.  Does every departing flight have corresponding weather data for that hour?
  
  flights |>
    anti_join(weather, by = c("origin", "time_hour"))
  
  #no, con el antijoin vemos todas las filas que no tienen su correspondiente en weather
  
#4.  What do the tail numbers that don’t have a matching record in planes have in common? (Hint: one variable explains ~90% of the problems.)
  flights |>
    anti_join(planes, by = "tailnum") |>
    count(carrier, sort = TRUE) |>
    mutate(prop = n / sum(n))
  
  ##son de pocas aerolineas el problema, MQ y AA.
  
#5. Add a column to planes that lists every carrier that has flown that plane. You might expect that there’s an implicit relationship between plane and airline, because each plane is flown by a single airline. Confirm or reject this hypothesis using the tools you’ve learned in previous chapters.

  planes_con_carriers <- planes |>
    left_join(
      flights |>
        distinct(tailnum, carrier) |>
        filter(!is.na(tailnum)) |>
        group_by(tailnum) |>
        summarize(carriers = paste(sort(unique(carrier)), collapse = ", ")),
      by = "tailnum"
    )
  
  flights |>
    filter(!is.na(tailnum)) |>
    distinct(tailnum, carrier) |>
    count(tailnum, name = "n_carriers") |>
    count(n_carriers, sort = TRUE)
  
  #La hipótesis se rechaza: no todos los aviones están asociados a una sola aerolínea, porque hay tailnum que aparecen con más de un carrier. 
  
#6. Add the latitude and the longitude of the origin and destination airport to flights. Is it easier to rename the columns before or after the join?
  
  flights_geo <- flights |>
    left_join(
      airports |>
        select(faa, origin_lat = lat, origin_lon = lon),
      by = c("origin" = "faa")
    ) |>
    left_join(
      airports |>
        select(faa, dest_lat = lat, dest_lon = lon),
      by = c("dest" = "faa")
    )
  #Es más fácil renombrar antes de cada join, porque así evitás sufijos automáticos como .x y .y y el resultado queda más claro.
#7.  Compute the average delay by destination, then join on the airports data frame so you can show the spatial distribution of delays. Here’s an easy way to draw a map of the United States:
  
  airports |>
  semi_join(flights, join_by(faa == dest)) |>
  ggplot(aes(x = lon, y = lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# You might want to use the size or color of the points to display the average delay for each airport.
  
  delay_by_dest <- flights |>
    group_by(dest) |>
    summarize(avg_delay = mean(arr_delay, na.rm = TRUE), .groups = "drop") |>
    inner_join(airports, by = c("dest" = "faa"))
  
  ggplot(delay_by_dest, aes(x = lon, y = lat, size = avg_delay, color = avg_delay)) +
    borders("state") +
    geom_point(alpha = 0.7) +
    coord_quickmap()
  
  # Al unir el retraso promedio por destino con airports, podés ver su distribución espacial en el mapa; en general, los puntos más problemáticos se identifican visualmente por mayor tamaño o color más intenso.

#8. What happened on June 13 2013? Draw a map of the delays, and then use Google to cross-reference with the weather.
  
  delay_june13 <- flights |>
    filter(year == 2013, month == 6, day == 13) |>
    group_by(dest) |>
    summarize(avg_delay = mean(arr_delay, na.rm = TRUE), .groups = "drop") |>
    inner_join(airports, by = c("dest" = "faa"))
  
  ggplot(delay_june13, aes(x = lon, y = lat, size = avg_delay, color = avg_delay)) +
    borders("state") +
    geom_point(alpha = 0.7) +
    coord_quickmap()
  
  #El 13 de junio de 2013 hubo tormentas eléctricas severas en gran parte del este de EE. UU., 
  #con demoras y cancelaciones masivas de vuelos, por lo que el patrón de retrasos de ese día es consistente con una disrupción meteorológica amplia.