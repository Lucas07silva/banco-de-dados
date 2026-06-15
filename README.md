

## 1. DDL — Linguagem de Definição de Dados

O **DDL** é usado para definir a estrutura do banco de dados, funcionando como o "esqueleto" ou "blueprint" do sistema.

### CREATE (Construir)

Usado para criar novos bancos de dados, esquemas ou tabelas. Ao criar uma tabela, definimos as colunas e seus tipos de dados.

* **Exemplo:**
```sql
CREATE DATABASE supermercado; -- Cria o contêiner principal

CREATE TABLE client (
  id INT NOT NULL,
  nome VARCHAR(50) NOT NULL, -- Texto de comprimento variável
  cpf VARCHAR(11) NOT NULL,
  CONSTRAINT pk_id_cliente PRIMARY KEY (id) -- Identificador único
);

```



### ALTER (Modificar Estrutura)

Permite atualizar a estrutura de uma tabela existente (adicionar, remover ou alterar colunas) sem precisar excluí-la.

* **Exemplo:**
```sql
-- Adicionando uma nova coluna
ALTER TABLE produto ADD COLUMN situacao BOOLEAN NOT NULL;

-- Alterando o tipo de dado de uma coluna existente
ALTER TABLE produto ALTER COLUMN descricao TYPE VARCHAR(200);

```



### DROP (Excluir Objeto)

Comando destrutivo que remove permanentemente o objeto e todos os registros nele contidos.

* **Exemplo:**
```sql
DROP TABLE produto; -- Remove a tabela e todos os seus dados

```



---

## 2. DML — Linguagem de Manipulação de Dados

O **DML** gerencia o conteúdo interno das tabelas, ou seja, os dados reais armazenados.

### INSERT (Adicionar)

Cria novas linhas de dados em uma tabela.

* **Exemplo:**
```sql
-- Entrada manual de valores
INSERT INTO client (id, nome, cpf)
VALUES (1, 'luquinhas', '12345678901');

```



### UPDATE (Editar)

Modifica informações que já existem na tabela.

> 
> **Regra Crucial:** Sempre use a cláusula `WHERE` para filtrar quais linhas serão alteradas, evitando atualizações em massa não intencionais.
> 
> 

* **Exemplo:**
```sql
UPDATE produto 
SET descricao = 'nescal' 
WHERE id = 2; -- Atualiza apenas o produto com ID 2

```



### DELETE (Remover)

Apaga registros específicos da tabela. Assim como o update, o uso do `WHERE` é fundamental para segurança.

* **Exemplo:**
```sql
DELETE FROM produto WHERE id = 3; -- Remove apenas uma linha específica
DELETE FROM produto; -- ATENÇÃO: Remove todos os registros da tabela!

```



---

## 3. DQL — Linguagem de Consulta de Dados

O **DQL** é a parte do SQL focada na recuperação e visualização das informações.

### SELECT

O comando principal para buscar dados. Ele segue uma ordem lógica de avaliação interna (Primeiro `FROM`, depois `WHERE`, depois `SELECT`, e por fim `ORDER BY`).

* 
**SELECT ***: Recupera todas as colunas da tabela.


* 
**Aliases (AS)**: Dá nomes temporários a colunas ou tabelas para facilitar a leitura.


* 
**ORDER BY**: Organiza o resultado de forma ascendente ou descendente.


* **Exemplo:**
```sql
-- Seleciona colunas específicas com alias e ordena de forma decrescente
SELECT prod.id, prod.descricao 
FROM produto AS prod 
ORDER BY id DESC;
```

## **Aula 4.1: Chave Estrangeira (Foreign Key)**

### **O que é Chave Estrangeira?**
* A **chave estrangeira (FK)** é um campo de uma tabela que aponta para a **chave primária (PK)** de outra tabela.
* Ela serve para criar **relacionamento** entre tabelas.
* Em outras palavras: é o que “liga” uma tabela à outra em um banco de dados relacional.

### **Por que precisamos dela?**
* **Sem chave estrangeira:**
    * As tabelas ficam isoladas.
    * Não há garantia de que os dados combinam.
    * Podem existir registros “órfãos” (sem relação real).
