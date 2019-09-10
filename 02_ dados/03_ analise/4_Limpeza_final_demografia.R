#Limpeza final dos dados demográficos
demog_munis <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/Informações extras IBGE/TCC - produtos/03_cidades&unidades.rds") %>% 
                  select(-c(Cód..x, Cód..y, municipio, uf))
demog_areas <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/Informações extras IBGE/TCC - produtos/03_02_areasPond&unidade.rds") %>% 
                  rename(Cod_ibge = Cod_Cidade) %>% 
                  select(Cod_ibge, Cidade, Estado, Cod_Area_Pond, area_ponderacao, Unidade, Bairro, Logradouro, 'inativo-20_24':'pop_2010_sem_rendimento', geometry)
                  
demog_munis <- demog_munis %>% 
          rename(
            inativo_2024 = "inativo-20_24",              
            inativo_2529 = "inativo-25_29",             
            inativo_3034 = "inativo-30_34",              
            inativo_3539 = "inativo-35_39",             
            inativo_4044 = "inativo-40_44",             
            inativo_4549 = "inativo-45_49",              
            inativo_5054 = "inativo-50_54",              
            inativo_5559 = "inativo-55_59",             
            inativo_6069 = "inativo-60_69",             
            inativo_70plus = "inativo-70_plus",
            inativo_19less = "inativo-19less",            
            ativo_2024 = "ativo-20_24",                
            ativo_2529 = "ativo-25_29",                
            ativo_3034 = "ativo-30_34",                
            ativo_3539 = "ativo-35_39",               
            ativo_4044 = "ativo-40_44",                
            ativo_4549 = "ativo-45_49",                
            ativo_5054 = "ativo-50_54",                
            ativo_5559 = "ativo-55_59",               
            ativo_6069 = "ativo-60_69",                
            ativo_70plus = "ativo-70_plus",              
            ativo_19less = "ativo-19less",            
            salMin_00to005 = "pop_2010_0.0_0.5_sal_min",   
            salMin_005to01 = "pop_2010_0.5_1.0_sal_min",   
            salMin_01to02 = "pop_2010_01_02_sal_min",   
            salMin_02to05 = "pop_2010_02_05_sal_min",   
            salMin_05to10 = "pop_2010_05_10_sal_min",  
            salMin_10to20 = "pop_2010_10_20_sal_min", 
            salMin_20plus = "pop_2010_20_plus_sal_min",   
            salMin_semrendimento = "pop_2010_sem_rendimento"
          )

demog_areas <- demog_areas %>% 
                  rowwise() %>% 
                  mutate(
                    ativo_6069 = ativo_6064 + ativo_6569,
                    inativo_6069 = inativo_6064+inativo_6569,
                    salMin_02to05 = salMin_02to03 + salMin_03to05,
                    ativo_6064 = NULL,
                    ativo_6569 = NULL,
                    inativo_6064 = NULL,
                    inativo_6569 = NULL,
                    salMin_02to03 = NULL,
                    salMin_03to05 = NULL
                  ) %>% 
                  ungroup()

demog_munis <- demog_munis %>% rename(salMin_semdec = "pop_2010_sem_declaracao") %>% mutate(salMin_semrendimento = salMin_semrendimento + salMin_semdec, salMin_semdec = NULL)

demog <- demog_munis %>% bind_rows(demog_areas)



