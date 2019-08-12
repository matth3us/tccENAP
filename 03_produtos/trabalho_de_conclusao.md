-   [Proposta de procedimento geoestatísticos para a gestão estratégica
    do atendimento presencial da Receita Federal do
    Brasil](#proposta-de-procedimento-geoestatisticos-para-a-gestao-estrategica-do-atendimento-presencial-da-receita-federal-do-brasil)
    -   [Introdução](#introducao)
    -   [Seção 1 (por que?)](#secao-1-por-que)
    -   [Seção 2 (como?)](#secao-2-como)
    -   [Seção 3 (o que?)](#secao-3-o-que)
        -   [Seção 3.1](#secao-3.1)
        -   [Seção 3.2](#secao-3.2)
    -   [Conclusão](#conclusao)
    -   [Referências](#referencias)

<!-- 
# Informações para edição do documento de acordo com as normas da ENAP

https://bookdown.org/yihui/rmarkdown/pdf-document.html
https://stackoverflow.com/questions/52118202/change-line-spacing-for-rmd-abstract

-->
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

<!-- 💭 citation needed: definição de serviços -->
Serviços, diz a definição, são intangíveis: transações que não envolvem
a entrega de bens materiais e conquanto, não assumem uma forma. Como
tal, não podem ser manufaturados, transportados, nem guardados para uso
futuro. São produzidos e consumidos simultâneamente. Hoje, com o advento
da internet e das TIC (tecnologias da informação e da comunicação), é
possível oferecer diversos serviços sem que seja necessária a presença
do ofertante e do demandante no mesmo local físico. O acesso a essas
tecnologias, claro, ainda é limitado.

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
destes passou de cerca de 24% do total para apenas 9% (<span
class="citeproc-not-found"
data-reference-id="gestãoRFB">**???**</span>). Mesmo assim, 14,9 milhões
equivalem a 40.000 cidadãos recebidos nas centenas de unidades da RFB
por dia, em todo o país.

<!-- 💭 conferir número exato de unidades -->
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
unevenly distributed throughout a region (Delamater et al. 2012, 1)”.
Consequência natural desse arranjo é que as desigualdades são
inevitáveis, mas a dimensão dessas é função: do arranjo de distribuições
das partes do sistemas; da distribuição no espaço da população; e das
características do espaço, como infraestrutura e relevo, que dificultem
ou facilitem a movimentação (Delamater et al. 2012).

Ao se analisar a relação entre população e o espaço físico, podemos
evidenciar o atrito contrário ao acesso a um sevriço de diferentes
grupos populacionais, identificar áreas de maior limitação no acesso, e,
assim, “understand the effects of opening, closing, or realocating
health care facilities (Delamater et al. 2012, 2)”. Desta forma,
promove-se a equidade, que “(…) manifests itself in the distribution,
access to and utilization of health services between population groups”
(Noor et al. 2003, 917).

A relevância da distribuição ótima é tanto mais importante quanto mais
escassos forem os recursos disponíveis. O Brasil enfrenta desde meados
de 2014 uma grave crise econômica, com efeitos diversos sobre a
população e sobre a estrutura administrativa do Estado. Mesmo o órgão
arrecadador não escapa das restrições necessárias ao ajuste fiscal
aplicado na tentativa de debela-la. Neste sentido, o TCU, em auditoria
operacional realizada na RFB, relata que “além da crise econômica que o
País vem enfrentando, que impacta a receita fazendária e a
previdenciária, tem-se constatado a ocorrência de baixa recuperação dos
créditos trbutários administrados pela RFB” (Contas da União 2017, 1).

Os reflexos internos na Receita Federal do Brasil são o
contingenciamento de despesas e a consequente paralisação de concursos,
estancando o fluxo de renovação de servidores. Em paralelo, há um
processo de aceleração no quantitativo de aposentadorias, muitas delas
influenciadas pelo temor que os anúncios da reforma previdenciária
inspiram. Vale lembrar que muitos servidores na ativa já alcançaram o
requisito mínimo para aposentar-se, mas continuam em serviço,
incentivados pelo chamado abono permanência (Contas da União 2017).
Entre 2015 e 2017, a RFB perdeu 1.831 servidores, de um total inicial de
23.687, o que representa uma diminuição de 7,7% de sua força de trabalho
em apenas 3 anos.

Este enxugamento, pode-se argumentar não seria de todo impactante na
organização, posto que, com o avançar da digitalização do governo,
espera-se um aumento na produtividade que compense em parte ou mesmo
totalmente os efeitos da diminuição no quantitativo de pessoal. Todavia,
lembra o TCU que “(…) não se pode contar apenas com a evolução dos meios
de tecnologia da informação, pois os mesmos dependem de fatores exógenos
como questões orçamentárias, disponibilidade do Serpro para
desenvolvimento de sistemas e outros que não permitem sua evolução com
velocidade o suficiente para suprir a nova demanda” (Contas da União
2017, 20).

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
mais convenientes (Thaddeus and Maine 1994), como os próprios canais
digitais supracitados. Que fique claro que a definição de onde dispor
unidades de atendimento é apenas um passo do objetivo estratégico de
atender bem a população.

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
associado àquele tipo de infraestrutura (Delamater et al. 2012). a
movimentação, portanto, ocorre entre pontos, de acordo com as linhas
disponíveis para cada ponto.

Os modelos de grade são compostos por uma série de celulas regulares,
geralmente retangulares, de tamanho e distância padronizados. Cada ponto
do mapa é resumido em um dos retângulos, e todas as informações
relevantes do mapa dentro da região encoberta por aquele retângulo são a
ele atribuído. No modelo de grade, as viagens ocorrem na passagem de uma
célula para outra, sempre em entre células adjacentes; assim, diferente
do modelo em rede, os passos da viagem são sempre regulares em
distância, variando apenas na velocidade (Delamater et al. 2012).

![](https://raw.githubusercontent.com/matth3us/tccENAP/master/04_imagens/figure_12_measuring_geographic_access.png)
Vemos acima, do artigo (Delamater et al. 2012), uma conversão entre um
mapa em network para um mapa em grid. (figure 12 no documento)

Há uma diferença fundamental na forma como esses modelos compreendem o
espaço.

“The raster data model defines space as a continuous surface where each
cell within the data extent has a specific location and attribute value.
The network data model defines space as an empty container that is
populated only by features having specific locations and attributes.”
(Delamater et al. 2012, 12)

Como todas as localizações do mapa são explicitamente definidadas nos
modelos de grade, isso torna-os “(…) attractive for creating service
areas, specially in regions without a all-encompassing transportation
network (Delamater et al. 2012, 4)”. Todavia, “real-world connectivity
is not accounted for in the raster data model.” (…) “Therefore, movement
is less restricted in the raster data model than in the real world and
travel time estimates will generaly be underestimated” (Delamater et al.
2012, 15). Isso ocorre porque o modelo considera que todos os pontos do
mapa são atravessáveis, fazendo, por exemplo, que um viajante pudesse
aproveitar-se da infraestrutura ferroviária entrando em qualquer ponto
que fosse mais próximo dele, ignorando a existência de estações ou, no
caso de rodovias, intersecções (J. Weiss et al. 2018).

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
(Etten 2017). Não faz sentido considerar que um posto de atendimento é o
mais próximo de um município se houver outros postos mais acessíveis
devido à infraestrutura disponível.

Mais interessante é a estimativa “as the wold run” (com o correr dos
lobos), pelo custo mínimo de viagem. Nele, atribuímos um custo de
fricção a cada um dos pontos da grade, de acordo com as infraestruturas
e obstáculos daquele ponto, e assim, estimamos o caminho com menor
fricção entre os pontos e as unidades de atendimento. Para tal fim,
utilizaremos o pacote em R gdistance, que “(…) provides functionality to
calculate various distance measures and routes in heterogeneous
geographic spaces represented as grids” (Etten 2017, 1).

Para este trabalho, utilizaremos o mapa gerado pelo Malaria Atlas
Project para estimar o custo de friccão. Ele “quantifies travel time to
cities in 2015 at a spatial resolution of approximately one by one
kilometre by integrating ten global-scale surfaces that characterize
factors affecting human movement rates and 13.840 high-density urban
centres within an established geospatial-modelling framework” (J. Weiss
et al. 2018, 333). O resultado é um mapa com informações que “(…)
characterize the spatial locations and properties of roads, railroads,
rivers, bodies of water, topographical conditions (elevantion and slope
angle), land cover and national borders” (J. Weiss et al. 2018, 337).

Algumas presunções devem ser explicitadas antes de qualquer análise.
Primeiro, os modelos assumem que todos possuem acesso a veículos
similares e que se movimentam nesses veículos de forma similar, o que
pode ser pouco realista mesmo considerando-se apenas viagens terrestes.
“Wealth, in particular, is a likely determinant of whether someone
travels on foot rather than taking a vehicle and thus substantially
affects acessibility on the level of the individual” (J. Weiss et al.
2018, 338).

Em segundo lugar, assume-se uniformidade nas condições de viagem,
ignorando-se horário, sazonalidades como horário de rush ou fins de
semana e feriados, variações temporais e climáticas, etc. Em terceiro
lugar, assume-se que as pessoas conhecem o caminho mais eficiente; uma
presunção razoável atualmente, com o amplo acesso à sistemas de
navegação em celulares e computadores. Em quarto lugar, presume-se que
as populações concentram-se num único ponto; ou seja, qualquer variação
da distribuição interna a cada um dos retângulos da grade é ignorada, e
atribui-se à centroide de cada retângulo a totalidade da população
daquele espaço (Delamater et al. 2012).

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


## Levantar variáveis de interesse, comparando (https://www.ibge.gov.br/censo2010/apps/areaponderacao/) com o (cidades.gov.br)
# Investigar dados de interesse por áreas de ponderação: https://www.ibge.gov.br/censo2010/apps/areaponderacao/
# Comparar localização das áreas de ponderação na distãncia das unidades de atendimento
# ver geoBr no github, repositórion com star


 Demonstração do raster map no Brasil usando dados da Nature e do IBGE
## mostrar 4 regiões, duas com alto densidade de infraestrutura e 4 com baixa densidade, para mostrar o potencial de diferenças nas classificações

# classificação dos municípios usando vectors (Open Street Map)
## Usar library do open street map para calcular distância entre cada um dos pontos centrais dos municípios brasileiros e cada uma das unidades disponíveis, encontrando a unidade mais próxima para realizar a classificação

### Usar pacote OSRMR (https://cran.r-project.org/web/packages/osrmr/vignettes/osrmr.html) para calcular distância entre cidades e postos de atendimento
## Usar distância linear quando não houver como calcular a distância utilizando os mapas do Open Street Map
## Marcar os que precisarem usar distância linear

 classificação dos municípios por unidade de atendimento
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

&lt;! – rescar livros com definição de políticas píblicas e a
importância do público alvo –&gt; Políticas públicas são respostas
intencionais do Estado a um problema específico, seja pela ação ou pela
omissão. Como tal, são definidas em torno de um problema enfrentado por
uma seção da população. Para serem efetivas, as políticas públicas devem
ser construídas de forma a maximizar o efeito dos recursos empregados
sobre a população-alvo ao mesmo tempo em que se minimiza o dispêndio de
recursos com aqueles fora da população-alvo, de forma a garantir a
eficiência da resposta do Estado.

A definição de qual é a população-alvo de uma política pública, é
portanto, um dos pontos mais cruciais para garantir sua eficiência,
eficácia e efetividade. Se essa população não estiver bem definida,
corre-se o risco de, dentro de um orçamento finito, não haver recursos o
suficiente para resolver o problema para o qual a política pública foi
inicialmente desenhada.

A disponibilização de atendimento presencial na Receita Federal do
Brasil é uma política pública. O serviço serve, primordialmente, para
garantir que o cidadão terá acesso não só a informações necessárias para
agir em conformidade com a norma tributária, mas também e eventualmente,
ter acesso aos meios de efetivar essa conformidade, pela entrega e
emissão de documentos e formulários assim como na geração e atualização
de cadastros e outras informações.

Com o avanço da digitalização dos serviços governamentais, cabe ao
Estado repensar o público-alvo do atendimento presencial. Como o custo
do atendimento digital é múltiplas vezes menor que o de manter postos de
atendimento presenciais, cabe ao Estado equilibrar a garantia de acesso
com a disponibilidade de recursos, buscando um ponto que maximize as
duas variáveis conflitantes. Este ponto de equilíbrio muito
provavelmente estará na oferta do serviço presencial preferencialmente
àqueles que não podem ou não saber como acessar digitalmente.O primeiro
passo, portanto, é identificar, hoje, quem são essas pessoas.
<!-- buscar citação que baseie a afirmação de que o serviço público digital é mais barato; preferencialmente BID ou OCDE -->

Seria interessante que a Receita Federal do Brasil testasse hipóteses em
cima das relações entre variáveis demográficas como renda, idade, gênero
e nível educacional e a preferência entre os canais digitais e
presenciais. Esses estudos podem ser realizados em cima das bases de
dado internas de acesso ao e-Cac e de atendimentos realizados, estes
últimos registrados no Sistema Nacional de Apoio ao Gerenciamento de
Atendimento (SAGA). Conhecendo-se o perfil demográfico do público-alvo,
seria interessante utilizar dados do IBGE e de outras fontes para se
medir o nível de acesso dessa população aos serviços presenciais da
secretaria.

<!-- https://repositorio.enap.gov.br/handle/1/585 -->
<!--    O Sistema Nacional de Apoio ao Gerenciamento do Atendimento (SAGA) foi concebido como um sistema eletrônico de coleta de dados e gerenciamento do atendimento da Receita Federal, em todas as suas etapas. A partir de sua configuração, torna-se possível ajustar as disponibilidades de material e recursos humanos às demandas quantitativas e qualitativas por parte dos contribuintes, de modo a diminuir os tempos de espera e de atendimento e obter um alto grau de conclusividade. O SAGA introduziu novos conceitos na área de atendimento ao público da Receita Federal, aprimorou os mecanismos de controle e gerenciamento, modificou a cultura interna relativa à visão da relação com o contribuinte e proporcionou uma significativa melhoria nessa relação. Um sistema gerencial de fácil utilização e configuração por parte do usuário, constituiu-se em uma ferramenta indispensável de organização das atividades e planejamento de ações, para possibilitar o melhor atendimento ao contribuinte e desenvolver a capacidade gerencial dos chefes das unidades de atendimento  -->
Para avaliarmos esse nível de acesso, poderia-se expandir o processo de
mensuração do acesso realizado nesse artigo. Uma primeira opção seria
realizar comparação mais paciente entre o uso de mapas de grade e mapas
de rede, especialmente nas regiões do país com menor acesso à
infraestrutura de transporte. A comparação forneceria maior
flexibilidade ao modelo, buscando-se a melhor simulação possível.

Segunda opção seria, em vez de utilizar apenas os dados do
OpenStreetMap, adicionar mais bases de dados de infraestrutura e mais
modais de transporte, como o hidroviário no norte do país. Aumentaria-se
assim o realismo do modelo geográfico, possibilitando a construção de
estimativas mais úteis.

Por fim, devemos entender que isso é um processo, não um projeto, ou
seja, ele é contínuo no tempo. À medida que os canais de atendimento
presencial e físico vão se modificando, e a população também se
modifica, novos testes devem ser realizados continuamente, seguindo o
tradicional ciclo de planejamento, execução, controle e avaliação.
Métricas devem ser estabelecidas e melhorias implementadas, buscando
fidedignidade no modelo.

Acreditamos que, dessa forma, estará estabelecido um processo de
planejamento do atendimento presencial com foco no cidadão, otimizando o
gasto público mas sem deixar de lado a garantia do direito de acesso
desse ao serviço público.

Conclusão
---------

Referências
-----------

Contas da União, Tribunal de. 2017. “Auditoria Operacional Realizada Na
Secretaria Da Receita Federal Do Brasil.”

Delamater, Paul, Joseph Messina, Ashton M Shortridge, and Sue C Grady.
2012. “Measuring Geographic Access to Health Care: Raster and
Network-Based Methods.” *International Journal of Health Geographics* 11
(May): 15. <https://doi.org/10.1186/1476-072X-11-15>.

Etten, Jacob van. 2017. “R Package Gdistance: Distances and Routes on
Geographical Grids.” *Journal of Statistical Software* 76 (13).
<https://www.researchgate.net/publication/305656946_R_Package_gdistance_Distances_and_Routes_on_Geographical_Grids>.

J. Weiss, D, Andy Nelson, Harry Gibson, W Temperley, Stephen Peedel, A
Lieber, M Hancher, et al. 2018. “A Global Map of Travel Time to Cities
to Assess Inequalities in Accessibility in 2015.” *Nature* 553 (7688).
<https://www.researchgate.net/publication/322368535_A_global_map_of_travel_time_to_cities_to_assess_inequalities_in_accessibility_in_2015?_sg=Im7RuSiWTkiNinanqup8V53CG0MB12I6dJ_p_Dvci_6XlpcaXrK517NFRuTIudP0Temj5nV3IkWmaog>.

Noor, Abdisalan, Simon Iain Hay, D Zurovac, S.A. Ochola, and Robert W
Snow. 2003. “Defining Equity in Physical Access to Clinical Services
Using Geographical Information Systems as Part of Malaria Planning and
Monitoring in Kenya.” *Tropical Medicine & International Health* 8 (10):
917–26.
<https://www.researchgate.net/publication/9075228_Defining_Equity_in_Physical_Access_to_Clinical_Services_Using_Geographical_Information_Systems_as_Part_of_Malaria_Planning_and_Monitoring_in_Kenya>.

Thaddeus, Sereen, and Deborah Maine. 1994. “Too Far to Walk: Maternal
Mortality in Context.” *Social Science & Medicine* 38 (8): 1091–1110.
<https://www.researchgate.net/publication/46505614_Too_Far_to_Walk_Maternal_Mortality_in_Context>.