# Análisis del Mockup — SENA · Gestión de Horarios

> **Fuente analizada:** código fuente completo del mockup en `code-sena/design-software-mockup`  
> **Pantallas cubiertas:** 53 pantallas · 7 módulos MFE · 5 roles  
> **Criterio:** se diferencia entre lo _observado_, lo _inferido_ y las _recomendaciones_

---

## ¿Qué es este sistema?

Un sistema web de gestión de horarios para centros SENA. Es un **mockup navegable**: prototipo estático con datos ficticios y sin backend real. Declara una arquitectura de **micro-frontends** por dominio (el sistema se divide en partes independientes que se integran en un shell).

Contiene **53 pantallas y modales** distribuidos en **7 módulos**, con un hub de parametrización central.

### Entidades principales del sistema

| Entidad | Descripción |
|---------|-------------|
| **Instructores** | Personal que dicta clases |
| **Aprendices** | Estudiantes de la ficha |
| **Fichas** | Grupos de formación |
| **Programas** | Currículos académicos |
| **Ambientes** | Aulas, laboratorios, talleres |
| **Horarios** | Programación semanal de sesiones |
| **Jornadas** | Franjas horarias disponibles |
| **Asignaciones** | Relación instructor ↔ sesión ↔ ambiente |

### Roles del sistema

| Rol | Qué hace en el sistema |
|-----|------------------------|
| **Coordinador Académico** | Crea y publica horarios, resuelve conflictos |
| **Instructor** | Ve su horario y registra seguimiento de ficha |
| **Aprendiz** | Consulta su horario y notificaciones |
| **Director de Centro** | Ve indicadores (KPIs) y administra usuarios |
| **Administrador de Soporte** | Gestiona documentos, auditoría y parámetros |

---

## Lo que funciona bien ✅

Antes de los problemas, esto merece destacarse:

- **Sistema de estados centralizado** — un solo componente `status()` cubre 25 estados distintos de forma uniforme en toda la app.
- **Flujo de publicación con bloqueo por conflictos** — el botón "Publicar" se desactiva mientras haya conflictos sin resolver. Buen patrón de flujo de trabajo.
- **RBAC bien estructurado** — la matriz rol↔permiso, los scopes (`GLOBAL`, `TRAINING_CENTER`, `OWN_*`) y el `x-required-feature` por pantalla/endpoint son una base sólida.
- **Auditoría bien concebida** — registra actor, servicio origen, entidad y payload JSON de cambios. Diseño correcto para sistemas distribuidos.
- **Navegación responsiva del shell** — la barra lateral colapsa a drawer móvil con backdrop. Los botones de la topbar se ocultan/muestran correctamente según el viewport.
- **Estados vacío / error / cargando** — cubiertos de forma uniforme en todas las pantallas con un solo componente.
- **Tokens de diseño centralizados** — colores, tipografía y espaciado como variables CSS. Sin valores mágicos dispersos en el código.

---

## Hallazgos

Los hallazgos están agrupados: si el mismo problema aparece en varias pantallas, se documenta una sola vez.

---

### H1 · Problemas generales de UI: alineación, espaciado y consistencia visual

**Categoría:** UI · **Impacto:** 🟡 Medio

**Qué se observa**

Al recorrer las pantallas se identifican varios problemas visuales que se repiten en distintos módulos:

| # | Problema | Dónde se ve |
|---|----------|-------------|
| 1 | **Alineación y distribución** — elementos con posiciones y tamaños poco uniformes | Filtros, botones de acción, cabeceras de panel |
| 2 | **Espaciado y proporciones** — campos, botones y espacios con proporciones poco equilibradas | Formularios, modales, filtros |
| 3 | **Superposición y contenido cortado** — componentes o modales parcialmente visibles | Modal inferior del editor de horarios |
| 4 | **Inconsistencia de componentes** — botones, paginación y formularios con comportamientos visuales distintos entre pantallas | Paginación vs. "Cargar más", tamaños de botón |
| 5 | **Legibilidad** — textos comprimidos en espacios reducidos | Columnas de tabla en pantallas densas |
| 6 | **Jerarquía visual** — dificultad para identificar advertencias y acciones principales | Conflictos en el dashboard, alertas de validación |

**Por qué importa**

La inconsistencia visual aumenta la curva de aprendizaje del sistema y puede llevar a errores de operación cuando el usuario no distingue qué elemento es clicable, cuál es un estado de alerta y cuál es información de solo lectura.

**Recomendación**

