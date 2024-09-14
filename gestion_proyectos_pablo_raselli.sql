-- Eliminar la base de datos si ya existe
DROP DATABASE IF EXISTS GestionProyectos;

-- Crear la base de datos
CREATE DATABASE GestionProyectos;

-- Utilizar la base de datos creada
USE GestionProyectos;

CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    contraseña VARCHAR(20),
    rol ENUM('Administrador', 'Miembro')
);

CREATE TABLE Equipos (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE MiembrosEquipo (
    id_miembro INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_equipo INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id_equipo)
);

CREATE TABLE Proyectos (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80),
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    id_equipo INT,
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id_equipo)
);

CREATE TABLE Tareas (
    id_tarea INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT,
    nombre VARCHAR(100),
    descripcion TEXT,
    estado ENUM('Pendiente', 'En Proceso', 'Completada'),
    fecha_inicio DATE,
    fecha_fin DATE,
    id_usuario_asignado INT,
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto),
    FOREIGN KEY (id_usuario_asignado) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Comentarios (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_tarea INT,
    id_usuario INT,
    contenido TEXT,
    fecha_comentario DATETIME,
    FOREIGN KEY (id_tarea) REFERENCES Tareas(id_tarea),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);



-- --------------------- INSERCIÓN DE REGISTROS: --------------------------

-- USUARIOS:
INSERT INTO Usuarios (nombre, apellido, email, contraseña, rol) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', 'juanPass', 'Administrador'),
('María', 'Gómez', 'maria.gomez@example.com', 'mariaPass', 'Miembro'),
('Carlos', 'López', 'carlos.lopez@example.com', 'carlosPass', 'Miembro'),
('Pablo', 'Raselli', 'pjraselli@example.com', 'pabloPass', 'Administrador'),
('Lucía', 'Fernández', 'lucia.fernandez@example.com', 'luciaPass', 'Miembro'),
('Valentín', 'Raselli', 'valenRaselli@example.com', 'valentinPass', 'Miembro');


-- EQUIPOS:
INSERT INTO Equipos (nombre) VALUES
('Equipo Rojo'),
('Equipo Azul'),
('Equipo Verde');


-- MIEMBROS DE EQUIPOS:
INSERT INTO MiembrosEquipo (id_usuario, id_equipo) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3);


-- PROYECTOS:
INSERT INTO Proyectos (nombre, descripcion, fecha_inicio, fecha_fin, id_equipo) VALUES
('Proyecto A', 'Sistema de Gestión de Proyectos', '2024-01-01', '2024-06-30', 1),
('Proyecto B', 'Portal Web Corporativo', '2024-02-01', '2024-07-31', 2),
('Proyecto C', 'Aplicación Móvil', '2024-03-01', '2024-08-31', 3);


-- TAREAS:
INSERT INTO Tareas (id_proyecto, nombre, descripcion, estado, fecha_inicio, fecha_fin, id_usuario_asignado) VALUES
(1, 'Diseño de la base de datos', 'Crear la estructura de la base de datos', 'Pendiente', '2024-01-05', '2024-01-15', 1),
(1, 'Desarrollo de la interfaz', 'Diseñar la UI del proyecto', 'En Proceso', '2024-01-16', '2024-02-15', 2),
(2, 'Implementación del backend', 'Desarrollar la lógica del servidor', 'Pendiente', '2024-02-05', '2024-02-28', 3),
(3, 'Pruebas y depuración', 'Realizar pruebas y corregir errores', 'Pendiente', '2024-03-05', '2024-03-20', 4);


-- COMENTARIOS:
INSERT INTO Comentarios (id_tarea, id_usuario, contenido, fecha_comentario) VALUES
(1, 2, 'Revisé el esquema de la base de datos y todo parece estar correcto.', '2024-01-06 10:00:00'),
(2, 1, 'La interfaz tiene algunos problemas de diseño.', '2024-01-20 15:30:00'),
(3, 3, 'El código backend está casi listo, solo faltan unos ajustes.', '2024-02-20 09:45:00'),
(4, 4, 'He encontrado varios bugs durante las pruebas.', '2024-03-10 14:15:00'),
(2, 5, 'La UI se ve mejor después de los ajustes. Faltaría verificar la compatibilidad en diferentes navegadores.', '2024-01-22 11:00:00'),
(1, 6, 'Volvimos a revisar la estructura de la base de datos y creo que podríamos optimizar algunas consultas.', '2024-01-07 16:30:00'),
(3, 4, 'El backend está funcionando bien, pero necesitamos mejorar la seguridad de las API.', '2024-02-22 10:20:00'),
(4, 3, 'He corregido algunos de los bugs reportados, pero aún faltan algunas pruebas.', '2024-03-12 09:00:00'),
(2, 1, 'He hecho algunos ajustes adicionales en la interfaz según lo charlado en las reuniones.', '2024-01-25 17:45:00');

