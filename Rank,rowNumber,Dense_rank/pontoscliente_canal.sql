/*Contexto de negócio
 
*Você precisa calcular o total de pontos de cada cliente, separado por canal.
Ex >> um cliente pode ter transações naTwitch e em cursos. Então você precisa agrupar por duas colunas ao mesmo tempo, cliente e canal.
----
*Calcular o total de pontos de cada cliente por canal , agrupando por IdCliente e DescSistemaOrigem e 
	aplicar RANK() , ROW_NUMBER() , DENSE_RANK() em cima do resultado da CTE*/


WITH pontos_por_canal AS  ( 
	SELECT IdCliente ,DescSistemaOrigem,SUM(QtdePontos ) AS qntdPontos
	FROM transacoes
	GROUP BY IdCliente,DescSistemaOrigem 
)

SELECT IdCliente, DescSistemaOrigem, qntdPontos,
    RANK()       OVER (PARTITION BY DescSistemaOrigem ORDER BY qntdPontos DESC) AS rank_pontos,
    ROW_NUMBER() OVER (PARTITION BY DescSistemaOrigem ORDER BY qntdPontos DESC) AS RowNumber_pontos,
    DENSE_RANK() OVER (PARTITION BY DescSistemaOrigem ORDER BY qntdPontos DESC) AS dense_rank_pontos
FROM pontos_por_canal

