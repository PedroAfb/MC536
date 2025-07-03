WITH estados_al AS (
    SELECT e.id_estado
    FROM estado e
    JOIN estado_regiao_administrativa era ON e.id_estado = era.estado_id_estado
    JOIN regiao_administrativa ra ON era.regiao_administrativa_id_regiao_administrativa = ra.id_regiao_administrativa
    WHERE ra.nome = 'Amazônia Legal'
),
temperatura_por_estado AS (
    SELECT
        e.id_estado,
        EXTRACT(YEAR FROM mc.data_horario_coleta) AS ano,
        AVG(mc.temperatura_max) AS temperatura_max_media,
        AVG(mc.temperatura_min) AS temperatura_min_media
    FROM medicoes_climaticas mc
    JOIN estacao_meteorologica em ON mc.id_estacao_meteorologica = em.id_estacao_meteorologica
    JOIN cidade c ON em.id_cidade = c.id_cidade
    JOIN estados_al e ON c.id_estado = e.id_estado
    GROUP BY e.id_estado, EXTRACT(YEAR FROM mc.data_horario_coleta)
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
        fq.id_estado,
        EXTRACT(YEAR FROM fq.mes_ano) AS ano,
        SUM(fq.quantidade) AS total_focos_estado
    FROM focos_queimadas fq
    JOIN estados_al e ON fq.id_estado = e.id_estado
    GROUP BY fq.id_estado, EXTRACT(YEAR FROM fq.mes_ano)
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
    FROM emissao_gases eg
    JOIN regiao_administrativa ra ON eg.id_regiao_administrativa = ra.id_regiao_administrativa
    WHERE ra.nome = 'Amazônia Legal'
    GROUP BY ano
)
SELECT
    e.ano,
    e.total_emissao_gases,
    t.temperatura_media_regiao,
    f.total_focos_regiao
FROM emissao_regiao e
INNER JOIN temperatura_regiao t ON e.ano = t.ano
INNER JOIN focos_regiao f ON e.ano = f.ano
ORDER BY e.ano;
