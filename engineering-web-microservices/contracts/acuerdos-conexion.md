# Acuerdos de Interconexión (Contracts)

Para que todos los módulos se comuniquen "profesionalmente", deben hablar el mismo idioma. Aquí se definen los esquemas fijos de datos.

## Estándar de Respuesta API REST (`api-rest-estandar.json`)

Cualquier microservicio construido por este módulo DEBE responder a otros módulos (como a **n8n** o al **Frontend**) usando exactamente esta estructura JSON, asegurando una conexión a prueba de fallos.

```json
{
  "success": true,
  "timestamp": "2026-03-15T20:00:00Z",
  "data": {
    "ejemplo_id": "123",
    "mensaje": "Operación exitosa"
  },
  "error": null,
  "metadata": {
    "version": "1.0",
    "origen": "microservicio-usuarios"
  }
}
```

> **Regla de Conexión:** Si el módulo `[[automating-n8n-workflows]]` hace una petición HTTP a nuestro microservicio, esperará estrictamente el campo `success` y `data` para saber cómo continuar el flujo.
