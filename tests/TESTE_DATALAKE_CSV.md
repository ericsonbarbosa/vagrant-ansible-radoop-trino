
# Datalak teste com arquivo CSV

## Hadoop

### 1. Se você estiver no terminal do hadoop-node, pode criar o arquivo rapidinho assim:
```Bash
nano produtos.csv
```
### 2. Colar o texto no csv, aperta Ctrl+O (para salvar) e Ctrl+X (para sair)
```Text
1,Smartphone,2500.00
2,Notebook,4500.00
3,Monitor,1200.00
```
Depois é só seguir com o hdfs dfs -put.

### 3. Enviar para o HDFS
Primeiro, mova o arquivo para a VM e depois para o sistema de arquivos distribuído:

```Bash
# Dentro do hadoop-node, crie a pasta para os dados brutos (Raw Zone)
hdfs dfs -mkdir -p /user/hive/warehouse/lab_ed.db/produtos_csv

# Suba o arquivo do seu Linux local para o HDFS
hdfs dfs -put produtos.csv /user/hive/warehouse/lab_ed.db/produtos_csv/
```

### Comandos Úteis (Remoção de Pasta/Arquivo do HDFS)
```Bash
# Remover a pasta
hdfs dfs -rm -r /user/hive/warehouse/lab_ed.db/produtos_csv/

# Remover o arquivo
hdfs dfs -rm -skipTrash /user/hive/warehouse/lab_ed.db/produtos_csv/produtos.csv

#Conultar pasta
hdfs dfs -ls /user/hive/warehouse/lab_ed.db/produtos_csv/
```

Atenção: ***O Hive/Trino lê a pasta, não o arquivo individual. Todos os arquivos dentro dessa pasta devem ter a mesma estrutura.***

## Trino

Entrar no modo Interração:
```bash
    trino --catalog hive --schema default
```
Criar tabela habilitando o formato CSV para SQL
```SQL
CREATE TABLE hive.lab_ed.produtos_csv (
    id BIGINT,
    nome VARCHAR,
    preco DOUBLE
)
WITH (
    format = 'TEXTFILE',
    textfile_field_separator = ',',
    external_location = 'hdfs://192.168.56.10:9000/user/hive/warehouse/lab_ed.db/produtos_csv/'
);
```
Consultar os dados
Agora é só rodar o bom e velho SQL:

```SQL
SELECT * FROM hive.lab_ed.produtos_csv;
```

Inserindo novos dados ao CSV
```SQL
INSERT INTO hive.lab_ed.produtos_csv VALUES (6, 'Headset Wireless', 450.00);

SELECT * FROM hive.lab_ed.produtos_csv;
```