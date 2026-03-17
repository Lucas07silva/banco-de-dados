

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
**Professor:** Jefté Goes

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
**Professor:** Jefté Goes

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
**Professor:** Jefté Goes

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
