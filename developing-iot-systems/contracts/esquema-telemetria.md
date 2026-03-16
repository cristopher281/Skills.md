# Contrato de Telemetría IoT

Para conectar Hardware (ESP32/Arduino) con la Nube (Bases de datos web o automatizaciones n8n), este es el estándar profesional forzoso. 

Cualquier código C++ generado DEBE empaquetar la lectura de sensores bajo este esquema MQTT o HTTP.

```json
{
  "device_id": "ESP32-PROD-01",
  "fw_version": "v1.0.4",
  "bateria_pct": 85,
  "payload": {
    "temperatura_c": 24.5,
    "humedad_pct": 60,
    "estado_rele": true
  },
  "timestamp_unix": 1789456789
}
```

> **Regla de Conexión:** Cuando este JSON llega a la red, el módulo `[[automating-n8n-workflows]]` ya sabe exactamente que existe un `device_id` para enrutar la notificación, o enviarla directo al módulo `[[engineering-web-microservices]]` para guardarlo en Supabase.
