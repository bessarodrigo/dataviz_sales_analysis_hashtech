# Instalação e Carregamento dos Pacotes -----------------------------------
library(dplyr)
library(ggplot2)
library(readr)

# Importação dos Dados ----------------------------------------------------
vendas_hashtech <- read_csv("../dados/vendas_hashtech.csv")
View(vendas_hashtech)

# Calculando o Faturamento Mensal -----------------------------------------

# Criação do DataFrame do Total de Vendas por Mês
vendas_mensais <- vendas_hashtech %>% 
  mutate(mes = substr(data, 1, 7)) %>% 
  group_by(mes) %>% 
  summarise(faturamento_total = sum(faturamento))

# Plot do Total de Vendas por Mês
ggplot(vendas_mensais, aes(x = mes, y = faturamento_total, group = 1)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2.5) +
  labs(
    title = "Faturamento Mensal",
    x = "Mês",
    y = "Faturamento"
  ) +
  theme_minimal()

# Calculando o Faturamento por Produto ------------------------------------
vendas_produtos <- vendas_hashtech %>%
  mutate(mes = substr(data, 1, 7)) %>%
  group_by(mes, produto) %>%
  summarise(faturamento_total = sum(faturamento))

ggplot(vendas_produtos, aes(x = mes, y = faturamento_total, fill = produto)) +
  geom_col(position = "dodge") + # por padrão, a posição vem como stack
  labs(
    title = "Faturamento Mensal por Produto",
    x = "Mês",
    y = "Faturamento",
    fill = NULL
  ) + 
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Calculando o Preço Médio dos Produtos -----------------------------------
preco_medio <- vendas_hashtech %>% 
  mutate(mes = substr(data, 1, 7)) %>% 
  group_by(mes, produto) %>%
  summarise(preco_medio = mean(preco_unitario))

ggplot(preco_medio, aes(x = mes, y = preco_medio, color = produto, group = produto)) +
  geom_line(size = 1.2) + 
  labs(
    title = "Preço Médio dos Produtos ao Longo do Tempo",
    x = "Mês",
    y = "Faturamento",
    color = NULL
  ) + 
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))