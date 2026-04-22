# Check Service Script

## Descrição
Script em Bash que verifica se um serviço está ativo.
Caso não esteja, tenta iniciar automaticamente.

---

## Requisitos
- Linux (testado no Rocky Linux)
- systemd
- Permissão de root (sudo)

---

## Como usar

```bash
sudo ./check.sh <nome_do_servico>