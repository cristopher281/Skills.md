# CTO de IA Orquestador — Guía Avanzada

Documentación extendida para personalización de flujos de trabajo (workflows), encadenamiento y patrones de orquestación avanzada.

## Encadenamiento de Workflows

Cuando una solicitud abarca múltiples flujos de trabajo, encadénalos usando este orden de prioridad:

```
Investigación → Startup → Software → Automatización
```

**Justificación:** La investigación informa a la estrategia, la estrategia informa a la arquitectura, la arquitectura informa a la implementación, la implementación informa a la automatización.

### Ejemplo de Encadenamiento

El usuario dice: *"Constrúyeme un SaaS para gestión de restaurantes"*

```
Cadena: [startup] → [software] → [automation]

1. Workflow de STARTUP:
   ├── Generar resumen de idea (enfoque SaaS para restaurantes)
   ├── Análisis de mercado (competidores: Toast, Square, etc.)
   ├── Branding/Marca (nombre, identidad visual)
   └── Arquitectura MVP (características, decisiones de tecnología)

2. Workflow de SOFTWARE (recibe contexto de la startup):
   ├── Requisitos desde la arquitectura del MVP
   ├── Esquema de base de datos para dominio de restaurantes
   ├── API Backend (pedidos, menú, reservas)
   ├── Frontend (panel de control, interfaz punto de venta)
   └── Configuración de despliegue en Docker

3. Workflow de AUTOMATIZACIÓN (recibe contexto del software):
   ├── Pipeline de CI/CD para la app
   ├── Monitoreo y alertas
   └── Automatización de respaldos (backups)
```

## Creación de Workflows Personalizados

Los usuarios pueden definir workflows personalizados especificando las tareas manualmente:

```markdown
## Workflow Personalizado: [Nombre]

Tareas:
1. [Descripción de la tarea] → mapeado a: [habilidad o FALLBACK]
2. [Descripción de la tarea] → mapeado a: [habilidad o FALLBACK]
3. [Descripción de la tarea] → depende de: [1, 2]
```

El orquestador deberá:
1. Analizar sistemáticamente la lista de tareas en detalle
2. Autodetectar posibles dependencias ocultas por medio de pistas en el contexto
3. Emparejar o asignar y enrutar inteligentemente cada tarea individualmente al sub-módulo de skill correspondiente
4. Por ende correr la fase ejecutiva (EXECUTE) cumpliendo sin dudas un orden correlativo

## Estrategia de Ejecución en Paralelo

Las tareas pueden correr en paralelo siempre y cuando carezcan y exhiban una nula línea de codependencia directa mutua:

```
Secuencial:  T1 → T2 → T3 → T4 → T5  (LENTO)
Paralelo:    T1 → [T2, T3] → T4 → T5  (RÁPIDO Y EFICAZ)
```

### Identificando Tareas Paralelizables

| Workflow | Grupos Paralelizables |
|----------|----------------------|
| Startup | [Análisis de Mercado, Branding] pueden correr en paralelo |
| Software | [API Backend, Frontend] corren en paralelo tras el esquema SQL |
| Research | [Extracción de Fuentes] se cruza o intercala con [Resumen o Research profundo] |
| Automation | [Diseño del Workflow, Investigación de Integración] convergen |

## Protocolo de Pase de Contexto (Pase de Testigo)

Toda Tarea y su nodo adquieren un "context object". Este paquete o información se va acoplando a futuras tareas subsecuentes que lo necesiten mediante el flujo.

```
TaskContext = {
  project_name: string,
  workflow_type: string,
  previous_outputs: {
    [task_id]: {
      status: "done" | "failed" | "skipped",
      output: any,
      artifacts: string[],  // rutas de los archivos generados
      metadata: object
    }
  },
  user_preferences: object,
  constraints: string[]
}
```

### Reglas de Enriquecimiento de Contexto

- Toda actividad o "Tarea" terminada SIEMPRE SUMA al Contexto base, por ende, nunca erradica bases ya pautadas
- Si hay errores rotundos, el output deberá entregar toda la sintaxis de rastreo (Trace logging error)
- De ser ignorado o "omitido/Skipped", se debe añadir justificativos obligatorios para argumentar el hecho
- En caso de contradecir, los requerimientos prioritarios o preferencias del USUARIO son de orden mayor general

## Algoritmo para el Enrutamiento y Reconocimiento y Asignaciones

Si se trata de asignar y orientar o repartir acciones, el Sistema Cerebro del Orquestador procederá de izquierda a derecha (y en peso) a través de estas normativas:

1. **Coincidencia Exacta de Triggers o Eventos** — Las descripciones internas del Skill hacen match perfecto en semántica u órdenes directas
2. **Coincidencia Semántica** — Significado anclado o parecidas conceptuales que derivan de una tarea explícita
3. **Coincidencia de Categoría (Match Grupal)** — Por descarte engloba de manera de "familias" al skill de modo más general ("ej: Todo SQL se envia a diseño academico")
4. **FALLBACK** — Ninguna encuentra resonancia o match. Entra en el escenario en que el asistente o Inteligencia resolverá de modo independiente sin lineamientos subyacentes.

## Formatos de Salida (Output Formats)

El Orquestador es plenamente capaz en todos sus dominios de estructurar de los siguientes modos formales:

| Formato | ¿Cuando se emplea? | Forma o Estructura |
|--------|------------|-----------|
| **Reporte en Formato MARKDOWN** | Por defecto | Múltiples hojas `.md` en modo texto generalizado |
| **Directorio Estructurado Global (Folders/Tree) de Proyecto** | Modo preferido de Workflows de Software | Se abren archivos, se escriben documentos listos para su respectiva prueba/arranque. Se implementan los entornos de sub-carpetas. |
| **Recolección en Artefactos** | Típico de informes y de Workflows de Investigación | Variados apuntes recabados englobados para revisar más adelante de manera no intrusiva. |
| **Plan Interactivo Base** | Modalidad exclusiva para "Solo Plantear" o Planning | Creación de listados por checkbox para que el gestor / desarrollador vaya de modo autómata comprobando (Todo lists). |
