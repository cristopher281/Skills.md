# Base de Conocimiento de Automatización Profesional

La diferencia entre una automatización de principiante y una profesional:

## Idempotencia
Tu workflow debe estar diseñado de forma que, si se ejecuta 2 o 5 veces por error (debido a un fallo de red o doble clic), **el resultado final y la Base de Datos sigan siendo exactamente los mismos**.
*Ejemplo: Antes de insertar un disco en Supabase, usa un nodo buscar (Find) para saber si su ID ya existe. Si existe, actualiza (Update). Si no, inserta (Create).*

## Manejo de Errores (Error Trigger)
Jamás dejes una ruta a medias. Añade el nodo especial **"Error Trigger"** en n8n. Si un nodo de API HTTP falla por límite de peticiones (429 Rate Limit), empuja un webhook a tu Telegram/Slack avisándote.
