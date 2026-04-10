# 🚀 Vagrant Lab — Hadoop + Trino (Base Infrastructure)

## 📌 Visão Geral

Este projeto tem como objetivo provisionar uma infraestrutura local utilizando **Vagrant + VirtualBox**, servindo como base para um ambiente distribuído com Hadoop e Trino.

Nesta primeira etapa, o foco é:

* Subir duas máquinas virtuais
* Configurar recursos (CPU, memória)
* Garantir conectividade entre os nós
* Preparar o ambiente para futuras automações (Ansible)

---

## 🧱 Arquitetura Inicial

| VM          | Hostname    | IP            | Função futura |
| ----------- | ----------- | ------------- | ------------- |
| hadoop-node | hadoop-node | 192.168.56.10 | Hadoop        |
| trino-node  | trino-node  | 192.168.56.11 | Trino         |

---

## ⚙️ Pré-requisitos

Antes de iniciar, é necessário ter instalado:

* VirtualBox
* Vagrant
* Sistema operacional host: Windows

⚠️ Observação:

> O Vagrant deve ser executado via PowerShell ou CMD (não via WSL).

---

## 📁 Estrutura do Projeto

```
vagrant-ansible-hadoop-trino/
├── Vagrantfile
└── README.md
```

---

## 🚀 Subindo a Infraestrutura

Execute no diretório do projeto:

```bash
vagrant up
```

### O que este comando faz:

* Baixa a box `ubuntu/jammy64`
* Cria duas VMs no VirtualBox
* Define:

  * 2 CPUs por VM
  * 2GB de RAM por VM
* Configura rede privada
* Define hostname das máquinas

---

## 🔐 Acesso às Máquinas Virtuais

### Hadoop Node

```bash
vagrant ssh hadoop-node
```

---

### Trino Node

```bash
vagrant ssh trino-node
```

---

## 🧪 Validação do Ambiente

Após acessar cada VM, execute:

```bash
hostname
free -h
nproc
```

### Resultado esperado:

* Hostname correto
* 2GB de memória disponível
* 2 CPUs provisionadas

---

## 🌐 Teste de Conectividade

### Do Hadoop para Trino:

```bash
ping 192.168.56.11
```

### Do Trino para Hadoop:

```bash
ping 192.168.56.10
```

✔ Se houver resposta, a comunicação entre os nós está funcionando.

---

## 📦 O que já foi provisionado automaticamente

Ao executar `vagrant up`, o ambiente já entrega:

* Sistema operacional Ubuntu Server
* Rede privada entre as VMs
* Acesso SSH configurado
* Sincronização de pasta (/vagrant)
* Estrutura pronta para automação

---

## ⚠️ Observações

### Guest Additions

Pode aparecer aviso de versão diferente do VirtualBox:

> Isso não impacta o funcionamento inicial do projeto.

---

### Portas SSH

As portas são atribuídas automaticamente:

* hadoop-node → 2222
* trino-node → 2200

---

## 🧹 Comandos úteis

Parar VMs:

```bash
vagrant halt
```

Destruir ambiente:

```bash
vagrant destroy
```

Reiniciar:

```bash
vagrant reload
```

---

## 🔮 Próximos Passos

Este projeto será evoluído com:

* Provisionamento com Ansible
* Instalação automatizada de Java
* Configuração de SSH entre nós
* Setup de cluster Hadoop
* Integração com Trino

---

## 📚 Objetivo do Projeto

Este laboratório tem como finalidade:

* Aprendizado prático de infraestrutura como código
* Simulação de ambiente distribuído local
* Construção de portfólio técnico

---

## 👨‍💻 Autor

Projeto em evolução contínua 🚀
