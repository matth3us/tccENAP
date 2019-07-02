[TOC]

# Proposta de procedimento geoestatísticos para a gestão estratégica do atendimento presencial da Receita Federal do Brasil

Celso Mattheus Cantanhede Silva

## Introdução

## Seção 1

Quantos quilômetros deve andar um cidadão em busca de acesso a um serviço para que possamos considerar que ele não tem acesso?

Os recursos, sabemos, são escassos, frente às necessidades e desejos. A nobreza do valor entregue pelos serviços públicos não subverte esta incômoda realidade, e cabe aos gestores da coisa pública planejar, executar e controlar os que estiverem sob sua responsabilidade de forma a conhecer a demanda para maximizar a oferta. 

Serviços, diz a definição <!-- 💭 citation needed -->, são intangíveis. São transações que não envolvem a entrega de bens materiais. Como tal, não podem ser manufaturados, transportador, nem guardados para uso futuro. São produzidos e consumidos simultâneamente. Hoje, com o advento da internet e das TIC (tecnologias da informação e da comunicação), é possível oferecer diversos serviços sem que seja necessário a presença do ofertante e do demandante no mesmo local físico. Ainda assim, diversos serviços não são digitalizáveis, e mesmo alguns digitalizáveis ainda precisam ser ofertados de maneira tradicional devido à desigualdade de acesso a tais tecnologias. 

Este é o caso do atendimento presencial oferecido por diversos órgãos públicos, conjunto nos quais está inserida a Secretaria da Receita Federal do Brasil (RFB). O atendimento é um dos principais canais de contato do cidadão com a Receita Federal, junto com os entrepostos aduaneiros. Por meio do atendimento, o cidadão pode tanto entregar quanto requisitar informações, declarações e documentos essenciais à conformidade tributária, auxiliando no papel da instituição de recolher os recursos necessários ao provimento dos diversos serviços públicos oferecidos pelo Estado brasileiro. No papel de orientação, são também instrumentos de educação fiscal e promoção da auto-regularização, fomentando uma cultura de conformidade pro-ativa e cidadã.

O atendimento já passou por larga digitalização, o que podemos perceber em seus números. Entre 2012 e 2017, o e-Cac, portal de atendimento na internet da RFB, passou de 66,6 milhões de atendimentos para 145,6 milhões de atendimentos; enquanto isso, os atendimentos presenciais caíram de 20,2 milhões para 14,9 milhões no mesmo período, de forma que o percentual destes passou de cerca de 24% do total para apenas 9% @gestãoRFB. Mesmo assim, 14,9 milhões de atendimentos podem ser traduzidos como cerca de 40.000 atendimentos por dia espalhados por centenas <!-- 💭 conferir número exato de unidades --> de unidades de atendimentos em todo o país. Há, portanto, ainda, uma demanda presencial a ser preenchida. 

Desta realidade surgem os dilemas do gestor. Para suprir essa necessidade de simultaneidade física entre os servidores da RFB e o cidadão demandando serviços, ao gestor cabe escolher como distribuir geograficamente seus recursos materiais e os servidores disponíveis. 

Estes dilemas não tem soluções únicas. Possíveis respostas vem sido levantadas em outros setores de serviço, como de transporte e de saúde, com a aplicação de sistemas de informações geográficas e técnicas de geoestatísticas que permitam encontrar soluções numericamente mais satisfatórias. 

No exemplo do setor de saúde, por exemplo, temos que os "health care services are provided at a finite number of fixed locations, yet they serve populations that are continuously and unevenly distributed throughout a region (@AF p. 1)".   Consequência natural desse arranjo é que as desigualdades são inevitáveis, mas a dimensão dessas é função do arranjo de distribuições das peças do sistemas, da distribuição no espaço da população, e das características do espaço como infraestrutura e relevo que dificultem ou facilitem a movimentação @AF.

Os fatores mencionados devem ser levados em consideração quando da distribuição dos recursos organizacionais. Ao se analisar a relação entre população e o espaço físico, podemos identificar qual o atrito existente para diferentes grupos populacionais terem acesso a um serviço, identificar grupos que moram em áreas com acessibilidade limitada, e, desta forma, "understand the effects of opening, closing, or realocating health care facilities (@AF  p. 2)". Desta forma, promove-se a equidade, que "(...) manifests itself in the distribution, access to and utilization of health services between population groups (@AD p. 917)".

