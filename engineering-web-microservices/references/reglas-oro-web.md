# Guía de Referencia Rápida: Diseño Premium Web

Esta carpeta guarda los estándares de oro para que cada proyecto web tenga calidad profesional y no sea un proyecto improvisado.

## Reglas de Supabase (Base de Datos & Auth)
- **Nunca exponer el Service Role Key** en el cliente (Frontend). Esa llave solo se usa en las *Edge Functions* o Microservicios Backend.
- Establecer **Row Level Security (RLS)** por defecto en `true` para cada nueva tabla.

## Reglas de Frontend y UI
- No usar colores genéricos (rojo puro, azul puro). Usar paletas basadas en la función de color moderna `oklch()`.
- Centralizar todo el manejo del estado global (Signals/Zustand) y nunca propagar las propiedades "Props" por más de 3 niveles de profundidad (Evitar el Prop-Drilling).
