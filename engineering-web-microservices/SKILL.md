---
name: engineering-web-microservices
description: Desarrolla interfaces de usuario front-end modernas, microservicios back-end, y maneja integraciones de bases de datos de Supabase.
triggers:
  - construir app web
  - crear microservicio
  - integrar supabase
  - diseñar UI frontend
version: 1.0.0
author: Sistema Creador de Skills Antigravity
---

# engineering-web-microservices

> Dedicado a construir aplicaciones web escalables y de alto rendimiento, microservicios backend resilientes, e integraciones fluidas con Supabase.

---

## 1. Topología del Ecosistema

- Controlado por: [[orchestrating-workspace-brain/SKILL|orchestrating-workspace-brain]]
- Consume las APIs de: [[automating-n8n-workflows/SKILL|automating-n8n-workflows]]

---

## 2. Principios de Arquitectura

- **Separación de Preocupaciones (Separation of Concerns):** Límites claros entre los componentes de la interfaz de usuario (UI) y la lógica de microservicios.
- **Backend-como-Servicio:** Aprovechar Supabase para Autenticación, Edge Functions y suscripciones de bases de datos en tiempo real.
- **Escalabilidad:** Los microservicios deben ser apátridas (stateless) y horizontalmente escalables.

---

## 3. Flujo de Trabajo — Planear → Validar → Ejecutar

### 3.1 Fase de PLANIFICACIÓN (PLAN)
1. **Reunir Requisitos:** Definir el diseño visual de la UI, los endpoints de microservicios y los requisitos de esquema de Supabase.
2. **Selección del Stack Tecnológico:** Determinar si la tarea requiere renderizado en cliente (Client-side rendering, p.e. herramientas internas) o renderizado en servidor (Server-side rendering, p.e. apps públicas).
3. **Contrato de API:** Preparar un borrador de los "blueprints" o planos de respuesta JSON para los microservicios.

### 3.2 Fase de VALIDACIÓN (VALIDATE)
- Revisar las Políticas de Seguridad de Nivel de Fila (RLS) en Supabase.
- Verificar que los componentes de la interfaz de usuario cumplan las Pautas de Accesibilidad (WCAG).
- Validar la seguridad de cada endpoint (API) y los límites de tasa (Rate Limits).

### 3.3 Fase de EJECUCIÓN (EXECUTE)
- Generar árboles de componentes de UI y archivos de diseño.
- Preparar la infraestructura / código para las Edge Functions y migraciones en Supabase.
- Escribir los endpoints (API) e integrar las capas de obtención de datos del frontend.

---

## 4. Contratos y Referencias

Para mantener la integridad operativa, este módulo consulta y obedece los siguientes estándares:
- 📄 **Acuerdos de Conexión (API):** [[acuerdos-conexion]]
- 👑 **Reglas de Oro Web:** [[reglas-oro-web]]
- 🧱 **Arquitectura Backend a Escala:** [[arquitectura-backend]]
