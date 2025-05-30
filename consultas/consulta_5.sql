WITH uc_desmatamento_detalhado AS (
    SELECT
        uc.id_unidade_conservacao,
        uc.area_amazonia_ha / 100.0 AS area_km2_amazonia,
        SUM(rd.area_km2) AS total_desmatado,
        c.id_estado
    FROM unidade_conservacao uc
    JOIN relatorio_desmatamento rd ON uc.id_unidade_conservacao = rd.id_unidade_conservacao
    JOIN cidade_unidade_conservacao cuc ON uc.id_unidade_conservacao = cuc.unidade_conservacao_id_unidade_conservacao
    JOIN cidade c ON cuc.cidade_id_cidade = c.id_cidade
    WHERE uc.area_amazonia_ha > 0
    GROUP BY uc.id_unidade_conservacao, uc.area_amazonia_ha, c.id_estado
),
uc_estado_regiao AS (
    SELECT
        ucdd.area_km2_amazonia,
        ucdd.total_desmatado,
        r.nome AS regiao
    FROM uc_desmatamento_detalhado ucdd
    JOIN estado e ON ucdd.id_estado = e.id_estado
    JOIN estado_regiao_administrativa era ON e.id_estado = era.estado_id_estado
    JOIN regiao_administrativa r ON era.regiao_administrativa_id_regiao_administrativa = r.id_regiao_administrativa
	WHERE r.nome IN ('Norte', 'Nordeste', 'Centro-Oeste', 'Sudeste', 'Sul')
)
SELECT
    regiao,
    ROUND(SUM(area_km2_amazonia), 2) AS area_km2_amazonia,
    ROUND(SUM(total_desmatado), 2) AS total_desmatado,
    ROUND((SUM(total_desmatado) / NULLIF(SUM(area_km2_amazonia), 0)) * 100, 2) AS percentual_desmatado
FROM uc_estado_regiao
GROUP BY regiao
ORDER BY percentual_desmatado DESC;
