#!/bin/bash

# Variables de colores con códigos ANSI
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

# Verifica si se ha proporcionado una IP o hostname
if [ "$#" -ne 1 ]; then
    echo ""
    echo "Uso: $0 <IP o hostname>"
    exit 1
fi

IP="$1"

# Realiza un ping al host
PING_OUTPUT=$(ping -c 1 "$IP" 2>&1)

# Verifica si el ping fue exitoso
if echo "$PING_OUTPUT" | grep -q "100% packet loss"; then
    echo ""
    echo -e "${RED}[!] $IP: Está apagada o se está reiniciando [!]${RESET}"
    exit 0
fi

# Extrae el TTL del resultado del ping
TTL=$(echo "$PING_OUTPUT" | grep -oP 'ttl=\K\d+')

# Verifica si se pudo extraer el TTL
if [ -z "$TTL" ]; then
    echo ""
    echo -e "${RED}[!] Verifica que la IP sea correcta [!]${RESET}"
    exit 3
fi

# Identifica el sistema basado en el TTL
if [ "$TTL" -le 64 ]; then
    echo ""
    echo -e "${YELLOW}[*] $IP:${RESET}${CYAN} Linux (TTL=$TTL)${RESET}"
else
    echo ""
    echo -e "${YELLOW}[*] $IP:${RESET}${CYAN} Windows (TTL=$TTL)${RESET}"
fi
