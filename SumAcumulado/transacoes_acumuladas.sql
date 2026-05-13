/* total acumulado de transações por mês
Contexto de negócio: O time quer um relatório mostrando o crescimento total da comunidade ao longo do tempo, quantas transações aconteceram no total até cada mês.*/

 WITH transacoes_mes as (
 		SELECT strftime('%Y-%m', DtCriacao) as mes,
					 count(IdTransacao ) AS total_transacoes
		FROM transacoes
		GROUP BY mes
)   	
SELECT mes,total_transacoes,SUM(total_transacoes) OVER (ORDER BY mes ) as Acc_por_mes
FROM transacoes_mes

