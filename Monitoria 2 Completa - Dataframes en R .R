
# Monitoria 2 -Haciendo Economia - María Alejandra Motta 


# Limpiar memoria: 
rm(list = ls())

# Un dataframe es basicamente tener varias columnas, es una hoja de calculo: 

# 1) Comando c: Combina o concatena valores en un solo vector. Si combinas diferentes tipos, R convierte todo al tipo más general posible (coerción)

A=c("A1","A2","A3")
B=c("B1","B2","B3")
C=c("C1","C2","C3")

# Se crean con vectores o directamente dentro de la función
df1 =  data.frame(A,B,C, "Valor"=c(4,5,6))
df1
df2 =  data.frame(A,B,C)
df2
df3 =  data.frame("Valor"=c(4,5,6))
df3

str(df1)      # La función str muestra la estructura del dataframe
ncol(df1)     # ncol me muestra número de columnas (variables)

nrow(df1)    #nrow me muestra número de filas (observaciones)

summary(df) # Me muestra estadisticas importantes del data frame 

# Lo usual es tomar los datos de diversas fuentes 
install.packages('readr')
library(readr) # Libreria para lectura de datos planos

df =  read_csv("https://raw.githubusercontent.com/MainakRepositor/Datasets/refs/heads/master/Air%20Quality/real_2016_air.csv")
str(df) # ¿Que hay? 
head(df) # Una vista rapida - Lo primero de la tabla 

df[2:5]      # Le podemos tratar como un grupo de vectores,me muestra el rango de vectores que quiera. 
df[1:3] 
df['Tm'] # Y acceder directamente a variable"
print(df['Tm'], n=12)

df$Tm    # de varias formas

df['H']
df$H

#Ojo,toca tener en cuenta estas diferencias!
class(df$TM)      # Es un vector normal 
class(df['TM'])   # Es un DataFrame, que no sirve automaticamente en graficas, regresiones, operaciones etc.
class(df[['TM']]) # Es un vector normal 

df[ df['TM']<25 ,]     # Lo podemos tratar como una matriz, tomando solo ciertas observaciones
df[ (df['TM']<25) & (df['SLP']>1017) , ] 

df[,c('VV', 'V')] # Se puede llamar observaciones utilizando nombres de variables
df[4,c('VV', 'V')] # Podemos llamar una fila 

df[2:5, c('VV', 'V')]    # En ambas dimensiones


# Podemos modificar los datos directamente, creo una nueva variable "Year"
df[ (df['TM']<25) & (df['SLP']>1017) , 'Year' ]=2016  
df

# Muestra el nombre de columnas 
nombre_columna= names(df)
nombre_columna

#Cambia el nombre de columnas 
nombre_columna[4] = 'Sea Level Pressure'
nombre_columna[6] = 'Visibility'
names(df) = nombre_columna
nombre_columna

# Podemos borrar variables (el "Drop" de Stata)
df['Year']=NULL
df

# O dejar solo algunas (Keep de Stata)
df = df[,c('T','TM','Tm','H','V')]
df

df = df[2,c('T','TM','Tm','H','V')] # Traigo de alguna posición 
df


# Manejando variables ...................................
# Ajustamos el valor de alguna variable ( ej: Temperatura) 
df['T'] = df['T'] + 273.15
df

# Y creamos una nueva variable
df['AH'] = (df['H'] *3.17)/(461.5*df$T*100)
df


# Operaciones con bases de datos =========================================
# Muy generalmente necesitamos unir bases de datos de diferentes fuentes
# Merge, append, collapse

install.packages('haven')
library(haven)
sforce  = read_dta('http://www.stata-press.com/data/r14/sforce.dta')
dollars = read_dta('http://www.stata-press.com/data/r14/dollars.dta')


# merge m:1 region using dollars

merged = merge(sforce,dollars,by="region") # Junto sfroce con dollars, por region 
merged

