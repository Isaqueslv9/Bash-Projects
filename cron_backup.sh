#!/usr/bin/env bash
# ==========================================
# Programa    : backup_system.sh
# Descrição   : Script para realizar backup de arquivos e diretórios no Linux.
# Uso         : para uso do script apenas para fazer backup: sudo ./backup_system.sh <diretório> <dias para manter os backups> 
#               para agendar backup via cron: sudo ./backup_system.sh --agendar
# Autor       : Isaque S.
# Versão      : 2.0
# ==========================================

# USO DO SCRIPT PARA AGENDAR BACKUP VIA CRON

if [ "$1" == "--agendar" ]; then
    echo "Agendamento de backup via Cron"

    mkdir -p backups_agendados
    SCRIPT_PATH="$(realpath "$0")"

    read -p "informe o diretorio para backup: " dir
    read -p "Informe a hora (0-23) para o backup(padrão: *): " hora
    read -p "Informe os minutos (0-59) para o backup(padrão: *): " minutos
    read -p "Informe os dias da semana para o backup (0-6) (padrão: *): " dias_semana
    read -p "Informe os dias do mês para o backup (1-31) (padrão: *): " dias_mes
    read -p "Informe os meses para o backup (1-12) (padrão: *): " meses
    read -p "Dias para manter os backups(padrão: 7): " dias

    dias=${dias:-7}
    minutos=${minutos:-*}
    hora=${hora:-*}
    dias_mes=${dias_mes:-*}
    meses=${meses:-*}
    dias_semana=${dias_semana:-*}
    dir=$(realpath "$dir")
    
     if [ ! -d "$dir" ]; then
        echo "O diretório informado não é válido. Por favor, informe um diretório válido."
        exit 1
     fi

     nome=$(basename "$dir" )
     mkdir -p "backups_agendados/backups_${nome}"


    cmd_cron="$minutos $hora $dias_mes $meses $dias_semana $SCRIPT_PATH \"$dir\" $dias --agendado >> $(realpath backups_agendados/backup_agendado.log) 2>&1"
    echo "$cmd_cron"
    (crontab -l 2>/dev/null; echo "$cmd_cron") | crontab -
    echo "Agendamento criado com sucesso. Comando Cron: $cmd_cron"
    exit 0
fi
   
# USO DO SCRIPT PARA REALIZAR BACKUP
if [ -z "$1" ]; then
    echo "Uso: $0 <diretório> [dias]" && exit 1
fi

mkdir -p backups

if [ -d $1 ]; then
    echo "Diretorio de origem para backup: $1"
else
    echo "O diretorio informado não é valido, por favor informe um valido" && exit 1
fi

dias=${2:-7}
nome=$( basename "$1" )
data=$( date +"%Y-%m-%d_%H-%M" )
backup="backup_${nome}_${data}.tar.gz"

echo "Removendo backups com mais de $dias dias"
quantidade=$(find backups/ -type f -name "backup_${nome}_*.tar.gz" -mtime +"$dias" -delete | wc -L)
if [ "$quantidade" -eq 0 ]; then
    echo "Foram removidos $quantidade arquivos de backup com mais de $dias dias."
else
    echo "Nenhum arquivo de backup com mais de $dias dias foi encontrado para remoção."
fi

echo "iniciando backup do diretorio $1 para o arquivo backups/$backup"

tar -czf backups/"$backup".tar.gz  "$1"

if [ $? -eq 0 ]; then
    echo "Backup do diretorio $1 realizado com sucesso. Arquivo de backup: $backup"
else
    echo "Falha ao realizar o backup do diretorio $1."
fi