Definir y aplicar un sistema de componentes estricto con guía de uso: qué tipo de botón va en cada contexto, cuándo usar un modal grande vs. uno compacto, y cómo se espacian los filtros. Muchos de estos problemas desaparecen si se usa el componente correcto en lugar de CSS inline.

---

### H2 · Calendario semanal y formularios inusables en móvil

**Categoría:** Responsive / UX · **Impacto:** 🔴 Alto

**Requisito relacionado**

> **RNF — Responsividad:** El sistema debe adaptar los formularios y sus componentes al tamaño de pantalla disponible, evitando desbordamientos horizontales y garantizando la visualización y utilización de todos los elementos en dispositivos móviles.

**Qué se observa**

El componente de horario semanal tiene un ancho mínimo de 880 px. En móvil, el CSS lo convierte en una lista de tarjetas sin encabezado de día ni franja horaria visible. El instructor o el aprendiz no puede saber cuándo es cada clase sin abrir el detalle de cada una.

Los formularios de varios modales (como "Editar parámetro — MAX_HOURS_PER_WEEK") muestran campos en dos columnas que en móvil quedan comprimidos o salen de pantalla. Algunos elementos del lado derecho quedan cortados.

**Cómo debería verse en móvil**

En lugar de dos columnas, los campos deben apilarse en una sola columna:

```
Instructor
┌──────────────────────────────┐
│ Juan Pérez                   │
└──────────────────────────────┘

Competencia
┌──────────────────────────────┐
│ Desarrollar software...      │
└──────────────────────────────┘

Fecha
┌──────────────────────────────┐
│ 2026-08-10                   │
└──────────────────────────────┘

Ambiente
┌──────────────────────────────┐
│ Laboratorio A-204            │
└──────────────────────────────┘
```

**Recomendación**

- En móvil, mostrar el horario como una **vista de agenda agrupada por día**, con el día y la franja como encabezado de cada grupo.
- Los formularios deben pasar a **una sola columna** en pantallas menores a 640 px.
- Los modales no deben ocupar más del 92 % de la altura de pantalla, con scroll interno si el contenido es extenso.

**Pantallas:** Mi horario — Instructor (19), Mi horario — Aprendiz (25), Modal agregar/editar sesión (11), Parametrización — Jornadas (48)

---

### H3 · Gráfica de distribución de riesgo sin valores ni umbral correcto

**Categoría:** Visualización · **Impacto:** 🔴 Alto

**Qué se observa**

En el panel del director hay tres barras de colores ("Seguimiento", "Riesgo", "Crítico") sin valores numéricos encima, sin eje Y y sin período de referencia. Las tarjetas KPI sobre la gráfica ya muestran los números (31, 12, 4), así que la gráfica repite información sin añadir contexto.

Adicionalmente, la línea de umbral punteada en la gráfica de evolución temporal está fija al 42 % por CSS, pero el umbral real del KPI de asistencia es el 80 % configurado en parametrización. Es visualmente engañosa.

**Por qué importa**

Una gráfica sin valores no permite tomar decisiones. Un umbral equivocado puede llevar a interpretaciones incorrectas del estado de las fichas.

**Recomendación**

Mostrar el valor numérico o el porcentaje sobre cada barra. Indicar el período. Vincular la línea de umbral al valor real del KPI, no a una posición CSS fija. Añadir eje Y con escala en la evolución temporal.

**Pantallas:** Panel de indicadores (29), Drill-down de KPI (30)

---

### H4 · Avance curricular ingresado manualmente sin cálculo automático

**Categoría:** Datos / Funcionalidad · **Impacto:** 🔴 Alto

**Qué se observa**

El instructor registra el porcentaje de avance curricular escribiéndolo a mano en un campo numérico. No hay ninguna relación con las competencias, resultados de aprendizaje ni sesiones ya registradas en el sistema.

El sistema ya tiene toda la información necesaria para calcularlo: el currículo con horas por competencia y las sesiones ejecutadas.

**Por qué importa**

Si el dato es subjetivo o estimado por el instructor, los KPI del director pierden confiabilidad. Dos instructores pueden reportar avances muy distintos para situaciones equivalentes.

**Cómo debería calcularse**

```
Actividades planificadas:   20
Actividades completadas:    13

Avance curricular:
13 / 20 × 100 = 65 %

                    65 %
█████████████░░░░░░░
```

O usando horas del currículo:

```
avance (%) = horas_sesiones_ejecutadas / horas_totales_del_programa × 100
```

