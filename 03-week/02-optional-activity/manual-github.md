manual-github.md

# 📘 Manual Básico: Cómo Subir y Bajar Archivos en GitHub

## 👨‍💻 Introducción

GitHub es una plataforma que permite guardar proyectos y trabajar en ellos desde cualquier lugar usando el sistema de control de versiones llamado Git.

Con GitHub puedes:

* 📤 Subir archivos a un repositorio
* 📥 Descargar proyectos
* 🔄 Actualizar archivos
* 👥 Trabajar en equipo

---

# 📥 1. Cómo Descargar (Clonar) un Proyecto de GitHub

Clonar significa **copiar un repositorio completo a tu computadora**.

## Pasos

1. Entrar al repositorio en GitHub.
2. Hacer clic en el botón **Code**.
3. Copiar la URL del repositorio.

Ejemplo:

```
https://github.com/usuario/proyecto.git
```

4. Abrir la terminal o consola.
5. Escribir el siguiente comando:

```
git clone https://github.com/usuario/proyecto.git
```

✅ Esto descargará todo el proyecto a tu computadora.

---

# 📥 2. Cómo Actualizar Archivos del Repositorio (Pull)

Si el proyecto cambió en GitHub, puedes descargar los cambios con:

```
git pull
```

📌 Este comando:

* Descarga los cambios
* Actualiza tu carpeta local

---

# 📤 3. Cómo Subir Archivos a GitHub

Cuando modificas o agregas archivos, debes subirlos al repositorio.

## Paso 1: Agregar archivos

```
git add .
```

Este comando agrega **todos los archivos modificados**.

También puedes agregar solo uno:

```
git add archivo.html
```

---

## Paso 2: Crear un commit

Un commit es un **registro de los cambios realizados**.

```
git commit -m "Agregando nuevos archivos"
```

📌 El mensaje explica qué cambios hiciste.

---

## Paso 3: Subir los archivos

Ahora subes los cambios al repositorio:

```
git push
```

✅ Los archivos aparecerán en GitHub.

---

# 🔄 4. Flujo básico de trabajo

Cada vez que trabajes en un proyecto usa este orden:

```
git pull
git add .
git commit -m "Descripción del cambio"
git push
```

---

# 📂 Ejemplo práctico

Supongamos que agregas un archivo llamado:

```
index.html
```

Los comandos serían:

```
git add index.html
git commit -m "Agregando página principal"
git push
```

---

# ⚠️ Errores comunes

## Error: repositorio no actualizado

Solución:

```
git pull
```

Luego vuelve a subir los cambios.

---

# 📚 Comandos importantes

| Comando    | Función               |
| ---------- | --------------------- |
| git clone  | Descargar repositorio |
| git pull   | Actualizar proyecto   |
| git add    | Preparar archivos     |
| git commit | Guardar cambios       |
| git push   | Subir cambios         |

---

# 🎯 Conclusión

GitHub permite:

* Guardar proyectos
* Trabajar en equipo
* Mantener historial de cambios

Aprendiendo estos comandos básicos podrás **subir y bajar archivos fácilmente**.