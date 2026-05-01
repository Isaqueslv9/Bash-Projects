#!/usr/bin/env bash
# ==========================================

# Programa    : health_check.sh
# Descrição   : Script para verificar status http e alertar caso serviço caia
# Uso         : sudo ./health_check.sh <url>
# Autor       : Isaque S.
# Versão      : 1.0
# ==========================================
URL="$1"

if [ -z "$URL" ]; then
    echo "Uso: $0 <url>"
    exit 1
fi

STATUS_ANTERIOR=0

while true; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

    if [[ $STATUS -ge 200 && $STATUS -lt 400 ]]; then
        echo "Site OK ($STATUS)"
        
        if [[ $STATUS_ANTERIOR -eq 1 ]]; then
            echo "Site voltou"
        fi

        STATUS_ANTERIOR=0

    else
        echo "Site com problema ($STATUS)"
        

        if [[ $STATUS_ANTERIOR -eq 0 ]]; then
            echo "ALERTA: Site caiu!"
        fi

        STATUS_ANTERIOR=1
    fi

    sleep 10
done