# Para adicionar-- unir objetos por filas: 
appended = rbind(sforce,sforce)  #Toma dos o más data frames, matrices o vectores con la misma estructura en columnas y los pega uno debajo del otro, añadiendo filas nuevas.
library(tibble) # Para ver todas las columnas cambio la versión de tibble 
print(as_tibble(appended), n = Inf, width = Inf)+
  
# Y la versión extraña del "collapse". A la derecha está la agrupación, a la izquierda las variables a procesar
install.packages('doBy')
library(doBy)
# Se colapsa o resume el conjunto de datos, reemplazando observaciones originales por estadísticas agregadas,
# segun variables especificas 
dfG = summaryBy(sales + cost ~ region , FUN=c(mean,sd), data=merged)
dfG 
# ~ se lee como “en función de” o “agrupado por”.
#summaryBy(formula, FUN, data)
#summaryBy(Variables a resumir y agrupar, funciones estadisticas a aplicar, data frame)

# Comandos Clave =========================================

# Muestra todos los datasets disponibles en los paquetes descargados
data()
data(math)

#Para leer archivos en formato texto 
read.table("https://raw.githubusercontent.com/jbkinney/15_sordella/refs/heads/master/data/samples.txt")

#Para leer archivos en csv
read.csv("/Users/mariaalejandramottaromero/Documents/people-100.csv")

# Para encontrar ayuda en alguna función
help(arima)

# Juntar bases de datos/Manejo de datos- nuevos comandos:  =========================================

# Para ver los datos: 
#Crear la carpeta .kaggle
dir.create(path = "~/.kaggle", showWarnings = FALSE)

#Copiar kaggle.json a esa carpeta
file.copy(from = "~/Downloads/kaggle.json", to = "~/.kaggle/kaggle.json", overwrite = TRUE)

# Define el nombre del dataset
dataset <- "poushal02/student-academic-stress-real-world-dataset"

# Usa system() para ejecutar el comando de Kaggle desde R
system(paste("kaggle datasets download -d", dataset))

# Descomprime el archivo (el ZIP tendrá el mismo nombre que la parte final del dataset)
unzip("student-academic-stress-real-world-dataset.zip", exdir = "datos")

# Lista archivos descomprimidos
list.files("datos")


library(tidyverse)  # incluye dplyr, ggplot2, readr, etc.

# Lee el archivo CSV (puedes usar read_csv para mejor manejo, pero read.csv funciona)
data <- read.csv("/Users/mariaalejandramottaromero/Documents/academicStress.csv")

head(data)
View(data)

# Limpieza y renombrado
datos_limpios <- data %>%
  # Quitamos la fila 2, que probablemente tiene información no útil
  filter(row_number() != 2L) %>%
  # Renombramos columnas para que sean más cortas y manejables
  rename(
    Academic_Stage = Your.Academic.Stage,
    Coping_strategy = What.coping.strategy.you.use.as.a.student.,
    bad_habits = Do.you.have.any.bad.habits.like.smoking..drinking.on.a.daily.basis.,
    Academic_competition = What.would.you.rate.the.academic..competition.in.your.student.life
  ) %>%
  # Quitamos la primera fila también si es que es encabezado extra o basura
  filter(row_number() != 1L)

# Mira el resultado
head(datos_limpios)


