MEco <- read_csv("C:/Users/02741207399/Desktop/Escritório de Processos/processos MEco-completo.csv")
RFB <- read_csv("C:/Users/02741207399/Desktop/Escritório de Processos/processos RFB-completo.csv")

library(tidyverse)


depara <- RFB %>% 
            select('processo', 'macroprocesso', 'processo - MEco') %>% 
            full_join((MEco %>% select(processo, macroprocesso)), by=c("processo - MEco" = 'processo')) %>% 
            rename(
              processo_RFB = processo,
              processo_MEco = "processo - MEco",
              macroprocesso_MEco = macroprocesso.y,
              macroprocesso_RFB = macroprocesso.x
            ) %>% 
            select(macroprocesso_RFB, processo_RFB, macroprocesso_MEco, processo_MEco) %>% 
            arrange(macroprocesso_RFB, processo_RFB, macroprocesso_MEco, processo_RFB)

write.csv(depara, "depara MEco- RFB.csv")
