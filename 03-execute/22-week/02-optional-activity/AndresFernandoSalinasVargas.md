# Diseño de Template para el Mockup de Gestión de Horarios

## 1. Introducción

El presente documento plantea una propuesta de template orientada al mockup de Gestión de Horarios. La finalidad es establecer una estructura visual que pueda utilizarse de manera repetitiva en las diferentes funcionalidades del sistema, manteniendo claridad, orden y facilidad de navegación.

El template se plantea como una guía para organizar los elementos de las interfaces antes de aplicarlos a las pantallas específicas del sistema.

## 2. Propósito del Template

El template tiene como propósito definir una base común para las pantallas del sistema de Gestión de Horarios.

Con esta estructura se busca que el usuario pueda identificar rápidamente:

- Dónde se encuentra dentro del sistema.
- Qué información está consultando.
- Qué acciones puede realizar.
- Qué registros están disponibles.
- Qué opciones puede seleccionar.
- Cuándo una operación fue realizada correctamente o presentó algún inconveniente.

## 3. Arquitectura de la Interfaz

La estructura propuesta se divide en cinco zonas principales.

### Zona A. Identificación

Se encuentra en la parte superior de la interfaz y contiene los elementos relacionados con la identificación del sistema y del usuario.

Puede incluir:

- Nombre del sistema.
- Perfil del usuario.
- Notificaciones.
- Acciones generales.
- Opciones de cuenta.

### Zona B. Navegación

Se encuentra en el lateral de la interfaz y permite acceder a las diferentes funciones.

La navegación puede organizarse por categorías como:

- Inicio.
- Horarios.
- Instructores.
- Ambientes.
- Programas.
- Reportes.
- Configuración.

Las opciones mostradas pueden variar dependiendo del rol del usuario.

### Zona C. Contexto

Esta sección identifica el módulo actual y proporciona información breve sobre la función que se está ejecutando.

Debe contener:

- Título del módulo.
- Descripción.
- Ruta de navegación.
- Acción principal.

### Zona D. Trabajo

Es el espacio donde se desarrolla la actividad principal del usuario.

Dependiendo de la funcionalidad, puede contener:

- Tablas.
- Formularios.
- Calendarios.
- Filtros.
- Tarjetas.
- Listados.
- Información detallada.

### Zona E. Respuesta del Sistema

Esta zona representa los mensajes que recibe el usuario después de realizar una acción.

Se pueden utilizar:

- Mensajes de éxito.
- Mensajes de error.
- Advertencias.
- Confirmaciones.
- Indicadores de carga.
- Estados vacíos.

## 4. Sistema de Componentes

Para facilitar la aplicación del template se definen componentes reutilizables.

### 4.1 Encabezado

El encabezado identifica la sección activa y permite mantener una jerarquía clara entre el título, la descripción y las acciones.

### 4.2 Barra de acciones

Agrupa las acciones relacionadas con la pantalla.

Ejemplos:

- Nuevo horario.
- Filtrar.
- Buscar.
- Exportar.
- Actualizar.

### 4.3 Filtros

Los filtros permiten reducir la cantidad de información mostrada.

Para Gestión de Horarios pueden utilizarse criterios como:

- Fecha.
- Jornada.
- Instructor.
- Ambiente.
- Programa.
- Ficha.
- Estado.

### 4.4 Tabla

La tabla presenta los registros de manera organizada.

Una estructura posible es:

| Horario | Instructor | Ambiente | Programa | Jornada | Estado | Acciones |
|---|---|---|---|---|---|---|
| Registro | Registro | Registro | Registro | Registro | Activo | Ver / Editar |

### 4.5 Formulario

Los formularios se organizan agrupando campos relacionados.

Ejemplo:

**Información del horario**

- Fecha.
- Hora inicial.
- Hora final.
- Jornada.

**Asignación**

- Instructor.
- Ambiente.
- Programa.
- Ficha.

**Acciones**

- Guardar.
- Cancelar.

### 4.6 Tarjetas informativas

Las tarjetas pueden utilizarse para mostrar información resumida antes de presentar los registros completos.

Ejemplos:

- Horarios programados.
- Horarios activos.
- Ambientes disponibles.
- Instructores asignados.

### 4.7 Ventanas de confirmación

