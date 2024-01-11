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
compra_test <- compras[401:600,]

# Exclusão da coluna ID
compra_train <- compra_train[,-1]

# Visualização dos dados(treino e teste)
View(compra_train)
View(compra_test)
summary(compra_train)
summary(compra_test)

#-------------------------------------------#
# CONSTRUÇÃO DO MODELO -> Árvore de Decisão #
#-------------------------------------------#

tree1 <- rpart(Achat~., compra_train)

#Exibição em árvore por funções R Base
plot(tree1)
text(tree1, pretty=0)

# Aplicando a árvore decisão ao conjunto de testes 
test_tree1 <- predict(tree1, compra_test, type="class")

# Exibindo o vetor de previsão da classe de exemplos de teste
test_tree1

# Exibição do número de previsões para cada uma das classes
table(test_tree1)

# Previsões adicionadas como uma nova coluna 'Prediction' no dataFrame 'compra_test'
compra_test$Prediction <- test_tree1
View(compra_test)

# Exibindo uma lista de exemplos de teste previstos corretamente
View(compra_test[compra_test$Achat==compra_test$Prediction, ])

# Cálculo do número de sucessos: número de exemplos com classe real idêntica e previsão
nbr_succes <- nrow(compra_test[compra_test$Achat==compra_test$Prediction,])
nbr_succes

# Cálculo da taxa de sucesso: número de acertos sobre o número de exemplos de teste
taxa_succes <- nbr_succes/nrow(compra_test)
taxa_succes

# Cálculo do número de falhas: número de exemplos com diferentes classes reais e previsão
nbr_fail <- nrow(compra_test[compra_test$Achat!=compra_test$Prediction,])
nbr_fail

# Cálculo da taxa de falha: número de falhas em relação ao número de exemplos de teste
taxa_fail <- nbr_fail/nrow(compra_test)
taxa_fail

#----------------------------#
# PREVISÕES DA ÁRVORE RPART #
#---------------------------#
