# 📄 Log Monitor Script (Bash)

Script em Bash para monitoramento de logs no Linux, com suporte a filtros personalizados, limitação de linhas e execução contínua.

---

## Funcionalidades

* Filtra logs por palavras-chave (regex)
* Ignora maiúsculas/minúsculas
* Limita quantidade de linhas analisadas
* Monitoramento contínuo (loop)
* Encerramento seguro com `Ctrl + C`
* Salva resultados em arquivo

---

## Como usar

```bash
sudo ./log_monitor.sh <arquivo_log> <filtro_opcional> <quantidade_linhas>
```

### Exemplos

```bash
sudo ./log_monitor.sh /var/log/messages
```

```bash
sudo ./log_monitor.sh /var/log/messages "error|fail"
```

```bash
sudo ./log_monitor.sh /var/log/messages "error|fail" 20
```

---

## ⚠️ Observações

* Alguns logs exigem permissão de superusuário, por isso recomendo utilizar com o Sudo:

* O script cria/atualiza o arquivo:

```
arquivo_de_errolog.txt
```

---

## Monitoramento contínuo

Após a primeira execução, o script pergunta se deseja continuar monitorando.

Se escolher `s`, ele:

* verifica o log a cada 10 segundos
* adiciona novas ocorrências ao arquivo

Para encerrar:

```bash
Ctrl + C
```

---