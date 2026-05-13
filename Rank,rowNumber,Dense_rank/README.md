# Ranking de Pontos por Canal com Funções de Janela

Consulta SQL que calcula o total de pontos de cada cliente separado por canal de origem, e aplica funções de janela para ranquear os clientes dentro de cada canal.

## O que esse script faz

1. Agrupa as transações por cliente e canal (`IdCliente` + `DescSistemaOrigem`)
2. Soma os pontos de cada combinação
3. Aplica três funções de ranking em cima do resultado

## Funções utilizadas

| Função | Comportamento com empates |
|---|---|
| `RANK()` | Pula posições após empate (ex: 1, 1, 3) |
| `ROW_NUMBER()` | Sempre único, sem empates (ex: 1, 2, 3) |
| `DENSE_RANK()` | Não pula posições (ex: 1, 1, 2) |

Todas as três usam `PARTITION BY DescSistemaOrigem` , ou seja, o ranking é reiniciado para cada canal separadamente.

## Estrutura esperada da tabela

```sql
transacoes (
  IdCliente,
  DescSistemaOrigem,
  QtdePontos
)
```

## Exemplo de resultado

| IdCliente | DescSistemaOrigem | qntdPontos | rank | row_number | dense_rank |
|---|---|---|---|---|---|
| 101 | Twitch | 500 | 1 | 1 | 1 |
| 205 | Twitch | 500 | 1 | 2 | 1 |
| 340 | Twitch | 300 | 3 | 3 | 2 |
| 101 | Cursos | 200 | 1 | 1 | 1 |

> Repare que `RANK` pula o 2 por causa do empate, enquanto `DENSE_RANK` não pula e `ROW_NUMBER` ignora o empate completamente.

## Como executar

Cole o script no seu cliente SQL (SQLite, DBeaver, etc.) e rode direto. Não precisa de nenhuma configuração adicional, só ter a tabela `transacoes` populada.
