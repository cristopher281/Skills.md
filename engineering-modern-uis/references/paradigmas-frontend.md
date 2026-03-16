# 🖥️ Paradigmas de Arquitectura Frontend 2026

Documento maestro de estándares para la ingeniería de interfaces web de altísimo rendimiento. Establece las reglas inquebrantables para todo entorno de producción visual.

## 1. Estrategias de Renderizado y Carga (Hydration)

Ninguna aplicación empresarial debe cargar JavaScript monolítico. Se exige la **Arquitectura de Islas (Islands Architecture)** o **Hidratación Parcial**:
- **Regla Cero JS:** El 80% de una interfaz (Headers, Footers, Contenido estático, Artículos) debe ser enviado desde el servidor (Server Components) con **0 bytes de JavaScript**.
- **Hidratación Diferida:** Los componentes interactivos (Carruseles, Formularios, Paneles reactivos) solo ejecutarán JavaScript (Hidratación) en los eventos `on:idle` (cuando el navegador está sin carga) o `on:visible` (cuando el usuario hace scroll hacia ellos).
- **Streaming Progresivo:** Al consultar datos pesados (ej. dashboards), enviar el esqueleto HTML inmediatamente y usar transbordos de `Suspense` o fragmentos en *streaming* para inyectar datos en vivo.

## 2. Dominio de Core Web Vitals (Métricas Vitales)

- **Largest Contentful Paint (LCP < 1.0s):** La imagen principal (Hero Image) o el bloque de texto vital debe no tener `lazy-loading`. Pre-cargar (`rel="preload"`) directamente en el `<head>` y utilizar formatos WebP o AVIF de próxima generación.
- **Cumulative Layout Shift (CLS = 0):** Bloqueo total de saltos visuales. Toda imagen MUST tener atributos explícitos `width` y `height`, o en su defecto un `aspect-ratio` definido en CSS. Toda fuente personalizada debe usar `font-display: swap` complementado con métricas de anulación (o *font fallbacks* locales adaptados).
- **Interaction to Next Paint (INP < 40ms):** Cualquier cálculo de datos o filtrado profundo de arrays que demore más de 12ms DEBE ser enviado a un `Web Worker` aislado para no bloquear el Hilo Principal (Main Thread) de UI.

## 3. Estado (State) y Signals

Prohibido el uso de propagación en cascada interminable y virtual-DOM difing masivo para gestionar variables (State). 
- El estado global debe manejarse usando primitivas reactivas puras (Signals/Zustand). 
- Los componentes deben suscribirse **solo** a los fragmentos de memoria que necesitan. Si un "Nombre de usuario" cambia en una esquina, **ningún otro componente paralelo** tiene permiso para re-renderizarse.

## 4. Estándares Visuales Rigurosos

- **Colores Matemáticos (OKLCH):** Evitar HSL, HEX o RGB. Toda paleta construida por la IA usará los espacios perceptuales cilíndricos `oklch()`, permitiendo transiciones de degradados que no sufran de la "franja muerta de grises".
- **Contenedores Modulares (Container Queries):** Los componentes (Ej. una tarjeta de producto) deben ser responsables de su propio tamaño respondiendo a `@container`, permitiendo que el mismo componente funcione en una barra lateral o ocupando toda la pantalla, todo en lugar del prehistórico uso de media queries de pantalla estáticos `@media`.
