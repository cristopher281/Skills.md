# ⚙️ Arquitectura de Firmware Industrial (C/C++)

Para que los componentes IoT evolucionen de simples placas académicas (módulo esp32/arduino convencional) a terminales Edge industriales, se exigen técnicas quirúrgicas orientadas a extrema durabilidad, ultra bajo consumo e intolerancia a los pánicos kernel.

## 1. RTOS y Programación de Tareas Confiables

- Los microcontroladores de capacidades superiores (EJ. **ESP32**) corren nativos sobre **FreeRTOS**. Está terminantemente prohibido usar los bucles monolíticos convencionales de `void loop()` bloqueantes. 
- Toda estructura IoT debe segmentarse en *Tareas de RTOS (xTaskCreate)* con prioridades separadas (Ej. Tarea 1: Leer Sensor I2C alta prioridad. Tarea 2: Enviar a la red de baja prioridad).
- Asignación de pila (Stack Memory) de memoria por tarea explícita, y uso riguroso de Semaphore e iteradores inter-task Mutexes para compartir datos seriales/Wi-Fi y evitar violaciones de concurrencia.

## 2. Robustez Infinita (Perro Guardián/WDT)

En equipos desplegados masivamente a kilómetros de distancia sin un servidor humano:
- **Watchdog Timer Activo (WDT):** El temporizador del "Perro Guardián" es OBLIGATORIO. El procesador exigirá a la placa "acariciar al perro" (Resetear el Timer) constantemente a lo largo del código. Si el sistema colapsa o entra en un "Bucle Infinito", el temporizador acabará y automáticamente cortará la energía física re-lanzando el CPU del ESP32.

## 3. Estrategia de Telecomunicación Resiliente

- Todas las colas de mensaje en el protocolo **MQTT** usarán obligatoriamente **QoS 1** ("Al menos una vez") para mediciones críticas, garantizando recibo de ACK (Acuse de recibo) mediante intermediarios, evitando la fuga de paquetes en redes enclenques.
- Respaldos o *Fallbacks:* Si la conexión WiFi o la interconexión Mesh Falla, el dispositivo DEBE retener la telemetría en partición SPIFFS local / SD Card, y traslucirla y volcarla automáticamente (`bulk insert`) usando *TimeStamps* cuando se reconecte el enlace central.

## 4. Consumo Energético Quirúrgico

- Para IoT movido por baterías, los miliamperios son vitales. Se prohíbe las conexiones ociosas. 
- Patrón OBLIGATORIO: **Despertar → Leer Muestra → Encender Redes → Volcar Envío MQTT HTTP → Apagar Sistemas Base (Radio Frecuencias, WiFi Array) → Deep Sleep**. Una placa debe gastar 99% del tiempo bajo modo en suspensión profunda, gastando micro-amperios (uA).
