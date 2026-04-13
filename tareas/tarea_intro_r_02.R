#primeros comandos de R Tutorial. Printing a stdout
"Hello World!"
5 + 5
plot(1:10)

#Asignar variables, las variables son dinamicas y pueden ser asignadas sin especificar el tipo
my_var <- 30
typeof(my_var) 
my_var <- "Sally" # el tipo de dato cambia de numero a texto
typeof(my_var) #vemos el cambio en el tipo de dato


#ejemplos de tipos de datos
# numerico
x <- 10.5
class(x) ##Usa class, es distinto que typeof?

# integer
x <- 1000L
class(x)

# complex
x <- 9i + 3
class(x)

# character/string
x <- "R is exciting"
class(x)

# logical/boolean
x <- TRUE
class(x)

## ahora vemos ejemplos de tipos numericos

x <- 10.5
y <- 10L
z <- 1i

## mas ejemplos, reusando las variables anteriores
# tipo Numeric, dato tipo generico para numeros
# cuanto espacio en memoria ocupa? Cuanta precisión?
x <- 10.5
y <- 55

x
y

class(x)
class(y)

# tipo de dato Integer. 

x <- 1000L
y <- 55L

x
y

class(x)
class(y)

# Numeros complejos, R tiene complejos como tipo de dato nativo
# se podra usar i para asignar una variable?

x <- 3+5i
y <- 5i

x
y

class(x)
class(y)


# Conversión de datos

x <- 1L #integer
y <- 2 #numeric

# convertimos un integer a numeric
a <- as.numeric(x)

# y viceversa
b <- as.integer(y)

x
y

class(a)
class(b)

## Strings, "cadenas", el tipo de texto

"hello"
'hello' ##se puede usar los dos tipos de comillas

str <- "Hello"
str #sigo el ejemplo de la pagina, es buena idea usar str como nombre de variable?

str <- "Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."

str # multilinea, facil de hacer, imprime con caracteres escapados en lugar del salto de linea
cat(str) ## para resolverlo en forma general usamos la funcion de concatenacion cat

nchar(str) # nos da la cantidad de caracteres en el texto


## buscamos si tiene un caracter

str <- "Hello World!"

grepl("H", str)
grepl("Hello", str)
grepl("X", str)

#concatenar

str1 <- "Hello"
str2 <- "World"

paste(str1, str2)

##booleans, valores verdadores o falsos, algebra de Bool

10 > 9
10 == 9
10 < 9

#Comparación de variables
a <- 10
b <- 9
a > b

a <- 200
b <- 33

# usamos expresiones booleans en control de flujo if
# sintaxis igual a JS

if (b > a) {
  print("b is greater than a")
} else {
  print(" b is not greater than a")
}

# Operadores

10 + 5
x <- 10
y <- 3

x + y
x - y
x * y
x / y
x ^ y
x %% y #modulo
x %/% y #division con redondeo

# distintas sintaxis para asignar variables

my_var <- 3
my_var <<- 3 #se ve que esto es para variables globales
3 -> my_var
3 ->> my_var

my_var

#operadores de comparacion

x == y
x != y
x > y
x < y
x >= y
x <= y

#Operadores logicos
x <- TRUE
y <- FALSE
x & y
x && y
x | y
x || y
!x
# la diferencia entre los operadores simples y los duplicados es que el simple es element-wise y el otro es logical. No entiende la diferencia, se refiere a bitwise?

# otros 
x <- 1:10 #para secuencias, muy util
y <- 5
y %in% x #para ver si un valor está en una lista
# %*% multiplicacion de matrices


## Control de flujos

# if

a <- 33
b <- 200

if (b > a) {
  print("b is greater than a")
}

# Else if

a <- 33
b <- 33

if (b > a) {
  print("b is greater than a")
} else if (a == b) {
  print ("a and b are equal")
}

#If Else

a <- 200
b <- 33

if (b > a) {
  print("b is greater than a")
} else if (a == b) {
  print("a and b are equal")
} else {
  print("a is greater than b")
}

# Else sin el else if

a <- 200
b <- 33

if (b > a) {
  print("b is greater than a")
} else {
  print("b is not greater than a")
}

## While loop, un bucle con condicion
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
}

#comando break, para salirse del bucle
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
  if (i == 4) {
    break
  }
}

i <- 0
while (i < 6) {
  i <- i + 1
  if (i == 3) {
    next
  }
  print(i)
}

## while loop con un if, else en el centro. Sale por else cuando dice es 6
dice <- 1
while (dice <= 6) {
  if (dice < 6) {
    print("No Yahtzee")
  } else {
    print("Yahtzee!")
  }
  dice <- dice + 1
}

# for loop, el loop que mas vamos a usar.

#loop por elementos de una lista
fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  print(x)
}

