# Módulo 2 — Proyecto Integrador SQL

## FarmaDistrib S.A. — Diseño de Base de Datos por Esquemas

**Curso:** Data Analytics — CoderHouse  
**Estudiante:** Sebastián Paris  
**Fecha:** Junio 2026  

---

## Descripción del Proyecto

Este proyecto integrador diseña una base de datos relacional para **FarmaDistrib S.A.**, una empresa ficticia de distribución farmacéutica. La base de datos está organizada por esquemas que representan las tres áreas de negocio principales de la empresa: ventas, logística y analytics.

---

## Estructura de la Base de Datos

### Esquema `ventas`
Gestiona la relación comercial con clientes y el registro de pedidos.

| Tabla | Descripción |
|---|---|
| `ventas.clientes` | Farmacias y distribuidores registrados como clientes |
| `ventas.pedidos` | Pedidos realizados por los clientes |

### Esquema `logistica`
Controla los depósitos de almacenamiento y los envíos generados.

| Tabla | Descripción |
|---|---|
| `logistica.depositos` | Almacenes desde donde se despachan los productos |
| `logistica.envios` | Despachos y entregas generados a partir de pedidos |

### Esquema `analytics`
Centraliza los reportes generados por el área de inteligencia de negocio.

| Tabla | Descripción |
|---|---|
| `analytics.reportes` | Reportes e informes del área de datos |

---

## Decisiones de Diseño

### Tipos de datos
- **INT AUTO_INCREMENT** para todas las claves primarias, garantizando unicidad automática
- **VARCHAR** para textos de longitud variable como nombres, direcciones y estados
- **DECIMAL(10,2)** para valores monetarios y capacidades, evitando errores de redondeo
- **DATETIME** para registros que requieren fecha y hora exacta (pedidos, envíos, registros)
- **DATE** para fechas sin hora donde la precisión horaria no es relevante (fecha estimada de entrega, habilitación de depósito)
- **TEXT** para descripciones largas sin límite predefinido

### Integridad referencial
- `ventas.pedidos` referencia a `ventas.clientes` mediante FOREIGN KEY, garantizando que no existan pedidos de clientes inexistentes
- `logistica.envios` referencia a `logistica.depositos` mediante FOREIGN KEY, garantizando que todo envío salga de un depósito registrado

### Usuarios y permisos
Cada área de negocio tiene un usuario con permisos específicos según su rol:

| Usuario | Esquemas con acceso | Permisos |
|---|---|---|
| `usuario_ventas` | `ventas` | SELECT, INSERT, UPDATE |
| `usuario_logistica` | `logistica` | SELECT, INSERT, UPDATE |
| `usuario_analytics` | `ventas`, `logistica`, `analytics` | SELECT |

El usuario de analytics tiene acceso de solo lectura a los tres esquemas porque necesita consultar datos de todas las áreas para generar reportes, pero no debe modificar ningún dato.

---

## Archivos del Proyecto

- `farmadistrib.sql` — Script SQL completo con la creación de esquemas, tablas, usuarios y permisos