/* --------------------- NUEVA INSERCIÓN DE DATOS ---------------------- */

INSERT INTO Proyectos (nombre, descripcion, fecha_inicio, fecha_fin, id_equipo) 
VALUES 
('Proyecto D', 'Desarrollo de plataforma de ecommerce', '2024-04-01', '2024-10-30', 1),
('Proyecto E', 'Automatización de procesos', '2024-05-01', '2024-12-01', 2);

INSERT INTO Tareas (id_proyecto, nombre, descripcion, estado, fecha_inicio, fecha_fin, id_usuario_asignado) 
VALUES 
(4, 'Análisis de requisitos', 'Reuniones con el cliente para analizar necesidades', 'Pendiente', '2024-04-05', '2024-04-10', 3),
(4, 'Desarrollo del frontend', 'Implementación de la UI', 'En Proceso', '2024-04-11', '2024-05-10', 4),
(5, 'Diseño de base de datos', 'Estructura de la base de datos del proyecto', 'Completada', '2024-05-05', '2024-06-05', 2),
(1, 'Planificación inicial', 'Definir el alcance del proyecto y crear un plan', 'Completada', '2024-01-01', '2024-01-05', 1),
(1, 'Desarrollo del backend', 'Implementar la lógica del servidor', 'Pendiente', '2024-02-01', '2024-03-01', 2),
(1, 'Pruebas del sistema', 'Realizar pruebas funcionales y de carga', 'En Proceso', '2024-03-02', '2024-03-20', 3),
(2, 'Diseño gráfico', 'Diseñar el layout de la página principal', 'Completada', '2024-02-01', '2024-02-15', 4),
(2, 'Optimización SEO', 'Optimizar la web para motores de búsqueda', 'Pendiente', '2024-03-01', '2024-03-20', 5),
(2, 'Pruebas de compatibilidad', 'Verificar compatibilidad con diferentes navegadores', 'En Proceso', '2024-03-21', '2024-03-30', 3),
(3, 'Diseño de la interfaz móvil', 'Crear un diseño responsivo', 'Pendiente', '2024-04-01', '2024-04-10', 6),
(3, 'Integración con APIs', 'Conectar la app con las APIs del servidor', 'En Proceso', '2024-04-11', '2024-04-25', 5),
(3, 'Pruebas de usabilidad', 'Realizar pruebas con usuarios', 'Completada', '2024-05-01', '2024-05-10', 4),
(4, 'Análisis de mercado', 'Investigar sobre las tendencias en ecommerce', 'Completada', '2024-04-01', '2024-04-05', 1),
(4, 'Implementación de pasarela de pagos', 'Desarrollar la integración con la pasarela de pagos', 'Pendiente', '2024-04-06', '2024-04-20', 2),
(4, 'Optimización de rendimiento', 'Mejorar el rendimiento del sitio para altos volúmenes de tráfico', 'En Proceso', '2024-04-21', '2024-05-01', 3);


UPDATE Tareas SET estado = 'Completada' WHERE id_tarea = 1;
UPDATE Tareas SET estado = 'En Proceso' WHERE id_tarea = 3;

-- --------------------- VISTAS: --------------------------


-- 1 / Progreso de las tareas:
CREATE VIEW vw_progreso_tareas AS
SELECT 
    p.nombre AS nombre_proyecto,
    t.nombre AS nombre_tarea,
    t.estado,
    t.fecha_inicio,
    t.fecha_fin,
    u.nombre AS nombre_usuario_asignado,
    u.apellido AS apellido_usuario_asignado
FROM 
    Tareas t
JOIN 
    Proyectos p ON t.id_proyecto = p.id_proyecto
JOIN 
    Usuarios u ON t.id_usuario_asignado = u.id_usuario;


-- 2 / Estado del Proyecto:
CREATE VIEW vw_estado_proyecto AS
SELECT 
    p.nombre AS nombre_proyecto,
    COUNT(t.id_tarea) AS total_tareas,
    SUM(CASE WHEN t.estado = 'Completada' THEN 1 ELSE 0 END) AS tareas_completadas,
    SUM(CASE WHEN t.estado = 'En Proceso' THEN 1 ELSE 0 END) AS tareas_en_proceso,
    SUM(CASE WHEN t.estado = 'Pendiente' THEN 1 ELSE 0 END) AS tareas_pendientes,
    ROUND(SUM(CASE WHEN t.estado = 'Completada' THEN 1 ELSE 0 END) / COUNT(t.id_tarea) * 100, 2) AS porcentaje_completado
FROM 
    Proyectos p
LEFT JOIN 
    Tareas t ON p.id_proyecto = t.id_proyecto
GROUP BY 
    p.id_proyecto, p.nombre;
    
    
