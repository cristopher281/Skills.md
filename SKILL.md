---
name: orchestrating-projects
description: Habilidad maestra de orquestación que actúa como un CTO de IA y gerente de proyectos. Analiza solicitudes complejas, las descompone en tareas, y coordina la ejecución de las habilidades disponibles. Usar cuando el usuario mencione "construir una startup", "crear un proyecto completo", "orquestar desarrollo", "planear una arquitectura", o "coordinar múltiples tareas".
---

# CTO de IA Orquestador

Analiza solicitudes complejas del usuario, las descompone en tareas ejecutables, identifica y coordina habilidades disponibles, y entrega resultados de proyectos estructurados.

## Cuándo usar esta habilidad

- El usuario solicita la creación de un proyecto completo (startup, app, plataforma, SaaS)
- El usuario necesita planificación técnica en múltiples pasos o diseño de arquitectura
- El usuario quiere coordinar múltiples tareas de desarrollo en secuencia
- El usuario menciona "orquestar", "full stack", "end to end", o "planear todo"
- El usuario necesita investigación + implementación combinadas en un solo entregable

## Prerrequisitos

- Acceso al entorno del agente Antigravity
- Directorio de habilidades en `/mnt/skills/user/` (o equivalente local)
- Las sub-habilidades disponibles se autodetectan en tiempo de ejecución

## Flujo de Trabajo (Workflow)

### Paso 1: Analizar la Solicitud

Analizar el objetivo del usuario y clasificarlo en uno de los tipos de flujos de trabajo soportados:

| ID del Workflow | Palabras Clave | Descripción |
|-------------|-----------------|-------------|
| `startup` | "startup", "lanzar", "idea de negocio", "MVP" | Pipeline de creación completa de startup |
| `software` | "crear app", "desarrollar", "full stack", "proyecto" | Ciclo de vida de desarrollo de software |
| `research` | "investigar", "analizar", "reportar" | Investigación profunda y reportes |
| `automation` | "automatizar", "workflow", "n8n", "pipeline" | Diseño de automatización de procesos |
| `custom` | (respaldo) | El agente razona un plan personalizado |

**Lógica de Decisión:**
- Si la solicitud coincide con UN workflow → ejecutar ese workflow
- Si la solicitud abarca MÚLTIPLES workflows → encadenarlos en orden lógico
- Si la solicitud NO coincide con NINGUNO → usar el workflow `custom` razonándolo

### Paso 2: Descubrir Habilidades Disponibles

Escanear el directorio de habilidades para encontrar sub-habilidades disponibles:

```
1. Listar todos los directorios en /mnt/skills/user/
2. Leer el frontmatter del SKILL.md de cada uno
3. Construir un mapa de capacidades: { nombre_habilidad → descripcion, triggers }
4. Emparejar capacidades con las tareas requeridas
```

Si una capacidad requerida no tiene una habilidad que coincida → marcar como `FALLBACK: agent-generated` (Generado por el agente).

### Paso 3: Descomponer en Grafo de Tareas

Dividir el objetivo en tareas ordenadas usando la plantilla de workflow apropiada.

```markdown
## Grafo de Tareas: [Nombre del Workflow]

| # | Tarea | Habilidad Asignada | Estado | Dependencias |
|---|------|---------------|--------|--------------|
| 1 | [Nombre tarea] | [nombre-habilidad] o FALLBACK | ⬜ Pendiente | Ninguna |
| 2 | [Nombre tarea] | [nombre-habilidad] o FALLBACK | ⬜ Pendiente | Tarea 1 |
| 3 | [Nombre tarea] | [nombre-habilidad] o FALLBACK | ⬜ Pendiente | Tarea 1 |
| 4 | [Nombre tarea] | [nombre-habilidad] o FALLBACK | ⬜ Pendiente | Tarea 2, 3 |
```

**Reglas:**
- Las tareas sin dependencias pueden ejecutarse en paralelo
- Las tareas con dependencias deben esperar a sus predecesoras
- Las tareas FALLBACK son resueltas por el agente directamente usando razonamiento

### Paso 4: Ejecutar Secuencia de Tareas

Por cada tarea en orden de dependencia:

1. **Cargar** el `SKILL.md` de la habilidad asignada
2. **Ejecutar** el workflow de la habilidad con el contexto actual
3. **Capturar** la salida como una sección estructurada
4. **Actualizar** el estado de la tarea a ✅ Hecho
5. **Pasar contexto** hacia adelante a las tareas dependientes

Para tareas FALLBACK (Respaldo):
1. **Razonar** sobre los requisitos de la tarea
2. **Generar** el mejor resultado posible usando el conocimiento disponible
3. **Documentar** suposiciones y limitaciones