* **Com chave estrangeira:**
    * O banco garante a **integridade dos dados**.
    * Evita erros e inconsistências.
    * Representa relações do mundo real (ex: Cliente → Pedido, Aluno → Matrícula).

### **Exemplo Prático**
**Tabela de Clientes**
| Id (PK) | Nome |
| :--- | :--- |
| 1 | Ana Silva |
| 2 | João Souza |

**Tabela de Pedidos**
| Id (PK) | clienteId (FK) | Total |
| :--- | :--- | :--- |
| 1001 | 1 | 3500 |
| 1002 | 2 | 200 |
| 1003 | 1 | 1200 |

---

## **Aula 4.2: Normalização**

### **Conceito**
Normalizar um banco de dados é organizar as informações para que cada dado exista apenas uma vez, evitando repetição, erros e "bagunça" nas tabelas.

### **Forma Não Normalizada (UNF)**
* **Características:** Todos os dados misturados em uma única tabela, com grupos repetidos e dados do cliente duplicados.
* **Problema:** Difícil de consultar e manter.

### **Primeira Forma Normal (1FN)**
* **Regra:** Os campos devem ser **atômicos** (um único valor por célula).
* **Ainda existe problema:** Os dados do cliente continuam duplicados e o "Total" pertence apenas ao pedido, mas há dependências misturadas.

### **Segunda Forma Normal (2FN)**
* **Regras:**
    1. Deve estar na 1FN.
    2. Remover dependências parciais.
    3. **Cada entidade passa a ter sua própria tabela** e sua própria chave primária (ex: Tabela Clientes e Tabela Pedidos separadas).

### **Terceira Forma Normal (3FN)**
* **Regras:**
    1. Deve estar na 2FN.
    2. Remover dependências transitivas.
    3. Campos não-chave **DEVEM** depender apenas da chave.
* **Resultado:** Tabelas totalmente limpas e relacionadas via IDs.

---

## **Aula 5: Métodos de Combinação**

### **JOINS (Adição de Colunas - Horizontal)**
Conectamos tabelas lateralmente através de uma coluna comum (Chave).



* **Inner Join:** Retorna apenas os registros que existem em ambas as tabelas.
* **Left Join:** Mantém tudo da tabela à esquerda e traz o que houver de correspondente na direita.
* **Right Join:** Mantém tudo da tabela à direita e traz o que houver na esquerda.
* **Full Join:** Traz tudo de ambos os lados, independentemente de haver correspondência.

**Exemplo de Sintaxe:**
```sql
SELECT TabelaA.Nome, TabelaB.Pais
FROM TabelaA 
INNER JOIN TabelaB ON TabelaA.id = TabelaB.id;
```

### **Operadores SET (Adição de Linhas - Vertical)**
Empilhamos resultados de consultas diferentes, desde que tenham a mesma estrutura de colunas.

* **UNION:** Combina os resultados e **remove duplicados**.
* **UNION ALL:** Combina tudo, **incluindo duplicados** (é mais rápido).
* **EXCEPT / MINUS:** Mostra o que existe no primeiro conjunto, mas não no segundo.
* **INTERSECT:** Mostra apenas o que é comum a ambos os conjuntos.

**Exemplo de Sintaxe:**
```sql
SELECT Nome FROM Clientes
UNION
SELECT Nome FROM Funcionarios;
```

---

## **Scripts de Exemplo**

### **Estrutura de Tabelas DDL**
```sql
CREATE TABLE public.clientes (
    id int NOT NULL,
    nome varchar(50) NOT NULL,
    cidade varchar(50) NULL,
    CONSTRAINT clientes_pkey PRIMARY KEY (id)
);

CREATE TABLE public.produtos (
    id int NOT NULL,
    nomeproduto varchar(100) NOT NULL,
    precopadrao numeric(10, 2) NULL,
    CONSTRAINT produtos_pkey PRIMARY KEY (id)
);

CREATE TABLE public.pedidos (
    id int NOT NULL,
    clienteid int NULL,
    produtoid int NULL,
    quantidade int NULL,
    precovenda numeric(10, 2) NULL,
    CONSTRAINT pedidos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_cliente_pedido FOREIGN KEY (clienteid) REFERENCES public.clientes(id),
    CONSTRAINT fk_produto_pedido FOREIGN KEY (produtoid) REFERENCES public.produtos(id)
);
```

