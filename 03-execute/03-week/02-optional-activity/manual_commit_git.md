# Manual para realizar un Commit en Git desde la Terminal

## 1. ¿Qué es un Commit?

Un **commit** en Git es un registro de los cambios realizados en los
archivos de un proyecto. Permite guardar versiones del proyecto y llevar
un historial de modificaciones.

------------------------------------------------------------------------

## 2. Requisitos Previos

Antes de realizar un commit debes tener: - Git instalado en tu
computadora. - Un repositorio Git inicializado o clonado. - Archivos
modificados o nuevos en el proyecto.

Verificar instalación de Git:

``` bash
git --version
```

------------------------------------------------------------------------

## 3. Verificar el estado del repositorio

``` bash
git status
```

Este comando muestra: - Archivos modificados - Archivos nuevos -
Archivos listos para commit

------------------------------------------------------------------------

## 4. Agregar archivos al área de preparación (Staging)

Agregar un archivo específico:

``` bash
git add nombre-del-archivo
```

Ejemplo:

``` bash
git add index.html
```

Agregar todos los archivos modificados:

``` bash
git add .
```

------------------------------------------------------------------------

## 5. Crear el Commit

``` bash
git commit -m "Descripción de los cambios"
```

Ejemplo:

``` bash
git commit -m "Se agregó el formulario de registro"
```

------------------------------------------------------------------------

## 6. Ver historial de commits

``` bash
git log
```

Mostrará: - ID del commit - Autor - Fecha - Mensaje del commit

------------------------------------------------------------------------

## 7. Subir cambios al repositorio remoto (opcional)

``` bash
git push origin main
```

O si la rama es master:

``` bash
git push origin master
```

------------------------------------------------------------------------

## 8. Flujo básico de trabajo

``` bash
git status
git add .
git commit -m "Mensaje del commit"
git push origin main
```

------------------------------------------------------------------------

## 9. Buenas prácticas

-   Usar mensajes claros.
-   Describir qué se cambió.
-   Hacer commits pequeños y frecuentes.

Ejemplo:

``` bash
git commit -m "Corrige error en cálculo de impuestos"
```

------------------------------------------------------------------------

## 10. Resumen

1.  Revisar cambios\
2.  Agregar archivos al staging\
3.  Crear commit con mensaje\
4.  Subir cambios al repositorio remoto