-- 3 / Resumen de proyectos por equipo:
CREATE VIEW vw_proyectos_x_equipo AS
SELECT 
    e.nombre AS nombre_equipo,
    p.nombre AS nombre_proyecto,
    p.descripcion,
    p.fecha_inicio,
    p.fecha_fin
FROM 
    Proyectos p
JOIN 
    Equipos e ON p.id_equipo = e.id_equipo;
    
    
-- 4 / Comentarios en tareas:
CREATE VIEW vw_comentarios_recientes AS
SELECT 
    t.nombre AS nombre_tarea,
    c.contenido AS comentario,
    u.nombre AS nombre_usuario,
    u.apellido AS apellido_usuario,
    c.fecha_comentario
FROM 
    Comentarios c
JOIN 
    Tareas t ON c.id_tarea = t.id_tarea
JOIN 
    Usuarios u ON c.id_usuario = u.id_usuario
ORDER BY 
    c.fecha_comentario DESC;


-- PRUEBAS VISTAS:
-- Descomentar y ejecutar para poder hacer las pruebas.

-- SELECT * FROM vw_progreso_tareas;

-- SELECT * FROM vw_estado_proyecto;

-- SELECT * FROM vw_proyectos_x_equipo;

-- SELECT * FROM vw_comentarios_recientes;



-- --------------------- FUNCIONES: --------------------------


-- 1 / Obtener el nombre completo de un usuario:

DELIMITER $$
CREATE FUNCTION fn_nombre_completo(p_id_usuario INT) 
RETURNS VARCHAR(80)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(80);

    SELECT CONCAT(nombre, ' ', apellido) 
    INTO nombre_completo 
    FROM Usuarios 
    WHERE id_usuario = p_id_usuario;

    RETURN nombre_completo;
END$$
DELIMITER ;



-- 2 / Saber cuantos comentarios tiene una tarea:

DELIMITER $$
CREATE FUNCTION fn_cantidad_comentarios(p_id_tarea INT) 
RETURNS VARCHAR(40)
DETERMINISTIC
BEGIN
    DECLARE num_comentarios INT;
    DECLARE resultado VARCHAR(40);

    SELECT COUNT(*)
    INTO num_comentarios 
    FROM Comentarios 
    WHERE id_tarea = p_id_tarea;

    SET resultado = CONCAT(num_comentarios, ' comentarios');

    RETURN resultado;
END$$
DELIMITER ;



-- 3 / Obtener el estado de un proyecto:

DELIMITER $$
CREATE FUNCTION fn_estado_proyecto(id_proyecto INT) 
RETURNS ENUM('Pendiente', 'En Proceso', 'Completada')
DETERMINISTIC
BEGIN
    DECLARE estado ENUM('Pendiente', 'En Proceso', 'Completada');

    SELECT 
        CASE 
            WHEN COUNT(*) = 0 THEN 'Pendiente'
            WHEN SUM(estado = 'Completada') = COUNT(*) THEN 'Completada'
            ELSE 'En Proceso'
        END
    INTO estado
    FROM Tareas
    WHERE id_proyecto = id_proyecto;

    RETURN estado;
END$$
DELIMITER ;


-- PRUEBAS FUNCIONES:
-- Descomentar y ejecutar para poder hacer las pruebas.

-- SELECT fn_nombre_completo(4);
 
-- SELECT fn_cantidad_comentarios(3);

-- SELECT fn_estado_proyecto(1);



-- --------------------- STORED PROCEDURES: --------------------------



-- 1 / Crear un nuevo proyecto y asignar un equipo:

DELIMITER $$
CREATE PROCEDURE sp_nuevo_proyecto(
    IN nombre_proyecto VARCHAR(80),
    IN descripcion_proyecto TEXT,
    IN fecha_inicio_proyecto DATE,
    IN fecha_fin_proyecto DATE,
    IN id_equipo_proyecto INT
)
BEGIN
    INSERT INTO Proyectos (nombre, descripcion, fecha_inicio, fecha_fin, id_equipo)
    VALUES (nombre_proyecto, descripcion_proyecto, fecha_inicio_proyecto, fecha_fin_proyecto, id_equipo_proyecto);
END$$
DELIMITER ;



-- 2 / Asignar una tarea a un usuario:

DELIMITER $$
CREATE PROCEDURE sp_asignar_tarea(
    IN id_tarea INT,
    IN id_usuario INT
)
BEGIN
    UPDATE Tareas
    SET id_usuario_asignado = id_usuario, estado = 'En Proceso'
    WHERE id_tarea = id_tarea;
END$$
DELIMITER ;



-- 3 / Cerrar un proyecto:

