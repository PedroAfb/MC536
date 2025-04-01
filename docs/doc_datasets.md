## Explicação das Colunas do Dataset do PRODES

Esse dataset fornece dados de desmatamento detectado por satélite na Amazônia Legal Brasileira.

  - fid → Identificador único da linha no banco de dados.

  - state → Estado onde ocorreu o desmatamento.

  - path_row → Referência da cena de satélite (órbita/ponto).

  - main_class / class_name / sub_class → Classificação da cobertura da terra.

  - def_cloud → Percentual de cobertura de nuvens na imagem.

  - julian_day → Dia do ano em formato juliano (1 a 365).

  - image_date → Data da captura da imagem.

  - year → Ano do dado de desmatamento.

  - area_km → Área desmatada (km²).

  - scene_id → Identificação da cena de satélite.

  - source / satellite / sensor → Fonte e equipamento que capturou os dados.

  - uuid → Identificação única do registro.

## Explicação das Colunas do Dataset do INPE
Esse dataset estima as emissões de gases do efeito estufa resultantes da mudança da cobertura da terra na Amazônia Legal Brasileira.
- Variáveis de Desmatamento

  - Year → Ano da medição.

  - D_Area (_area) → Área desmatada no ano específico (km²).

  - D_AreaAcc (_AreaAcc) → Área total desmatada acumulada até aquele ano (km²).

- Emissão de CO₂

  - VR_CO2_1stOrder (_CO2_1stOrder) → Emissão de CO₂ de primeira ordem: refere-se ao CO₂ liberado imediatamente no momento do desmatamento, principalmente pela queima da vegetação.

  - VR_CO2_2ndOrder (_CO2_2ndOrder) → Emissão de CO₂ de segunda ordem: refere-se ao CO₂ liberado ao longo do tempo, à medida que o material vegetal restante se decompõe.

  - VR_CO2_2ndOrderFire (_CO2_2ndOrderFire) → Parcela das emissões de segunda ordem que foram emitidas pelo fogo.

  - VR_CO2_2ndOrderDecay (_CO2_2ndOrderDecay) → Parcela das emissões de segunda ordem que foram emitidas pela decomposição da biomassa.

- Emissão de Outros Gases de Efeito Estufa

  - VR_CH42Eq_2ndOrderFire (_CH4Eq_2ndOrderFire) → Emissão de metano (CH₄) no desmatamento, convertido em equivalente de carbono.

  - VR_N2OEq_2ndOrderFire (_CN2OEq_2ndOrderFire) → Emissão de óxido nitroso (N₂O) no desmatamento, convertido em equivalente de carbono.

- Vegetação Secundária e Absorção de CO₂

  - SV_AreaTotal (_AreaTotal) → Área total coberta por vegetação secundária (km²). É a soma das áreas que passaram por desmatamento, mas onde a floresta conseguiu crescer novamente.

  - SV_AreaCleared (_AreaCleared) → Área da vegetação secundária que foi desmatada (km²).

  - SV_CO2Emission (_CO2Emission) → Emissão de CO₂ resultante do corte da vegetação secundária. Esse campo se refere especificamente às emissões de CO₂ provenientes do desmatamento da vegetação secundária.

  - SV_CO2Absorption (_CO2Absorption) → Quantidade de CO₂ absorvida pelo recrescimento da vegetação secundária.

- Balanço Final de Emissões

  - NET_CO2_2ndOrder (_NET_CO2_2ndOrder) → Balanço líquido considerando o processo de decomposição e fogo.
    Ele leva em conta não apenas o CO₂ liberado no desmatamento, mas também o carbono que continua sendo emitido ao longo do tempo pela decomposição da matéria orgânica (troncos, folhas caídas) e pelo fogo.
    Também considera a absorção de carbono pela regeneração florestal.

  - NET_CO2_1stOrder (_NET_CO2_1stOrder) → Balanço líquido considerando apenas as emissões comprometidas no momento do desmatamento.
    Esse campo representa o balanço líquido imediato de emissões, ou seja, apenas o CO₂ liberado no momento do desmatamento.
    Ele não considera as emissões de longo prazo da decomposição.
    Também não inclui a absorção de CO₂ pelo recrescimento da vegetação.



## O que é Vegetação Secundária?
Vegetação secundária é a floresta que cresce em áreas anteriormente desmatadas. 
Quando uma área é desmatada, parte dela pode ser usada para agricultura ou pecuária, mas, em alguns casos, a vegetação pode voltar a crescer naturalmente ou por reflorestamento. 
Esse processo é importante porque essa vegetação pode sequestrar (absorver) CO₂ da atmosfera.
