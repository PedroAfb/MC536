# MC536

## Visão Geral

Projeto para a disciplina de Banco de Dados da Unicamp. O objetivo do projeto é criar um banco de dados utilizando dados relacionados a ODS 13 (Ação contra a Mudança Global do Clima), usando dados reais para o preenchimento do banco. O banco utilizado foi Postgres.

Desenvolvido por:
- Pedro Borges(torne o nome em um hperlink: https://github.com/JoaoVgon31) (260628)
- João Vitor (torne o nome em um hiperlink: https://github.com/PedroAfb) (237871)
## Objetivo do Projeto

Esse projeto tem como objetivo reunir dados relacionados direta ou indiretamente a Amazonia Legal, e mostrar dados de degradação da região relacionados a outros fatores relevantes.

## Esquema do Banco de Dados

- **Modelo Conceitual**
![Modelo Conceitual](imagens/modelo_conceitual.png "Modelo Conceitual do Banco de Dados")
- **Modelo Relacional**
![Modelo Relacional](imagens/modelo_relacional.png "Modelo Relacional do Banco de Dados")
- Caminho do arquivo para gerar BD: **GeracaoBD.sql**

## Datasets

### Cidades

- link
- caminho csv
- atalho arquivo insercao associado

Descrição: Dataset disponibilizado pelo IBGE (Instituto Brasileiro de Geografia e Estatística). Contém dados sobre todos os municípios brasileiros.

### Unidades de Conservação

- link: https://dados.mma.gov.br/id/dataset/unidadesdeconservacao
- caminho csv: datasets/UnidadesConservacao.csv

Descrição: Dataset disponibilizado pelo Ministério do Meio Ambiente e Mudança do Clima. Contém dados sobre unidades de conservação cadastradas no CNUC (Cadastro Nacional de Unidades de Conservação), presentes nos estados que fazem parte da Amazônia Legal. Os dados são disponibilizados semestralmente, sendo que, para esse projeto, está sendo utilizado o arquivo referente ao 2 semestre de 2024.

### Foco de Queimadas

- link: https://terrabrasilis.dpi.inpe.br/app/dashboard/fires/biomes/aggregated/#
- caminho csv: datasets/FocoQueimadasEstado.csv

Descrição: Dataset disponibilizado pelo INPE (Instituto Nacional de Pesquisas Espaciais) por meio da plataforma TerraBrasilis. Contém dados sobre focos de queimadas obtidos por satélites. Os dados são disponibilizados com referência ã todo território brasileiro, assim como, categorizados por bioma, sendo que, nesse projeto, está sendo utilizado o arquivo referente ao bioma Amazônia.

### Meteorologia

- link: https://bdmep.inmet.gov.br
- caminho csv: de datasets/clima2000 até datasets/clima2024

Descrição: Dataset disponibilizado pelo INMET (Instituto Nacional de Meteorologia). Contém dados meteorológicos coletados por estações meteorológicas. Os dados podem ser acessados por solicitação de dados específicos ou pelo acesso aos dados gerais de todo histórico de coleta, que foi o caso desse projeto.

### Desmatamento

- link: https://terrabrasilis.dpi.inpe.br/app/dashboard/deforestation/biomes/legal_amazon/increments
- caminho csv:
  - datasets/DesmatamentoAreasIndigena.csv
  - datasets/DesmatamentoCidades.csv
  - datasets/DesmatamentoUnidadeConservacao.csv

Descrição: Dataset disponibilizado pelo INPE (Instituto Nacional de Pesquisas Espaciais) por meio da plataforma TerraBrasilis. Contém dados sobre desmatamento por bioma e pela região da Amazonia Legal. Os dados são disponibilizados por Estado, cidades, unidades de conservação e áreas indígenas. Nesse projeto, estão sendo utilizados dados de desmatamento por cidades, unidades de conservação e áreas indígenas, todos referentes a Amazônia Legal.

### Emissão de Gases Amazônia Legal

- link: https://dados.gov.br/dados/conjuntos-dados/inpe-em
- caminho csv: datasets/EmissaoGasesAmazonia.xlsx
- atalho arquivo insercao associado

Descrição: Dataset disponibilizado pelo INPE (Instituto Nacional de Pesquisas Espaciais). Contém dados dados de estimativas de emissões de gases anuais para toda Amazônia Legal. Os dados são disponibilizados agregados por ano (1960 a 2020) e de modo desagregado espacialmente, sendo que, nesse projeto, são utilizados os dados agregados por ano.

## Dicionario de Dados

- Cidade: Unidade administrativa municipal oficialmente reconhecida no Brasil. Serve como base geográfica para associar dados de desmatamento e meteorologia. Imutável enquanto o município existir oficialmente. Inclui todas as cidades que façam parte de Estados que fazem parte da Amazônia Legal.

  - Atributos:
    - nome_normalizado: nome da cidade em minúsculo e sem acentos. Para fins de preenchimento do banco de dados.

- Estado: Unidade federativa que compõe a divisão administrativa do Brasil. Serve como base geográfica para associar dados de desmatamento, meteorologia e queimadas. Imutável enquanto o Estado existir oficialmente. Inclui todos os Estados que fazem parte da Amazônia Legal.

- Região Administrativa: Conjunto de estados agrupados com base em critérios geográficos, socioeconômicos ou administrativos. Serve como base geográfica para associar dados de desmatamento, meteorologia, queimadas e emissão. Inclui as grandes regiões do Brasil segundo o IBGE (Norte, Sul, Sudeste, Centro-Oeste e Nordeste), e a região da Amazônia Legal. Imutável, exceto em casos de reconfiguração das regiões.

- Unidade de Conservação: Área protegida por lei com o objetivo de conservação ambiental, podendo permitir ou restringir o uso humano. Usada como base geográfica para associar dados de desmatamento. Inclui todas as unidades de conservação presentes no CNUC (Cadastro Nacional de Unidades de Conservação), mantido pelo MMA (Ministério do Meio Ambiente), até o 2o semestre de 2024. Dados de cadastro atualizados semestralmente podem conter alterações, porém dificilmente ocorrem alterações.

  - Atributos:
    - area_amazonia_ha: área em hectares ocupada pela unidade de conservação no território da Amazônia Legal
    - esfera_administrativa: indica qual nível de governo administra a unidade (federal, estadual, municipal)
    - tipo: Classificação geral da unidade quanto ao tipo de proteção e nível de intervenção humana (Proteção Integral ou Uso Sustentável)
    - categoria: Classificação da unidade quanto ao tipo de proteção e objetivo (por exemplo, Parque, Reserva Biológica, Estação Ecológica). Subclassificação de tipo

- Área Indígena: Território reconhecido como de ocupação tradicional de povos indígenas, com posse permanente e usufruto exclusivo. em áreas protegidas. Usada como base geográfica para associar dados de desmatamento. Inclui todas as áreas indígenas presentes na Amazônia Legal cujos dados de desmatamento foram disponibilizados pelo PRODES (Projeto de Monitoramento do Desmatamento na Amazônia Legal por Satélites), por meio da plataforma TerraBrasilis. Imutável após registro do relatório.

- Estação Meteorológica: Instalação com instrumentos para registrar dados climáticos automaticamente. Usada como base geográfica para associar dados de meteorologia. Inclui todas as estações meteorológicas presentes nos relatórios de meteorologia disponibilizados pelo INMET (Instituto Nacional de Meteorologia) de 2000 a 2024. Imutável após registro do relatório.

- Relatorio de Desmatamento: Registro anual da área desmatada em determinada cidade/unidade de conservação/área indígena. Usada para avaliar desmatamento e impacto ambiental. Imutável após registro do relatório.

  - Atributos:
    - area_km2: área desmatada em quilômetros quadrados

- Relatorio de Meteorologia: Registro de dados climáticos diários, hora em hora, por estação meteorológica. Usada para avaliar dados meteorológicos e impacto ambiental. Imutável após registro do relatório.

  - Atributos:
    - temperatura_max: temperatura máxima registrada na hora anterior, em graus Celsius
    - temperatura_min: temperatura mínima registrada na hora anterior, em graus Celsius
    - precipitacao: precipitação total na hora de medição, em milímetros
    - umidade: umidade relativa do ar na hora de medição, em porcentagem
    - velocidade_vento: velocidade do ar na hora de medição, em metros por segundo

- Relatorio de Emissão de Gases: Consolidação anual das emissões e absorções de gases de efeito estufa por região. Usada para avaliar emissão e impacto ambiental. Imutável após registro do relatório.

  - Atributos:
    - co2_1a_ordem: emissão de CO2 de 1 ordem. A medida de 1a ordem supõe de modo simplificado que 100% das emissões ocorram no momento da mudança de uso/cobertura
    - co2_2a_ordem: emissão de CO2 de 2 ordem. A medida de 2a ordem busca representar o processo gradativo de liberação e absorção do carbono como ocorre de fato
    - co2_por_fogo: parcela de emissão de CO2 2 ordem especificamente por fogo
    - co2_por_decaimento: parcela de emissão de CO2 2 ordem especificamente por decaimento natural de biomassa
    - ch4_eq_fogo: emissão de CH4 em carbono equivalente\*
    - n2o_eq_fogo: emissão de N2O em carbono equivalente\*

* Quantidade expressa em termos do impacto que teria se fosse CO2

- Relatorio de Focos de Queimadas: Registros de pontos de calor detectados por satélite, indicando possível queimada. Usada para avaliar focos de queimada e impacto ambiental. Imutável após registro do relatório.

- Relacionamentos

- Relatório de Desmatamento **ocorreu em** Cidade/Unidade de Conservação/Área Indígena: representa o local em que aconteceu o desmatamento referenciado. O desmatamento pode ocorrer em Cidade, Unidade de Conservação e Área Indígena, mas um mesmo relatório pode ter relação apenas com uma dessas entidades por vez. É definido no momento de cadastro do relatório e não pode ser alterado.

- Relatório de Meteorologia **pertence a** Estação Meteorológica: representa a estação que gerou os dados do relatório de meteorologia. Definido no momento de cadastro do relatório e não pode ser alterado.

- Estação Meteorológica **pertence a** Cidade: representa a cidade em que a estação meteorológica está localizada. Definido no momento de cadastro da estação meteorológica e não pode ser alterado.

- Cidade **pertence a** Estado: representa o Estado em que a cidade está localizada. Definido no momento de cadastro da cidade e não pode ser alterado.

- Unidade de Conservação **pertence a** Estado: representa o Estado em que a unidade de conservação está localizada. Definido no momento do cadastro da unidade de conservação e não pode ser alterado.

- Unidade de Conservação **abrange** Cidades: representa as cidades em que o território da unidade de conservação está presente. Definido no momento do cadastro da unidade de conservação e pode ser alterado caso ocorram mudanças no território da área de conservação.

- Relatório de Focos de Queimadas **pertence a** Estado: representa o Estado em que aconteceram os registro do foco de queimadas referenciado. Definido no momento do cadastro do relatório e não pode ser alterado.

- Estado **pertence a** Região Administrativa: representa a região administrativa à qual o Estado pertence. Um Estado pode pertencer a diferentes regiões administrativas. Definido no momento do cadastro do Estado e não pode ser alterado.

- Relatório de Emissão de Gases **pertence a** Região Administrativa: representa a região administrativa à qual os dados de emissão de gases se referem. Definido no momento do cadastro do relatório e não pode ser alterado.

## Scripts de Preenchimento do Banco de Dados

O preenchimento do banco de dados foi realizado em Python com a biblioteca psycopg2. Foi utilizado Jupyter Notebook para ajudar no controle de fluxo no momento de execução. Cada script contém uma seção de inicial de conexão com o banco, e duas seções ao final do arquivo, uma para fechar a conexão e outra para roolback em caso de erros nas transações. O arquivo insert_all reune o conteúdo de todos os demais arquivos para auxiliar no setup do banco de dados.

Nem todos os campos de todos os datasets são utilizados, e alguns dados são tratados ou derivados de campos do dataset.

#### insert_regiao_administrativa

tabelas preenchidas/atualizadas:

- Insere regioes administrativas

#### insert_emissao

tabelas preenchidas/atualizadas:

- Insere relatórios de emissão de gases
- Relaciona com regiões administrativas

#### insert_estado

tabelas preenchidas/atualizadas

- Insere estados
- Relaciona com regioes administrativa

##### insert_queimadas

tabelas preenchidas/atualizadas

- Inserte relatório de queimadas
- Relaciona com Estados

#### insert_cidade

tabelas preenchidas/atualizadas

- Insere cidades
- Relaciona com Estados

#### insert_meteorologia

tabelas preenchidas/atualizadas

- Insere estações meteorológicas
- Insere relatórios de meteorologia
- Relaciona cidade com estações meteorológicas
- Relaciona estações meteorológicas com relatórios de meteorologia

#### insert_unidade_conservacao

tabelas preenchidas/atualizadas

- Insere unidades de conservação
- Relaciona com Estados
- Relaciona com Cidades

#### insert_indigena

tabelas preenchidas/atualizadas

- Insere áreas indígenas

#### insert_desmatamento_cidade

tabelas preenchidas/atualizadas

- Insere relatórios de desmatamento
- Relaciona com Cidades

#### insert_desmatamento_unidade_conservacao

tabelas preenchidas/atualizadas

- Insere relatórios de desmatamento
- Relaciona com Unidades de conservação

#### insert_desmatamento_indigena

tabelas preenchidas/atualizadas

- Insere relatórios de desmatamento
- Relaciona com áreas indígenas

## Setup e Execução

O arquivo insert_all está organizado para o preenchimento do banco de dados apenas executando cada célula do notebook de forma sequencial. O arquivo reune os arquivos de insert e os executa na ordem de explicação acima.

Para começar, é necessário **criar o banco de dados Postgres**, **Rodar o script do arquivo GeracaoBD.sql para criar os esquemas do BD**, **atualizar a configuração do BD no arquivo inserts/DATABASE_CONFIG.py**. Após isso, conectando-se ao banco de dados com sucesso, **basta seguir a execução dos blocos em ordem no arquivo inserts/insert_all.ipynb**

## Consultas e Resultados

### Consulta 1

Esta consulta identifica, para cada estação meteorológica, o dia com a maior variação diária de temperatura (diferença entre a máxima e mínima) registrada, mostrando a data, os valores extremos do dia e a variação, além de calcular a média geral das variações diárias daquela estação ao longo do período; os resultados incluem também o nome da estação, cidade e estado, permitindo comparar os dias mais extremos de cada local com seu comportamento médio, tudo organizado em ordem decrescente pela maior variação registrada.

- Código em consultas/CONSULTA1.sql
- Resultado em consultas/RESULTADO1.csv

### Consulta 2

Esta consulta calcula, para cada cidade que possui pelo menos uma unidade de conservação exclusiva\*, a área total desmatada entre 2008 e 2024, separando quanto desse desmatamento ocorreu dentro dessas unidades exclusivas e quanto ocorreu no restante da cidade, e então calcula o percentual que as áreas exclusivas representam no total desmatado da cidade; ao final, ela lista essas cidades ordenadas do maior para o menor percentual de desmatamento vindo de unidades exclusivas, permitindo identificar quais municípios mais concentram seu desmatamento dentro dessas áreas específicas.

- \*Unidade de conservacão exclusiva é aquela associada somente a uma cidade, ou seja, cujo território abrange apenas uma cidade

- Código em consultas/CONSULTA2.sql
- Resultado em consultas/RESULTADO2.csv

### Consulta 3

Esta consulta reúne, para cada ano, os dados agregados da Amazônia Legal combinando três grandes dimensões: (1) o total anual de emissão de gases de efeito estufa, (2) a temperatura média anual calculada a partir das médias estaduais (baseada em temperaturas máximas e mínimas), e (3) o total anual de focos de queimadas registrados; ela cruza essas informações ano a ano, garantindo que só sejam considerados os anos onde há dados disponíveis em todas as três fontes, e entrega uma visão consolidada que permite analisar possíveis correlações entre temperatura, queimadas e emissões na região ao longo do tempo.

- Código em consultas/CONSULTA3.sql
- Resultado em consultas/RESULTADO3.csv

### Consulta 4

Esta consulta retorna as 10 áreas mais desmatadas, considerando tanto áreas indígenas quanto unidades de conservação, combinando os dados das duas entidades. Para cada área, ela exibe o nome, o tipo (explicitamente marcado como Área Indígena ou Unidade de Conservação) e o total acumulado de desmatamento em km², ordenando os resultados do maior para o menor total desmatado e limitando a exibição às dez primeiras posições, ou seja, às áreas mais impactadas pelo desmatamento.

- Código em consultas/CONSULTA4.sql
- Resultado em consultas/RESULTADO4.csv

### Consulta 5

Essa consulta tem como objetivo calcular, para cada uma das cinco grandes regiões administrativas do Brasil (Norte, Nordeste, Centro-Oeste, Sudeste e Sul), a soma total da área da Amazônia presente nas unidades de conservação localizadas em seus estados, a soma total da área desmatada nessas unidades e o percentual que essa área desmatada representa em relação à área total amazônica.

- Código em consultas/CONSULTA5.sql
- Resultado em consultas/RESULTADO5.csv
