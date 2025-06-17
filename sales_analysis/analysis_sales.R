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


