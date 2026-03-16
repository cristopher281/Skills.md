---
name: developing-iot-systems
description: Desarrolla firmware embebido en C/C++, maneja integraciones de hardware y administra telemetría de sensores en microcontroladores (ESP32/Arduino).
triggers:
  - programar esp32
  - escribir firmware arduino
  - recolectar telemetria sensor
  - integrar hardware
version: 1.0.0
author: Sistema Creador de Skills Antigravity
---

# developing-iot-systems

> Maneja la ingeniería de sistemas embebidos de bajo nivel. Se enfoca en escribir firmware eficiente en C/C++, gestionar interacciones de pines GPIO, y asegurar una transmisión de telemetría fiable por MQTT o HTTP.

---

## 1. Topología del Ecosistema

- Controlado por: [[orchestrating-workspace-brain/SKILL|orchestrating-workspace-brain]]
- Envía Telemetría a: [[automating-n8n-workflows/SKILL|automating-n8n-workflows]]

---

## 2. Principios de Arquitectura

- **Eficiencia de Memoria:** El firmware debe evitar la asignación dinámica de memoria (p.ej. uso de clases `String`) para prevenir la fragmentación del heap (memoria).
- **Código No Bloqueante (Non-blocking):** Usar temporizadores de hardware (timers) o máquinas de estado en vez de `delay()`.
- **Tolerancia a Fallos:** Implementar lógica de auto-reconexión para desconexiones Wi-Fi/MQTT y asegurar los "watchdog timers" (WDT).

---

## 3. Flujo de Trabajo — Planear → Validar → Ejecutar

### 3.1 Fase de PLANIFICACIÓN (PLAN)
1. **Mapeo de Hardware:** Definir pines GPIO, interfaces I2C/SPI, y bibliotecas de periféricos requeridas.
2. **Diseño de la Máquina de Estados:** Trazar los estados de ejecución (Ej. INIT, LEER_SENSOR, TRANSMITIR, DORMIR).
3. **Carga Útil de Telemetría (Payload):** Definir la estructura JSON para los datos del sensor.

### 3.2 Fase de VALIDACIÓN (VALIDATE)
- Verificar el presupuesto energético ("power budget") y las capacidades de deep-sleep.
- Buscar límites de tamaño de arrays y evitar los "buffer overflows" típicos en C/C++.
- Validar la seguridad de red (TLS/SSL para MQTT si aplica).

### 3.3 Fase de EJECUCIÓN (EXECUTE)
- Generar código estructurado en C/C++ para el ESP32/Arduino.
- Entregar instrucciones de cableado del hardware o diagramas esquemáticos si fuera necesario.
- Escribir test unitarios para las capas de abstracción de hardware.

---

## 4. Contratos y Referencias

Para mantener la integridad operativa, este módulo consulta y obedece los siguientes estándares:
- 📡 **Esquema de Telemetría:** [[esquema-telemetria]]
- ⚙️ **Mejores Prácticas C++:** [[mejores-practicas-cpp]]
- ⚙️ **Firmware Industrial (C/C++):** [[firmware-industrial]]
