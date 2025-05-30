SELECT
    ai.nome AS nome_area,
    'Área Indígena' AS tipo,
    SUM(rd.area_km2) AS total_desmatado_km2
FROM relatorio_desmatamento rd
JOIN area_indigena ai ON rd.id_area_indigena = ai.id_area_indigena
GROUP BY ai.nome

UNION ALL

SELECT
    uc.nome AS nome_area,
    'Unidade de Conservação' AS tipo,
    SUM(rd.area_km2) AS total_desmatado_km2
FROM relatorio_desmatamento rd
JOIN unidade_conservacao uc ON rd.id_unidade_conservacao = uc.id_unidade_conservacao
GROUP BY uc.nome
ORDER BY total_desmatado_km2 DESC
LIMIT 10;