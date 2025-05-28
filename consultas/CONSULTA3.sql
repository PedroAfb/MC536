WITH regiao_al AS (
    SELECT id_regiao_administrativa
    FROM regiao_administrativa
    WHERE nome = 'Amazônia Legal'
),
estados_al AS (
    SELECT era.estado_id_estado AS id_estado, e.nome, e.uf
    FROM estado_regiao_administrativa era
    JOIN estado e ON era.estado_id_estado = e.id_estado
    WHERE era.regiao_administrativa_id_regiao_administrativa = (SELECT id_regiao_administrativa FROM regiao_al)
),
temperatura_por_estado AS (
    SELECT
        e.id_estado,
        EXTRACT(YEAR FROM rm.data_horario_coleta) AS ano,
        AVG(rm.temperatura_max) AS temperatura_max_media,
        AVG(rm.temperatura_min) AS temperatura_min_media
    FROM relatorio_meteorologia rm
    JOIN estacao_meteorologica em ON rm.id_estacao_meteorologica = em.id_estacao_meteorologica
    JOIN cidade c ON em.id_cidade = c.id_cidade
    JOIN estados_al e ON c.id_estado = e.id_estado
    GROUP BY e.id_estado, EXTRACT(YEAR FROM rm.data_horario_coleta)
),
temperatura_regiao AS (
    SELECT
        ano,
        ROUND(AVG((temperatura_max_media + temperatura_min_media) / 2), 2) AS temperatura_media_regiao
    FROM temperatura_por_estado
    GROUP BY ano
),
focos_estado AS (
    SELECT
        rq.id_estado,
        EXTRACT(YEAR FROM rq.mes_ano) AS ano,
        SUM(rq.quantidade) AS total_focos_estado
    FROM relatorio_focos_queimadas rq
    JOIN estados_al e ON rq.id_estado = e.id_estado
    GROUP BY rq.id_estado, EXTRACT(YEAR FROM rq.mes_ano)
),
focos_regiao AS (
    SELECT
        ano,
        SUM(total_focos_estado) AS total_focos_regiao
    FROM focos_estado
    GROUP BY ano
),
emissao_regiao AS (
    SELECT
        ano,
        SUM(co2_1a_ordem + co2_2a_ordem + co2_por_fogo + co2_por_decaimento + ch4_eq_fogo + n2o_eq_fogo) AS total_emissao_gases
    FROM relatorio_emissao_gases_anual
    WHERE id_regiao_administrativa = (SELECT id_regiao_administrativa FROM regiao_al)
    GROUP BY ano
)
SELECT
    e.ano,
    e.total_emissao_gases,
    t.temperatura_media_regiao,
    f.total_focos_regiao
FROM emissao_regiao e
LEFT JOIN temperatura_regiao t ON e.ano = t.ano
LEFT JOIN focos_regiao f ON e.ano = f.ano
WHERE e.total_emissao_gases IS NOT NULL
  AND t.temperatura_media_regiao IS NOT NULL
  AND f.total_focos_regiao IS NOT NULL
ORDER BY e.ano;