Las ventanas de confirmación se utilizan cuando una acción puede afectar información existente.

Por ejemplo:

> ¿Desea eliminar este horario?

Las opciones serían:

- Confirmar.
- Cancelar.

## 5. Aplicación al Módulo de Gestión de Horarios

Una vez definido el template, se aplica a las pantallas correspondientes a Gestión de Horarios.

La pantalla comienza con la identificación del módulo y continúa con las herramientas necesarias para consultar o administrar los registros.

### 5.1 Consulta

La pantalla de consulta presenta los horarios existentes.

El usuario puede utilizar filtros para encontrar rápidamente un registro específico.

La información puede visualizarse mediante una tabla organizada por fecha, instructor, ambiente, programa y jornada.

### 5.2 Creación

Para crear un nuevo horario se utiliza el formulario definido en el template.

El formulario separa los datos generales de la asignación y presenta las acciones al final.

### 5.3 Edición

La edición conserva la misma estructura del formulario de creación, pero carga previamente los datos del horario seleccionado.

Esto permite que el usuario reconozca fácilmente la interfaz y reduzca el tiempo necesario para aprender una pantalla diferente.

### 5.4 Visualización

La opción de visualizar permite consultar la información completa de un horario sin modificarla.

La información puede organizarse mediante bloques:

**Datos generales**

Fecha, hora y jornada.

**Asignación**

Instructor, ambiente, programa y ficha.

**Estado**

Situación actual del horario.

### 5.5 Eliminación

Antes de eliminar un registro, el sistema debe mostrar una confirmación.

Esto ayuda a prevenir eliminaciones accidentales y permite que el usuario confirme la operación.

## 6. Reglas de Organización Visual

Para mantener el template consistente se establecen las siguientes reglas:

1. Los títulos deben identificar claramente la función actual.
2. Las acciones principales deben ser fáciles de encontrar.
3. Los campos relacionados deben permanecer agrupados.
4. Los formularios deben conservar la misma distribución.
5. Las tablas deben mantener encabezados claros.
6. Los mensajes del sistema deben diferenciarse según su propósito.
7. Las acciones destructivas deben solicitar confirmación.
8. La navegación debe conservar la misma posición en las diferentes pantallas.
9. Los componentes reutilizados deben mantener el mismo comportamiento.
10. La información debe presentarse siguiendo una jerarquía visual.

## 7. Flujo de Uso

El template permite establecer un flujo general para la administración de horarios:

**Acceder → Seleccionar Gestión de Horarios → Consultar → Filtrar → Seleccionar registro → Ver, editar o eliminar**

Para la creación:

**Acceder → Gestión de Horarios → Nuevo horario → Completar información → Validar → Guardar → Mostrar resultado**

Este flujo permite representar de manera sencilla las principales operaciones del módulo.

## 8. Estados de la Interfaz

El template contempla diferentes situaciones que pueden presentarse durante el uso del sistema.

### Estado inicial

La pantalla presenta la información disponible y las acciones principales.

### Estado de búsqueda

Se muestran los registros que coinciden con los criterios seleccionados.

### Estado vacío

Cuando no existen registros, se presenta un mensaje indicando que no se encontraron horarios.

### Estado de carga

Se utiliza mientras el sistema procesa una solicitud.

### Estado exitoso

Informa que una operación fue realizada correctamente.

### Estado de error

Informa que una operación no pudo completarse y, cuando sea posible, indica cómo solucionarla.

## 9. Ventajas de la Propuesta

La estructura planteada permite:

- Reutilizar componentes.
- Mantener una navegación uniforme.
- Facilitar la lectura de información.
- Reducir diferencias entre pantallas.
- Mejorar la identificación de acciones.
- Facilitar futuras ampliaciones del sistema.
- Mantener una experiencia de usuario consistente.

## 10. Conclusión

El template propuesto funciona como una estructura base para organizar el mockup de Gestión de Horarios. La separación de la interfaz en zonas de identificación, navegación, contexto, trabajo y respuesta permite establecer una distribución clara de los elementos.

Al aplicar los mismos componentes y reglas en las diferentes operaciones, como consultar, crear, editar y eliminar horarios, se obtiene una interfaz coherente y fácil de comprender.

## Autor

AndresFernandoSalinasVargas
