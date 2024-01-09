#---------------------------------------#
# INSTALAÇÃO E ATIVAÇÃO DAS BIBLIOTECAS #
#---------------------------------------#

install.packages("rpart")
library(rpart)
library(readr)

# Carregamento e leitura da base de dados
compras <- read.csv2("dataachat.csv", header = TRUE, sep = ",", dec = ".", stringsAsFactors=T)
str(compras)
View(compras)
table(compras$compras)

# Divisão do conjunto de dados em treino e teste
compra_train <- compras[1:400,]
compra_test <- compras[404:600,]

# Exclusão da coluna ID
compra_train <- subset(compra_train, select = -ID)

# Visualização dos dados(treino e teste)
View(compra_train)
View(compra_test)
summary(compra_train)
summary(compra_test)