### **População de Dados DML**
```sql
INSERT INTO Produtos (Id, NomeProduto, PrecoPadrao) VALUES
(10, 'Notebook Pro', 4500.00),
(11, 'Rato Sem Fio', 120.00);

INSERT INTO Clientes (Id, Nome, Cidade) VALUES
(1, 'Maria Silva', 'São Paulo'),
(2, 'João Pereira', 'Rio de Janeiro');

INSERT INTO Pedidos (Id, ClienteID, ProdutoID, Quantidade, PrecoVenda) VALUES
(101, 1, 10, 1, 4500.00); -- Maria comprou Notebook
```
## **Aula 6: Funções de Linha Única no SQL**

### **O que são Funções SQL?**
As **funções SQL** são conjuntos de instruções que recebem um ou mais valores de entrada e retornam um valor de saída para cada linha.

Elas são utilizadas principalmente para:
* Limpeza de dados (ex: remover espaços)
* Transformação (ex: alterar formato de texto ou data)
* Análise rápida de valores por linha

---

### **Funções de Texto (String Functions)**

São usadas para manipular e extrair informações de textos.

* **Manipulação:**
  * `CONCAT` → une strings  
  * `UPPER / LOWER` → converte para maiúsculo/minúsculo  
  * `TRIM` → remove espaços extras  
  * `REPLACE` → substitui caracteres  

* **Extração e Medida:**
  * `LEN` → quantidade de caracteres  
  * `LEFT / RIGHT` → extrai caracteres das extremidades  
  * `SUBSTRING` → extrai parte do texto de qualquer posição  

* **Exemplo:**
```sql
SELECT UPPER(nome), LEN(nome)
FROM clientes;
```

## **Aula 7: Funções de Agregação**

### **O que são Funções de Agregação?**
As **funções de agregação** processam um conjunto de valores e retornam um único resultado resumido.

São muito usadas para transformar dados brutos em informações estratégicas.

---

### **Principais Funções**

* `COUNT` → conta registros  
* `SUM` → soma valores numéricos  
* `AVG` → calcula média  
* `MAX` → maior valor  
* `MIN` → menor valor  

* **Exemplo:**
```sql
SELECT COUNT(*), SUM(preco), AVG(preco)
FROM produtos;
```
# Aula 8: Views (Visões)

## O que é uma View?

Uma **View (Visão)** é uma tabela virtual criada a partir de uma consulta SQL (`SELECT`).

Ela não armazena os dados fisicamente (na maioria dos casos), mas exibe informações provenientes de uma ou mais tabelas.

### Por que usar Views?

* Simplificam consultas complexas.
* Aumentam a segurança, exibindo apenas dados necessários.
* Facilitam a reutilização de consultas frequentes.
* Melhoram a organização do banco de dados.

---

## Sintaxe Básica

```sql
CREATE VIEW vw_clientes_pedidos AS
SELECT
    c.nome,
    p.id AS pedido_id,
    p.quantidade
FROM clientes c
INNER JOIN pedidos p
    ON c.id = p.clienteid;
```

---

## Consultando uma View

```sql
SELECT * FROM vw_clientes_pedidos;
```

### Resultado

| nome | pedido_id | quantidade |
|--------|-----------|------------|
| Maria Silva | 101 | 1 |

---

## Removendo uma View

```sql
DROP VIEW vw_clientes_pedidos;
```

---

# Aula 9: Procedures (Procedimentos Armazenados)

## O que é uma Procedure?

Uma **Procedure** é um conjunto de comandos SQL armazenados no banco de dados que pode ser executado sempre que necessário.

Diferente das funções, procedures podem:

* Alterar dados.
* Executar várias instruções.
* Receber parâmetros.
* Controlar transações.

### Por que usar Procedures?

* Automatizam processos repetitivos.
* Centralizam regras de negócio.
* Melhoram a manutenção do sistema.
* Reduzem a quantidade de código na aplicação.

---

## Exemplo de Procedure

Cadastro automático de cliente:

```sql
CREATE OR REPLACE PROCEDURE cadastrar_cliente(
    p_id INT,
    p_nome VARCHAR,
    p_cidade VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO clientes(id, nome, cidade)
    VALUES (p_id, p_nome, p_cidade);
END;
$$;
```

---

