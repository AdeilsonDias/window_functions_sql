# Segmentação de Clientes por Engajamento com NTILE

Script SQL que divide os clientes em níveis de engajamento com base no volume de transações, usando a função `NTILE()`. O resultado alimenta campanhas de CRM direcionadas por perfil.

## Contexto

O time de CRM precisa tratar clientes diferentes de formas diferentes. Quem transaciona muito recebe ofertas exclusivas. Quem some há tempo recebe campanha de reativação. Esse script faz essa divisão de forma automática e proporcional.

## Como funciona

**1ª CTE — `resumo_clientes`**  
Conta quantas transações cada cliente fez no total.

**2ª CTE — `segmentado`**  
Usa `NTILE(3)` para dividir os clientes em 3 grupos iguais, ordenando do mais ativo para o menos ativo. O número dentro do `NTILE` define quantos segmentos você quer — se quiser 4 grupos, troca por `NTILE(4)`.

**Select final**  
Traduz o número do segmento para um label legível via `CASE WHEN`.

## Segmentos gerados

| Segmento | Label | Estratégia sugerida |
|---|---|---|
| 1 | Hiper Ativo | Ofertas exclusivas e benefícios VIP |
| 2 | Muito Ativo | Engajamento e retenção |
| 3 | Pouco Ativo | Reativação e incentivo |

## Estrutura esperada da tabela

```sql
transacoes (
  IdCliente,
  IdTransacao
)
```

## Observação importante

`NTILE` divide os registros de forma **proporcional**, não por um valor fixo. Se você tem 100 clientes e usa `NTILE(3)`, vai ter ~33 em cada grupo. Isso significa que o corte de pontos varia conforme a base cresce — o que é geralmente o comportamento desejado para segmentação relativa.

Se precisar de critérios fixos (ex: "quem tem mais de 50 transações é Hiper Ativo"), o `CASE WHEN` direto no count é mais adequado do que o `NTILE`.
