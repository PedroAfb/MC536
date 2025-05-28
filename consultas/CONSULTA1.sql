WITH variacao_diaria AS (
    SELECT 
        m.id_estacao_meteorologica,
        DATE(m.data_horario_coleta) AS dia,
        MAX(m.temperatura_max) AS temperatura_max,
        MIN(m.temperatura_min) AS temperatura_min,
        MAX(m.temperatura_max) - MIN(m.temperatura_min) AS variacao_diaria
    FROM relatorio_meteorologia m
    WHERE m.temperatura_max IS NOT NULL 
      AND m.temperatura_min IS NOT NULL
    GROUP BY m.id_estacao_meteorologica, DATE(m.data_horario_coleta)
),
maior_variacao AS (
    SELECT DISTINCT ON (id_estacao_meteorologica)
        id_estacao_meteorologica,
        dia AS dia_maior_variacao,
        variacao_diaria AS maior_variacao,
        temperatura_max,
        temperatura_min
    FROM variacao_diaria
    ORDER BY id_estacao_meteorologica, variacao_diaria DESC
)
SELECT
    em.nome AS estacao,
    c.nome AS cidade,
    e.uf AS estado,
    mv.dia_maior_variacao,
    mv.maior_variacao,
    mv.temperatura_max,
    mv.temperatura_min,
    ROUND(AVG(vd.variacao_diaria), 2) AS media_variacao
FROM maior_variacao mv
JOIN variacao_diaria vd 
  ON mv.id_estacao_meteorologica = vd.id_estacao_meteorologica
JOIN estacao_meteorologica em 
  ON mv.id_estacao_meteorologica = em.id_estacao_meteorologica
JOIN cidade c 
  ON em.id_cidade = c.id_cidade
JOIN estado e 
  ON c.id_estado = e.id_estado
GROUP BY em.nome, c.nome, e.uf, mv.dia_maior_variacao, mv.maior_variacao, mv.temperatura_max, mv.temperatura_min
ORDER BY mv.maior_variacao DESC;
