WITH variacao_diaria AS (
    SELECT 
        mc.id_estacao_meteorologica,
        DATE(mc.data_horario_coleta) AS dia,
        MAX(mc.temperatura_max) AS temperatura_max,
        MIN(mc.temperatura_min) AS temperatura_min,
        MAX(mc.temperatura_max) - MIN(mc.temperatura_min) AS variacao,
        ROW_NUMBER() OVER(PARTITION BY mc.id_estacao_meteorologica ORDER BY (MAX(mc.temperatura_max) - MIN(mc.temperatura_min)) DESC) as ranking_variacao,
        AVG(MAX(mc.temperatura_max) - MIN(mc.temperatura_min)) OVER(PARTITION BY mc.id_estacao_meteorologica) as media_variacao
    FROM medicoes_climaticas mc
    WHERE mc.temperatura_max IS NOT NULL AND mc.temperatura_min IS NOT NULL
    GROUP BY mc.id_estacao_meteorologica, DATE(mc.data_horario_coleta)
)
SELECT
    em.nome AS estacao,
    c.nome AS cidade,
    e.uf AS estado,
    vd.dia AS dia_maior_variacao,
    vd.variacao AS maior_variacao,
    vd.temperatura_max,
    vd.temperatura_min,
    ROUND(vd.media_variacao, 2) AS media_variacao
FROM variacao_diaria vd
JOIN estacao_meteorologica em
  ON vd.id_estacao_meteorologica = em.id_estacao_meteorologica
JOIN cidade c 
  ON em.id_cidade = c.id_cidade
JOIN estado e 
  ON c.id_estado = e.id_estado
WHERE vd.ranking_variacao = 1
ORDER BY vd.variacao DESC;