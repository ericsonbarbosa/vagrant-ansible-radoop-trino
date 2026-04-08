#!/bin/bash

# Encerra o script em caso de erro
set -e

# Caminho absoluto para o executável do Windows no WSL
VAGRANT="/mnt/c/Program\ Files\ \(x86\)/Vagrant/bin/vagrant.exe"

echo "🔍 Verificando o status das máquinas virtuais..."

# 1. Checagem de Status
# Usamos eval para que o Bash interprete corretamente os espaços no caminho do Windows
VM_STATUS=$(eval "$VAGRANT status --machine-readable" | tr -d "\r" | grep ",state," | cut -d',' -f4)

if echo "$VM_STATUS" | grep -qv "running"; then
    echo "pit stop 🛑 Algumas VMs estão desligadas ou não criadas. Iniciando..."
    eval "$VAGRANT up --no-provision"
else
    echo "✅ VMs já estão em execução. Pulando o boot."
fi

echo "⏳ Aguardando estabilização da rede (5s)..."
sleep 5

echo "⚙️  Executando a orquestração com Ansible..."
export ANSIBLE_HOST_KEY_CHECKING=False

# 2. Execução do Ansible
# Certifique-se de que o comando 'ansible-playbook' está instalado no seu Ubuntu/WSL
if command -v ansible-playbook >/dev/null 2>&1; then
    ansible-playbook -i ansible/inventory/hosts.ini ansible/playbook.yml "$@"
else
    echo "❌ Erro: ansible-playbook não encontrado no WSL. Instale com: sudo apt install ansible"
    exit 1
fi

echo "🏁 Processo concluído!"
read -p "Pressione [Enter] para fechar..."