A relevância da distribuição ótima é tanto mais importante quanto mais escassos forem os recursos disponíveis. O Brasil enfrenta desde meados de 2014 uma grave crise econômica, que tem efeitos diversos sobre a população e sobre a estrutura administrativa do Estado. Mesmo o órgão arrecadador não escapa das restrições necessárias ao ajuste fiscal aplicado na tentativa de debela-la. Neste sentido, o TCU, em auditoria operacional realizada na RFB, relata que  "além da crise econômica que o País vem enfrentando, que impacta a receita fazendária e a previdenciária, tem-se constatado a ocorrência de baixa recuperação dos créditos trbutários administrados pela RFB" (@AY p. 1). 

Os reflexos internos na Receita Federal do Brasil são o contingenciamento de despesas e a consequente paralisação de concursos, estancando o fluxo de renovação de servidores. Em paralelo, há um processo de aceleração no quantitativo de aposentadorias, muitas delas influenciadas pelo temor que os anúncios da reforma previdenciária inspiram. Valendo lembrar que muitos servidores na ativa  já alcançaram o requisito mínimo para aposentar-se, mas continuam em serviço, incentivados pelo “abono permanência” @AY. Entre 2015 e 2017, a RFB perdeu 1831 servidores, de um total inicial de 23.687, o que representa menos 7.7% de sua força de trabalho em apenas 3 anos.

Certamente que a dimunuição absoluta de servidores não conta toda a história, posto que, com o avançar da digitalização do governo, percebe-se um aumento de produtividade que poderia diminuir ou até mesmo sanar os efeitos dessa queda no quantitativo de pessoal. Todavia, o TCU lembra que "(...) não se pode contar apenas com a evolução dos meios de tecnologia da informação, pois os mesmos dependem de fatores exógenos como questões orçamentárias, disponibilidade do Serpro para desenvolvimento de sistemas e outros que não permitem sua evolução com velocidade o suficiente para suprir a nova demanda" (@AY p. 20).

Desta forma, temos todos os fatos em frente aos gestores da Receita Federal do Brasil. De um lado, há um quantitativo decrescente de servidores disponíveis para todas as tarefas da organização, não apenas o atendimento. De outro, a digitalização possui diversos obstáculos e entraves que impossibilitam substituir imediatemente o atendimento presencial. 

Cabe-os então decidir, como distribuir os recursos da forma mais eficiente? De que maneira promover a equidade no acesso aos serviços da organização? O objetivo do presente trabalho é sugerir um modelo que, incluído num processo maior, possa responda às essas necessidades.

Acreditamos, antes de tudo, que esse processo de distribuição das unidades de atendimento está no âmago da estratégia da Receita Federal do Brasil e de seu propósito para a sociedade. Como tal, sugerimos que, definidas as balizas estratégicas de qual o público alvo deve ser atingido pelas unidades de atendimento, a organização empregue modelos geoestatísticos na tomada de decisões de que unidades abrir e fechar e quantos servidores devem se dedicar em cada unidade, de acordo com a demanda estimada para cada ponto geográfico. Desta forma, a distribuição destes recursos estaria mais alinhada ao seu objetivo social, tornando-o menos vulnerável a captura política.  

Este trabalho, de forma mais pontual, busca mostrar a viabilidade do cruzamento de dados estatísticos e geoestatístico do IBGE e de outras fontes para conhecer e explorar informações relevantes sobre o público alvo das unidades de atendimento, um dos passos necessários ao processo mencionado acima. 

Antes de passarmos a sua execução, cabe uma ressalva importante que deve ser levada em conta quando da promoção de acessibilidade. Embora a disponibilidade e a distância sejam fatores relevantes, não são suficientes; o aumento da acessibilidade nem sempre é acompanhado de um aumento da utilização dos serviços, e outros fatores devem ser avaliados também, como qualidade do serviço oferecido e disponibilidade de canais mais convenientes @AZ, como os próprios canais digitais supracitados .

## Seção 2



> Descrever os bancos de dados utilizados no IBGE
>
> Descrever os dados geoestatísticos utilizados (IBGE, Google Maps, OpenStreetMaps)
>
> Descrever os dados e variáveis: inicialmente, usar semelhantes ao disponível no cidades.ibge.gov.br



