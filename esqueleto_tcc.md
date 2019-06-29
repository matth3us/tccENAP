[TOC]

# Proposta de procedimento geoestatísticos para a gestão estratégica do atendimento presencial da Receita Federal do Brasil

Celso Mattheus Cantanhede Silva

> Abstract / Resumo

## Introdução

## Seção 1

Falar sobre a relação entre acessibilidade de serviços públicos e geografia

> Otimização de um serviço: buscar fornecer a máxima oferta para uma demanda conhecida, dados recursos escassos
>
>  "Health care services are provided at a finite number of fixed locations, yet they serve populations that are continuously and unevenly distributed throughout a region." (@AF p. 1) 
>
>  Desigualdades são inevitáveis, mas o tamanho dessas desigualdades é proporcional ao arranjo dos sistemas de distribuição do serviço, à distribuição da população e às características da infraestrutura de transporte. @AF

O Brasil enfrenta desde meados de 2014 uma grave crise econômica. Ela tem efeitos diversos sobre a população e sobre a estrutura administrativa do Estado. Mesmo o órgão arrecadador não escapa das restrições necessárias ao ajuste fiscal aplicado na tentativa de debela-la.

> "Além da crise econômica que o País vem enfrentando, que impacta a receita fazendária e a previdenciária, tem-se constatado a ocorrência de baixa recuperação dos créditos trbutários administrados pela RFB" (@AY p. 1)

> "Adicionalmente a esses dois fatores, agrega-se a alteração de legislação tributária, que modifica a forma de tributação, cria novos tributos, bem como concede desonerações e compensações e acabam por contribuir também para a variação da arrecadação" (@AY p. 4)

Na Secretaria da Receita Federal do Brasil, o que se observou foi o contingenciamento de despesas e paralisação de concursos, que não são realizados desde 2014. O fluxo de renovação, portanto, estagnou-se.

Além disso, uma outra tendência é a aceleração no quantitativo de aposentadorias, muitas delas influenciadas pelo temor que os anúncios da reforma previdenciária inspiram. Vale lembrar que muitos servidores na ativa  já alcançaram o requisito mínimo para aposentar-se, mas continuam em serviço, incentivados pelo “abono permanência”.

> o número de servidores tem diminuído em todas as carreiras, e não há reposição sendo realizada nem á vista @AY 

Fato é, o fluxo de renovação de pessoal estagnou-se, levando a uma forte diminuição da força de trabalho.Entre 2015 e 2017, por exemplo, a Receita perdeu 1831 servidores, de um total inicial de 23.687, o que representa menos 7.7% de sua força de trabalho em apenas 3 anos.

A crise também reforçou uma iniciativa latente do governo federal de investimento em inovação e governo digital, que passou a buscar formas de baratear a prestação de serviços tanto em termos de recursos físicos quanto humanos, sem deixar de garantir ou mesmo aumentar a qualidade do serviço prestado.

> "(...) não se pode contar apenas com a evolução dos meios de tecnologia da informação, pois os mesmos dependem de fatores exógenos como questões orçamentárias, disponibilidade do Serpro para desenvolvimento de sistemas e outros que não permitem sua evolução com velocidade o suficiente para suprir a nova demanda." (@AY p. 20) 

Todas essas tendências, juntas, explicam porque a Receita Federal tem investido fortemente na expansão dos atendimentos via digital e reduzido  os atendimentos em unidades físicas. 



Falar sobre a importância dos serviços oferecidos pela RFB

Falar sobre a importância do atendimento físico para a acessibilidade dos serviços oferecidos pela RFB

> Acessibilidade espacial: envolve a acessibilidade e disponibilidade do serviço. @AF 
>
> Acessibilidade mede a fricção da distância entre pontos de uma viagem @AF 
>
> Identificar areas com acessibilidade limitada "(...) allow planners to understand the effects of opening, closing, or realocating health care facilities. " (@AF  p. 2)
>
> "Equity manifests itself in the distribution, access to and utilization of health services between population groups" (@AD p. 917)

 

Tal movimento pode ser percebido em números. O e-Cac, atendimento digital, passou de 66,6 milhões de atendimentos em 2012 para 145,6 milhões em 2017. Enquanto isso, os atendimentos presenciais caíram de 20,2 milhões em 2012 para 14,9 milhões em 2017. Percentualmente, o e-Cac representava 76% dos atendimentos em 2012 e agora representa 91%. 

