Tema: Tomar asistencia



Planteamiento del problema:

Actualmente, el proceso de toma de asistencia de los aprendices de la ficha ADSO 3413974 se realiza mediante la plataforma SOFIA Plus. Aunque esta plataforma permite registrar la asistencia, el procedimiento resulta lento y poco eficiente, ya que el instructor debe ingresar al sistema, buscar la ficha correspondiente, localizar a cada aprendiz de manera individual y verificar nuevamente el número de asistentes para asegurar que el registro sea correcto.



Objetivo:

* Desarrollar un sistema web que optimice el proceso de toma de asistencia de los aprendices de la ficha ADSO 3413974, reduciendo el tiempo empleado por el instructor en el registro de 	la asistencia.



Objetivo especifico:

* Analizar el proceso actual de toma de asistencia realizado mediante SOFIA Plus para identificar las principales dificultades.
* Diseñar una interfaz sencilla que permita registrar la asistencia de todos los aprendices desde una única pantalla.
* Implementar un sistema que permita registrar y consultar la asistencia de los aprendices de forma rápida y organizada.
* Almacenar los registros de asistencia para facilitar su consulta y modificación cuando sea necesario.



Ingeniería de requisitos:

&#x09;

Requerimientos funcionales:



RF01. El sistema deberá mostrar el listado de aprendices de la ficha ADSO 3413974.



RF02. El sistema deberá permitir registrar la asistencia de todos los aprendices desde una única pantalla.



RF03. El sistema deberá permitir marcar el estado de cada aprendiz como:(Asistió, Tarde, Ausente)



RF04. El sistema deberá almacenar la fecha y el estado de asistencia de cada aprendiz.



RF05. El sistema deberá permitir consultar los registros de asistencia por ficha.



RF06. El sistema deberá permitir modificar un registro de asistencia previamente almacenado.



RF07. El sistema deberá permitir buscar un aprendiz por nombre o documento.



SRS (IEEE 830)



Caso de Uso:

&#x20;                       Instructor

&#x20;                           |

&#x20;     -------------------------------------------------

&#x20;     |         |          |          |               |

&#x20;     |         |          |          |               |

&#x20;     V         V          V          V               V

&#x20;   (UC01)    (UC02)     (UC03)     (UC04)        (UC05)

&#x20;Registrar   Consultar   Modificar   Buscar      Generar

&#x20;Asistencia Asistencia  Asistencia  Aprendiz     Reportes

&#x20;     |

&#x20;     |

&#x20;     |

&#x20;     V

&#x20; -------------------------------

&#x20; |             |               |

&#x20; V             V               V

(UC01.1)    (UC01.2)       (UC01.3)

Mostrar     Registrar      Guardar

lista de    estado de      registro

aprendices  asistencia



Clases:



&#x20;                   +-------------------------+

&#x20;                   |       Instructor        |

&#x20;                   +-------------------------+

&#x20;                   | - idInstructor          |

&#x20;                   | - nombre               |

&#x20;                   +-------------------------+

&#x20;                   | + registrarAsistencia() |

&#x20;                   | + consultarAsistencia() |

&#x20;                   | + modificarAsistencia() |

&#x20;                   +-------------------------+

&#x20;                              |

&#x20;                              | 1

&#x20;                              |

&#x20;                              | registra

&#x20;                              |

&#x20;                              | \*

&#x20;                   +-------------------------+

&#x20;                   |       Asistencia        |

&#x20;                   +-------------------------+

&#x20;                   | - idAsistencia          |

&#x20;                   | - fecha                |

&#x20;                   | - estado              |

&#x20;                   +-------------------------+

&#x20;                   | + guardar()            |

&#x20;                   | + editar()             |

&#x20;                   | + consultar()          |

&#x20;                   +-------------------------+

&#x20;                              |

&#x20;                              | \*

&#x20;                              |

&#x20;                              | pertenece a

&#x20;                              |

&#x20;                              | 1

&#x20;                   +-------------------------+

&#x20;                   |        Aprendiz         |

&#x20;                   +-------------------------+

&#x20;                   | - idAprendiz           |

&#x20;                   | - documento            |

&#x20;                   | - nombre               |

&#x20;                   +-------------------------+

&#x20;                   | + obtenerDatos()       |

&#x20;                   +-------------------------+



