
# Manipulação de dados ----------------------------------------------------

# o dplyr é o pacote utilizado para realizar manipulação na base
# de dados. 
# dplyr é um pacote que faz parte do tidyverse.


# Principais funções ------------------------------------------------------

# as principais funções do dplyr são:

# filter() - filtra as linhas de uma colunas;
# select() - seleciona as coluns nominalmente;
# arrange() - reordena os valores de uma coluna(s) por ordem
# alfabética ou numérica;
# mutate() - modifica ou cria novas colunas a partir de operações com antigas;
# group_by() - agrupa a base conforme uma coluna;
# summarize() - sumariza as colunas.



# Arquivos e pacotes base para os exercícios ------------------------------



imdb <- readr::read_rds("https://github.com/curso-r/blog/raw/main/static/data/desafios/imdb.rds")
library(tidyverse)


# Select() ----------------------------------------------------------------

# selecionando colunas com select()

imdb %>% 
  select(titulo)

# selecionando mais de uma coluna

imdb %>% 
  select(titulo, orcamento, generos)

# selecionado colunas consecutivas com o operador ":"

imdb %>% 
  select(titulo:generos)

# obs: além de utilizar o operador pipe " %>% " o argumento 
# padrão para selecionar colunas é o seguinte, primeiro
# o nome da base de dados e depois a coluna:

select(imdb, titulo)

# eu dou preferência ao pipe por tornar o código mais legível

 
# starts_with(): para colunas que começam com um texto padrão
# ends_with(): para colunas que terminam com um texto padrão
# contains(): para colunas que contêm um texto padrão

imdb %>% 
  select(starts_with("ator"))



# Arrange() ---------------------------------------------------------------

# o arrange serve para reordenar as linhas em ordem numérica
# ou alfabética

imdb %>% 
  arrange(orcamento)

arrange(imdb, ano)

arrange(imdb, desc(ano), desc(orcamento))


# filter ------------------------------------------------------------------

# filtrando linhas

imdb %>% 
  filter(orcamento > 10000)

# == apenas esse:
imdb %>% 
  filter(diretor == "Michael Curtiz")

# != todos menos esse:
imdb %>% 
  filter(diretor != "Michael Curtiz")


# | "ou" esse e esse (mesma coluna)

imdb %>% 
  filter(diretor == "Sam Raimi" | diretor == "Michael Curtiz")



# & "e" esse e esse combinação entre duas colunas diferentes

imdb %>% 
  filter(diretor == "Aaron Seltzer" & nota_imdb > 9.0)



# mutate() ----------------------------------------------------------------

# modifica e cria novas colunas

imdb %>% 
  mutate(duracao_horas = duracao/60) %>% 
  select(titulo, duracao_horas)


# Summarize() -------------------------------------------------------------

# reduz todos os valores de uma coluna a um único número.

imdb %>% 
  summarize(media_orcamento = mean(orcamento, na.rm = TRUE))


# group_by() --------------------------------------------------------------

# agrupa as linhas a um denominador comum, funciona melhor
# com outras funções

imdb %>% 
  group_by(diretor) %>% 
  count() %>% arrange()

imdb %>% 
  group_by(ator_1, ator_2, ator_3) %>% 
count()

imdb %>% 
  group_by(ano) %>% 
  count()


# left_join() -------------------------------------------------------------

# left_join junta duas base a partir de colunas chaves

tab_lucro_direcao <- imdb %>% 
  group_by(diretor) %>% 
  summarise(lucro_medio = mean(receita - orcamento, na.rm = T))

# juntando as duas bases a partir da coluna "chave"

imdb_lucro_medio <- left_join(imdb, tab_lucro_direcao, by = "diretor")