Ainda assim, 14.9 milhões de atendimentos presenciais ainda significam cerca de 40.000 atendimentos em todo o Brasil por dia, espalhados entre mais de 400 unidades de atendimento em diversas localidades. 

Somando a forte e latente demanda por atendimentos físicos, que também representam uma quantidade significativa de homens-horas dedicadas pela organização, às tendências que pressionam pela diminuição acelerada da força de trabalho, resta à organização empreender mudanças recorrentes de sua estrutura organizacional. Isso significa fechar unidades e realocar servidores para unidades com maior demanda. Não por acaso, essa foi a resposta já empreendida entre 2017 e 2018, com nova alteração prevista para o segundo semestre em 2019. 

Assim, cabe aos gestores responsáveis pelo atendimento da organização a seguinte decisão: como distribuir o seu pessoal entre as unidades? Que unidades fechar e que unidades reforçar? 



> "Numerous researchers have observed that increasing the availibility of services (for instance, by building more facilities or expanding health programs) does not always increase the use of service." (@AZ p. 1093)
>
> "Distance exerts a dual influence: long distances can be an actual obstacle to reaching  health facility, and they can be a disincentive to even trying to seek care." (@AZ p. 1094)
>
> "(...) in the Guatemalan highlahds, government health posts seemed to be conveniently located, yet that proximity did not guarantee utilization, probably because the facilities were understaffed and underequipped and thus unable to provide quality care." (@AZ p. 1095)

O objetivo dessa experiência é fornecer modelos de análise de dados que façam com que a tomada de decisões referentes à estrutura de atendimento físico da Receita Federal esteja mais alinhada com o objetivo social da prestação desse serviço, e portanto, esteja melhor informado e menos vulnerável à captura política. 

Por fim, e de forma mais ampla, o objetivo desse trabalho é inspirar outros no serviço público brasileiro a pensar no atendimento, presencial ou não, como o fornecimento de uma política pública; a construir essa política com foco no objetivo almejado; a identificar com máxima precisão viável a população atendida; e a mensurar e avaliar o fornecimento dessa política pública, visando a melhoria contínua e o fomento da inovação.





## Seção 2

Uso de dados em grid do IBGE para definir quais os municípios são atendidos por quais unidades de atendimento

> Descrever os bancos de dados utilizados no IBGE
>
> Descrever os dados e variáveis: inicialmente, usar algumas selecionadas, semelhantes ao que está disponível no cidades.ibge.gov.br

Justificar uso de dados em grids; vantagens e desvantagens em relação à dados de network graph, e potenciais testes futuros para verificar se a decisão de justifica

> Modelo em rede @AF 
>
> - Uma série de nós conectados por linhas, representando objetos geográficos (localizações, para os pontos, e infraestrutura de viagem, no caso das linhas)
> - O custo para atravessar uma linha é definido pelo tamanho da linha e pela velocidade de viagem associado àquele tipo de infraestrutura
>
> Modelo em grade @AF 
>
> - O modelo é composto por uma série de células de tamanho e distância regulares, sobreposto sobre o mapa
> - No modelo de viagem, a viagem ocorre na passagem de uma célula para outra, sempre em entre células adjacentes; assim, diferente do modelo em rede, os passos da viagem são sempre regulares em distância, variando apenas na velocidade
> - "Because all locations are explicitly defined in the raster data model, it is attractive for creating service areas, specially in regions without a all-encompassing transportation network" (p. 4)
> - "The estimation of travel speed for each road segment, in the absence of measured travel speed data, can be accomplished most accurately using the posted speed limit and surface material of the road segment." (p. 5)
>
> "The raster data model defines space as a continuous surface where each cell within the data extent has a specific location and attribute value. The network data model defines space as an empty container that is populated only by features having specific locations and attributes." ( @AF p. 12)
>
> "real-world connectivity is not accounted for in the raster data model." (...) "Therefore, movement is less restricted in the raster data model than in the real world and travel time estimates will generaly be underestimated." (@AF  p. 15)
>
> "Because the raster model defines all areas as transversable, the raster-based method appears more suitable when estimating travel time service areas for non-vehicular travel modes or in regions where travel is not restricted to roads." @AF 
>
> Quais são as presunções básicas quando se está construindo um modelo conceitual de viagem? @AF 
>
> - Os modelos assumem que todos possuem acesso a veículos similares e que se movimentam nesses veículos de forma similar
> - Os modelos assumem que as pessoas enfrentam os mesmos obstáculos de viagem, ignorando fatores como horário da viagem, dia da semana, sazonalidades mensais ou anuais, variações climáticas, etc.
> - Os modelos assumem que as pessoas conhecem o caminho mais eficiente entre os pontos da viagem; essa é uma das presunções menos atacáveis hoje em dia, com o acesso amplo à sistemas de navegação em celulares e computadores
> - Por limitações na captura dos dados, os modelos assumem que a população se concentra em um único ponto (seja um ponto da rede ou um ponto da grade)
>
> Uma presunção unspoken: o usuário do serviço sempre vai no mais próximo.  @AD

