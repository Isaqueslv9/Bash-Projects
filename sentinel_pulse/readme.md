# Sentinel Pulse

**Sentinel Pulse** é uma ferramenta em Bash para monitoramento básico de saúde do sistema Linux.
Com uma interface interativa no terminal, permite visualizar rapidamente o estado de CPU, memória, disco e serviços essenciais.

---

## Funcionalidades

* 📊 Monitoramento de CPU
* 🧠 Monitoramento de memória RAM
* 💾 Monitoramento de disco
* ⚙️ Verificação de serviços ativos
* 🖥️ Menu interativo no terminal

---

## Tecnologias utilizadas

* Bash Script
* Comandos Linux nativos:

  * `top`
  * `free`
  * `df`
  * `systemctl`

---


## Como usar


```bash
./sentinel-pulse.sh -h ( para mostrar menu)
```

---

## Menu do sistema

```
1) Monitorar CPU
2) Monitorar RAM
3) Monitorar Disco
4) Monitorar Serviços
5) Sair
```

---

## Exemplos de uso

* Ver consumo atual de CPU
* Checar uso de memória rapidamente
* Identificar uso de disco
* Listar serviços ativos no sistema

---

## Requisitos

* Sistema Linux com `systemd`
* Permissões adequadas (alguns comandos podem exigir `sudo`)

---

## Possíveis melhorias futuras

* [ ] Logs de monitoramento
* [ ] Alertas automáticos (CPU, RAM, Disco)
* [ ] Monitoramento contínuo
* [ ] Integração com cloud (ex: envio para S3)
* [ ] Interface mais amigável

---
