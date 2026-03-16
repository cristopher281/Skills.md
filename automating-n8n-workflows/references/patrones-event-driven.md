# 🔄 Patrones para Arquitecturas Orientadas a Eventos (EDA)

Documento avanzado. En los flujos automáticos y sistemas interconectados (vía webhooks en *n8n*, o pasarelas asíncronas), debes garantizar que una avalancha repentina de notificaciones no sature a los sistemas conectados. 

## 1. Contrapresión o "Backpressure" & Agrupamiento (Batching)

Si el Módulo de IoT de Telemetría o un Ecommerce colapsa enviando 3,000 eventos o JSONS Webhook simultáneos:
- **Prohibido el bombardeo directo de 1 a 1.** Acata la arquitectura *Rate Limiting* estricta de las plataformas API de destino.
- N8n debe comportarse forzando nodos del **Tipo Batch (Agrupamiento)**. Los flujos atraparan los 3000 eventos dentro de una memoria intermedia temporal e inyectarán al CRM o a la Base de datos Supabase paquetes en lotes seguros (Ej: arreglos estables "Array Maps" de entre 100 y 300 componentes con tiempos de pausa).

## 2. Colas de Letras Muertas (Dead-Letter Queues / DLQ)

En la automatización estricta, ningún dato se escabulle silenciosamente en un colapso "Error 500". 
- Todo esquema estandarizado exige un sub-enrutamiento a un **Nodo Atrapa-Errores (Error Trigger)** global dentro de n8n.
- Los archivos en formato JSON con falla y las señales que los originaron DEBEN serializarse obligadamente en un registro secundario permanente de disco (El almacén de DLQ), para luego ser manualmente re-inyectados por ti o por un Administrador Humano de Base de Datos.

## 3. Retraso Exponencial de Retroceso (Exponential Backoff)

Cuando los Módulos de n8n realizan llamadas *HTTP Requests* a una API paralela y ésta rebota un error temporal (`HTTP 429 Limit` o `HTTP 502 Bad Gateway`), un "Error en Cadena" NO cancelará la operación.
- El Nodo activará opciones de reintento sistemático dilatado forzoso. (Ej: Reintentar a los 5 segundos, LUEGO a los 15 segundos, LUEGO a los 60 segundos). Permitiendo a la red sanar la carga interna y asegurar la entrega final.

## 4. Orquestadores Híbridos (SAGA pattern simple)

Una coreografía o enrutador asíncrono tiene que garantizar que cuando ocurre una transacción con múltiples apéndices involucrados y el último falle, el sistema regrese.
- En un sistema (Por Ej: Crear Usuario, Dar Alta en CRM, Enviar Email), si el servidor `SendEmail` se bloquea... n8n no debe dar por exitosa las altas originadas del webhook.
- Para conservar los estándares, las señales deben contener instrucciones para invocar subflujos "Rollback" o llamadas `DELETE/INACTIVAR` a los sub-sistemas satélites mediante condicionales `Switch` duros, anulando el usuario roto en la Base.
