#!/usr/bin/env bash
# ==========================================
# Programa    : conf2.sh
# Descrição   : Script para realizar backup de arquivos e diretórios no Linux utilizando variaveis de ambiente
# Uso         : sudo ./conf2.sh
# Autor       : Isaque S.
# Versão      : 1.0
# ==========================================
# carregar .env
[ -f .env ] && source .env

pasta=${1:-$PASTA_BACKUP}
dias=${2:-$DIAS_PADRAO}

mkdir -p backups

if [ -d "$pasta" ]; then
    echo "Diretorio de origem para backup: $pasta"
else
    echo "O diretorio informado não é valido" && exit 1
fi

nome=$(basename "$pasta")
data=$(date +"%Y-%m-%d_%H-%M")
backup="backup_${nome}_${data}.tar.gz"

echo "Removendo backups com mais de $dias dias"

quantidade=$(find backups/ -type f -name "backup_${nome}_*.tar.gz" -mtime +"$dias" | wc -l)

if [ "$quantidade" -gt 0 ]; then
    find backups/ -type f -name "backup_${nome}_*.tar.gz" -mtime +"$dias" -delete
    echo "Foram removidos $quantidade arquivos antigos."
else
    echo "Nenhum arquivo antigo encontrado."
fi

echo "Iniciando backup do diretorio $pasta para backups/$backup"

tar -czf "backups/$backup" "$pasta"

if [ $? -eq 0 ]; then
    echo "Backup realizado com sucesso: $backup"
else
    echo "Falha ao realizar o backup"
fi