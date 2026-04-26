#!/usr/bin/env bash
# ==========================================
# Programa    : backup_system.sh
# Descrição   : Script para realizar backup de arquivos e diretórios no Linux.
# Uso         : sudo ./backup_system.sh <diretório> <dias para manter os backups>
# Autor       : Isaque S.
# Versão      : 1.0
# ==========================================
mkdir -p backups

if [ -d $1 ]; then
    echo "Diretorio de origem para backup: $1"
else
    echo "O diretorio informado não é valido, por favor informe um valido" && exit 1
fi

dias=${2:-7}
echo "Removendo backups com mais de $dias dias"
quantidade=$(find backups/ -type f -name "backup_${nome}_*.tar.gz" -mtime +"$dias" -delete | wc -L)
if [ "$quantidade" -eq 0 ]; then
    echo "Foram removidos $quantidade arquivos de backup com mais de $dias dias."
else
    echo "Nenhum arquivo de backup com mais de $dias dias foi encontrado para remoção."
fi
nome=$( basename "$1" )
data=$( date +"%Y-%m-%d_%H-%M" )
backup="backup_${nome}_${data}.tar.gz"

echo "iniciando backup do diretorio $1 para o arquivo backups/$backup"

tar -czf backups/"$backup".tar.gz  "$1"

if [ $? -eq 0 ]; then
    echo "Backup do diretorio $1 realizado com sucesso. Arquivo de backup: $backup"
else
    echo "Falha ao realizar o backup do diretorio $1."
fi