Há duas formas de se dispor os dados em sistemas de informação geográficas. Há os modelos vetoriais, que podem ser analisados como grafos em redes (network graphs); e os modelos em grade (raster). 

Os modelos vetoriais consistem de uma série de nós, conectados por linhas, representando os objetos geográficos. Pontos no mapa são representados por nós, conexões e infraestruturas como ferrovias e rodovias são linhas, e regiões são delimitadas por polígonos consistindo dos dois. Nos modelos vetoriais, o custo para atravessar uma linha é definido pelo tamanho da linha e pela velocidade de viagem associado àquele tipo de infraestrutura. O custo para atravessar uma linha é definido pelo tamanho da linha e pela velocidade de viagem associado àquele tipo de infraestrutura @AF. a movimentação, portanto, ocorre entre pontos, de acordo com as linhas disponíveis para cada ponto. 

<!-- inserir ilustração de modelo vetorial -->

Os modelos de grade são compostos por uma série de celulas regulares, geralmente retangulares, de tamanho e distância padronizados. Cada ponto do mapa é resumido em um dos retângulos, e todas as informações relevantes do mapa dentro da região encoberta por aquele retângulo são a ele anexados <!-- pensar em outra palavra -->. No modelo de grade, as viagens ocorrem na passagem de uma célula para outra,  sempre em entre células adjacentes; assim, diferente do modelo em rede, os passos da viagem são sempre regulares em distância, variando apenas na velocidade @AF.

<!-- inserir ilustração de modelo de grade -->

Há uma diferença fundamental na forma como esses modelos compreendem o espaço.

"The raster data model defines space as a continuous surface where each cell within the data extent has a specific location and attribute value. The network data model defines space as an empty container that is populated only by features having specific locations and attributes." ( @AF p. 12)

Como todas as localizações do mapa são explicitamente definidadas nos modelos de grade, isso torna-os "(...) attractive for creating service areas, specially in regions without a all-encompassing transportation network (@AF p. 4)". Todavia, "real-world connectivity is not accounted for in the raster data model." (...) "Therefore, movement is less restricted in the raster data model than in the real world and travel time estimates will generaly be underestimated" (@AF  p. 15). Isso ocorre porque o meodelo considera que todos os pontos do mapa são atravessáveis, fazendo, por exemplo, que um viajante pudesse aproveitar-se da infraestrutura ferroviária entrando em qualquer ponto que fosse mais próximo dele, ignorando a existência de estações ou, no caso de rodovias, intersecções @AF, @AB.

Para nós, a adoção de um modelo em grade nos parece mais interessante. Embora ele tenha as limitações mencionadas acima, sem falar no seu custo computacional mais elevado, nós acreditamos que, ao se analisar a movimentação em todo o Brasil, especialmente em regiões mais afastadas dos grandes centros populacionais, os mapas em grade acabarão por nos fornecer uma perspectiva mais realista.

A forma como essa movimentação é modelada também deve ser explicitada. Certamente que, até computacionalmente, seria consideravelmente mais simples estimar as distâncias "as the crow flies" (com o voar do corvo), ou seja, a distância linear entre cada um dos pontos e as unidades de atendimento. Todavia, essa estimativa ignora completamente a infraestrutura e os obstáculos existentes, tornando a análise pouco útil @AC. 

Mais interessante é a estimativa "as the wold run" (com o correr dos lobos), pelo custo mínimo de viagem. Isso é realizado ao se atribuir um custo de fricção a cada um dos pontos da grade, de acordo com as infraestruturas e obstáculos daquele ponto, e assim, estimar o caminho com menor fricção entre os pontos e as unidades de atendimento. Para iso, pretendemos utilizar o pacote gdistance, de R, que "(...) provides functionality to calculate various distance measures and routes in heterogeneous geographic spaces represented as grids" @AC p. 1. 

Para este trabalho, utilizaremos o mapa gerado pelo Malaria Atlas Project <!-- --> para estimar o custo de friccão. Este é um mapa que "quantifies travel time to cities in 2015 at a spatial resolution of approximately one by one kilometre by integrating ten global-scale surfaces that characterize factors affecting human movement rates and 13.840 high-density urban centres within an established geospatial-modelling framework" (@AB p. 333). 

