## Aula 1: Introdução à Linguagem SQL

**Professor:** Jefté Goes 

### O que é SQL?

* 
**Definição**: Significa Linguagem de Consulta Estruturada (Structured Query Language).


* 
**Pronúncia**: Frequentemente pronunciado como "SeQuel".


* 
**Utilidade**: Usado para interagir com dados em bancos de dados, permitindo cálculos complexos como encontrar "Gasto Total" em grandes conjuntos de dados.



### Por que aprender SQL?

* 
**Falar com Dados**: Permite comunicar diretamente com sistemas de dados.


* 
**Alta Demanda**: Existe uma alta procura por essas habilidades em várias funções técnicas.


* 
**Caminhos de Carreira**: Essencial para Desenvolvedores, Analistas de Dados, Cientistas de Dados e Engenheiros de Dados.


* 
**Padrão da Indústria**: Linguagem padrão para ferramentas como Power BI, Tableau, Kafka, Spark e Synapse.



### Sistema de Gerenciamento de Banco de Dados (DBMS)

* 
**Interface**: Atua como interface entre o usuário e o banco de dados.


* 
**Hospedagem**: Normalmente hospedados em servidores ou na nuvem.


* 
**Disponibilidade**: Funcionam 24/7 para garantir o acesso aos dados.


* 
**Interação**: Aplicativos, ferramentas de BI e usuários enviam consultas SQL ao DBMS.



### Estrutura e Tipos de Dados

* 
**Hierarquia**: Servidor > Banco de Dados > Esquema > Tabela.


* **Componentes da Tabela**:
* 
**Colunas**: Categorias verticais (tipos de dados).


* 
**Linhas**: Registros horizontais individuais.


* 
**Célula**: Unidade única na interseção de linha e coluna.


* 
**Chave Primária**: Identificador único para cada registro.




* **Tipos de Dados Comuns**:
* 
**Numéricos**: `INT` (inteiros) e `DECIMAL` (frações).


* 
**Texto**: `CHAR` (comprimento fixo) e `VARCHAR` (comprimento variável).


* 
**Data/Hora**: `DATE` (YYYY-MM-DD) e `TIME` (HH:MM:SS).





---

## Aula 2.1: Tipos de Comandos SQL

Os comandos SQL são classificados em categorias de acordo com sua função:

| Sigla | Nome Inglês | Descrição | Comandos |
| --- | --- | --- | --- |
| **DDL** | Data Definition Language | Define ou modifica a estrutura do banco.

 | <br>`CREATE`, `ALTER`, `DROP` 

 |
| **DQL** | Data Query Language | Recupera dados do banco.

 | <br>`SELECT` 

 |
| **DML** | Data Manipulation Language | Gerencia dados dentro das tabelas.

 | <br>`INSERT`, `UPDATE`, `DELETE` 

 |
| **DCL** | Data Control Language | Gerencia permissões e acesso.

 | <br>`GRANT`, `REVOKE` 

 |
| **TCL** | Transaction Control Language | Gerencia transações no banco.

 | <br>`COMMIT`, `ROLLBACK`, `SAVEPOINT` 

 |

---

## Aula 2.2: DDL - Linguagem de Definição de Dados

O DDL é usado para definir a estrutura ("esqueleto") dos objetos de dados.

* 
**CREATE**: Constrói novos objetos (Bancos de Dados ou Tabelas).


* Exemplo: `CREATE TABLE Products (ProductID INT, ProductName VARCHAR(100), Price DECIMAL);` 




* 
**ALTER**: Modifica a estrutura de um objeto existente sem excluí-lo.


* 
**Adicionar coluna**: `ALTER TABLE Products ADD Category VARCHAR(50);` 


* 
**Remover coluna**: `ALTER TABLE Products DROP COLUMN Price;` 




* 
**DROP**: Comando destrutivo que remove permanentemente o objeto e todos os seus dados.


* Exemplo: `DROP TABLE Products;` 





---

## Aula 3.1: DML - Linguagem de Manipulação de Dados

O DML permite gerenciar o conteúdo interno (os dados reais) das tabelas.

* 
**INSERT**: Adiciona novas linhas de dados.


* 
**Entrada Manual**: Usando a cláusula `VALUES`.


* 
**Via SELECT**: Insere dados de uma tabela de origem em uma de destino.




* 
**UPDATE**: Modifica registros existentes.


* 
**Aviso**: Sempre use a cláusula `WHERE` para evitar atualizações em todas as linhas.




* 
**DELETE**: Remove registros específicos.


* Assim como o update, requer `WHERE` para filtrar as linhas a serem apagadas.





---

## Aula 3.2: Anatomia de uma Declaração SQL

Uma instrução SQL é composta por elementos que orientam o processamento do banco de dados:

* 
**Comentários (`--`)**: Documentam o código.


* 
**Palavras-chave**: Termos reservados com significado especial.


* 
**Cláusulas**: Blocos que constroem a instrução (ex: `SELECT`, `FROM`).


* 
**Identificadores**: Nomes de objetos como tabelas ou colunas.


* 
**Operadores**: Usados para comparações.


* 
**Literais**: Valores constantes ou strings.



### Filtragem e Ordenação

* 
**DISTINCT**: Remove duplicatas dos resultados.


* 
**WHERE**: Filtra registros com condições específicas.


* 
**ORDER BY**: Ordena resultados (ascendente ou descendente).


* 
**TOP / LIMIT**: Especifica o número de registros retornados.


* 
**Aliases (AS)**: Dá nomes temporários a colunas ou tabelas para legibilidade.



### Ordem Lógica de Avaliação

O SQL processa as cláusulas em uma ordem diferente da escrita. A execução lógica padrão é:

1. 
**FROM** 


2. 
**WHERE** 


3. 
**SELECT** 


4. 
**ORDER BY** 



