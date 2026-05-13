/*Contexto de negócio: O time de CRM quer dividir os clientes em 4 níveis de engajamento para campanhas diferentes , os mais ativos recebem ofertas exclusivas, os menos ativos recebem campanhas de reativação.*/

WITH resumo_clientes  AS   (	
			SELECT IdCliente ,
					 count(IdTransacao ) AS total_transacoes
			FROM transacoes
			GROUP BY IdCliente
			ORDER BY total_transacoes DESC 
),
segmentado  as (
			SELECT IdCliente,total_transacoes,NTILE(3) OVER (ORDER BY total_transacoes desc) AS segmento
			FROM resumo_clientes
)
SELECT IdCliente, total_transacoes,
			CASE
				WHEN segmento = 1 then 'Hiper Ativo '
				WHEN segmento = 2 then ' Muito Ativo'
				WHEN segmento = 3 then 'Pouco Ativo'
			END AS nivel		
FROM segmentado

