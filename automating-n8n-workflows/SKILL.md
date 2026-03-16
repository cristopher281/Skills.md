---
name: automating-n8n-workflows
description: Automatiza procesos usando n8n, enlaza APIs y maneja la ingesta de webhooks y el enrutamiento.
triggers:
  - configurar n8n
  - crear automatizacion
  - manejar webhook
  - hacer puente apis
version: 1.0.0
author: Sistema Creador de Skills Antigravity
---

# automating-n8n-workflows

> Actúa como el sistema nervioso central conectando distintos servicios. Construye arquitecturas dirigidas por eventos (event-driven), procesa webhooks y crea automatizaciones complejas usando n8n.

---

## 1. Topología del Ecosistema

- Controlado por: [[orchestrating-workspace-brain/SKILL|orchestrating-workspace-brain]]
- Dispara acciones en: [[engineering-web-microservices/SKILL|engineering-web-microservices]]
- Ingiere (consume) datos de: [[developing-iot-systems/SKILL|developing-iot-systems]]

---

## 2. Principios de Arquitectura

- **Idempotencia:** Los flujos (workflows) tienen que ser seguros de ejecutar múltiples veces (p. ej. los reintentos no deberían duplicar información en las bases).
- **Manejo de Errores:** Cada flujo de trabajo debe tener un sub-flujo definido que capture fallos y lance notificaciones.
- **Conciencia de Límites de Tasa (Rate Limits):** Respetar los límites máximos de las APIs usando agrupamiento (batching) o limitadores (throttles).

---

## 3. Flujo de Trabajo — Planear → Validar → Ejecutar

### 3.1 Fase de PLANIFICACIÓN (PLAN)
1. **Identificación del Disparador (Trigger):** Definir el evento que inicia el flujo (ej. Entrada de Webhook, horario Cron, consulta (polling) periódica).
2. **Transformación de Datos:** Mapear el diagrama del JSON de entrada al diagrama requerido por las APIs de salida.
3. **Distribución de los Nodos (Node Layout):** Abstraer y definir qué nodos de n8n irán en qué orden lógico (HTTP Request, Switch, Set, etc.).

### 3.2 Fase de VALIDACIÓN (VALIDATE)
- Evaluar switches lógicos buscando que no se generen bucles infinitos.
- Validar métodos de autenticación de las API (OAuth2, Tokens Bearer).
- Asegurar que las contraseñas/credenciales confidenciales estén referenciadas de manera dinámica y no codificadas a la fuerza (hardcoded) en texto plano.

### 3.3 Fase de EJECUCIÓN (EXECUTE)
- Proporcionar el "blueprint" o plano JSON exacto del flujo de n8n listo para importar.
- Plantear e indicar procesos de pruebas manuales (p.ej. usar comandos en línea "cURL" para comprobar si el webhook se recibe y dispara correctamente).

---

## 4. Contratos y Referencias

Para mantener la integridad operativa, este módulo consulta y obedece los siguientes estándares:
- 🪝 **Webhook Maestro:** [[webhook-maestro]]
- 🔄 **Flujos Idempotentes:** [[flujos-idempotentes]]
- 🔄 **Patrones Event-Driven:** [[patrones-event-driven]]
