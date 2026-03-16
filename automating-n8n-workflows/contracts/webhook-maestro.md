# Acuerdos de Entrada (Webhook Ingestion)

Para que n8n pueda procesar alertas de otros módulos sin fallar, declaramos este contrato maestro de Webhook.

## Estructura Esperada del Webhook
Cualquier evento del sistema que requiera una automatización (p.ej. Usuario se registró en la Web, el Sensor IoT detectó fuego), debe enviar este POST al Webhook maestro:

```json
{
  "evento_tipo": "NUEVO_USUARIO | ALERTA_IOT | REPORTE_DB",
  "prioridad": "ALTA | MEDIA | BAJA",
  "datos": { 
      "comodin": "Cualquier objeto JSON según el evento" 
  }
}
```

Al obligar a enviar `"evento_tipo"`, n8n solo necesita un (1) nodo **"Switch"** central para desviar el tráfico profesionalmente a los sub-flujos correspondientes.
