#!/usr/bin/env bash

# ===============================
# USO DO SCRIPT PARA AGENDAR BACKUP VIA CRON
# ===============================

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
        echo "O diretório informado não é válido."
        exit 1
    fi

    nome=$(basename "$dir")

    # cria pasta específica para aquele diretório
    mkdir -p "backups_agendados/backups_${nome}"

    cmd_cron="$minutos $hora $dias_mes $meses $dias_semana $SCRIPT_PATH \"$dir\" $dias --agendado >> $(realpath backups_agendados/backup_agendado.log) 2>&1"

    echo "$cmd_cron"
    (crontab -l 2>/dev/null; echo "$cmd_cron") | crontab -

    echo "Agendamento criado com sucesso!"
    echo "Backups serão salvos em: backups_agendados/backups_${nome}"
    exit 0
fi


# ===============================
# USO DO SCRIPT PARA REALIZAR BACKUP
# ===============================

if [ -z "$1" ]; then
    echo "Uso: $0 <diretório> [dias]"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "O diretorio informado não é valido"
    exit 1
fi

dias=${2:-7}
nome=$(basename "$1")
data=$(date +"%Y-%m-%d_%H-%M")
backup="backup_${nome}_${data}.tar.gz"

# 🔥 DEFINIÇÃO DINÂMICA DO DESTINO
if [ "$3" == "--agendado" ]; then
    DIR_BACKUP="backups_agendados/backups_${nome}"
else
    DIR_BACKUP="backups"
fi

mkdir -p "$DIR_BACKUP"

echo "Removendo backups com mais de $dias dias em $DIR_BACKUP"

quantidade=$(find "$DIR_BACKUP" -type f -name "backup_${nome}_*.tar.gz" -mtime +"$dias" -delete | wc -l)

if [ "$quantidade" -gt 0 ]; then
    echo "Foram removidos $quantidade arquivos antigos."
else
    echo "Nenhum backup antigo encontrado para remoção."
fi

echo "Iniciando backup do diretorio $1 para $DIR_BACKUP/$backup"

tar -czf "$DIR_BACKUP/$backup" "$1"

if [ $? -eq 0 ]; then
    echo "Backup realizado com sucesso: $DIR_BACKUP/$backup"
else
    echo "Falha ao realizar o backup."
fi