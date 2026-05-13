# SQL — Window Functions & Analytics

Repositório com scripts SQL focados em funções de janela e análise de dados de transações. Os exemplos foram desenvolvidos em SQLite e usam uma tabela de transações como base.

## Contexto

Os scripts simulam cenários reais de uma plataforma com múltiplos canais (Twitch, cursos, etc.), onde o time de dados e CRM precisa entender o comportamento dos clientes ao longo do tempo.

---

## Scripts

### 1. Ranking de Pontos por Canal
**Arquivo:** `ranking_pontos_canal.sql`

Calcula o total de pontos de cada cliente por canal de origem e aplica três funções de ranking , `RANK()`, `ROW_NUMBER()` e `DENSE_RANK()` , para comparar o comportamento de cada uma delas em cenários com empate.

---

### 2. Variação de Transações Mês a Mês
**Arquivo:** `variacao_mensal.sql`

Relatório mensal que mostra quantas transações aconteceram em cada mês e quanto isso variou em relação ao mês anterior. Usa `LAG()` para puxar o valor do período anterior na mesma linha.

---

### 3. Total Acumulado por Mês
**Arquivo:** `acumulado_mensal.sql`

Mostra o crescimento total da plataforma ao longo do tempo com `SUM() OVER`, calculando o acumulado de transações desde o início até cada mês.

---

### 4. Segmentação de Clientes por Engajamento
**Arquivo:** `segmentacao_clientes.sql`

Divide os clientes em 3 níveis de engajamento (Hiper Ativo, Muito Ativo, Pouco Ativo) usando `NTILE(3)`. O resultado é usado pelo time de CRM para direcionar campanhas diferentes para cada perfil.

---

## Funções abordadas

- `RANK()` / `ROW_NUMBER()` / `DENSE_RANK()`
- `LAG()`
- `SUM() OVER` (acumulado)
- `NTILE()`
- CTEs (`WITH`)

## Banco de dados

Todos os scripts foram escritos para **SQLite**. O uso de `strftime('%Y-%m', data)` para extrair ano/mês é específico do SQLite , para outros bancos, adapte:

| Banco | Equivalente |
|---|---|
| PostgreSQL | `TO_CHAR(data, 'YYYY-MM')` |
| MySQL | `DATE_FORMAT(data, '%Y-%m')` |
| SQL Server | `FORMAT(data, 'yyyy-MM')` |

## Estrutura da tabela base

```sql
transacoes (
  IdTransacao        INTEGER,
  IdCliente          INTEGER,
  DescSistemaOrigem  TEXT,      -- ex: 'Twitch', 'Cursos'
  QtdePontos         INTEGER,
  DtCriacao          DATETIME
)
```