El sistema ya almacena ambos datos: las horas por competencia en el módulo de currículo y las sesiones ejecutadas en el módulo de horarios.

**Recomendación**

Calcular automáticamente a partir de las sesiones marcadas como ejecutadas versus las horas planificadas por competencia. Mostrar el detalle del cálculo (actividades completadas / planificadas) junto al porcentaje. Dejar el campo manual solo como ajuste extraordinario con justificación obligatoria.

**Pantallas:** Registrar seguimiento (24), Seguimiento de ficha (23), Panel de indicadores (29)

---

### H5 · Sin aviso de tratamiento de datos personales

**Categoría:** Privacidad / Seguridad · **Impacto:** 🔴 Alto

**Qué se observa**

Las pantallas de login, recuperación y restablecimiento de contraseña solo dicen: _"Uso exclusivo de personal y comunidad académica autorizada."_ No hay enlace a política de privacidad, mención al responsable del tratamiento ni referencia a los derechos del titular.

El sistema maneja: nombre y documento de instructores, nombre y correo de aprendices, IPs de sesión y estados académicos.

**Marco normativo aplicable**

| Norma | Tema |
|-------|------|
| **Ley 1581 de 2012** | Protección de datos personales |
| **Decreto 1377 de 2013** | Reglamentación de protección de datos |
| **Decreto 1074 de 2015** | Reglamentación del tratamiento de datos |
| **Ley 1273 de 2009** | Delitos contra información y datos |
| **Constitución, Art. 15** | Intimidad y habeas data |

Estas normas exigen informar al titular sobre la finalidad del tratamiento, el responsable y sus derechos, antes o al momento de recolectar sus datos. Aplica a sistemas institucionales con datos de personas naturales.

**Recomendación**

Añadir en el login un enlace visible a la política de privacidad institucional. No requiere cambios de backend; es suficiente con el enlace al documento vigente de la entidad.

**Pantallas:** Login (1), Recuperar contraseña (2), Nueva contraseña (3)

---

### H6 · Tablas en móvil con acciones múltiples que se amontonan

**Categoría:** Responsive / UI · **Impacto:** 🟡 Medio

**Qué se observa**

En móvil las tablas cambian a modo "tarjeta apilada". Funciona bien para celdas simples, pero las celdas con múltiples botones de acción (Editar + Cancelar + Eliminar) se apilan en columna sin espaciado, formando un bloque comprimido y difícil de tocar.

**Recomendación**

En móvil, reemplazar las acciones múltiples de tabla por un menú desplegable (⋮) o mostrarlas dentro del detalle de la fila expandida.

**Pantallas:** Crear/editar horario (10), Parametrización — Jornadas (48), Ambientes (49), Estados de actores (51)

---

## Resumen de hallazgos

| # | Hallazgo | Categoría | Impacto |
|---|----------|-----------|---------|
| H1 | Problemas generales de UI: alineación, espaciado y consistencia | UI | 🟡 Medio |
| H2 | Calendario semanal y formularios inusables en móvil | Responsive / UX | 🔴 Alto |
| H3 | Gráfica de riesgo sin valores ni umbral correcto | Visualización | 🔴 Alto |
| H4 | Avance curricular manual sin cálculo automático | Datos / Funcionalidad | 🔴 Alto |
| H5 | Sin aviso de tratamiento de datos personales | Privacidad / Seguridad | 🔴 Alto |
| H6 | Acciones múltiples colisionadas en tablas móvil | Responsive / UI | 🟡 Medio |

---

## Recomendaciones en orden de prioridad

### Prioridad 1 — Impacto alto en los usuarios finales

1. **Adaptar el sistema a móvil (H2)** — el horario semanal y los formularios en dos columnas son los casos más urgentes.
2. **Unificar validaciones de formularios (H5)** — un campo con error no debe permitir guardar.
3. **Agregar aviso de privacidad (H6)** — costo técnico mínimo (un enlace), riesgo regulatorio alto si se omite.
4. **Calcular el avance curricular automáticamente (H4)** — el sistema ya tiene los datos; eliminarlo como campo manual mejora la confiabilidad de todos los KPI.

### Prioridad 2 — Mejoras de calidad

5. **Corregir la gráfica de riesgo (H3)** — añadir valores numéricos y vincular el umbral al parámetro real.
6. **Resolver los problemas generales de UI (H1)** — revisar alineación, espaciado y consistencia de componentes.
7. **Revisar tablas en móvil con acciones múltiples (H7)**
