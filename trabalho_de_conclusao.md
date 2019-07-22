Proposta de procedimento geoestatísticos para a gestão estratégica do atendimento presencial da Receita Federal do Brasil
=========================================================================================================================

Celso Mattheus Cantanhede Silva

Introdução
----------

Seção 1 (por que?)
------------------

Os recursos, sabemos, são escassos frente às necessidades e desejos; a
nobreza do serviço público não subverte tal incômoda realidade. Cabe aos
gestores da coisa pública planejar, executar e controlar o que estiver
sob sua responsabilidade de forma a conhecer a demanda e maximizar a
oferta.

Serviços, diz a definição <!-- 💭 citation needed -->, são intangíveis:
transações que não envolvem a entrega de bens materiais e conquanto, não
assumem uma forma. Como tal, não podem ser manufaturados, transportados,
nem guardados para uso futuro. São produzidos e consumidos
simultâneamente. Hoje, com o advento da internet e das TIC (tecnologias
da informação e da comunicação), é possível oferecer diversos serviços
sem que seja necessária a presença do ofertante e do demandante no mesmo
local físico. O acesso a essas tecnologias, claro, ainda é limitado.

Este é o caso do atendimento presencial oferecido por diversos órgãos
públicos, conjunto no qual está inserida a Secretaria da Receita Federal
do Brasil (RFB). Esse é um dos principais canais de contato do cidadão
com a Receita Federal, junto aos entrepostos aduaneiros. Por ele, o
cidadão pode tanto entregar quanto requisitar informações, declarações e
documentos essenciais à conformidade tributária, auxiliando no papel da
instituição de recolher os recursos necessários ao provimento dos
diversos serviços públicos oferecidos pelo Estado brasileiro. No papel
de orientação, são também instrumentos de educação fiscal e promoção da
auto-regularização, fomentando uma cultura de conformidade pro-ativa e
cidadã.

O atendimento já foi alvo de larga digitalização, evidenciada em seus
números.

A virtualização dos serviços de atendimento da RFB avança a passos
largos; entre 2012 e 2017, o e-Cac, portal de atendimento na internet da
RFB, passou de 66,6 milhões de atendimentos para 145,6 milhões de
atendimentos. Enquanto isso, os atendimentos presenciais caíram de 20,2
milhões para 14,9 milhões no mesmo período, de forma que o percentual
destes passou de cerca de 24% do total para apenas 9% @gestãoRFB. Mesmo
assim, 14,9 milhões equivalem a 40.000 cidadãos recebidos nas centenas
de unidades <!-- 💭 conferir número exato de unidades --> da RFB por dia,
em todo o país.

Desta realidade surgem os dilemas do gestor. Para suprir essa
necessidade de simultaneidade física entre os servidores da RFB e o
cidadão demandando serviços, cabe a ele escolher como distribuir
geograficamente os recursos materiais e os servidores disponíveis.

Estes dilemas não tem solução única. Possíveis respostas tem sido
levantadas em outros setores de serviço, como de transporte e de saúde,
com a aplicação de Sistemas de Informações Geográficas (GIS, na sigla em
inglês) e técnicas de geoestatísticas que permitam encontrar soluções
numericamente satisfatórias.

No exemplo do setor de saúde, por exemplo, o problema é exposto da
seguinte forma: “health care services are provided at a finite number of
fixed locations, yet they serve populations that are continuously and
unevenly distributed throughout a region (@AF p. 1)”. Consequência
natural desse arranjo é que as desigualdades são inevitáveis, mas a
dimensão dessas é função: do arranjo de distribuições das partes do
sistemas; da distribuição no espaço da população; e das características
do espaço, como infraestrutura e relevo, que dificultem ou facilitem a
movimentação @AF.

Ao se analisar a relação entre população e o espaço físico, podemos
evidenciar o atrito contrário ao acesso a um sevriço de diferentes
grupos populacionais, identificar áreas de maior limitação no acesso, e,
assim, “understand the effects of opening, closing, or realocating
health care facilities (@AF p. 2)”. Desta forma, promove-se a equidade,
que “(…) manifests itself in the distribution, access to and utilization
of health services between population groups (@AD p. 917)”.

A relevância da distribuição ótima é tanto mais importante quanto mais
escassos forem os recursos disponíveis. O Brasil enfrenta desde meados
de 2014 uma grave crise econômica, com efeitos diversos sobre a
população e sobre a estrutura administrativa do Estado. Mesmo o órgão
arrecadador não escapa das restrições necessárias ao ajuste fiscal
aplicado na tentativa de debela-la. Neste sentido, o TCU, em auditoria
operacional realizada na RFB, relata que “além da crise econômica que o
País vem enfrentando, que impacta a receita fazendária e a
previdenciária, tem-se constatado a ocorrência de baixa recuperação dos
créditos trbutários administrados pela RFB” (@AY p. 1).