Uma gama de informações diferentes foram combinadas na geração desse mapa. "The datasets that we used to construct the friction surface characterize the spatial locations and properties of roads, railroads, rivers, bodies of water, topographical conditions (elevantion and slope angle), land cover and national borders." (@AB p. 337)

Algumas presunções devem ser explicitadas antes de qualquer análise. Primeiro, os modelos assumem que todos possuem acesso a veículos similares e que se movimentam nesses veículos de forma similar, o que pode ser pouco realista mesmo considerando-se apenas viagens terrestes. "Wealth, in particular, is a likely determinant of whether someone travels on foot rather than taking a vehicle and thus substantially affects acessibility on the level of the individual." (@AB p. 338)

Em segundo lugar, assume-se uniformidade nas condições de viagem, ignorando-se horário, sazonalidades como horário de rush ou fins de semana e feriados, variações temporais, etc.  Em terceiro lugar, assume-se que as pessoas conhecem o caminho mais eficiente; uma presunção razoável atualmente, com o amplo acesso à sistemas de navegação em celulares e computadores. Em quarto lugar, presume-se que as populações concentram-se num único ponto; ou seja, qualquer variação da distribuição interna a cada um dos retângulos da grade é ignorada, e atribui-se à centroide de cada retângulo a totalidade da população daquele espaço @AF.

Por fim, há um problema específico a análise do público-alvo de cada uma das unidades de atendimento, como definiremos abaixo. Enquanto temos algumas informações da distribuição da população no espaço em mapa de grade, a maior parte das informações demográficas foram registradas apenas no nível municipal. Como tal, podemos calcular a distância dos postos de atendimento a cada um dos pontos do mapa, mas temos que usar essa informação para tomar uma decisão de qual unidade de atendimento atende a cada município. Não será possível, por exemplo, dividir as informações de um município que se localize relativamente próxima a mais de uma unidade de atendimento. 

Essas limitações decorrem não apenas dos custos que envolveriam realizar levantamentos demográficos para cada um dos pontos geográficos do país, mas também devido aos riscos à privacidade que envolveriam esse levantamento. <!-- citar IBGE aqui --> Como tal, reconhecemos que há o risco enfrentarmos algumas falácias estatísticas em nossas análises, como a falácia ecológica e o problema da unidade de área modificável. 

## Seção 3

### Seção 3.1

```R
# Como os dados foram baixados (Data Scrapping)
## mostrar script para download dos dados do IBGE
## mostrar script para download dos dados da RFB
## mostrar posicionamento geográficos das unidades de atendimento da Receita Federal do Brasil

# classificação dos municípios usando vectors (Open Street Map)
## Usar library do open street map para calcular distância entre cada um dos pontos centrais dos municípios brasileiros e cada uma das unidades disponíveis, encontrando a unidade mais próxima para realizar a classificação

# preparação dos dados do raster grid
## mostrar onde os brasileiros vivem, como na reportagem da Nexo

# preparação da matriz de transição
## usar dados da Nature

# Cálculo da superfície de custo acumulado (Accumulated Surface Cost)
## justificar fórmula utilizada

# classificação dos municípios por unidade de atendimento
## Municípios com unidades de atendimento já tem classificação; os que tem mais de uma unidade de atendimento são agrupados com todas as unidades dentro daquele município
## Os Municípios que não tem unidade são classificador de acordo com uma "votação" da unidade mais próxima a cada um dos locus habitados do município

# comparação entre raster e vector based
## identificar municípios que mudaram de classificação

# data mining dos dados do IBGE combinados a partir dos clusters gerados na classificação dos municípios

# simulações com a exclusão e adição de postos de atendimento
```

### Seção 3.2

Seção para sugerir como inserir o modelo de análise num processo estratégico completo

- definir, no processo estratégico da organização, qual a população alvo do atendimento físico, para estabelecer parâmetros de otimização
- realizar acompanhamento formal do modelo, com métricas estabelecidas
- incluir dados reais de atendimento para fazer cross-validation do modelo e estimar a relevãncia da distância na decisão do atendimento, assim como a distância entre o público ideal (definido estratégicamente) e o público real
- revisar dados de infraestrutura de transporte para melhorar a acurácia das informações de movimentação

## Conclusão