# Monitoria 1 -Haciendo Economia 

#Autor: María Alejandra Motta 
#Script editado 

##TIPS
## Para correr lineas del script windows (ctrl + enter) y Mac (cmd + enter)
## correr todo el script (ctrl + shift + enter) y Mac (cmd+shift + enter)
## Siempre limpiar el environment (memoria de R) antes de empezar a trabajar, 
## se hace con el codigo rm(list = ls())
## Definir el directorio antes de empezar a trabajar, se hace asi: setwd("el path a la carpeta")

## Limpiar  enviroment
rm(list = ls())

## DIRECTORIO
setwd("/Users/mariaalejandramottaromero/Documents")
setwd("/Users/mariaalejandramottaromero/Documents")
#Instalar paquetes 
install.packages(c("haven", "dplyr", "fixest", "stargazer"))

#Cargar librerias necesarias: 
library(haven)
library(dplyr)
library(fixest)
library(stargazer)

# Cargar la base
nunn_data <- read_dta("Nunn(2008).dta")


## Calculadora en R
3+5 # Suma
5-3 #Resta
5*5 #Multiplicacion
5/5 #Division
5^2 #Exponenciacion
5%%2 #Residuo de la division
sqrt(4) #Raiz Cuadrada
abs(-11) #Valor Absoluto
log(2) # Log. natural
log10(2) #Log Base 10


#Creacion de variables  
variable1 <- 3.6
variable2 = 5
variable3 <- variable1 < variable2
variable4 <- "Hola"

#Saber que tipo de variables tienen
class(variable1)
class(variable2)
class(variable3)
class(variable4)
#O tambien 

typeof(variable1)
typeof(variable2)
typeof(variable3)
typeof(variable4)

# Para usar las variables con un tipo disitinto al que son
#as.numeric() as.integer() as.character()
as.integer(variable1)+variable2 #Se puede
variable1 + as.numeric(variable4) # No se puede, por que la variable 4 es texto

#Pedir ayuda en R
help("matrix")

#Vectores
v_numerico <- c(1,2,3,4)
v_numerico2 <- c(1:9)
v_logico <- c(TRUE, FALSE, TRUE, FALSE)
v_texto <- c("Bogota", "Bogota", "Chia", "Sopo")

#Traer un elemento específico []

v_texto[3]
v_numerico[1]

#Matrices
#Creacion Independiente
matriz1 <- matrix(1:15, byrow = FALSE, nrow=3, ncol=5)

matriz1

#A partir de vectores ya creados
matriz2 <- matrix(v_numerico2, byrow=FALSE, nrow = 3, ncol = 3)
matriz2

#Crear matriz identidad
matriz_ident <- diag(4)  

#Traer un elemento especifico []
matriz1[3] # Trae el tercer elemento, los cuenta por columnas (de arriba a abajo)
matriz2[1,] #trae toda la fila 1
matriz2[,3] #trae toda la columna 3
matriz2[2,3] #Trae el elemento situado en la fila 2 y columna 3(una posición específica)

#Operaciones de matrices
A <- matriz2
B <- matrix(c(3,6,1,11,23,42,4,5,9), byrow = TRUE, ncol=3, nrow=3)
C <- matrix(c(3,6,1,9,5,3), byrow = TRUE, nrow=2)
D <- matrix(c(3,6,1,9,5,3), byrow = TRUE, nrow=3)

#SUMA (deben tener las mismas dimensiones, suma directa)
A+C #error porque A es 3x3 y C 2x3
A+B #si corre

#MULTIPLICACIÓN    
A%*%C #error porque A es 3x3 y C 2x3
A%*%D #Si corre porque A es 3x3 y D 3x2

#TRASPUESTA 
t(B)

#DIAGONAL
diag(A)

#TRAZA (suma diagonal)
trazaB <- sum(diag(B))  
trazaB

#DETERMINANTE (solo para matrices cuadradas)
det(B)

#INVERSA (solo funciona para matrices con determinante diferente de 0)
solve(B)


### DATA FRAMES

#A partir de vectores ya creados
datos_personas <- data.frame("ID"=v_numerico, "Hombre" = v_logico, "Residencia" =v_texto)
datos_personas #ver la base de datos en la consola

View(datos_personas) #Ver en nueva ventana

#A partir de matrices
datos_ejemplo <- data.frame(A)
datos_ejemplo



### CARGAR DATOS  
setwd("/Users/mariaalejandramottaromero/Documents/Monitoria- Haciendo Economía")
#CSV
nombres <- read.csv("college_student_placement_dataset.csv") 
nombres2 <- read.csv("placement-dataset.csv", stringsAsFactors = TRUE)
#stringAsFactor : Todas las variables string las vuelve factores o niveles (ejemplo la ciudad)
class(nombres2$city)

#Delimitados (TXT)
academico <- read.delim("iris.txt", header=TRUE) # Pone encabezado
academico2 <- read.table ("iris.txt", sep="\t", header = TRUE) # "\t" : separado por espacios (como en Python)
Requisitos<-read.table("requirements.txt", sep ="\\", header = TRUE) # "\\" : separado por \
Requisitos2 <- read.table("requirements.txt", sep=";", header = TRUE) # ";" : separado por ;
Requisitos3 <- read.table("requirements.txt", sep=";", header = FALSE, col.names = c("Nombre", "Nota", "Aprobacion")) # ";" : separado por ;

#Excel  
install.packages("readxl")
library("readxl")
personas <- read_excel("Base de datos Proyecto .xlsx")


## Básicos
head(personas) #Parte superior
tail(personas) #Parte Inferior

attach(personas)
mean(Edad)

detach(personas)

mean(personas$Edad) # con $ llamamos una variable especifica
sd(personas$Edad) 
class(personas$Edad)


# Install from Markdown
install.packages('rmarkdown')

