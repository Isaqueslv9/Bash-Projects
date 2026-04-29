#!/usr/bin/env bash
# ==========================================

# Programa    : sentinel_pulse.sh
# Descrição   : Script para monitorar serviços e saude da maquina.
# Uso         : sudo ./sentinel_pulse.sh -h (para exibir o menu de opções)
# Autor       : Isaque S.
# Versão      : 1.0
# ==========================================
MENU="
     $(basename $0) - [OPÇÕES]

     1) Monitorar CPU
     2) Monitorar RAM
     3) Monitorar Disco
     4) Monitorar serviços
     5) Sair
"
while true; do
    echo "$MENU"
    read -p "Escolha uma opção: " opcao
    case $opcao in
       -h) echo "$MENU" ;;
        1) echo "Monitorando cpu" && top -b -n 1 | head -n 10 ;;
        2) echo "Monitorando ram" && free -h ;;
        3) echo "Monitorando disco" && df -h ;; 
        4) echo "Monitorando serviços" && systemctl list-units --type=service --state=running ;;
        5) echo "Encerrando o monitoramento." && exit 0 ;;
        *) echo "Opção inválida. Por favor, escolha uma opção válida" ;;   
    esac
done
 
      