## Executando a Procedure

```sql
CALL cadastrar_cliente(
    3,
    'Carlos Souza',
    'Salvador'
);
```

---

## Procedure com Atualização

```sql
CREATE OR REPLACE PROCEDURE atualizar_preco(
    p_id INT,
    p_novo_preco NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE produtos
    SET precopadrao = p_novo_preco
    WHERE id = p_id;
END;
$$;
```

---

## Executando

```sql
CALL atualizar_preco(10, 5000.00);
```

---

# Aula 10: Functions (Funções)

## O que é uma Function?

Uma **Function (Função)** é um bloco de código SQL que recebe parâmetros e obrigatoriamente retorna um valor.

Pode ser utilizada dentro de consultas SQL.

## Diferença entre Function e Procedure

| Function | Procedure |
|-----------|------------|
| Retorna valor | Não é obrigada a retornar |
| Pode ser usada em SELECT | Não pode ser usada em SELECT |
| Ideal para cálculos | Ideal para processos |

---

## Exemplo de Function

Calculando o valor total de um pedido:

```sql
CREATE OR REPLACE FUNCTION calcular_total(
    p_quantidade INT,
    p_preco NUMERIC
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN p_quantidade * p_preco;
END;
$$;
```

---

## Executando

```sql
SELECT calcular_total(2, 4500.00);
```

### Resultado

```text
9000.00
```

---

## Function Consultando Dados

```sql
CREATE OR REPLACE FUNCTION quantidade_pedidos_cliente(
    p_cliente_id INT
)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM pedidos
    WHERE clienteid = p_cliente_id;

    RETURN total;
END;
$$;
```

---

## Executando

```sql
SELECT quantidade_pedidos_cliente(1);
```

---

# Aula 11: Triggers (Gatilhos)

## O que é uma Trigger?

Uma **Trigger (Gatilho)** é um mecanismo que executa automaticamente uma ação quando ocorre um evento em uma tabela.

Eventos mais comuns:

* `INSERT`
* `UPDATE`
* `DELETE`

Uma trigger sempre está associada a uma função que contém a lógica a ser executada.

### Por que usar Triggers?

* Automatizar tarefas.
* Auditar alterações.
* Garantir regras de negócio.
* Manter integridade dos dados.

---

## Estrutura de uma Trigger

1. Criar uma Function.
2. Associar essa Function a uma Trigger.

---

## Exemplo Prático

### Tabela de Log

```sql
CREATE TABLE log_clientes (
    id SERIAL PRIMARY KEY,
    cliente_id INT,
    data_alteracao TIMESTAMP
);
```

---

### Function da Trigger

```sql
CREATE OR REPLACE FUNCTION registrar_alteracao_cliente()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO log_clientes(
        cliente_id,
        data_alteracao
    )
    VALUES(
        NEW.id,
        CURRENT_TIMESTAMP
    );

    RETURN NEW;
END;
$$;
```

---

### Criando a Trigger

```sql
CREATE TRIGGER trg_cliente_update
AFTER UPDATE
ON clientes
FOR EACH ROW
EXECUTE FUNCTION registrar_alteracao_cliente();
```

---

## Funcionamento

Quando um cliente for atualizado:

```sql
UPDATE clientes
SET cidade = 'Feira de Santana'
WHERE id = 1;
```

Automaticamente será criado um registro em:

```sql
SELECT * FROM log_clientes;
```

### Resultado

| id | cliente_id | data_alteracao |
|----|------------|----------------|
| 1 | 1 | 2026-06-14 15:30:00 |

---

# Resumo Geral

| Recurso | Finalidade |
|----------|-----------|
| **View** | Criar uma tabela virtual baseada em consultas |
| **Procedure** | Executar processos e operações no banco |
| **Function** | Retornar valores e realizar cálculos |
| **Trigger** | Executar ações automaticamente após eventos |
| **Trigger Function** | Função especial executada por uma Trigger |

## Fluxo da Trigger

```text
INSERT / UPDATE / DELETE
          ↓
       TRIGGER
          ↓
   TRIGGER FUNCTION
          ↓
     Ação Automática
```

Esses recursos são amplamente utilizados em sistemas corporativos para automatizar processos, centralizar regras de negócio e melhorar a organização e manutenção dos bancos de dados.