DELIMITER $$
CREATE PROCEDURE sp_cerrar_proyecto(
    IN id_proyecto INT
)
BEGIN
    DECLARE tareas_pendientes INT;

    SELECT COUNT(*) INTO tareas_pendientes
    FROM Tareas
    WHERE id_proyecto = id_proyecto AND estado != 'Completada';

    IF tareas_pendientes = 0 THEN
        UPDATE Proyectos
        SET estado = 'Completado'
        WHERE id_proyecto = id_proyecto;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede cerrar el proyecto, aún hay tareas pendientes.';
    END IF;
END$$
DELIMITER ;

/* ACLARACIÓN FUNCIONAMIENTO STORED PROCEDURE 3:
- Investigué e hice esto ya que, de no poder cerrar el proyecto, si no daba algún tipo de
mensaje de porque no podía cerrarlo, no tenía mucho sentido hacerlo.

- SIGNAL: Es el comando que se utiliza para lanzar una excepción o un error.

- SQLSTATE '45000': SQLSTATE es un código de cinco caracteres que representa un estado de error.
'45000' código genérico utilizado para errores definidos por el usuario.

- SET MESSAGE_TEXT: Esta parte del código es para proporcionar un mensaje descriptivo del error.
En este caso el mensaje es: "No se puede cerrar el proyecto, aún hay tareas pendientes." */




-- PRUEBAS STORED PROCEDURES:
-- Descomentar y ejecutar para poder hacer las pruebas.

/*
-- 1 / Crear un nuevo proyecto y asignar un equipo:
CALL sp_nuevo_proyecto(
    'Proyecto D', 
    'Nueva Aplicación Web', 
    '2024-04-01', 
    '2024-09-30', 
    2
);

SELECT * FROM proyectos;
*/


-- 2 / Asignar una tarea a un usuario:
-- CALL sp_asignar_tarea(1, 2);

/* ME DA ERROR!!. Supuestamente porque MySQL está en "modo de actualización segura"
y evita que realice actualizaciones o eliminaciones que puedan afectar muchas filas */


-- 3 / Cerrar un proyecto:
-- CALL sp_cerrar_proyecto(1);



-- --------------------- TRIGGERS: --------------------------


-- 1 / Evitar la eliminación de un usuarios con tareas:

DELIMITER $$

CREATE TRIGGER tg_evitar_eliminar_usuario_con_tareas
BEFORE DELETE ON Usuarios
FOR EACH ROW
BEGIN
    DECLARE num_tareas INT;

    -- Contar el número de tareas asignadas al usuario que se está intentando eliminar
    SELECT COUNT(*) INTO num_tareas
    FROM Tareas
    WHERE id_usuario_asignado = OLD.id_usuario;
    
    -- Si el usuario tiene tareas asignadas, cancela la eliminación
    IF num_tareas > 0 THEN
        -- Mensaje de error literal
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el usuario porque tiene tareas asignadas.';
    END IF;
END$$

DELIMITER ;


-- PRUEBA TRIGGER:
-- Descomentar y ejecutar para poder hacer las pruebas.

-- SELECT * FROM Tareas WHERE id_usuario_asignado = 1;
-- DELETE FROM Usuarios WHERE id_usuario = 1;


-- 2 / Actualiza automáticamente el estado de un proyecto cuando todas sus tareas están completas:
DELIMITER $$

CREATE TRIGGER tg_actualizar_estado_proyecto
AFTER UPDATE ON Tareas
FOR EACH ROW
BEGIN
    DECLARE tareas_pendientes INT;
    
    -- Contar cuántas tareas hay pendientes
    SELECT COUNT(*) INTO tareas_pendientes
    FROM Tareas
    WHERE id_proyecto = NEW.id_proyecto
    AND estado != 'Completada';
    
    -- Si ya no hay tareas pendientes, actualizar el estado del proyecto a 'Completado'
    IF tareas_pendientes = 0 THEN
        UPDATE Proyectos
        SET estado = 'Completado'
        WHERE id_proyecto = NEW.id_proyecto;
    END IF;
END$$

DELIMITER ;

-- -------------------------------------------------------------

SELECT * FROM vw_estado_proyecto; -- Consulta para extraer los datos para los gráficos:
-- "CANTIDAD y ESTADO DE TAREAS DE LOS PROYECTOS" 
-- "ESTADO DE PROYECTO: Proyecto A"
-- "PORCENTAJE DE AVANCE DE LOS PROYECTOS"

/*---------------------------------------------------------------*/

-- Consulta para extraer los datos para el gráfico:
-- "ORGANIGRAMA - Inicio Y DURACIÓN DE LAS TAREAS"

SELECT
    p.nombre AS nombre_proyecto, 
    t.nombre AS nombre_tarea, 
    t.fecha_inicio, 
    t.fecha_fin 
FROM 
    Proyectos p
JOIN 
    Tareas t ON p.id_proyecto = t.id_proyecto;