# Unión de base de datos:
# Creación de Data Frames 
Data_Frame1 <- data.frame (
  Training = c("Strength", "Vitamina", "Calcium"),
  Pulse    = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

Data_Frame2 <- data.frame (
  Training = c("Vitamina", "Vitamina", "Strength"),
  Pulse    = c(132, 150, 160),
  Duration = c(30, 45, 21)
)

#Ejemplo 1: rbind --- Nuevo 

New_Data_Frame <- rbind(Data_Frame1, Data_Frame2)
New_Data_Frame 

#Ejemplo 2: rbind-- Bases de datos existentes 
data1 <- read.csv("/Users/mariaalejandramottaromero/Documents/college_student_placement_dataset.csv")
data2 <- read.csv("/Users/mariaalejandramottaromero/Documents/college_student_placement_dataset 2.csv")

New_data <- rbind(data1, data2)
New_data


#Merge__________
# Ojo, no usar rbind!! Casi nunca va a ser una buena idea
# La clave esta siempre en los identificadores-- para hacer merge 

#Ejemplo 1: Merge --- Bases de datos creadas 
Data_Frame4 <- data.frame (
  Training = c("Strength", "Vitamina", "Talento"),
  Steps    = c(300, 60450, 2010),
  Calories = c(300, 400, 3003)
)


#Ejemplo 2: Merge -- Bases de datos existentes 

#Inner.join 
merge(New_Data_Frame, Data_Frame4, by.x = "Training", by.y = "Training")
#Une las filas de ambos data.frames donde el valor en la columna "Training" coincide en ambos.
#Left join 

merge(New_Data_Frame, Data_Frame4, by.x = "Training", by.y = "Training", all.x = TRUE)
#Mantiene todas las filas de New_Data_Frame (izquierdo), y agrega las columnas de Data_Frame4 cuando coinciden en "Training".

#Right Join
merge(New_Data_Frame, Data_Frame4, by.x = "Training", by.y = "Training", all.y = TRUE)
#Mantiene todas las filas de Data_Frame4 (derecho), y agrega las columnas de New_Data_Frame cuando coinciden.

#Full Join 
merge(New_Data_Frame, Data_Frame4, by.x = "Training", by.y = "Training", all.x = TRUE, all.y = TRUE)
#Mantiene todas las filas de ambos data.frames, combinando por "Training".


#Dplry-- Otros comandos mas claros
inner_join(New_Data_Frame, Data_Frame4, by = join_by(Training == Training))
left_join(New_Data_Frame, Data_Frame4, by = join_by(Training == Training))
right_join(New_Data_Frame, Data_Frame4, by = join_by(Training == Training))
full_join(New_Data_Frame, Data_Frame4, by = join_by(Training == Training))

#join_by(Training == Training) indica que la unión se realiza con la columna "Training" de ambos data.frames

#Ejemplo 2: Merge -- Bases de datos existentes 
library(dplyr)

datos <- read.csv("/Users/mariaalejandramottaromero/Documents/placement-dataset.csv")

# Cambiar nombre de columna 'placement' a 'Placement'
datos <- datos %>%
  rename(Placement = placement)

colnames(datos)

#Inner.join 
merge(New_data,datos, by.x = "Placement", by.y = "Placement")
#Une las filas de ambos data.frames donde el valor en la columna "Placement" coincide en ambos.

#Left join 

merge(New_data,datos, by.x = "Placement", by.y = "Placement", all.x = TRUE)
#Mantiene todas las filas de New_Data_Frame (izquierdo), y agrega las columnas de Data_Frame4 cuando coinciden en "Training".

#Right Join
merge(New_data,datos, by.x = "Placement", by.y = "Placement", all.y = TRUE)
#Mantiene todas las filas de Data_Frame4 (derecho), y agrega las columnas de New_Data_Frame cuando coinciden.

#Full Join 
merge(New_data,datos, by.x = "Placement", by.y = "Placement", all.x = TRUE, all.y = TRUE)
#Mantiene todas las filas de ambos data.frames, combinando por "Training".


# Mirar valores faltantes______

# Escogemos base de datos 

URL <-'https://raw.githubusercontent.com/SmilodonCub/DATA607/master/eduDATA_df.csv'
#read to an R data.frame with read.csv().
eduDATA_OR <- read.csv( URL ,stringsAsFactors = FALSE )
View(eduDATA_OR)

#¿Que valores faltan?
missing_summary <- eduDATA_OR %>%
  summarise_all(~sum(is.na(.))) %>% #Para cada columna, calcula cuántos valores son NA usando sum(is.na(.)).
  pivot_longer(cols = everything(), names_to = "Variable", values_to = "NA_Count") # Convierte ese resultado de formato ancho a formato largo, creando dos columnas:

View(eduDATA_OR)
# Quitar filas con NAs 
eduDATA_clean <- eduDATA_OR %>%
  drop_na()

View(eduDATA_clean)

# Verificación de como estan los datos ahora 


summary(eduDATA_clean)