dice <- c(1, 2, 3, 4, 5, 6)
class(dice) ## parece ser un vector, un tipo de coleccion de datos especifico de R
for (x in dice) {
  print(x)
}

## usamos break en el for loop, en el ejemplo lo unico especial que hace es evitar hacer un print con "cherry"
fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  if (x == "cherry") {
    break
  }
  print(x)
}

# comando next, para saltearse elementos de un loop

fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  if (x == "banana") {
    next
  }
  print(x)
}

## mismo ejemplo de dice anterior, pero con for en vez de while, mas natural

dice <- 1:6

for(x in dice) {
  if (x == 6) {
    print(paste("The dice number is", x, "Yahtzee!"))
  } else {
    print(paste("The dice number is", x, "Not Yahtzee"))
  }
}

## vector, una lista de elementos del mismo tipo, debe ser muy eficiente en el manejo de la memoria

# Vector of strings
fruits <- c("banana", "apple", "orange")

# Print fruits
fruits

# Vector of numerical values
numbers <- c(1, 2, 3)

# Print numbers
numbers

# Vector with numerical values in a sequence
numbers <- 1:10 #se ve que este operador es una forma sencilla de llamar a c()

numbers

# Vector with numerical decimals in a sequence
numbers1 <- 1.5:6.5
numbers1

# Vector with numerical decimals in a sequence where the last element is not used
numbers2 <- 1.5:6.3
numbers2

# Vector of logical values
log_values <- c(TRUE, FALSE, TRUE, FALSE)

## ordenar
fruits <- c("banana", "apple", "orange")

length(fruits) ##el manejo es distinto que un string, quizas no trate al string como una secuencia de caracteres, no usa la misma funcion para medir el largo

fruits <- c("banana", "apple", "orange", "mango", "lemon")
numbers <- c(13, 3, 5, 7, 20, 2)

sort(fruits)  # Sort a string
sort(numbers) # Sort numbers

## slicing, acceder a elementos particulares de un vector

fruits <- c("banana", "apple", "orange")

# Access the first item (banana)
fruits[1]

fruits <- c("banana", "apple", "orange", "mango", "lemon")

# Access the first and third item (banana and orange)
fruits[c(1, 3)]

fruits <- c("banana", "apple", "orange", "mango", "lemon")

# Access all items except for the first item
fruits[c(-1)]

#asignar a un lugar del vector
fruits <- c("banana", "apple", "orange", "mango", "lemon")

# Change "banana" to "pear"
fruits[1] <- "pear"

# Print fruits
fruits

#repeat

#funcion muy util! hay muchas formas facil de armar un vector

repeat_each <- rep(c(1,2,3), each = 3)

repeat_each

repeat_times <- rep(c(1,2,3), times = 3) #otra forma de armar las repeticiones

repeat_times

repeat_indepent <- rep(c(1,2,3), times = c(5,2,1)) ##mas variedad en repeat

repeat_indepent

## mas formas de generar vectores, funcion seq

numbers <- seq(from = 0, to = 100, by = 20)

numbers

#Listas, mas flexibles pero computacionalmente deben ser más caro, debe requerir más poder de procesamiento para saltar de un elemento al otro

thislist <- list("apple", "banana", "cherry")

thislist

thislist

#slicing

thislist[1]

#cambiando un elemento

thislist[1] <- "blackcurrant"

thislist

#largo de la lista, igual que en un vector

length(thislist)

## fijarse si un elemento esta en la lista. En este caso, como cambiamos el primer elemento no lo va a encontrar

"apple" %in% thislist

#agregar un elemento

append(thislist, "orange")

append(thislist, "orange", after = 2)

#sacar un elemento

newlist <- thislist[-1]

newlist

## mas slicing

thislist <- list("apple", "banana", "cherry", "orange", "kiwi", "melon", "mango")

(thislist)[2:5]

## loops por lista

for (x in thislist) {
  print(x)
}

#Concatenar con c, se ve que esta funcion no es para armar vectores per se, si no para unir elementos en una coleccion

list1 <- list("a", "b", "c")
list2 <- list(1,2,3)
list3 <- c(list1,list2)

list3

## matrices

##forma facil de armar una matriz

thismatrix <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)
thismatrix

#matriz de strings, que tan util puede ser?

thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

thismatrix

#tambien podemos hacer slice con matrices
thismatrix[1, 2]

thismatrix[2,]

thismatrix[,2]

