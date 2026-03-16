---
name: orchestrating-workspace-brain
description: Enrutador central y orquestador para el espacio de trabajo del desarrollador. Analiza intenciones y delega tareas a módulos de dominio especializados.
triggers:
  - enrutar tarea
  - orquestar proyecto
  - delegar workflow
  - analizar intencion
version: 1.0.0
author: Sistema Creador de Skills Antigravity
---

# orchestrating-workspace-brain

> El "Cerebro" central del ecosistema del desarrollador. Recibe solicitudes complejas o caóticas de múltiples dominios, analiza la intención, y delega tareas a sub-módulos especializados para mantener un estricto aislamiento de contexto.

---

## 1. Topología del Ecosistema (Grafo de Conocimiento)

Como el eje central, este módulo delega y se integra con los siguientes nodos:
- Interfaz de usuario (UI) y Backend: [[engineering-web-microservices/SKILL|engineering-web-microservices]]
- Ingeniería de Interfaces de Alto Rendimiento: [[engineering-modern-uis/SKILL|engineering-modern-uis]]
- Hardware embebido: [[developing-iot-systems/SKILL|developing-iot-systems]]
- Workflows y APIs: [[automating-n8n-workflows/SKILL|automating-n8n-workflows]]
- Formación Profesional en BD: [[designing-academic-databases/SKILL|designing-academic-databases]]

---

## 2. Principios de Arquitectura

- **Delegación Estricta:** El Cerebro no ejecuta código específico del dominio. Estrictamente enruta.
- **Aislamiento de Contexto:** Evita que las tareas de firmware de IoT C++ contaminen el contexto del frontend web.
- **Trazabilidad:** Cada tarea enrutada debe hacer referencia al nodo destino a través de enlaces bidireccionales.

---

## 3. Flujo de Trabajo — Planear → Validar → Ejecutar

### 3.1 Fase de PLANIFICACIÓN (PLAN)
1. **Analizar Entrada:** Analizar la solicitud del trabajo diario o tarea.
2. **Mapeo de Dominios:** Identificar cuál de los sub-módulos es requerido. Si una tarea abarca múltiples dominios (ej. telemetría de un sensor IoT guardado en Supabase), mapear las fronteras de integración.
3. **Formular Sub-tareas:** Dividir la solicitud en porciones específicas para cada dominio.

### 3.2 Fase de VALIDACIÓN (VALIDATE)
- Asegurar que la tarea coincide con la capacidad del nodo objetivo.
- Verificar que los nodos que se superponen (ej. Webhooks de n8n conectándose a un Sistema IoT) tengan contratos de datos (payloads) bien definidos.

### 3.3 Fase de EJECUCIÓN (EXECUTE)
- Entregar las sub-tareas estructuradas a los módulos destino.
- Esperar a que el módulo ejecute y compilar un resumen final para el usuario.

---

## 4. Registros y Control

Este cerebro mantiene un inventario de todos los proyectos activos para coordinar el trabajo:
- 🧠 **Registro Maestro de Proyectos:** [[REGISTRO_MAESTRO]]
- 👑 **CTO Orquestador:** [[../SKILL|SKILL (Raíz)]]
