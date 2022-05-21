# https://curso-r.github.io/main-r4ds-1/slides/05-ggplot2.html#1

# Visualização de dados ---------------------------------------------------

# ggplot ------------------------------------------------------------------

# pacote dentro do conjunto do tidyverse.
# é o pacote que serve para fazer diferentes tipos de gráficos.

# um gráfico é uma representação visual dos dados, por meio de
# atributos estéticos e formas geométricas.


# base de dados para o exercícios -----------------------------------------

imdb <- readr::read_rds("https://github.com/curso-r/blog/raw/main/static/data/desafios/imdb.rds")
library(tidyverse)

imdb <- imdb %>% 
  mutate(lucro = receita - orcamento)

# grafico de pontos:

ggplot(data = imdb)+
  geom_point(aes(x = orcamento, y = receita))

# modelo padrão 
# ggplot(data = data.frame)+
#   geom_tipo_de_grafico(mapping = aes(x = exemplo1, y = exemplo_2))


ggplot(data = imdb)+
  geom_point(aes(x = orcamento, y = receita))+
  geom_abline(intercept = 0, slope = 1, color = "red")


# atributo color

ggplot(data = imdb)+
  geom_point(aes(x = orcamento, y = receita, color = lucro))


# ifelse()

imdb %>% 
  mutate(lucrou = ifelse(lucro <= 0, "Não", "Sim")) %>% 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucrou))



imdb %>% 
 mutate(orcamento_mais_que_10.000.000 = 
          ifelse(orcamento >= 10000000, "Não", "Sim")) %>% 
  ggplot()+
  geom_point(aes(x = orcamento, y = receita, color = orcamento_mais_que_10.000.000))




# Gráfico de linhas -------------------------------------------------------

# gráfico de linhas são bastante utilizados para representar
# séries temporais


imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = T)) %>% 
  ggplot()+
  geom_line(aes(x = ano, y = nota_media))


# notas dos filmes com Robert de Niro

imdb %>% 
  filter(str_detect(ator_1, "Robert De Niro")) %>% 
  group_by(ano) %>% 
  mutate(nota_media = mean(nota_imdb, na.rm = T)) %>% 
  ggplot(aes(x = ano, y = nota_media ))+
  geom_line() + geom_point() +
  geom_label(aes(label = nota_media))



# Gráfico de barras -------------------------------------------------------

# a função do  gráfico de colunas é geom_col

# abaixo gráfico dos 10 diretores que mais fizeram filmes

imdb %>% 
  count(diretor) %>% 
  top_n(10, n) %>% 
  mutate(diretor = fct_reorder(diretor, n)) %>% 
  ggplot()+
  geom_col(aes(x = diretor, y = n))


imdb %>% 
  count(diretor) %>% 
  filter(!is.na(diretor)) %>% 
  top_n(10, n) %>% 
  mutate(diretor = fct_reorder(diretor, n)) %>% 
  ggplot()+
  geom_col(aes(x = diretor, y = n, fill = diretor),
           show.legend = F)+
  geom_label(aes(x = diretor, y = n/2, label = n))+
  theme_classic()+
  coord_flip()

# fct_reorder reordena as colunas em ordem crescente ou decrescente


# Histogramas -------------------------------------------------------------

imdb %>% 
  filter(diretor == "Steven Spielberg") %>% 
  ggplot()+
  geom_histogram(aes(x = lucro),
                 binwidth = 100000000, color = "white")

#  binwidth = 100000000, muda a distância do intervalo




# Colocando título e subtítulo --------------------------------------------

imdb %>%
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita, color = lucro)) +
  labs(
    x = "Orçamento ($)",
    y = "Receita ($)",
    color = "Lucro ($)",
    title = "Gráfico de dispersão",
    subtitle = "Receita vs Orçamento"
  )


# Mudando a escala do gráfico ---------------------------------------------

# a função para isso é cood_cartesian()

imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media)) +
  scale_x_continuous(breaks = seq(1916, 2016, 10)) +
  scale_y_continuous(breaks = seq(0, 10, 2)) +
  coord_cartesian(ylim = c(0, 10))

