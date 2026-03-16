---
name: engineering-modern-uis
description: Ingeniería de interfaces web ultra modernas y de alto rendimiento usando paradigmas de arquitectura frontend de 2026.
triggers:
  - construir UI de alto rendimiento
  - estructurar frontend moderno
  - diseñar layout web 2026
  - generar arquitectura UI moderna
  - crear frontend ultra rapido
version: 1.0.0
author: Sistema Creador de Skills Antigravity
---

# engineering-modern-uis

> Diseña interfaces web de grado producción y ultra modernas utilizando renderizado desde el borde (edge-first), reactividad basada en señales (signals), interacciones aceleradas por GPU y cumplimiento de accesibilidad WCAG 3.0.

---

## 1. Topología del Ecosistema

- Controlado por: [[orchestrating-workspace-brain/SKILL|orchestrating-workspace-brain]]
- Consumidor visual de: [[engineering-web-microservices/SKILL|engineering-web-microservices]]

---

## 2. Principios de Arquitectura

- **Server-Driven UI (SDUI):** Transmisión progresiva de componentes desde el servidor. Componentes interactivos marcados como cliente.
- **Estado basado en Señales (Signals):** Eliminación completa del diffing del DOM virtual (VDOM). Las actualizaciones son quirúrgicas y directas.
- **CSS Moderno:** Uso intensivo de consultas de contenedor (container queries), anidamiento de CSS nativo (`&`) y colores perceptualmente uniformes (`oklch()`).
- **Aceleración GPU:** Interacciones impulsadas mediante la API de Web Animations y WebGL.

---

## 3. Flujo de Trabajo — Planear → Validar → Ejecutar

### 3.1 Fase de PLANIFICACIÓN (PLAN)
1. **Analizar Requisitos UI:** Analizar el diseño, la interacción y las necesidades de datos a plasmar en la vista.
2. **Jerarquía de Componentes:** Producir un árbol de componentes con separación clara entre servidor (`server`) y cliente (`client`).
3. **Mapeo de Flujo de Datos:** Identificar datos "edge-fetched", señales (signals) y derivaciones computadas (computed).

### 3.2 Fase de VALIDACIÓN (VALIDATE)
- Validar Accesibilidad (WCAG 3.0): Contrastes de `4.5:1`, navegación por teclado completa y estructura semántica estricta.
- Validar Estabilidad del Diseño (CLS < 0.05): Uso de esqueletos de carga con dimensiones exactas para evitar corrimientos.
- Validar Presupuesto de Rendimiento: Largest Contentful Paint (LCP) < 1.0s, Interaction to Next Paint (INP) < 40ms, Peso de JS total < 40KB.

### 3.3 Fase de EJECUCIÓN (EXECUTE)
- Generar esqueletos y árbol de componentes separando carga.
- Imprimir *tokens* de diseño CSS y la capa de estado en Signals.
- Ejecutar test visuales locales incluyendo `audit-performance.sh`.

---

## 4. Contratos y Referencias

Para garantizar que el frontend opere a velocidad de la luz, acata los siguientes estándares de la industria:
- 👑 **Reglas de Oro Web:** [[../engineering-web-microservices/references/reglas-oro-web|reglas-oro-web]]
- 📘 **Paradigmas Frontend 2026:** [[paradigmas-frontend]]
