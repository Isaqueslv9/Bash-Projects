#!/usr/bin/env bash
# ==========================================

# Programa    : check_service.sh
# Descrição   : Script para verificar o status de um serviço no Linux. Caso esteja inativo, o script tentara iniciar o serviço.
# Uso         : sudo ./check_service.sh <serviço>
# Autor       : Isaque S.
# Versão      : 1.0
# ==========================================

echo "Verificando o status do serviço $1..."

if systemctl is-active --quiet $1; then
    echo "O serviço $1 está ativo."
else
    echo "O serviço $1 não está ativo. Vamos iniciá-lo..."
    systemctl start $1 --quiet
    systemctl start $1
        if systemctl is-active --quiet "$1"; then
            echo "O serviço $1 foi iniciado com sucesso."
        else
            echo "Falha ao iniciar o serviço $1."
        fi
fi
