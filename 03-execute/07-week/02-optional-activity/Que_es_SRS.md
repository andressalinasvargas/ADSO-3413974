# ¿Qué es un SRS (Software Requirements Specification)?

**Programa:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Aprendiz:** Andrés Fernando Salinas Vargas  
**Semana:** Week 7  

---

## 1. Definición y propósito

Un **SRS** (*Software Requirements Specification*, o **Especificación de Requisitos de Software**) es un documento técnico y formal que describe de manera completa, precisa y verificable **qué debe hacer** un sistema de software y **bajo qué condiciones y restricciones** debe operar, antes de iniciar su diseño e implementación.

### ¿Para quién sirve?
- **Cliente / Usuario / Negocio:** Valida que el equipo entendió exactamente sus necesidades y sirve como acuerdo de alcance (rol contractual).
- **Analistas y Arquitectos:** Define las capacidades, reglas de negocio y atributos de calidad que guiarán el diseño de la arquitectura y la base de datos.
- **Desarrolladores:** Sirve como fuente única de verdad para construir las funcionalidades sin suposiciones ambiguas.
- **Equipo de Calidad (QA):** Permite derivar los casos de prueba funcionales, no funcionales y de aceptación (E2E).

> En términos prácticos: el SRS establece **el qué** (el comportamiento externo y restricciones del software) sin imponer innecesariamente **el cómo** (detalles internos de implementación), salvo que exista una restricción técnica explícita.

---

## 2. Estándares de referencia: IEEE 830 e ISO/IEC/IEEE 29148

El estándar clásico para redactar especificaciones de requisitos es **IEEE Std 830-1998** (*Recommended Practice for Software Requirements Specifications*), el cual posteriormente fue reemplazado y unificado por la norma **ISO/IEC/IEEE 29148** (*Systems and software engineering — Life cycle processes — Requirements engineering*).

### Estructura estándar recomendada (basada en IEEE 830)

1. **Introducción**
   - **Propósito:** objetivo del documento y público al que va dirigido.
   - **Alcance:** qué hace y qué **no** hace el software; beneficios, objetivos y metas.
   - **Definiciones, acrónimos y abreviaturas (Glosario):** vocabulario común del dominio.
   - **Referencias:** normas, manuales, documentos de levantamiento previos.
   - **Visión general del documento:** resumen de cómo se organizan las secciones restantes.

2. **Descripción general**
   - **Perspectiva del producto:** contexto del sistema (independiente o integrado con otros sistemas, interfaces de sistema/usuario/hardware).
   - **Funciones del producto:** resumen de alto nivel de los módulos principales.
   - **Características de los usuarios / actores:** roles, nivel técnico y responsabilidades.
   - **Restricciones generales:** políticas institucionales, hardware, navegadores, normativas legales (ej. protección de datos).
   - **Suposiciones y dependencias:** factores externos necesarios para que el sistema funcione.

3. **Requisitos específicos**
   - **Interfaces externas:** interfaces de usuario (UI), de hardware, de software/APIs y de comunicaciones.
   - **Requisitos funcionales (RF):** entradas, procesos, validaciones, salidas y reglas de negocio por módulo o caso de uso.
   - **Requisitos no funcionales (RNF) / atributos de calidad:** rendimiento, seguridad, disponibilidad, usabilidad, mantenibilidad y portabilidad.
   - **Requisitos de base de datos lógica:** entidades clave, integridad y retención de datos.
   - **Requisitos adicionales / apéndices:** matriz de trazabilidad, prototipos o diagramas de apoyo.

---

## 3. Características de un buen SRS y de buenos requisitos

Según IEEE 830 e ISO/IEC/IEEE 29148, un SRS de calidad debe ser:

| Característica | Significado práctico |
| :--- | :--- |
| **Correcto** | Cada requisito refleja fielmente una necesidad real validada con los interesados. |
| **No ambiguo** | Cada requisito tiene una única interpretación posible (evitar términos vagos como *"rápido"*, *"fácil"*, *"adecuado"*). |
| **Completo** | Incluye todos los requisitos significativos (funcionales, restricciones, errores y casos límite), sin secciones pendientes (`TBD`) sin gestionar. |
| **Consistente** | Ningún requisito contradice a otro requisito ni a las reglas de negocio del dominio. |
| **Priorizado / Clasificado** | Distingue requisitos obligatorios, deseables u opcionales (por ejemplo mediante **MoSCoW** o matriz Importancia × Urgencia). |
| **Verificable** | Existe una prueba objetiva o métrica finita para comprobar que el sistema cumple el requisito. |
| **Modificable** | Su estructura numerada (`RF-01`, `RNF-01`) e indexada permite actualizar requisitos sin duplicar información ni romper coherencia. |
| **Trazable** | Cada requisito tiene un identificador único que permite rastrear su origen (entrevista, observación, norma) y su destino (caso de uso, código y prueba). |

---

## 4. Requisitos Funcionales (RF) vs. Requisitos No Funcionales (RNF)

| Aspecto | Requisitos Funcionales (RF) | Requisitos No Funcionales (RNF) |
| :--- | :--- | :--- |
| **Qué definen** | Acciones, servicios, flujos, cálculos y comportamientos del sistema. | Cualidades, restricciones operativas, rendimiento, seguridad y estándares de calidad. |
| **Pregunta clave** | *¿Qué debe hacer el sistema?* | *¿Qué tan bien y bajo qué condiciones debe hacerlo?* |
| **Cómo se prueban** | Pruebas funcionales, de casos de uso y E2E. | Pruebas de carga, estrés, seguridad, usabilidad y compatibilidad. |
| **Ejemplo (Supermercado La Esquina)** | `RF-01`: Registrar cada venta con fecha, hora, productos, cantidades, cálculo automático de total y descuento de stock al confirmar. | `RNF-03`: Tiempo de respuesta máximo de 3 segundos por pantalla en condiciones normales de red. |
| **Ejemplo (Asistencia / Horarios SENA)** | `RF-03`: Permitir marcar el estado de cada aprendiz (`Asistió`, `Tarde`, `Ausente`) desde una única pantalla y registrar hora/fecha. | Garantizar control de acceso por rol, auditoría de cambios manuales y disponibilidad de un flujo de contingencia cuando falle el escaneo QR. |

---

## 5. Beneficios y errores comunes al elaborar un SRS

### Beneficios principales
- Reduce retrabajos costosos en etapas avanzadas de desarrollo.
- Alinea expectativas entre el cliente/instructor y el equipo de desarrollo.
- Sirve de base directa para estimar tiempos, costos, arquitectura y plan de pruebas.
- Evita la pérdida de conocimiento técnico cuando cambian integrantes del equipo.

### Errores frecuentes que se deben evitar
1. **Usar lenguaje subjetivo o ambiguo:** escribir *"el sistema debe ser muy seguro y rápido"* en lugar de definir autenticación, cifrado y tiempos concretos en segundos.
2. **Mezclar diseño con requisitos:** imponer tablas SQL o librerías específicas dentro de un requisito funcional sin justificación de restricción.
3. **Omitir flujos de error y casos límite:** describir solo el camino feliz y olvidar qué ocurre si no hay stock, si se cae la red o si el usuario ingresa datos inválidos.
4. **Falta de trazabilidad y numeración:** redactar párrafos largos sin códigos (`RF-XX`, `RNF-XX`), lo que impide asociar pruebas y criterios de aceptación.
5. **No validar contradicciones:** aceptar respuestas verbales de entrevistas sin contrastarlas con observación directa o documentos reales del negocio.

---

## 6. Referencias

- **IEEE Std 830-1998:** *IEEE Recommended Practice for Software Requirements Specifications*.
- **ISO/IEC/IEEE 29148:2018:** *Systems and software engineering — Life cycle processes — Requirements engineering*.
- **Sommerville, I.:** *Ingeniería de Software* (capítulos sobre Ingeniería de Requisitos y Especificación).
