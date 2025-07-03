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
desmatamento_agregado AS (
    SELECT
        COALESCE(d.id_cidade, cue.id_cidade) AS id_cidade_final,
        SUM(d.area_km2) AS area_desmatada_total,
        SUM(CASE WHEN d.id_unidade_conservacao IS NOT NULL THEN d.area_km2 ELSE 0 END) AS area_desmatada_uc     
    FROM desmatamento d
    LEFT JOIN cidade_uc_exclusiva cue ON d.id_unidade_conservacao = cue.id_uc
    WHERE d.ano BETWEEN 2008 AND 2024
    GROUP BY id_cidade_final
)
SELECT
    da.id_cidade_final AS id_cidade,
    c.nome AS nome_cidade,
    ROUND(da.area_desmatada_total - da.area_desmatada_uc, 2) AS area_desmatada_cidade,
    ROUND(da.area_desmatada_uc, 2) AS area_desmatada_uc,
    ROUND(da.area_desmatada_total, 2) AS area_desmatada_total,
    CASE 
        WHEN da.area_desmatada_total > 0 THEN ROUND(da.area_desmatada_uc * 100.0 / da.area_desmatada_total, 2)
        ELSE 0 
    END AS percentual_uc_exclusiva
FROM desmatamento_agregado da
JOIN cidade c ON da.id_cidade_final = c.id_cidade
WHERE da.area_desmatada_total > 0 AND da.id_cidade_final IS NOT NULL
ORDER BY percentual_uc_exclusiva DESC;