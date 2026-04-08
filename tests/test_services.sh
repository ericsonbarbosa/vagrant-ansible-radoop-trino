#!/bin/bash

echo "🔍 Testando conectividade dos serviços..."

# Teste HDFS NameNode UI (Porta 9870)
if curl -s --head  --request GET http://192.168.56.10:9870 | grep "200 OK" > /dev/null; then 
   echo "✅ HDFS NameNode está online."
else
   echo "❌ HDFS NameNode não respondeu."
fi

# Teste Trino UI (Porta 8080 padrão)
if curl -s --head  --request GET http://192.168.56.11:8080/ui/ | grep "200" > /dev/null; then 
   echo "✅ Trino Coordinator está online."
else
   echo "❌ Trino Coordinator não respondeu."
fi