#!/bin/bash

echo "🔍 Testando conectividade dos serviços..."

# Teste HDFS NameNode UI
# Usamos -s (silent), -I (head) e -L (follow redirect)
if curl -sL -I http://192.168.56.10:9870 | grep -q "200 OK"; then 
   echo "✅ HDFS NameNode está online."
else
   echo "❌ HDFS NameNode não respondeu."
fi

# Teste Trino UI
if curl -sL -I http://192.168.56.11:8080 | grep -q "200"; then 
   echo "✅ Trino Coordinator está online."
else
   echo "❌ Trino Coordinator não respondeu."
fi