# cargamos las librerías que vamos a usar

#install.packages("tidyverse")
#install.packages("palmerpenguins")
##install.packages("ggthemes") # comento estas linea para que no se instale cada vez que lo corro#

library(tidyverse)
library(palmerpenguins)
library(ggthemes)
library(ggplot2)

penguins
glimpse(penguins)
##View(penguins) ## muy bueno para ver los datos

?penguins 


ggplot(data = penguins) ## grafico vacio

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) ## ahora el grafico tiene ejes

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() ##esto crea un grafico de puntos

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() ##agregamos un nueva variable al grafico, asi vemos mejor la relacion entre las distintas variables. Como species es una variable categorica usamos
# le asignamos al color

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm")  ##agregamos lineas que relacional los datos


ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth(method = "lm")  ##modificamos el codigo asi no nos genera multiples lineas y solo una linea que relaciona la masa con el largo de las aletas

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")  ##agregamos tambien formas a los puntos, expresando la variable especies. Esto ayuda a expresar mejor los datos, para daltonicos

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind() ## por ultimo hacemos un salto en calidad, agregamos titulos, subtitulos, cambiamos los nombres de los ejes y hacemos que los colores sea vean mejor para daltonicos.


