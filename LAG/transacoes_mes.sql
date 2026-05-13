/*variação de transações mês a mês
Contexto de negócio: O time quer um relatório mensal mostrando se a comunidade está crescendo ou encolhendo, quantas transações aconteceram em cada mês e quanto isso variou em relação ao mês anterior.*/

 WITH transacoes_mes AS (
		 SELECT strftime('%Y-%m', DtCriacao) as mes,
					 count(IdTransacao ) AS total_transacoes
		FROM transacoes
		GROUP BY mes 
),
 mes_com_lag as (  
			select mes,
			total_transacoes,
			LAG(total_transacoes,1,0) OVER (ORDER BY mes) AS mes_anterior
			from transacoes_mes
)

SELECT mes,
			total_transacoes,
			mes_anterior,
			(total_transacoes-mes_anterior) AS variacao
from mes_com_lag