Os reflexos internos na Receita Federal do Brasil são o
contingenciamento de despesas e a consequente paralisação de concursos,
estancando o fluxo de renovação de servidores. Em paralelo, há um
processo de aceleração no quantitativo de aposentadorias, muitas delas
influenciadas pelo temor que os anúncios da reforma previdenciária
inspiram. Vale lembrar que muitos servidores na ativa já alcançaram o
requisito mínimo para aposentar-se, mas continuam em serviço,
incentivados pelo chamado abono permanência @AY. Entre 2015 e 2017, a
RFB perdeu 1.831 servidores, de um total inicial de 23.687, o que
representa uma diminuição de 7,7% de sua força de trabalho em apenas 3
anos.

Este enxugamento, pode-se argumentar não seria de todo impactante na
organização, posto que, com o avançar da digitalização do governo,
espera-se um aumento na produtividade que compense em parte ou mesmo
totalmente os efeitos da diminuição no quantitativo de pessoal. Todavia,
lembra o TCU que “(…) não se pode contar apenas com a evolução dos meios
de tecnologia da informação, pois os mesmos dependem de fatores exógenos
como questões orçamentárias, disponibilidade do Serpro para
desenvolvimento de sistemas e outros que não permitem sua evolução com
velocidade o suficiente para suprir a nova demanda” (@AY p. 20).

Desta forma, temos todos os fatos em frente aos gestores da Receita
Federal do Brasil. De um lado, há um quantitativo decrescente de
servidores disponíveis para todas as tarefas da organização, não apenas
o atendimento. De outro, percebemos uma gama de obstáculos que
impossibilitam sua substituição imediata por canais digitais. Cabe-os
então decidir, como distribuir os recursos da forma mais eficiente? De
que maneira promover a equidade no acesso aos serviços da organização? O
objetivo do presente trabalho é sugerir um modelo que, incluído num
processo maior, possa responda às essas necessidades.

Acreditamos, antes de tudo, que esse processo de distribuição das
unidades de atendimento está no âmago da estratégia da Receita Federal
do Brasil e de seu propósito para a sociedade. Como tal, sugerimos que,
definidas as balizas estratégicas de qual o público alvo deve ser
atingido pelas unidades de atendimento, a organização empregue modelos
geoestatísticos na tomada de decisões de que unidades abrir e fechar e
quantos servidores devem se dedicar em cada unidade, de acordo com a
demanda estimada para cada ponto geográfico. Desta forma, a distribuição
destes recursos estaria mais alinhada ao seu objetivo social, tornando-o
menos vulnerável a captura política.

Este trabalho, de forma mais pontual, busca mostrar a viabilidade do
cruzamento de dados estatísticos e geoestatístico do IBGE e de outras
fontes para conhecer e explorar informações relevantes sobre o público
alvo das unidades de atendimento, um dos passos necessários ao processo
descrito acima.

Antes de passarmos a sua execução, cabe uma ressalva importante que deve
ser levada em conta quando da promoção de acessibilidade. Embora a
disponibilidade e a distância sejam fatores relevantes, não são
suficientes; o aumento da acessibilidade nem sempre é acompanhado de um
aumento da utilização dos serviços, e outros fatores devem ser avaliados
também, como qualidade do serviço oferecido e disponibilidade de canais
mais convenientes @AZ, como os próprios canais digitais supracitados.
Que fique claro que a definição de onde dispor unidades de atendimento é
apenas um passo do objetivo estratégico de atender bem a população.

Seção 2 (como?)
---------------

Há duas formas de se dispor dados em sistemas de informação geográficas.
Há os modelos vetoriais, que podem ser analisados como grafos em redes
(network graphs); e os modelos em grade (raster).

Os modelos vetoriais consistem de uma série de nós, conectados por
linhas, representando os objetos geográficos. Pontos no mapa são
representados por nós; conexões e infraestruturas como ferrovias e
rodovias são linhas, e regiões são delimitadas por polígonos, nós
combinados com vértices. Nos modelos vetoriais, o custo para atravessar
uma linha é função do tamanho da linha e da velocidade de viagem
associado àquele tipo de infraestrutura @AF. a movimentação, portanto,
ocorre entre pontos, de acordo com as linhas disponíveis para cada
ponto.

