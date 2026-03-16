# 🧱 Arquitectura Backend a Alta Escala

Este documento constituye la piedra angular para todo microservicio, pasarela API, o nodo backend empresarial gestionado en este ecosistema.

## 1. Diseño de API y Microservicios

- **Gateway / API First:** Todo microservicio debe tener un contrato claro definido (Ej. especificación OpenAPI). Las aplicaciones cliente no se comunican directamente a micro-bases, pasan por un enrutador inteligente.
- **Paginación y Limitación Obligatoria:** Ningún Endpoint debe retornar "Todos" los registros `SELECT *`. Todos los endpoints de listas exigen la técnica de *Cursor-based pagination* o paginaciones indexadas, para prevenir colapsos de memoria RAM.
- **Timeouts Agresivos:** Configurar los de red (ej. en Edge Functions) para abandonar los procesos si superan el límite (Por defecto, `5s` max. para transaccionales, `1s` en sub-microservicios internos). Evitar conexiones "zombie".

## 2. Bases de Datos, Pooling y Supabase Integrations

Para garantizar la estabilidad transaccional usando PostgreSQL (Supabase):
- **Connection Pooling Obligatorio:** Los microservicios sin estado (como Serverless/Edge) reinician sus conexiones constantemente. Se exige el uso del ruteo a través de Supavisor u otro agrupador de conexiones (Pooler) (puerto 6543) para canalizar y estabilizar el límite máximo del hardware.
- **Seguridad en Profundidad (RLS):** Policies a nivel de fila (`Row Level Security`) no son una opción; son ley. Validar `auth.uid()` o delegar la validación de tokens JWT internamente antes de que un querie atraviese a la tabla maestra. Nunca usar el `Service_Role Key` en peticiones originadas desde dominios públicos.

## 3. Estrategias de Cache

- El acceso al disco de la base de datos es caro (lento). Se exige implementar capas transitorias. Todo registro o tabla estática (ej. *Lista de Categorías de la Tienda*) debe ser almacenado en caché (ej. Redis / In-Memory Edge Cache) con un ciclo de tiempo de vida sensato (TTL, *Time-to-Live*).
- **Invalidador Inducido (Cache Invalidation Event):** El backend no espera a que el tiempo expire para contenido crítico; si hay una transacción de escritura maestra `UPDATE / INSERT`, un Webhook o Trigger debe invalidar y asfixiar la caché estática inmediatamente (Stale-while-revalidate).

## 4. Trazabilidad y Seguridad (Logs Reales)

- **Sanitización de Consultas:** Todo *payload* o JSON entrante es considerado malicioso o "contaminado" hasta que pasa por validadores estrictos (ej. Zod/Joi schema). Las Inyecciones SQL o envenenamientos masivos de JSON deben ser rebotados con error estructurado estandar.
- **Correlation IDs:** En microservicios encadenados, todas las cabeceras HTTP generadas por este módulo deben heredar e insertar un identificador único global `X-Correlation-ID` para permitir rastrear peticiones a lo largo de toda una cadena de componentes defectuosos.
