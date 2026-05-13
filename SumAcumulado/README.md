# Total Acumulado de Transações por Mês

Script SQL que calcula o crescimento total da comunidade ao longo do tempo, mostrando quantas transações aconteceram no acumulado até cada mês.

## Contexto

Diferente do relatório mês a mês (que mostra só o que aconteceu naquele mês), esse aqui mostra o total cumulativo — ou seja, quanto a plataforma somou desde o início até determinado ponto no tempo.

## Como funciona

**CTE — `transacoes_mes`**  
Agrupa e conta as transações por mês, igual ao script anterior.

**Select final**  
Usa `SUM()` como função de janela com `OVER (ORDER BY mes)`. Isso faz o SQL somar tudo que veio antes, linha a linha, resultando no acumulado.

```sql
SUM(total_transacoes) OVER (ORDER BY mes) AS Acc_por_mes
```

Sem o `PARTITION BY`, o acumulado é global (soma tudo desde o primeiro mês). Se quiser acumulado por categoria, é só adicionar `PARTITION BY`.

## Estrutura esperada da tabela

```sql
transacoes (
  IdTransacao,
  DtCriacao   -- formato DATE ou DATETIME
)
```

## Exemplo de resultado

| mes | total_transacoes | Acc_por_mes |
|---|---|---|
| 2024-01 | 120 | 120 |
| 2024-02 | 145 | 265 |
| 2024-03 | 98 | 363 |
| 2024-04 | 200 | 563 |

## Banco de dados

Feito para **SQLite**. Para outros bancos, apenas a função `strftime` precisa ser adaptada.
