#!/bin/bash

# Verifica se o script está sendo executado com sudo
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute o script com 'sudo'."
  exit 1
fi

# Função para exibir mensagens informativas
function info {
  echo "[INFO] $1"
}

# Função para verificar o sucesso de um comando
function check_success {
  if [ $? -ne 0 ]; then
    echo "[ERRO] $1"
    exit 1
  fi
}

# Instala o curl se não estiver instalado
info "Instalando o curl, se necessário..."
sudo apt install -y curl
check_success "Falha ao instalar o curl."

# Baixa a chave GPG para o repositório Brave e a armazena no local apropriado
info "Baixando e adicionando a chave GPG do Brave..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
check_success "Falha ao adicionar a chave GPG do Brave."

# Adiciona o repositório Brave ao sources.list.d
info "Adicionando o repositório Brave ao sources.list.d..."
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null
check_success "Falha ao adicionar o repositório do Brave."

# Atualiza a lista de pacotes
info "Atualizando a lista de pacotes..."
sudo apt update -q
check_success "Falha ao atualizar a lista de pacotes."

# Instala o Brave Browser
info "Instalando o Brave Browser..."
sudo apt install -y brave-browser
check_success "Falha ao instalar o Brave Browser."

info "Brave Browser instalado com sucesso."
