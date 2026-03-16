# 🛡️ Guía de Seguridad Estudiantil

Reglas de protección para que ningún estudiante ejecute operaciones destructivas accidentalmente.

---

## Reglas Inquebrantables

### 1. Nunca ejecutar sin entender
Antes de correr cualquier script SQL, el estudiante debe poder explicar **cada línea** del código. Si no puede, no debe ejecutarlo.

### 2. Siempre trabajar en Sandbox
| Entorno | Herramienta Recomendada | Costo |
|---------|------------------------|-------|
| Navegador | [DB Fiddle](https://www.db-fiddle.com) | Gratis |
| Local ligero | SQLite + DB Browser | Gratis |
| Local completo | PostgreSQL con pgAdmin | Gratis |
| Docker | `docker run -e POSTGRES_PASSWORD=test -p 5432:5432 postgres` | Gratis |

### 3. Lista de verificación pre-ejecución
```
□ ¿Estoy en la base de datos correcta? (SELECT current_database())
□ ¿Tengo un backup o puedo recrear los datos?
□ ¿Entiendo cada línea del script?
□ ¿Probé primero con SELECT antes de DELETE/UPDATE?
□ ¿Mis DELETE/UPDATE tienen cláusula WHERE?
```

### 4. Operaciones Prohibidas sin Supervisión
| Operación | Riesgo | Alternativa Segura |
|-----------|--------|-------------------|
| `DROP DATABASE` | Pérdida total de datos | Renombrar primero, eliminar después de verificar |
| `DELETE FROM tabla` (sin WHERE) | Borra todas las filas | Siempre agregar `WHERE` + verificar con `SELECT` primero |
| `TRUNCATE TABLE` | Elimina datos sin log | Usar `DELETE` con condición y respaldo previo |
| `ALTER TABLE DROP COLUMN` | Pérdida de columna | Verificar dependencias antes, backup obligatorio |

### 5. Patrón Seguro para Modificaciones
```sql
-- PASO 1: Ver qué voy a afectar (SIEMPRE primero)
SELECT * FROM ESTUDIANTE WHERE fecha_ingreso < '2020-01-01';

-- PASO 2: Contar cuántas filas serán afectadas
SELECT COUNT(*) FROM ESTUDIANTE WHERE fecha_ingreso < '2020-01-01';

-- PASO 3: Solo si estoy seguro, ejecutar la modificación
-- DELETE FROM ESTUDIANTE WHERE fecha_ingreso < '2020-01-01';
-- (Nota: descomenta la línea anterior solo cuando estés 100% seguro)
```