thismatrix <- matrix(c("apple", "banana", "cherry", "orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)

thismatrix[c(1,2),]

thismatrix <- matrix(c("apple", "banana", "cherry", "orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)

thismatrix[, c(1,2)]

#Agregando elementos a una matriz, por columna cbind y por fila rbind

thismatrix <- matrix(c("apple", "banana", "cherry", "orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)

newmatrix <- cbind(thismatrix, c("strawberry", "blueberry", "raspberry"))

# Print the new matrix
newmatrix

thismatrix <- matrix(c("apple", "banana", "cherry", "orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)

newmatrix <- rbind(thismatrix, c("strawberry", "blueberry", "raspberry"))

# Print the new matrix
newmatrix

#la funcion c tambien se puede usar para sacar elementos de una matriz, parece una fucion overloaded

thismatrix <- matrix(c("apple", "banana", "cherry", "orange", "mango", "pineapple"), nrow = 3, ncol =2)

#Remove the first row and the first column
thismatrix <- thismatrix[-c(1), -c(1)]

thismatrix

# el operador para buscar elementos

"apple" %in% thismatrix

#para medir la dimension de una matriz usamos dim, para ver la cantidad de elemenots length
thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

dim(thismatrix)
length(thismatrix)

#Hacemos loop por una matriz

for (rows in 1:nrow(thismatrix)) {
  for (columns in 1:ncol(thismatrix)) {
    print(thismatrix[rows, columns])
  }
} #complejo

#hacemos merge en matrices
Matrix1 <- thismatrix
Matrix2 <- matrix(c("orange", "mango", "pineapple", "watermelon"), nrow = 2, ncol = 2)

# Adding it as a rows
Matrix_Combined <- rbind(Matrix1, Matrix2)
Matrix_Combined

# Adding it as a columns
Matrix_Combined <- cbind(Matrix1, Matrix2)
Matrix_Combined


##Arrays para armar colecciones con mas de dos dimensoines, mas grande que una matriz

# An array with one dimension with values ranging from 1 to 24
thisarray <- c(1:24)
thisarray

# An array with more than one dimension
multiarray <- array(thisarray, dim = c(4, 3, 2))
multiarray

#slicing, mas complejo

multiarray[2, 3, 2]

multiarray[c(1),,1]

multiarray[,c(1),1]

#buscar elementos en el array

2 %in% multiarray

dim(multiarray)

#largo

length(multiarray)

#Loop

for(x in multiarray){
  print(x)
}

### Data Frame, para armar tablas, cada columna puede tener solo un tipo de datos

Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame
summary(Data_Frame) #info de la tabla

## slicing en tablas

Data_Frame[1]

Data_Frame[["Training"]]

Data_Frame$Training

## agregar una fila
New_row_DF <- rbind(Data_Frame, c("Strength", 110, 110)) 
New_row_DF
## agregar una columna
New_col_DF <- cbind(Data_Frame, Steps = c(1000, 6000, 2000))
New_col_DF #no hay problema con la fila extra porque no se la agregamos a la tabla original, es decir, el rbind y el cbind no alteran el elemento original, crean uno nuevo, bien funcional

## Borrar elementos del DF

Data_Frame_New <- Data_Frame[-c(1), -c(1)]
Data_Frame_New

## elementos en el df
dim(Data_Frame) 
ncol(Data_Frame)
nrow(Data_Frame)
length(Data_Frame) #es lo mismo qe un ncol, length en df se define por el numero de columnas (raro, pensaria que el largo de una tabla serian sus filas, no sus campos)

##combinar dos tablas
##une por filas
Data_Frame1 <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame2 <- data.frame (
  Training = c("Stamina", "Stamina", "Strength"),
  Pulse = c(140, 150, 160),
  Duration = c(30, 30, 20)
)

New_Data_Frame <- rbind(Data_Frame1, Data_Frame2)
New_Data_Frame

#une columnas
#une por orden de filas, por lo que si tus datos estan desordenados te van a quedar mal las tablas
Data_Frame3 <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame4 <- data.frame (
  Steps = c(3000, 6000, 2000),
  Calories = c(300, 400, 300)
)

New_Data_Frame1 <- cbind(Data_Frame3, Data_Frame4)
New_Data_Frame1

##Factors
##Categoriza datos, para armar etiquetas, 
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))

music_genre
#Levels vendria a ser como hacer un unique, elimina duplicados
levels(music_genre)

#tambien podemos especificar los levels de antemano
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"), levels = c("Classic", "Jazz", "Pop", "Rock", "Other"))

levels(music_genre)

#largo de un factor
length(music_genre)

#slicing
music_genre[3]

##agregando datos
music_genre[3] <- "Pop"

music_genre[3]

#pero no se pueden agregar elementos que no esten en los niveles, protege a la coleccion

music_genre[3] <- "Opera"

music_genre[3]

### Pero si lo agregamos de antemano si nos deja

music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"), levels = c("Classic", "Jazz", "Pop", "Rock", "Opera"))

music_genre[3] <- "Opera"

music_genre[3]