### Paso 5: Ensamblar Entregable Final

Combinar todas las salidas de las tareas en un resultado estructurado con estas secciones:

```markdown
# 🎯 Proyecto: [Nombre del Proyecto]

## 1. Resumen del Proyecto
- Objetivo: [Qué estamos construyendo]
- Workflow: [Qué workflow se usó]
- Habilidades Usadas: [Lista de habilidades invocadas]

## 2. Arquitectura Recomendada
- Diagrama o descripción del sistema
- Stack tecnológico con justificación
- Decisiones clave de diseño

## 3. Pasos de Implementación
- Plan de acción ordenado con prioridades
- Cada paso referencia la tarea que lo generó

## 4. Herramientas y Tecnologías
| Categoría | Herramienta | Razón |
|----------|------|--------|
| [categoría] | [herramienta] | [por qué se eligió] |

## 5. Entregables Generados
- [Lista de artefactos, archivos, o documentos producidos]

## 6. Próximas Acciones
- [ ] Siguientes pasos inmediatos
- [ ] Hitos a corto plazo
- [ ] Consideraciones a largo plazo
```

## Referencia de Workflows Soportados

### 🚀 Creación de Startup
| Paso | Tarea | Salida Predeterminada |
|------|------|---------------|
| 1 | Generar idea de startup | Resumen de idea con propuesta de valor |
| 2 | Análisis de mercado | Matriz de competidores, TAM/SAM/SOM |
| 3 | Branding (Marca) | Nombre, colores, concepto de logo, eslogan |
| 4 | Landing page | Landing page en HTML/CSS/JS |
| 5 | Arquitectura MVP | Diseño del sistema, stack tecnológico, roadmap |

### 💻 Desarrollo de Software
| Paso | Tarea | Salida Predeterminada |
|------|------|---------------|
| 1 | Análisis de requerimientos | Documento PRD (Requisitos) |
| 2 | Arquitectura del proyecto | Diagrama del sistema, mapa de componentes |
| 3 | Esquema de base de datos | Diagrama ER, migraciones SQL |
| 4 | API Backend | Rutas API, controladores, modelos |
| 5 | Estructura Frontend | Componentes, páginas, enrutamiento |
| 6 | Despliegue Docker | Dockerfile, docker-compose.yml |

### 🔬 Investigación
| Paso | Tarea | Salida Predeterminada |
|------|------|---------------|
| 1 | Investigación profunda | Hallazgos clave, puntos de datos |
| 2 | Extracción de fuentes | Referencias curadas, extractos |
| 3 | Resumen | Resumen ejecutivo |
| 4 | Reporte estructurado | Documento de reporte completo |

### ⚙️ Automatización
| Paso | Tarea | Salida Predeterminada |
|------|------|---------------|
| 1 | Análisis de proceso | Estado actual vs. deseado |
| 2 | Diseño de workflow | Diagrama de flujo, puntos de decisión |
| 3 | Plan de automatización | Implementación paso a paso |
| 4 | Integración | JSON de workflow de n8n o scripts |

## Validación

Después de que la orquestación termine, verificar:

- [ ] Todas las tareas en el grafo de tareas están marcadas como ✅ Hecho
- [ ] El entregable final contiene las 6 secciones requeridas
- [ ] Ninguna tarea fue omitida sin una justificación explícita
- [ ] Las tareas FALLBACK tienen las suposiciones documentadas
- [ ] Los artefactos de salida se guardaron en el directorio del proyecto

## Manejo de Errores

| Error | Causa | Resolución |
|-------|-------|------------|
| No hay habilidades en la carpeta | Carpeta skills vacía | Usar modo FALLBACK para todas las tareas; recomendar crear sub-habilidades |
| Dependencia circular en el grafo | Dependencias mal configuradas | Aplanar el grafo; ejecutar secuencialmente |
| Fallo al ejecutar habilidad | Sub-habilidad no cumple prerrequisitos | Registrar error, cambiar a FALLBACK, continuar el pipeline |
| Objetivo del usuario es ambiguo | Falta de detalle en la solicitud | Pausar y pedir al usuario aclaraciones antes de seguir |
| Tipo de workflow no está claro | La solicitud coincide con múltiples | Pedir al usuario confirmación, o encadenar workflows lógicamente |

## Recursos

- 📘 **Ecosistema Completo (README):** [[README]]
- 🔧 **Guía Avanzada:** [[ADVANCED]]
- 🚀 **Workflows:** [[startup]], [[software]], [[research]], [[automation]]
- 📊 **Ejemplos:** [[startup-orchestration]], [[software-orchestration]]
- 🧠 **Cerebro del Espacio de Trabajo:** [[orchestrating-workspace-brain/SKILL|orchestrating-workspace-brain]]
