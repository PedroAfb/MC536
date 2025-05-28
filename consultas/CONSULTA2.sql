WITH unidades_exclusivas AS (
    SELECT unidade_conservacao_id_unidade_conservacao AS id_uc
    FROM cidade_unidade_conservacao
    GROUP BY unidade_conservacao_id_unidade_conservacao
    HAVING COUNT(DISTINCT cidade_id_cidade) = 1
),
cidade_uc_exclusiva AS (
    SELECT cidade_id_cidade AS id_cidade, unidade_conservacao_id_unidade_conservacao AS id_uc
    FROM cidade_unidade_conservacao
    WHERE unidade_conservacao_id_unidade_conservacao IN (SELECT id_uc FROM unidades_exclusivas)
),
desmatamento_por_cidade AS (
    SELECT id_cidade, SUM(area_km2) AS area_desmatada_cidade
    FROM relatorio_desmatamento
    WHERE ano BETWEEN 2008 AND 2024 AND id_cidade IS NOT NULL
    GROUP BY id_cidade
),
desmatamento_por_uc_exclusiva AS (
    SELECT cue.id_cidade, SUM(rd.area_km2) AS area_desmatada_uc
    FROM relatorio_desmatamento rd
    JOIN cidade_uc_exclusiva cue ON rd.id_unidade_conservacao = cue.id_uc
    WHERE rd.ano BETWEEN 2008 AND 2024
    GROUP BY cue.id_cidade
),
desmatamento_total AS (
    SELECT
        dc.id_cidade,
        ROUND(dc.area_desmatada_cidade, 2) AS area_desmatada_cidade,
        ROUND(du.area_desmatada_uc, 2) AS area_desmatada_uc,
        ROUND(dc.area_desmatada_cidade + du.area_desmatada_uc, 2) AS area_desmatada_total
    FROM desmatamento_por_cidade dc
    LEFT JOIN desmatamento_por_uc_exclusiva du ON dc.id_cidade = du.id_cidade
)
SELECT
    dt.id_cidade,
    c.nome AS nome_cidade,
    dt.area_desmatada_cidade,
    dt.area_desmatada_uc,
    dt.area_desmatada_total,
    ROUND(dt.area_desmatada_uc * 100.0 / dt.area_desmatada_total, 2) AS percentual_uc_exclusiva
FROM desmatamento_total dt
JOIN cidade c ON dt.id_cidade = c.id_cidade
WHERE dt.area_desmatada_total > 0
ORDER BY percentual_uc_exclusiva DESC;
