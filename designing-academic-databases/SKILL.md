---
name: designing-academic-databases
description: Diseña esquemas SQL o NoSQL, Diagramas de Entidad-Relación (ER) y maneja tareas o "assignments" de nivel de ingeniería para la Universidad.
triggers:
  - disenar diagrama er
  - escribir esquema sql
  - completar tarea base de datos
  - normalizar base de datos
version: 1.0.0
author: Sistema Creador de Skills Antigravity
---

# designing-academic-databases

> Un módulo dedicado de manera puramente académica para responder y cumplir de modo estricto todos los ejercicios/trabajos y materias del 2do año de Ingeniería en Computación o Sistemas orientados al mundo de Bases de Datos.

---

## 1. Topología del Ecosistema

- Controlado por: [[orchestrating-workspace-brain/SKILL|orchestrating-workspace-brain]]
- Entorno Aislado: Por regla general funciona de manera independiente, pero puede hacer envíos puntuales al entorno de [[engineering-web-microservices/SKILL|engineering-web-microservices]] si necesita un puente de infraestructura.

---

## 2. Principios de Arquitectura

- **Rigor Académico:** Se debe cumplir de manera extrema todas las normas estrictas formales dictaminadas por la universidad en materias (como llegar a Tercera Forma Normal o 3NF, o la BC: Forma normal de Boyce-Codd).
- **La Documentación Primero:** Por cada nuevo esquema generado debe ir adjunto y escrito en diagrama Entidad-Relación (ER) representacional además de un diccionario de datos explicativo.
- **Sin Dependencia de Vendedor de Base de Datos (Agnostic):** Usar ANSI SQL estándar para cualquier sentencia antes de añadir detalles específicos a PostgreSQL, MySQL u Oracle.

---

## 3. Flujo de Trabajo — Planear → Validar → Ejecutar

### 3.1 Fase de PLANIFICACIÓN (PLAN)
1. **Análisis de la Tarea/Asignación Universitaria:** Analizar cuáles son las restricciones que piden, cuántas y cuáles entidades (entities) requieren, así como las "business rules" expresas en el enunciado otorgado por el docente.
2. **Diseño Conceptual:** Delimitación de identidades, listado de atributos, designación de Clave Primaria (PK) y Claves Foráneas (FK).
3. **Ruta de Normalización:** Definir o mapear con lujo de detalles desde la Forma sin normalizar o UNF (Unnormalized Form) hasta concluir con la de grado 3 o Tercera forma normal (3NF).

### 3.2 Fase de VALIDACIÓN (VALIDATE)
- Auditar y encontrar todo riesgo o fallas existentes (Fallos de inserción, baches y fallos de borrado u olvidos de "update" y actualización).
- Verificar e inspeccionar explícitamente y minuciosamente qué relación (1:1, 1:N o una compleja y ambigua "Muchos a Muchos" M:N) tienen con la finalidad explícita de descomponer y arreglarlas de modo limpio y natural.
- Garantizar e instar que todos los "restraints" de integridad referencial mantengan congruencia y validez.

### 3.3 Fase de EJECUCIÓN (EXECUTE)
- Entrega el respectivo código gráfico usando en la redacción la sintaxis de "Mermaid.js" y "Diagrama/Flow ER".
- Realizar las sentencias definitivas y entregarlas en Scripts oficiales de DDL (Data Definition Language) de MySQL, ANSI, PostgreSQL (Ej. sentencias CREATE TABLE e inclusive si hay modificaciones tipo ALTER TABLE).
- Aportar una férrea, metódica y brillante defensa para justificar las implementaciones para la nota universitaria.

---

## 4. Contratos y Referencias

Para mantener el rigor, este módulo consulta y obedece los siguientes estándares:
- 📚 **Estándares Académicos DB:** [[estandares-db-academicos]]
