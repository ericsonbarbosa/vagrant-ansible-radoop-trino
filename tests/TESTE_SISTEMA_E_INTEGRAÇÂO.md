# 🚀 Guia de Testes de Integração e Sistema: Ecossistema Big Data
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
* **Validar se o Metastore está rodando na 9083 e pronto para receber o Trino:**
    ```bash
    sudo netstat -nlpt | grep 9083
    ```
    *Nota: O comando deve retornar que está ecutando: tcp 0.0.0.0:9083*

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

### ✅ Passo A: Escrita e Consulta via Trino
Objetivo: Validar se o Trino consegue ler do Hive e criar novos arquivos no HDFS. No Trino CLI, execute:

```sql
-- 1. Criar um schema (banco de dados) no catálogo do Hive
CREATE SCHEMA hive.lab_ed;

-- 2. Criar a tabela
CREATE TABLE hive.lab_ed.usuarios (
    id BIGINT, nome VARCHAR, cargo VARCHAR
) WITH (format = 'PARQUET');

-- 3. Inserir os dados (Este é o momento da verdade!)
INSERT INTO lab_ed.usuarios VALUES (1, 'Ericson', 'Data Engineer'), (2, 'Ana Vitória', 'Little Artist');

-- 4. Consultar os dados
SELECT * FROM lab_ed.usuarios;

-- 5. Visualizar todas as tabelas criadas dento do lab_ed.db
SHOW TABLES FROM lab_ed;

-- 6. Excluir schema para recomeçar os testes
DROP SCHEMA IF EXISTS hive.lab_ed CASCADE;
```

### ✅ Passo C: Validação Física no HDFS - VM *hadoop-node*
Objetivo: Confirmar que os dados foram fisicamente gravados no disco distribuído. No terminal do **hadoop-node**, execute:

**Listar recursivamente os diretórios do warehouse**
```bash
# Listar os arquivos do HDFS (Hadoop Distributed File System), que é o sistema de arquivos virtual e distribuído. 
hdfs dfs -ls /

# Listar o arquivo físico no HDFS do tipo .db
hdfs dfs -ls -R /user/hive/warehouse/

# Listar o "status" de saúde do cluster
hdfs dfsadmin -report 
```