Justificar o uso de least-cost path-route finding

> Tipos de métodos de busca de rotas: @AC

> - As the wolf run (com o correr dos lobos): distância pelo mínimo custo, considerando a friccção do terreno e os obstáculos do caminho
> - As the crow flies (com o voar do corvo): distância euclideana direta entre dois pontos
>
> "it (gdistance package) provides functionality to calculate various distance measures and routes in heterogeneous geographic spaces represented as grids". (@AC p. 1)

> "Here we developed and validate a map that quantifies travel time to cities in 2015 at a spatial resolution of approximately one by one kilometre by integrating ten global-scale surfaces that characterize factors affecting human movement rates and 13.840 high-density urban centres within an established geospatial-modelling framework" (@AB p. 333)
>
> "The datasets that we used to construct the friction surface characterize the spatial locations and properties of roads, railroads, rivers, bodies of water, topographical conditions (elevantion and slope angle), land cover and national borders." (@AB p. 337)
>
> "Wealth, in particular, is a likely determinant of whether someone travels on foot rather than taking a vehicle and thus substantially affects acessibility on the level of the individual." (@AB p. 338)
>
> "Least-cost path algorithm is able to freely transition from these networks to roads or vice-versa when, in reality, switching modes of transport tipically requires a station or port." (@AB p. 338)



Explicar e justificar decisão de como conectar unidades de atendimento a municípios, e porque dedicar o município inteiro a uma unidade de atendimento

> "Different levels of data aggregation, know in the field of spatial analysis as the change of support, influence the results of geostatistical analysis. The support defines the method, spacing and/or volume of data acquisition. The change of support is related to the adopted scale and the existence of the Modifiable Area Unit Problem (MAUP) and ecological falacy (when ocurring the misinterpretation of results)." (@AA p. 638)

> > O uso de dados reais de atendimento, posicionando os CPFs atendidos de acordo com seu endereço de residência, diminuiriam esse problema
>
> > "Aggregated data per unit area are associated to their centroids and, henre, are spacially discrete. Moreover, the geostatistics technique has been developed for regular geographic unit. However, in general, travel data are associated to area with different shapes and sizes, that in most cases it is associated to census tracts in order to maintan the confidentiality of individuals."(@AA p. 644 )
>
> 



## Seção 3

### Seção 3.1

Explicar como é realizado o Data Wrangling

Explicar em formato de fluxograma (talves utilizar notação DOT para facilitar a geração desse fluxograma; para cada passo, associar input e output)

```R
#Teste de linguagem R no Typora
```

Fazer como referência a distância linear entre os municípios e os postos de atendimento

Explicar como são realizadas as análises e decisões pelo script

- Usar grid do IBGE para decobrir posicionamentos do país em que haja pelo menos um habitante
- Usar accumulated cost com dados de valocidade levantados em artigo da Nature para decidir, para esses pontos, qual a posto de atendimento mais próximo
- Fazer votação: para os municípios que tiverem sob a área de influência de mais de um posto de atendimento, "ganha" o município o posto de atendimento que tiver mais 
  - Para os municípios que tiverem postos de atendimento, o posto sempre atende o município inteiro, para facilitar a análise; considerar relativizar isso no futuro

Escolher algumas unidades de atendimento que possam ser interessantes, seja por si só, seja por comparação

Demonstrar como o modelo criado permite a simulação da extinção de uma unidade de atendimento

### Seção 3.2

- definir, no processo estratégico da organização, qual a população alvo do atendimento físico, para estabelecer parâmetros de otimização
- incluir dados reais de atendimento para fazer cross-validation do modelo
- testar modelos baseado em network-graph, em vez de raster, tanto em termos de acurácia quanto em termos de custo computacional
- revisar dados de infraestrutura de transporte para melhorar a acurácia das informações de movimentação

## Conclusão