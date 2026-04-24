#!/usr/bin/env bash
# ==========================================

# Programa    : log_monitor.sh
# Descrição   : Script para monitorar arquivos de log no Linux.
# Uso         : sudo ./log_monitor.sh <arquivo_de_log> <palavra a ser procurada> <quantidade das ultimas linhas>
# Autor       : Isaque S.
# Versão      : 1.1
# ==========================================
if [ -f "$1" ]; then 
   echo "Arquivo de log que sera analisado: $1" 
else 
   echo "o arquivo informado nao existe, por favor informe um arquivo valido" && exit 1 
fi 
if [ -n "$1" ]; then 
   arquivo="$1" 
   else 
   arquivo="/var/log/messages" 
fi

if [ -n "$2" ]; then
    palavra="$2"
else
    palavra="error|fail|denied|failure"
fi
if [ -n "$3" ]; then
    linhas="$3"
else
    linhas="${3:-100}"
fi

echo "Iniciando o monitoramento do arquivo de log $arquivo por ocorrencias da palavra $palavra nas ultimas $linhas linhas."

if grep -Ei "$palavra" "$arquivo" | tail -n "$linhas" > arquivo_de_errolog.txt; then
    echo "Ocorrencias encontradas e salvas no arquivo de erros."
else
    echo "Nenhuma ocorrencia encontrada para a palavra $palavra no arquivo $arquivo."
fi

echo "Monitoramento concluido."
echo "Deseja que continue monitorando o arquivo? (s/n)?"
read -r resposta

trap 'echo "Monitoramento finalizado pelo usuário."; exit 0' SIGINT
echo "Pressione Ctrl+C caso queira encerrar o monitoramento"
case "$resposta" in
    [sS]) while true; do
        sleep 10
        echo "verificando novamente o arquivo"
        if grep -Ei "$palavra" "$arquivo" | tail -n "$linhas" >> arquivo_de_errolog.txt; then
            echo "Nova ocorrencias encontradas foram salvas no arquivo de erros."
        else
            echo "Nenhuma nova ocorrencia encontrada"
        fi 
    done ;;
    [nN])
        echo "Encerrando o monitoramento do arquivo de log." && exit 0 ;;
    *) echo "Resposta inválida. Encerrando o monitoramento do arquivo de log." && exit 1 ;;
esac

