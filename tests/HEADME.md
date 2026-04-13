# 🚀 Guia de Testes de Integração: Ecossistema Big Data
## Hadoop (HDFS) | Hive | Trino

Este documento fornece as instruções passo a passo para acessar as plataformas e executar os testes de integração que validam a fluidez dos dados entre o armazenamento (HDFS), o catálogo de metadados (Hive) e o motor de consulta distribuída (Trino).

---

## 1. Como Acessar as Plataformas

### 🐘 Hadoop-Node (Armazenamento e Metadados)
Este nó contém o **HDFS** e o **Hive Server/Metastore**.

* **Acesso à VM:** 
    ```bash
    vagrant ssh hadoop-node
    ```
* **Acesso ao Hive (via Beeline CLI):**
    ```bash
    beeline -u jdbc:hive2://localhost:10000 -n vagrant
    ```
    *Nota: O Beeline é o cliente SQL padrão do Hive. O parâmetro `-n vagrant` define o usuário da sessão.*

### 🔱 Trino-Node (Motor de Consulta)
Este nó é responsável pela execução de queries de alta performance sobre os dados do Hadoop.

* **Acesso à VM:**
    ```bash
    vagrant ssh trino-node
    ```
* **Acesso ao Trino CLI:**
    ```bash
    trino --catalog hive --schema default
    ```
    *Nota: O Trino utiliza conectores para "enxergar" o catálogo do Hive e os arquivos físicos no HDFS.*

---

## 2. Cenários de Teste de Integração

Siga esta sequência lógica para validar se os dados estão "viajando" corretamente entre as camadas.

### ✅ Passo A: Escrita no Hive (Origem)
**Objetivo:** Criar um dado no "chão de fábrica" e registrar no catálogo. No **Beeline**, execute:

```sql
-- 1. Criar a tabela no formato Parquet
CREATE TABLE usuarios_hadoop (id INT, nome STRING) STORED AS PARQUET;

-- 2. Inserir um registro de teste
INSERT INTO usuarios_hadoop VALUES (1, 'Ericson - Origem Hive');

-- 3. Verificar persistência local
SELECT * FROM usuarios_hadoop;
```

### ✅ Passo B: Consulta e Escrita via Trino (Federação)
Objetivo: Validar se o Trino consegue ler do Hive e criar novos arquivos no HDFS. No Trino CLI, execute:

```sql
-- 1. Consultar o dado que foi criado originalmente no Hive
SELECT * FROM hive.default.usuarios_hadoop;

-- 2. Criar uma nova tabela (CTAS) usando o motor do Trino
CREATE TABLE hive.default.usuarios_trino AS 
SELECT id, nome, 'Criado via Trino' as origem 
FROM hive.default.usuarios_hadoop;
```

### ✅ Passo C: Validação Física no HDFS
Objetivo: Confirmar que os dados foram fisicamente gravados no disco distribuído. No terminal do hadoop-node, execute:

**Listar recursivamente os diretórios do warehouse**
```bash
hdfs dfs -ls -R /user/hive/warehouse/
```