Os modelos de grade são compostos por uma série de celulas regulares,
geralmente retangulares, de tamanho e distância padronizados. Cada ponto
do mapa é resumido em um dos retângulos, e todas as informações
relevantes do mapa dentro da região encoberta por aquele retângulo são a
ele atribuído. No modelo de grade, as viagens ocorrem na passagem de uma
célula para outra, sempre em entre células adjacentes; assim, diferente
do modelo em rede, os passos da viagem são sempre regulares em
distância, variando apenas na velocidade @AF.

![](https://raw.githubusercontent.com/matth3us/tccENAP/master/04_imagens/figure_12_measuring_geographic_access.png)
Vemos acima, do artigo @AF, uma conversão entre um mapa em network para
um mapa em grid. (figure 12 no documento)

Há uma diferença fundamental na forma como esses modelos compreendem o
espaço.

“The raster data model defines space as a continuous surface where each
cell within the data extent has a specific location and attribute value.
The network data model defines space as an empty container that is
populated only by features having specific locations and attributes.” (
@AF p. 12)

Como todas as localizações do mapa são explicitamente definidadas nos
modelos de grade, isso torna-os “(…) attractive for creating service
areas, specially in regions without a all-encompassing transportation
network (@AF p. 4)”. Todavia, “real-world connectivity is not accounted
for in the raster data model.” (…) “Therefore, movement is less
restricted in the raster data model than in the real world and travel
time estimates will generaly be underestimated” (@AF p. 15). Isso ocorre
porque o modelo considera que todos os pontos do mapa são atravessáveis,
fazendo, por exemplo, que um viajante pudesse aproveitar-se da
infraestrutura ferroviária entrando em qualquer ponto que fosse mais
próximo dele, ignorando a existência de estações ou, no caso de
rodovias, intersecções @AF, @AB.

Para nós, a adoção de um modelo em grade nos parece mais interessante.
Embora ele tenha as limitações mencionadas acima, sem falar no seu custo
computacional mais elevado, nós acreditamos que, ao se analisar a
movimentação em todo o Brasil, especialmente em regiões mais afastadas
dos grandes centros populacionais, os mapas em grade acabarão por nos
fornecer uma perspectiva mais realista.

A forma como essa movimentação é modelada também deve ser explicitada.
Certamente que, até computacionalmente, seria consideravelmente mais
simples estimar as distâncias “as the crow flies” (com o voar do corvo),
ou seja, a distância linear entre cada um dos pontos e as unidades de
atendimento. Todavia, essa estimativa ignora completamente a
infraestrutura e os obstáculos existentes, tornando a análise pouco útil
@AC. Não faz sentido considerar que um posto de atendimento é o mais
próximo de um município se houver outros postos mais acessíveis devido à
infraestrutura disponível.

Mais interessante é a estimativa “as the wold run” (com o correr dos
lobos), pelo custo mínimo de viagem. Nele, atribuímos um custo de
fricção a cada um dos pontos da grade, de acordo com as infraestruturas
e obstáculos daquele ponto, e assim, estimamos o caminho com menor
fricção entre os pontos e as unidades de atendimento. Para tal fim,
utilizaremos o pacote em R gdistance, que “(…) provides functionality to
calculate various distance measures and routes in heterogeneous
geographic spaces represented as grids” @AC p. 1.

Para este trabalho, utilizaremos o mapa gerado pelo Malaria Atlas
Project para estimar o custo de friccão. Ele “quantifies travel time to
cities in 2015 at a spatial resolution of approximately one by one
kilometre by integrating ten global-scale surfaces that characterize
factors affecting human movement rates and 13.840 high-density urban
centres within an established geospatial-modelling framework” (@AB
p. 333). O resultado é um mapa com informações que “(…) characterize the
spatial locations and properties of roads, railroads, rivers, bodies of
water, topographical conditions (elevantion and slope angle), land cover
and national borders.” (@AB p. 337)

Algumas presunções devem ser explicitadas antes de qualquer análise.
Primeiro, os modelos assumem que todos possuem acesso a veículos
similares e que se movimentam nesses veículos de forma similar, o que
pode ser pouco realista mesmo considerando-se apenas viagens terrestes.
“Wealth, in particular, is a likely determinant of whether someone
travels on foot rather than taking a vehicle and thus substantially
affects acessibility on the level of the individual.” (@AB p. 338)

Em segundo lugar, assume-se uniformidade nas condições de viagem,
ignorando-se horário, sazonalidades como horário de rush ou fins de
semana e feriados, variações temporais e climáticas, etc. Em terceiro
lugar, assume-se que as pessoas conhecem o caminho mais eficiente; uma
presunção razoável atualmente, com o amplo acesso à sistemas de
navegação em celulares e computadores. Em quarto lugar, presume-se que
as populações concentram-se num único ponto; ou seja, qualquer variação
da distribuição interna a cada um dos retângulos da grade é ignorada, e
atribui-se à centroide de cada retângulo a totalidade da população
daquele espaço @AF.

Por fim, há um problema específico a análise do público-alvo de cada uma
das unidades de atendimento, como definiremos abaixo.

Possuímos as informações da distribuição da população num mapa em grade,
mas não possuímos diversos outras estatísticas relacionadas à demografia
com esse nível de detalhe; em geral, elas estão registradas no nível
municipal. Como tal, podemos calcular a distância dos postos de
atendimento a cada um dos pontos do mapa, mas temos que usar essa
informação para tomar uma decisão de qual unidade de atendimento atende
a cada município.

<!-- segundo o professor, não preciso me justificar pelas decisões do IBGE. Reduzir esse parágrafo. -->
Seria mais realista um modelo que pudessemos combinar as informações
demográficas dos grupos populacionais mais próximos, independente de
divisões municipais. Todavia, esse tipo de levantamento de dados não
seria apenas custoso mas também traria diversos riscos à privacidade da
população analisada <!-- citar IBGE aqui -->. Como tal, fazemos o
registro apenas para reconher o risco, em nossa análise, de enfrentarmos
algumas falácias estatísticas, como a falácia ecológica e o problema da
unidade de área modificável.

``` r
# Como os dados foram baixados (Data Scrapping)
## Relatar de onde os dados foram baixados e dar url do github
## mostrar posicionamento geográficos das unidades de atendimento da Receita Federal do Brasil
##Descrever os bancos de dados utilizados no IBGE
##Descrever os dados geoestatísticos utilizados (IBGE, Google Maps, OpenStreetMaps)
##Descrever os dados e variáveis: inicialmente, usar semelhantes ao disponível no cidades.ibge.gov.br


# Demonstração do raster map no Brasil usando dados da Nature e do IBGE
## mostrar 4 regiões, duas com alto densidade de infraestrutura e 4 com baixa densidade, para mostrar o potencial de diferenças nas classificações

# classificação dos municípios usando vectors (Open Street Map)
## Usar library do open street map para calcular distância entre cada um dos pontos centrais dos municípios brasileiros e cada uma das unidades disponíveis, encontrando a unidade mais próxima para realizar a classificação

# classificação dos municípios por unidade de atendimento
## Municípios com unidades de atendimento já tem classificação; os que tem mais de uma unidade de atendimento são agrupados com todas as unidades dentro daquele município
```

Seção 3 (o que?)
----------------

### Seção 3.1

``` r
# Análise e simulações dos dados dos municípios, agrupados por unidade de atendimento, com a exclusão e adição de postos de atendimento
## usar leaflet para gerar de forma interativa
## tentar usar modelo do Ministério do Planejamento para digitalização de serviços (ou outro modelo melhor) para estimar o custo para a sociedade
## incluir no Leaflet

# Seleção dos contribuintes-alvo
## justificar que os serviços às pessoas jurídicas são mais facilmente digitalizáveis, posto que é quase obrigatório que todos tenham certificados digitais
## Levantar os serviços disponíveis às pessoas físicas
## hipótese, a ser confirmada: basicamente serviços de cadastro e de IRPF
## se confirmado, e posto que serviços de cadastros tem sido terceirizados a outras instituições como o Banco do Brasil e os Correios, selecionar os contribuintes fora dos limites de isenção do IRPF nos municípios, para fazer nova análise
## Incluir no leaflet a opção de variar o limite de renda da população
```

### Seção 3.2

Seção para sugerir como inserir o modelo de análise num processo
estratégico completo

-   definir, no processo estratégico da organização, qual a população
    alvo do atendimento físico, para estabelecer parâmetros de
    otimização
-   realizar acompanhamento formal do modelo, com métricas estabelecidas
-   incluir dados reais de atendimento para fazer cross-validation do
    modelo e estimar a relevância da distância na decisão do
    atendimento, assim como a distância entre o público ideal (definido
    estratégicamente) e o público real
-   revisar dados de infraestrutura de transporte para melhorar a
    acurácia das informações de movimentação

Conclusão
---------

Referências
-----------
