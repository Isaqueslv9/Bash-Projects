# Simple Site Health Check

Script simples em Bash para monitorar a disponibilidade de um site usando `curl`.

Ele verifica o status HTTP continuamente e **avisa quando o site cai ou volta ao normal**.

---

## Funcionalidades

* Verifica status HTTP (200, 404, 500…)
* Detecta se o site está **UP ou DOWN**
* Alerta quando:

  * 🔴 O site cai
  * 🟢 O site volta
* Loop contínuo com intervalo de 10 segundos

---

## Requisitos

* Linux / Bash
* `curl` instalado

---

## Como usar

```bash
chmod +x health_check.sh
sudo ./health_check.sh https://google.com
```

---

## Como funciona

O script:

1. Faz uma requisição HTTP com `curl`
2. Captura o código de status
3. Classifica:

   * `200–399` → site OK
   * Outros → problema
4. Compara com o estado anterior
5. Exibe alerta apenas se houver mudança

---

## Exemplo de saída

```bash
Site OK (200)
Site OK (200)
Site com problema (500)
ALERTA: Site caiu!
Site com problema (500)
Site OK (200)
Site voltou!
```

---

