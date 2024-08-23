#!/bin/bash

# Verifica se o script está sendo executado com sudo
if [ "$EUID" -eq 0 ]; then
  echo "Por favor, execute o script com 'sudo' e não como root diretamente."
  exit 1
fi

# Função para exibir mensagens
function info {
  echo "[INFO] $1"
}

# Adiciona a chave GPG para o repositório VSCodium
info "Adicionando a chave GPG do repositório VSCodium..."
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/vscodium-archive-keyring.gpg > /dev/null
if [ $? -ne 0 ]; then
  echo "[ERRO] Falha ao adicionar a chave GPG."
  exit 1
fi

# Adiciona o repositório VSCodium ao sources.list.d
info "Adicionando o repositório VSCodium ao sources.list.d..."
echo 'deb [signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list > /dev/null
if [ $? -ne 0 ]; then
  echo "[ERRO] Falha ao adicionar o repositório."
  exit 1
fi

# Atualiza a lista de pacotes
info "Atualizando a lista de pacotes..."
sudo apt update -q
if [ $? -ne 0 ]; then
  echo "[ERRO] Falha ao atualizar a lista de pacotes."
  exit 1
fi

# Instala o VSCodium
info "Instalando o VSCodium..."
sudo apt install -y codium
if [ $? -ne 0 ]; then
  echo "[ERRO] Falha ao instalar o VSCodium."
  exit 1
fi

info "VSCodium instalado com sucesso."
