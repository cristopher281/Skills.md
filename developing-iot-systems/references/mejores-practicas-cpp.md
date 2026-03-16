# Base de Conocimiento IoT: C++ Embebido

Para que los proyectos de hardware sean estables y no se reinicien solos (Kernel Panic):

## Manejo de Memoria (Critical)
Evita usar la clase genérica `String` de Arduino en entornos productivos. Usa cadenas de caracteres estándar C `char miCadena[50]` o `std::string`. Evitarás fragmentar la pequeña memoria RAM del ESP32.

## Máquinas de Estado
Todo proyecto IoT se diseña a través de Estados para mantenerse "No Bloqueante".
```cpp
// NUNCA USES: delay(5000); 
// USA ESTO:
unsigned long currentMillis = millis();
if (currentMillis - previousMillis >= interval) {
  previousMillis = currentMillis;
  // Ejecutar acción
}
```
