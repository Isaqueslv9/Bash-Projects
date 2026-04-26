# Backup System Script

Script em Bash para realizar backup automatizado de diretórios no Linux, com compressão e rotação de arquivos antigos.

---

## Funcionalidades

* Compactação de diretórios em `.tar.gz`
* Inclusão de data e hora no nome do backup
* Remoção automática de backups antigos
* Definição de dias de retenção (padrão: 7 dias)

---

## 🛠️ Como usar

```bash
./backup_system.sh <diretório> [dias]
```

### Parâmetros:

* `<diretório>` → caminho do diretório que será salvo
* `[dias]` → (opcional) quantidade de dias para manter os backups

  * padrão: `7`

---

## Exemplo

```bash
./backup_system.sh /home/isaque/projeto 5
```

Resultado: Cria um backup do diretório e remove backups com mais de 5 dias.

---

## Estrutura gerada da pasta

```text
backups/
 ├── backup_projeto_2026-04-26_14-30.tar.gz
 ├── backup_projeto_2026-04-25_10-15.tar.gz
```

---

## Observações

* Certifique-se de que o diretório informado existe
* O script cria automaticamente a pasta `backups/`
* Backups antigos são removidos com base na data de modificação

---

## Futuras melhorias

* Upload automático dos backups para a nuvem (ex: Amazon S3)
* Tentativas automáticas em caso de falha
* Integração com `cron` para execução agendada

---

