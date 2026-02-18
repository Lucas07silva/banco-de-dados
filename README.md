

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

