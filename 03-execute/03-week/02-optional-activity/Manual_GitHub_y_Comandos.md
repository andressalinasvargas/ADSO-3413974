# Manual de Git, GitHub y Comandos Esenciales

**Programa:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Aprendiz:** Andrés Fernando Salinas Vargas  
**Semana:** Week 3  

> Complementa el documento [`manual_commit_git.md`](./manual_commit_git.md) con el uso completo de GitHub, conexión remota, ramas y flujo colaborativo con *Fork* y *Pull Request*.

---

## 1. Diferencia entre Git y GitHub

| Concepto | ¿Qué es? | ¿Dónde funciona? |
| :--- | :--- | :--- |
| **Git** | Sistema de control de versiones distribuido que registra el historial de cambios de un proyecto. | Local (en tu computador, desde la terminal o IDE). |
| **GitHub** | Plataforma web de alojamiento para repositorios Git que facilita la colaboración, revisión de código y respaldo en la nube. | En la nube (`github.com`). |

---

## 2. Configuración inicial

Antes de crear commits que queden vinculados a tu cuenta de GitHub, configura tu nombre y correo electrónico global:

```bash
# Definir nombre y correo del autor
git config --global user.name "Andres Salinas"
git config --global user.email "salinasvargasandresfernando@gmail.com"

# Verificar configuración activa
git config --list
```

---

## 3. Crear o clonar un repositorio

```bash
# Inicializar un repositorio nuevo en una carpeta local existente
git init

# Clonar un repositorio remoto desde GitHub
git clone https://github.com/usuario/repositorio.git
```

---

## 4. Ciclo diario de trabajo

```bash
# 1. Revisar archivos modificados, nuevos o en staging
git status

# 2. Ver cambios línea por línea antes de preparar
git diff

# 3. Agregar un archivo específico o todos los cambios al área de preparación (staging)
git add ruta/del/archivo.md
git add .

# 4. Guardar una instantánea (commit) en el historial local
git commit -m "docs: descripción clara del cambio realizado"

# 5. Consultar historial de commits
git log --oneline -n 10
```

---

## 5. Conexión y sincronización con GitHub

```bash
# Ver remotos configurados (fetch y push)
git remote -v

# Conectar un repositorio local con uno remoto en GitHub
git remote add origin https://github.com/usuario/repositorio.git

# Descargar cambios remotos sin fusionarlos aún
git fetch origin

# Descargar y fusionar cambios de la rama remota en tu rama local
git pull origin main

# Subir tus commits locales a GitHub
git push -u origin main
```

---

## 6. Trabajo con ramas (*Branches*)

Las ramas permiten desarrollar nuevas funcionalidades o tareas sin afectar la rama principal (`main`).

```bash
# Listar ramas locales y remotas
git branch -a

# Crear una rama nueva y cambiarse a ella
git switch -c feature/nueva-funcionalidad
# (Equivalente clásico: git checkout -b feature/nueva-funcionalidad)

# Cambiar entre ramas existentes
git switch main

# Fusionar una rama terminada dentro de main
git merge feature/nueva-funcionalidad

# Eliminar una rama local ya fusionada
git branch -d feature/nueva-funcionalidad
```

---

## 7. Flujo colaborativo en GitHub (Fork, Sync Fork y Pull Request)

En proyectos formativos (como el repositorio base de la ficha en `code-sena/ADSO-3413974`), el flujo de trabajo recomendado es:

1. **Fork:** crear una copia del repositorio de la organización/instructor en tu propia cuenta de GitHub (`andressalinasvargas/ADSO-3413974`).
2. **Clone:** clonar **tu fork** en tu equipo para trabajar localmente.
3. **Sync fork / Upstream:** agregar el repositorio original como `upstream` (o usar el botón **Sync fork** en GitHub) para traer las actualizaciones del instructor (por ejemplo, carpetas `01-session/`):
   ```bash
   git remote add upstream https://github.com/code-sena/ADSO-3413974.git
   git fetch upstream
   git merge upstream/main
   ```
4. **Commit y Push:** subir tus actividades dentro de `02-optional-activity/` hacia tu remoto `origin`.
5. **Pull Request (PR):** cuando se requiere entregar o integrar cambios hacia el repositorio principal, abrir un **Pull Request** desde tu rama/fork hacia la rama destino indicando título claro y descripción de los cambios.

---

## 8. `.gitignore` y buenas prácticas

- **Archivo `.gitignore`:** evita subir archivos temporales, dependencias pesadas (`node_modules/`), credenciales (`.env`) o binarios del sistema operativo.
- **Nunca subir secretos:** no guardar contraseñas, tokens o claves privadas en el historial de Git.
- **Commits atómicos:** agrupar cambios relacionados en commits pequeños con mensajes descriptivos (ej. `docs:`, `feat:`, `fix:`, `refactor:`).
- **Sincronizar antes de subir:** ejecutar `git pull` antes de `git push` para evitar conflictos innecesarios.
