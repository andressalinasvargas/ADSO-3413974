# A2 y A3 · Diagrama de Clases y Patrones de Diseño (GoF)

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P1 · Artefactos de diseño (`RAP 593103`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23`  
**Fuente editable:** [02-diagrama-clases.drawio](02-diagrama-clases.drawio) · **Imagen exportada:** [02-diagrama-clases.svg](02-diagrama-clases.svg)

---

## 1. Vista Rápida del Diagrama de Clases (`19` Elementos: `17` Clases + `2` Interfaces)

```mermaid
classDiagram
  direction TB

  class Persona {
    <<abstract>>
    -id: int
    -documento: string
    -nombre: string
    -email: string
    -activo: bool
    +obtenerIdentidad(): string
    +estaActivo(): bool
    +cambiarEstado(activo: bool): void
  }

  class UsuarioSistema {
    -usuario: string
    -passwordHash: string
    -rolSistema: string
    -especialidad: string
    +verificarClave(clavePlana: string): bool
    +esInstructor(): bool
    +esCoordinador(): bool
  }

  class Aprendiz {
    -qrToken: string
    -idFicha: int
    +perteneceAFicha(idFicha: int): bool
    +actualizarQrToken(token: string): void
  }

  class ProgramaFormacion {
    -idPrograma: int
    -codigoPrograma: string
    -nombrePrograma: string
    -nivelFormacion: string
    +obtenerDescripcion(): string
  }

  class SedeFormacion {
    -idSede: int
    -nombreSede: string
    -latitud: float
    -longitud: float
    -radioMaxMetros: int
    +estaEnPerimetro(distanciaMetros: float): bool
  }

  class FichaFormacion {
    -idFicha: int
    -numeroFicha: string
    -jornada: string
    -activa: bool
    +asignarAprendiz(aprendiz: Aprendiz): void
    +desactivar(): void
  }

  class AsignacionInstructor {
    -fechaInicio: DateTimeImmutable
    -fechaFin: DateTimeImmutable
    -rolEnFicha: string
    +estaVigente(fecha: DateTimeImmutable): bool
  }

  class SesionAsistencia {
    -idSesion: int
    -token: string
    -codigo: string
    -iniciaEn: DateTimeImmutable
    -venceEn: DateTimeImmutable
    -toleranciaMinutos: int
    -activa: bool
    +estaVigente(ahora: DateTimeImmutable): bool
    +cerrar(propietarioId: int): void
    +agregarRegistro(registro: RegistroAsistencia): void
  }

  class RegistroAsistencia {
    -idRegistro: int
    -fechaHora: DateTimeImmutable
    -canalRegistro: string
    -tardeMinutos: int
    -latitud: float
    -longitud: float
    -precisionGps: float
    -verificadoGps: bool
    -consentimientoDatos: bool
    -ipOrigen: string
    -estadoRed: string
    +agregarNovedad(novedad: NovedadContingencia): void
    +registrarTardanza(minutos: int): void
  }

  class NovedadContingencia {
    -numeroNovedad: int
    -tipoNovedad: string
    -observacion: string
    -fechaReporte: DateTimeImmutable
    +obtenerResumen(): string
  }

  class IEstrategiaRegistro {
    <<interface>>
    +construirRegistro(sesion: SesionAsistencia, aprendiz: Aprendiz, datos: array): RegistroAsistencia
    +obtenerCanal(): string
  }

  class EstrategiaMovilQr {
    -validadorGeo: ValidadorGeocerca
    +construirRegistro(sesion: SesionAsistencia, aprendiz: Aprendiz, datos: array): RegistroAsistencia
    +obtenerCanal(): string
  }

  class EstrategiaEscanerQr {
    +construirRegistro(sesion: SesionAsistencia, aprendiz: Aprendiz, datos: array): RegistroAsistencia
    +obtenerCanal(): string
  }

  class EstrategiaManualContingencia {
    +construirRegistro(sesion: SesionAsistencia, aprendiz: Aprendiz, datos: array): RegistroAsistencia
    +obtenerCanal(): string
  }

  class ValidadorGeocerca {
    -radioTierraMetros: float
    +calcularDistanciaHaversine(lat1: float, lng1: float, lat2: float, lng2: float): float
    +validarPerimetro(sede: SedeFormacion, lat: float, lng: float, precision: float): bool
  }

  class CalculadorTardanza {
    +calcularMinutos(iniciaEn: DateTimeImmutable, toleranciaMin: int, horaRegistro: DateTimeImmutable): int
  }

  class IRepositorioAsistencia {
    <<interface>>
    +guardarSesion(sesion: SesionAsistencia): int
    +guardarRegistro(registro: RegistroAsistencia): int
    +existeDuplicado(idAprendiz: int, idSesion: int): bool
    +consultarHistorial(filtros: array): array
  }

  class ServicioReportes {
    -repositorio: IRepositorioAsistencia
    +generarResumenFicha(idFicha: int, desde: DateTimeImmutable, hasta: DateTimeImmutable): array
    +exportarCsv(filas: array): string
  }

  class FachadaControlAsistencia {
    -repositorio: IRepositorioAsistencia
    -calculadorTardanza: CalculadorTardanza
    -estrategias: array
    +abrirSesion(instructor: UsuarioSistema, ficha: FichaFormacion, tolerancia: int): SesionAsistencia
    +registrarAsistencia(canal: string, sesion: SesionAsistencia, aprendiz: Aprendiz, datos: array): RegistroAsistencia
    +cerrarSesion(instructor: UsuarioSistema, sesion: SesionAsistencia): void
  }

  Persona <|-- UsuarioSistema
  Persona <|-- Aprendiz

  ProgramaFormacion "1" --> "0..*" FichaFormacion
  SedeFormacion "1" --> "0..*" FichaFormacion
  FichaFormacion "0..1" o-- "0..*" Aprendiz

  UsuarioSistema "1" --> "0..*" AsignacionInstructor
  FichaFormacion "1" --> "1..*" AsignacionInstructor

  UsuarioSistema "1" --> "0..*" SesionAsistencia
  FichaFormacion "0..1" --> "0..*" SesionAsistencia

  SesionAsistencia "1" *-- "0..*" RegistroAsistencia
  Aprendiz "1" --> "0..*" RegistroAsistencia
  RegistroAsistencia "1" *-- "0..*" NovedadContingencia

  IEstrategiaRegistro <|.. EstrategiaMovilQr
  IEstrategiaRegistro <|.. EstrategiaEscanerQr
  IEstrategiaRegistro <|.. EstrategiaManualContingencia
  EstrategiaMovilQr "1" --> "1" ValidadorGeocerca
  EstrategiaMovilQr ..> SedeFormacion

  FachadaControlAsistencia "1" --> "1..*" IEstrategiaRegistro
  FachadaControlAsistencia "1" --> "1" CalculadorTardanza
  FachadaControlAsistencia "1" --> "1" IRepositorioAsistencia
  ServicioReportes "1" --> "1" IRepositorioAsistencia
```

---

## 2. Catálogo de Clases y Principios Orientados a Objetos Aplicados

| Principio / Relación OO | Dónde se aplica en el diagrama | Justificación en `asistencia-sena` |
| :--- | :--- | :--- |
| **Herencia («es un»)** | `Persona` (`{abstract}`) ⇐ `UsuarioSistema`, `Aprendiz` | Comparte identidad (`id`, `documento`, `nombre`, `email`, `activo`) evitando duplicar atributos y comportamiento de activación lógica (`RF-02`). |
| **Agregación («tiene / agrupa»)** | `FichaFormacion "0..1" o-- "0..*" Aprendiz` | Un aprendiz puede existir temporalmente sin ficha o reasignarse entre fichas sin destruir su historial académico. |
| **Composición («es parte de»)** | `SesionAsistencia "1" *-- "0..*" RegistroAsistencia` y `RegistroAsistencia "1" *-- "0..*" NovedadContingencia` | Un registro de asistencia solo existe dentro de una sesión concreta y las novedades dependen totalmente de la existencia de su registro padre (`RF-07`, `RF-09`). |
| **Polimorfismo por interfaz** | `IEstrategiaRegistro` con `EstrategiaMovilQr`, `EstrategiaEscanerQr` y `EstrategiaManualContingencia` | `FachadaControlAsistencia` invoca `construirRegistro(...)` sobre la interfaz sin acoplarse ni usar condicionales gigantes para distinguir canales (`RF-05`, `RF-08`, `RF-09`). |
| **Alta cohesión (sin mezcla de áreas)** | Clases de negocio separadas de UI y de persistencia (`IRepositorioAsistencia`) y reportes separados en `ServicioReportes` | Ninguna clase de dominio mezcla HTML, SQL o generación CSV; cada clase atiende una única responsabilidad verificable en `06-matriz-trazabilidad-diseno.md`. |

---

## 3. Patrones de Diseño GoF Aplicados (A3)

Se incorporan **2 patrones GoF distintos** (ninguno es Singleton) reflejados directamente en las clases del diagrama:

| Patrón GoF | Problema concreto en `asistencia-sena` | Por qué este patrón y no condicionales planos | Clases e interfaces participantes | Qué mejora en mantenibilidad |
| :--- | :--- | :--- | :--- | :--- |
| **1. Estrategia (*Strategy*)** | La asistencia se captura por 3 canales con reglas distintas: **autorregistro móvil** (exige consentimiento Ley 1581 + validación GPS Haversine y precisión), **escáner QR del instructor** (valida token de credencial e instructor autenticado) y **contingencia manual** (valida propiedad del instructor + novedad opcional). Concentrar los 3 flujos en un solo método provoca acoplamiento alto y regresiones frecuentes. | Encapsula las variaciones de captura y validación detrás de un contrato único polimórfico (`IEstrategiaRegistro`), permitiendo sustituir o seleccionar dinámicamente el algoritmo por canal en tiempo de ejecución sin `if/switch` acoplados. | `IEstrategiaRegistro`, `EstrategiaMovilQr`, `EstrategiaEscanerQr`, `EstrategiaManualContingencia` *(cliente: `FachadaControlAsistencia`)*. | Agregar un futuro cuarto canal (por ejemplo lectura NFC o biometría institucional) requiere crear una nueva implementación de `IEstrategiaRegistro` sin modificar `SesionAsistencia`, `RegistroAsistencia` ni las demás estrategias. |
| **2. Fachada (*Facade*)** | Registrar o cerrar una asistencia obliga a coordinar múltiples colaboradores: verificar sesión vigente y duplicados en repositorio (`IRepositorioAsistencia`), ejecutar la estrategia del canal (`IEstrategiaRegistro`), validar geocerca (`ValidadorGeocerca`), calcular tardanza uniforme (`CalculadorTardanza`) y persistir el resultado. Exponer esa orquestación a la capa UI provocaría lógica duplicada (como ocurría antes entre registro móvil y manual) y riesgo de saltarse validaciones. | Provee un punto de entrada cohesivo de alto nivel (`FachadaControlAsistencia`) que oculta la complejidad del subsistema de asistencia y garantiza invariantes críticas (`RF-04`, `RF-07`, `RF-10`, `RF-11`) en un solo flujo uniforme para toda interfaz (`WebAppInstructor` y `WebAppMovilAprendiz`). | `FachadaControlAsistencia` *(coordina `IEstrategiaRegistro`, `CalculadorTardanza`, `IRepositorioAsistencia`, `SesionAsistencia`, `RegistroAsistencia`)*. | La UI no depende de múltiples servicios internos; si cambia la fórmula de tardanza o el repositorio PDO, los controladores web no cambian, reduciendo el acoplamiento entre capas y evitando duplicación de reglas de negocio. |
