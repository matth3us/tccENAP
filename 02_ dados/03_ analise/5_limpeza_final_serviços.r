#limpar dados de público alvo:
servicos <- servicos %>% 
  mutate(
    publico_alvo = as.character(publico_alvo),
    publico_alvo = str_replace(publico_alvo, "  e", " e"),
    publico_alvo = str_replace(publico_alvo, "\n", " e "),
    publico_alvo = str_replace(publico_alvo, " \n", " e "),
    publico_alvo = str_replace(publico_alvo, "\\(matrícula CEI\\).", ""),
    publico_alvo = str_replace(publico_alvo, "\\(matrícula CEI\\)", ""),
    publico_alvo = str_replace(publico_alvo, "Jurídica\\.", "Jurídica"),
    publico_alvo = str_replace(publico_alvo, "Física\\.", "Física"),
    publico_alvo = str_replace(publico_alvo, "Pessoa Jurídicae Pessoa Física\\(", "Pessoa Física e Pessoa Jurídica"),
    publico_alvo = str_replace(publico_alvo, "Pessoa Jurídicae Pessoa Física\\(\\.", "Pessoa Física e Pessoa Jurídica"),
    publico_alvo = str_replace(publico_alvo, "Pessoa Físicae Pessoa Jurídica", "Pessoa Física e Pessoa Jurídica"),
    publico_alvo = str_replace(publico_alvo, "Pessoa Jurídica e Pessoa Física", "Pessoa Física e Pessoa Jurídica"),
    publico_alvo = str_replace(publico_alvo, "Pessoa Física  e Pessoa Jurídica", "Pessoa Física e Pessoa Jurídica"),
    publico_alvo = str_trim(publico_alvo),
    publico_alvo = as.factor(publico_alvo)
  )