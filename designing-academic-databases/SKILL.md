---
name: designing-academic-databases
description: Módulo formativo profesional para el diseño riguroso de bases de datos relacionales. Guía a estudiantes de ingeniería a través de normalización (1NF–BCNF), modelado ER, escritura de DDL estándar y mejores prácticas de la industria, asegurando que cada entregable cumpla con estándares profesionales reales.
triggers:
  - disenar diagrama er
  - escribir esquema sql
  - normalizar base de datos
  - modelar entidad relacion
  - aprender diseño de bases de datos
version: 2.0.0
author: Sistema Creador de Skills Antigravity
---

# designing-academic-databases

> Módulo profesional de formación en Ingeniería de Bases de Datos. Transforma ejercicios académicos en entregables con calidad de producción, enseñando a estudiantes a pensar, diseñar y documentar como un Ingeniero de Datos profesional desde el primer día.

---

## 1. Topología del Ecosistema

- Controlado por: [[orchestrating-workspace-brain/SKILL|orchestrating-workspace-brain]]
- Puente de infraestructura con: [[engineering-web-microservices/SKILL|engineering-web-microservices]] (cuando un esquema necesita desplegarse en Supabase u otro backend real)

> **Nota de Aislamiento:** Este módulo opera en un entorno seguro y educativo. Los esquemas se diseñan con rigor profesional, pero no se despliegan automáticamente en producción para proteger al estudiante de errores irreversibles.

---

## 2. Principios de Arquitectura

- **Rigor Profesional Desde el Aula:** Cada esquema debe cumplir las formas normales exigidas (1NF, 2NF, 3NF, BCNF) bajo los mismos estándares que un DBA senior aplicaría en producción.
- **Documentación Obligatoria:** Ningún esquema se entrega sin su Diagrama Entidad-Relación (ER) en Mermaid.js y un Diccionario de Datos completo. Esto entrena al estudiante en la documentación profesional real.
- **SQL Agnóstico Primero:** Toda sentencia se redacta en ANSI SQL estándar antes de incluir extensiones específicas de PostgreSQL, MySQL u Oracle. Esto garantiza portabilidad y comprensión profunda del lenguaje.
- **Zona Segura de Aprendizaje:** Los scripts generados incluyen comentarios explicativos línea por línea. Los errores se documentan como oportunidades de aprendizaje, no como fracasos.

---

## 3. Flujo de Trabajo — Planear → Validar → Ejecutar

### 3.1 Fase de PLANIFICACIÓN (PLAN)
1. **Análisis de Requerimientos:** Extraer del enunciado (académico o profesional) las entidades, atributos, restricciones y reglas de negocio. Documentar supuestos si el enunciado es ambiguo.
2. **Diseño Conceptual:** Identificar entidades, atributos (simples, compuestos, multivaluados), designar Claves Primarias (PK), Claves Foráneas (FK) y Claves Candidatas.
3. **Ruta de Normalización:** Mapear paso a paso desde la Forma sin Normalizar (UNF) hasta la forma objetivo (mínimo 3NF), documentando cada transformación con justificación técnica.

### 3.2 Fase de VALIDACIÓN (VALIDATE)
- **Auditoría de Anomalías:** Detectar y documentar anomalías de inserción, actualización y borrado antes de que el esquema avance.
- **Inspección de Cardinalidades:** Verificar explícitamente cada relación (1:1, 1:N, M:N) y descomponer las M:N en tablas intermedias con atributos propios si aplica.
- **Integridad Referencial:** Garantizar que todos los constraints (FOREIGN KEY, UNIQUE, CHECK, NOT NULL) mantengan coherencia lógica y física.
- **Revisión de Seguridad Estudiantil:** Confirmar que los scripts no contengan operaciones destructivas sin protección (DROP sin confirmación, DELETE sin WHERE).

### 3.3 Fase de EJECUCIÓN (EXECUTE)
- Generar el Diagrama ER profesional usando sintaxis `Mermaid.js` con nomenclatura estandarizada.
- Entregar scripts DDL (CREATE TABLE, ALTER TABLE, CREATE INDEX) en ANSI SQL con variantes comentadas para PostgreSQL y MySQL.
- Incluir un **Diccionario de Datos** con descripción de cada tabla, columna, tipo de dato, restricciones y propósito de negocio.
- Agregar una **sección de defensa técnica** que justifique cada decisión de diseño — esto entrena la habilidad de argumentación profesional del estudiante.

---

## 4. Guía de Seguridad para Estudiantes

> Esta sección establece las reglas de protección para que ningún estudiante pueda ejecutar accidentalmente operaciones dañinas.

| Regla | Descripción |
|-------|-------------|
| 🔒 **Sin DROP automático** | Nunca generar `DROP TABLE` o `DROP DATABASE` sin confirmación explícita del estudiante |
| 🛡️ **Scripts comentados** | Cada línea de SQL incluye un comentario que explica qué hace y por qué |
| 📋 **Checklist pre-ejecución** | Antes de ejecutar cualquier script, verificar: ¿Estoy en la base correcta? ¿Tengo backup? ¿Entiendo cada línea? |
| ⚠️ **Modo sandbox** | Se recomienda trabajar en bases de prueba locales o servicios gratuitos (db-fiddle.com, SQLite) antes de tocar servidores reales |
| 📖 **Explicación pedagógica** | Cada entregable incluye una sección "¿Por qué se hizo así?" para reforzar el aprendizaje |

---

## 5. Plantilla de Entregable Estudiantil

Cada proyecto dentro de este módulo debe seguir esta estructura para garantizar calidad profesional:

```markdown
# 📊 [Nombre del Proyecto de Base de Datos]

## 1. Análisis de Requerimientos
- Enunciado original (citado textual)
- Entidades identificadas
- Reglas de negocio extraídas
- Supuestos documentados

## 2. Diseño Conceptual (Diagrama ER)
- Diagrama Mermaid.js
- Notación de cardinalidades

## 3. Ruta de Normalización
- Estado UNF → 1NF → 2NF → 3NF (con explicación de cada paso)

## 4. Diseño Físico (Scripts DDL)
- Script ANSI SQL
- Variante PostgreSQL / MySQL (si aplica)

## 5. Diccionario de Datos
| Tabla | Columna | Tipo | Restricción | Descripción |
|-------|---------|------|-------------|-------------|

## 6. Defensa Técnica
- Justificación de decisiones de diseño
- Trade-offs considerados
```

---

## 6. Contratos y Referencias

Para mantener el rigor profesional-educativo, este módulo consulta y obedece los siguientes estándares:
- 📚 **Estándares de Normalización:** [[estandares-db-academicos]]
- 🛡️ **Guía de Seguridad Estudiantil:** [[guia-seguridad-estudiantil]]
- 📖 **Patrones de Diseño Relacional:** [[patrones-diseno-relacional]]
