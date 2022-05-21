usethis::use_github()
usethis::use_readme_md()


# Diretórios de trabalho no R ---------------------------------------------

# o diretório de trabalho é fundamental na organização do fluxo
# de trabalho, ao definir um WD estamos definindo a pasta base
# na qual o R irá procurar arquivos para importar, e onde, irá
# salvar arquivos quando acionado.

# você pode:
# 1 - adicionar manualmente um diretório com setwd() - como argumento
# recebe o caminho para o novo diretório setwd(~/OneDriver/Documentos/novapasta);
# 2- checar onde está o diretório atual com getwd()
# 3 - salvar o trabalho na forma de projeto;
#  4- salvar um projeto com controle de versões atrelado ao
# git-hub.



# Caminhos absolutos ------------------------------------------------------

# caminhos absolutos são aqueles que tem o caminho raiz
# definido a partir da pasta de usuários do computador local.

#usar caminho absoluto é considerado uma má prática, pois
# o código se torna irreprodutível ao ser compatilhado,
# ou seja, se você abrir o arquivo em outro computador, ou,
# compartilhar o script com outra pessoa, não será possível
# reproduzir os arquivos salvos, e o trabalho como um todo.


# Caminhos relativos ------------------------------------------------------

# caminhos relativos são aqueles que tem início no diretório de
# trabalho da sua sessão.

# ou seja, salva tudo dentro da pasta do projeto.
# desta forma, ao compartilhar a pasta do projeto com alguém
# todos os arquivos estarão salvos naquela pasta e assim,
# poderão ser reproduzidos em qualquer computador.


# Tibbles -----------------------------------------------------------------

# Tibbles são uma adaptação dos data.frames, com comportamentos
# apenas desejáveis. Por exemplo, não altera o formato dos objetos
# das colunas forçosamete.

# os tibbles são próprios do pacote tidyverse, por isso que
# qualquer manipulação de dados com as funções desse pacote
# retorna um tibble.

# como as tabelas são mostradas no console
# o tibble mostra o número de linhas, coluns e a classe das
# variáveis.
# tibbles só mostram apenas as primeiras 10 linhas.
# tibbles só mostra o número de colunas que couber na tela.
# tibbles não nomeiam linhas (row.names)


# Lendo arquivos de textos ------------------------------------------------

# para ler arquivos de texto iremos utilizar as funções do
# pacote readr, que pertence ao tidyverse.
# para ler arquivos no formato .csv e .txt.

library(readr)
library(dados)
install.packages("imdb")
install.packages("remotes")
remotes::install_github("cienciadedatos/dados")
library(tidyverse)

starwars <- dados::dados_starwars
install.packages("xlsx")

starwars <- read.csv("./starwars.csv", encoding = "UTF-8", sep = ",")

xlsx::write.xlsx(starwars, "starwars.xls")

starwars <- readxl::read_xls("./starwars.xls")
class(starwars)

# para ler arquivos com ponto e vírgula basta usar a função
# read_csv2, enquanto a função read_csv, é para ler arquivos
# separados por vírgulas.

# arquivos de texto podem ser lidos com a função
# read_delim()

# para ler arquivos excel, além do pacote xlsx, também podem
# ser utilizados o pacote readxl() e a função read_excel.
# abaixo alguns argumentos que podem ser úteis no caso da
# planilha vim desconfigurado:
# Listamos abaixo os principais argumentos:
#
# sheet= para definir em qual aba estão os dados
#
# col_names indica se a primeira linha representa o nome das colunas
#
# col_types= para definir a classe das colunas
#
# skip= para pular linhas
#
# na= indica quais strings devem ser interpretadas como NA

# para salvar os arquivos utiliza-se a função write_pacote()
# de cada respectivo pacote. Os argumentos nessa função
# são o nome do arquivos no enviroment, e depois o caminho
# a ser indicado/nome junto com a extensão

# ex: write_xlsx(arquivo, "arquivo.xls")
