# Variação de Transações Mês a Mês

Script SQL que gera um relatório mensal mostrando quantas transações aconteceram em cada mês e quanto isso variou em relação ao mês anterior.

## Contexto

O time queria entender se a comunidade está crescendo ou encolhendo ao longo do tempo. Com esse relatório dá pra ver rapidinho quando teve um pico de engajamento ou uma queda brusca.

## Como funciona

O script usa duas CTEs encadeadas:

**1ª CTE — `transacoes_mes`**  
Agrupa as transações por mês usando `strftime('%Y-%m', DtCriacao)` e conta quantas aconteceram em cada período.

**2ª CTE — `mes_com_lag`**  
Usa a função `LAG()` para puxar o valor do mês anterior e colocar na mesma linha. O terceiro argumento do `LAG` é `0`, então o primeiro mês não fica nulo — aparece como zero.

**Select final**  
Calcula a variação subtraindo o mês atual pelo anterior.

## Estrutura esperada da tabela

```sql
transacoes (
  IdTransacao,
  DtCriacao   -- formato DATE ou DATETIME
)
```

## Exemplo de resultado

| mes | total_transacoes | mes_anterior | variacao |
|---|---|---|---|
| 2024-01 | 120 | 0 | +120 |
| 2024-02 | 145 | 120 | +25 |
| 2024-03 | 98 | 145 | -47 |

> Variação negativa indica queda no engajamento naquele mês.

## Banco de dados

Feito para **SQLite**. O `strftime` é função nativa do SQLite — se for rodar em outro banco (Postgres, MySQL), adapte para `TO_CHAR` ou `DATE_FORMAT`.
